package com.amphenol.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.amphenol.tools.HttpServer;
import com.amphenol.util.ConstantUtils;

public class EnsureDateServlet extends HttpServlet {


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = null ;
		Statement statement = null;
		ResultSet resultSet = null;

		String envId = "";
		String userCode = "";
		String userHouse = "";

		String PISQJI = "";
		String ORDRJI = "";
		String OLDDATE = "";
		String BKSQJI = "";
		String newDate = "";
		
		envId = (String) request.getSession().getAttribute("envId");
		userHouse = (String) request.getSession().getAttribute("userHouse");
		
		try {
			java.sql.DriverManager.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
			Class.forName("com.ibm.as400.access.AS400JDBCDriver");
			String url = "jdbc:as400://" + ConstantUtils.DATABASE_IP + "/"
					+ envId + ";translate binary=true";
			conn = DriverManager.getConnection(url,
					ConstantUtils.DATABASE_NAME,
					ConstantUtils.DATABASE_PASSWORD);

		} catch (Exception e) {
			e.printStackTrace();
		}



		PISQJI = request.getParameter("PISQJI");
		ORDRJI = request.getParameter("ORDRJI");
		OLDDATE = request.getParameter("OLDDATE");
		BKSQJI = request.getParameter("BKSQJI");
		newDate = request.getParameter("newDate");
		String currentDate = "";
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		currentDate = dateFormat.format(new Date());
		response.setContentType("text/html;charset=UTF-8");

		SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
		try {
			newDate = dateFormat.format(dateFormat2.parse(newDate));
		} catch (ParseException e) {
			e.printStackTrace();
		}

		PrintWriter out = response.getWriter();
		try {
			if(dateFormat.parse(OLDDATE).getTime()>dateFormat.parse(newDate).getTime()){
				out.print("<script language='javascript'>alert('错误：日期仅能延后！');window.opener.location.href=window.opener.location.href;window.close();</script>");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		String sql = "SELECT * FROM "+envId.trim()+".ZDELIDA WHERE ORDRJI = '"+ORDRJI+"' AND PISQJI = '"+PISQJI+"' AND BKSQJI = '"+BKSQJI+"' ORDER BY ORDSEQ DESC";
		try {
			statement = conn.createStatement();
			resultSet = statement.executeQuery(sql);
			if(resultSet.next()){
				if(resultSet.getInt("STAUS") == 10){
					out.print("<script language='javascript'>alert('错误：交期审核状态非法！');window.opener.location.href=window.opener.location.href;window.close();</script>");
					throw new RuntimeException();
				}
				sql = "INSERT INTO "+envId.trim()+".ZDELIDA (ORDRJI,PISQJI,BKSQJI,ORDSEQ,WKDTJI,STAUS,VNDRJI,WHIDJI) VALUES ('"+ORDRJI+"','"+PISQJI+
						"','"+BKSQJI+"','"+(resultSet.getInt("ORDSEQ")+1)+"','"+new BigDecimal(newDate).subtract(new BigDecimal(19000000)).toString()+"','10','"+userCode+"','"+userHouse.trim()+"')";
			}else{
				sql = "INSERT INTO "+envId.trim()+".ZDELIDA (ORDRJI,PISQJI,BKSQJI,ORDSEQ,WKDTJI,STAUS,VNDRJI,WHIDJI) VALUES ('"+ORDRJI+"','"+PISQJI+
						"','"+BKSQJI+"','1','"+new BigDecimal(newDate).subtract(new BigDecimal(19000000)).toString()+"','10','"+userCode+"','"+userHouse.trim()+"')";
			}
			System.out.println("sql is "+sql);
			statement.execute(sql);
			out.print("<script language=javascript>window.opener.location.href=window.opener.location.href;window.close();");
			out.print("</script>");
		} catch (Exception e1) {
			e1.printStackTrace();
		}finally{
			try {
				if(resultSet!=null)
					resultSet.close();
				if(statement!=null)
					statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}


		try {
			out.flush();
			out.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		/*

		 String xml = "";
		if(BKSQJI.equals("0")){
			xml = "<?xml version='1.0' encoding='UTF-8'?><!DOCTYPE System-Link SYSTEM 'SystemLinkRequest.dtd'>"
					+"<System-Link><Login userId='amapics' password='amapics' maxIdle='900000' properties='com.pjx.cas.domain.EnvironmentId=M1, com.pjx.cas.domain.SystemName=S844DD1W, com.pjx.cas.user.LanguageId=zh'/>"
					+"<Request sessionHandle='*current' workHandle='*new' broker='EJB' maxIdle='1000'>"
					+"<Create name = 'POItemVATxn'  domainClass=' com.mapics.mm.PurchaseOrderItemVendorAcceptTxn'>"
					+"<DomainEntity>"
					+"<Key>"
					+"<Property path='order'>"
					+"<Value><![CDATA["+ORDRJI+"]]></Value>"
					+"</Property>"
					+"<Property path='line'>"
					+"<Value><![CDATA["+PISQJI+"]]></Value>"
					+"</Property>"
					+"</Key>"
					+"<Property path='promisedDate'>"
					+"<Value><![CDATA["+newDate+"]]></Value>"
					+"</Property>"
					+"<Property path='transactionDate'>"
					+"<Value><![CDATA["+currentDate+"]]></Value>"
					+"</Property>"
					+"<Property path='reprintPo'>"
					+"<Value><![CDATA[false]]></Value>"
					+"</Property>"
					+"<Property path='shipViaDescription'>"
					+"<Value><![CDATA[]]></Value>"
					+"</Property>"
					+"<Property path='poComments1st40'>"
					+"<Value><![CDATA[]]></Value>"
					+"</Property>"
					+"<Property path='poComments2nd40'>"
					+"<Value><![CDATA[]]></Value>"
					+"</Property>"
					+"</DomainEntity>"
					+"</Create>"
					+"</Request>"
					+"<Logout sessionHandle='*current'/>"
					+"</System-Link>";


		}else{
			xml = "<?xml version='1.0' encoding='UTF-8'?>"
					+"<!DOCTYPE System-Link SYSTEM 'SystemLinkRequest.dtd'>"
					+"<System-Link>"
					+"<Login userId='amapics' password='amapics' maxIdle='900000'"
					+"        properties='com.pjx.cas.domain.EnvironmentId=M1,"
					+"             com.pjx.cas.domain.SystemName=S844DD1W,"
					+"             com.pjx.cas.user.LanguageId=zh'/>"
					+"   <Request sessionHandle='*current' workHandle='*new' broker='EJB' maxIdle='1000'>"
					+"    <Create name = 'POReleaseVATxn' domainClass = 'com.mapics.mm.PurchaseOrderItemReleaseVendorAcceptTxn'>"
					+"       <DomainEntity>"
					+"          <Key>"
					+"             <Property path='order'>"
					+"                <Value><![CDATA["+ORDRJI+"]]></Value>"
					+"             </Property>"
					+"             <Property path='line'>"
					+"                <Value><![CDATA["+PISQJI+"]]></Value>"
					+"             </Property>"
					+"           <Property path='release'>"
					+"                <Value><![CDATA["+BKSQJI+"]]></Value>"
					+"             </Property>"
					+"          </Key>"
					+"          <Property path='promisedDate'>"
					+"             <Value><![CDATA["+newDate+"]]></Value>"
					+"          </Property>"
					+"          <Property path='transactionDate'>"
					+"             <Value><![CDATA["+currentDate+"]]></Value>"
					+"          </Property>"
					+"          <Property path='reprintPo'>"
					+"             <Value><![CDATA[false]]></Value>"
					+"          </Property>"
					+"          <Property path='poComments1st40'>"
					+"             <Value><![CDATA[]]></Value>"
					+"          </Property>"
					+"          <Property path='poComments2nd40'>"
					+"             <Value><![CDATA[]]></Value>"
					+"          </Property>"
					+"          <Property path='shipViaDescription'>"
					+"             <Value><![CDATA[]]></Value>"
					+"          </Property>"
					+"       </DomainEntity>"
					+"    </Create>"
					+" </Request>"
					+"</System-Link>";
		}
		System.out.println("the put xml is "+xml);
		String returnVal = HttpServer.postXMLRequest(ConstantUtils.ENSURE_DATE_URL,xml);
		System.out.println(returnVal);
		out.print("<script language=javascript>window.opener.location.href=window.opener.location.href;window.close();");
		out.print("</script>");
		out.flush();
		out.close();*/
	}

}
