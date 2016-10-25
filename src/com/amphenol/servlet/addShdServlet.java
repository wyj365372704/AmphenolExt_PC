package com.amphenol.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sun.rmi.runtime.Log;

import com.amphenol.util.ConstantUtils;
import com.sun.corba.se.spi.orbutil.fsm.State;

public class addShdServlet extends HttpServlet {
	String userName = "";
	String envId = "";
	String envIdXA = "";
	String userCode = "";
	String userHouse = "";
	String stid = "";
	String PISQJI = "";
	String ORDRJI = "" ;
	String BKSQJI = "";
	String BLCF = "" ;
	String SCTKJI = "";
	String SHPLN = "";
	String SHPNO = "";
	String ITNBR = "";
	String PURUM = "";
	String B2CQCD = "";
	float UMCVJI = 1;//转换系数

	float WEGHT = 0f;
	float wjl = 0f;//未交量
	float SHQTY = 0f;//本次送货量
	private String[] batchNames;
	private String[] batchNums;
	private String BLKSQ;
	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		boolean insertResult = false ;


		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		System.out.println("doPost start!!!");
		userName = (String) request.getSession().getAttribute("userName");
		userHouse = (String) request.getSession().getAttribute("userHouse");
		envId = (String) request.getSession().getAttribute("envId");
		envIdXA = (String) request.getSession().getAttribute("envIdXA");
		userCode = (String) request.getSession().getAttribute("userCode");
		stid = (String) request.getSession().getAttribute("stid");

		batchNames = request.getParameterValues("batch_name");
		batchNums = request.getParameterValues("batch_num");
		PISQJI = (String) request.getParameter("PISQJI") ;
		ORDRJI = (String) request.getParameter("ORDRJI") ;
		BKSQJI = (String) request.getParameter("BKSQJI") ;
		BLCF = (String) request.getParameter("BLCF") ;
		ITNBR = (String) request.getParameter("ITNBR");
		SCTKJI = (String) request.getParameter("SCTKJI") ;
		PURUM = (String) request.getParameter("PURUM") ;
		B2CQCD = (String) request.getParameter("B2CQCD") ;
		System.out.println(request.getParameter("WEGHT"));
		System.out.println(request.getParameter("wjl"));
		WEGHT = Float.valueOf((String) request.getParameter("WEGHT"));
		wjl = Float.valueOf((String) request.getParameter("wjl"));
		SHQTY = Float.valueOf((String) request.getParameter("SHQTY"));
		UMCVJI = Float.valueOf(request.getParameter("UMCVJI"));
		Connection conn = null ;

		try {
			java.sql.DriverManager.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
			Class.forName("com.ibm.as400.access.AS400JDBCDriver");
			String url = "jdbc:as400://" + ConstantUtils.DATABASE_IP + "/"
					+ envId + ";translate binary=true";
			conn = DriverManager.getConnection(url,
					ConstantUtils.DATABASE_NAME,
					ConstantUtils.DATABASE_PASSWORD);
			conn.setAutoCommit(false);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		SHPNO = getHeaderShpno(conn);
		if(SHPNO.equals("")){
			//不存在表头,插入表头
			boolean result = insertHead(conn);
			System.out.println("the insert shpno is "+SHPNO);
			if(result){
				//表头插入成功，插入表体
				insertResult = insertBody(conn);
			}
		}else{
			//存在表头，插入表体
			insertResult = insertBody(conn);
		}
		if(insertResult){
			if(batchNames!=null&&batchNames.length>0)
				insertResult = insertBatch(conn);
		}

		if(insertResult){
			try {
				conn.commit();
				conn.setAutoCommit(true);
				conn.close();

				out.print("<script language='javascript'>alert('送货单添加成功');window.location.href='supplier/buyIn.jsp';</script>");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else{
			System.out.println("insert body error!!!");
			try {
				conn.rollback();
				conn.close();

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			out.print("<script language='javascript'>alert('送货单添加失败');window.location.href='supplier/buyIn.jsp';</script>");
		}
		out.flush();
		out.close();
	}


	private boolean  insertBatch(Connection conn) {
		// TODO Auto-generated method stub
		boolean result = false ;
		Statement statement = null ;
		String sql ="insert into "+envId.trim()+".ZSHPBCH (SHPNO,SHPLN,SHPBN,VNDNR,HOUSE,ORDNO,POISQ," +
				"BLKSQ,ITNBR,BHQTY,LBHNO,PURUM,MFGDT,EXPDT) values ";
		String temp = "";
		for(int i=0;i<batchNames.length;i++){
			temp +="('"+SHPNO+"',"+SHPLN+","+(i+1)+",'"+userCode+"','"+userHouse+"','"+ORDRJI+"',"+
					PISQJI+","+BKSQJI+",'"+ITNBR+"',"+batchNums[i]+",'"+batchNames[i]+"','"+PURUM+"',"+getDate()+","+getDate()+"),";
		}
		sql +=temp.substring(0,temp.length()-1) ;
		System.out.println("add batch sql is "+sql);
		try {
			statement = conn.createStatement();
			int i = statement.executeUpdate(sql);
			System.out.println("add batch num is "+i);
			result = i == 0?false:true ;
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace() ;
		}finally{
			try {
				statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result ;

	}

	private boolean insertBody(Connection conn) {
		boolean result = false ;
		Statement stmt = null;
		SHPLN = getShpln(conn);
//		BLKSQ = getBLKSQ(conn) ;
		try {
			if (conn != null) {
				stmt = conn.createStatement();
				String sql = "insert into "+envId.trim()+".ZSHPITM (SHPNO,SHPLN,VNDNR,HOUSE,ORDNO,POISQ,BLCOD,BLKSQ,LSTAT,ITNBR,BLCF,SHQTY,PURUM,SCTKJI,TWHT,WHTUM) values('"+
						SHPNO+"','"+SHPLN.trim()+"','"+userCode+"','"+userHouse+"','"+ORDRJI+"',"+PISQJI+",'"+((wjl-SHQTY)>0f?"1":"0")+
						"',"+BKSQJI+",'10','"+ITNBR+"','"+BLCF+"','"+SHQTY+"','"+PURUM+"','"+SCTKJI+"',"+WEGHT*SHQTY+",'"+B2CQCD+"')";
				System.out.println("the insert Body sql is "+sql);
				int i = stmt.executeUpdate(sql);
				result  = i == 1?true:false;
			}
		}catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace() ;
		}finally{
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return result;
	}

	private String getBLKSQ(Connection conn) {
		// TODO Auto-generated method stub
		int result = 0;
		boolean temp = false ;
		try {
			Statement statement = conn.createStatement();
			String sql = "select BLKSQ from "+envId+".ZSHPITM where ORDNO = '"+ORDRJI.trim()+"' and POISQ = '"+PISQJI.trim()+"' and SHPLN = '"+SHPLN.trim()+"' and SHPNO = '"+SHPNO.trim()+"'";
			System.out.println("!!!---get BLKSQ sql is ="+sql);
			ResultSet rs = statement.executeQuery(sql);
			while(rs.next()){
				System.out.println("!!!---temp been true");
				result = rs.getInt("BLKSQ")>result?rs.getInt("BLKSQ"):result;
				System.out.println("!!!---result is "+result);
				temp = true;
			}
		} catch (SQLException e) {
			System.out.println("!!!---has error");
			e.printStackTrace();
		}
		if(temp)
			result++;
		System.out.println("!!!---finally the result is  "+result);
		return result+"";
	}

	private String getShpln(Connection conn) {
		// TODO Auto-generated method stub
		int result = 0;
		try {
			Statement statement = conn.createStatement();
			String sql = "select SHPLN from "+envId+".ZSHPITM where SHPNO = '"+SHPNO+"'";
			System.out.println("get shpln sql is ="+sql);
			ResultSet rs = statement.executeQuery(sql);
			while(rs.next())
				result =rs.getInt("SHPLN");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ++result+"";
	}

	private boolean insertHead(Connection conn) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMdd");
		Statement stmt = null;
		boolean result= false;
		try {
			SHPNO = userCode+"-"+dateFormat.format(new Date())+"-"+getSNO(conn);

			if (conn != null) {
				stmt = conn.createStatement();
				String sql = "insert into "+envId+".ZSHPHDR (SHPNO,VNDNR,OSTAT,CRUS,CRDT,CRTM,CHUS,CHDT,CHTM) values('"+
						SHPNO+"','"+userCode+"','"+10+
						"','"+userCode+"',"+getDate()+","+getTime()+",'"+userCode+"',"+getDate()+","+getTime()+")";
				System.out.println("the insertHead sql is "+sql);
				int i = stmt.executeUpdate(sql);
				result = i == 1?true:false ;
			}
		}catch (Exception e) {
			SHPNO = "";
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		}finally{
			try {
				stmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return result;
	}

	/**
	 * 获取当前用户的送货单表头
	 * @return
	 */
	private String getHeaderShpno(Connection conn) {
		Statement stmt = null;
		ResultSet rs = null;
		String result = "";
		try {
			String sql = "select * from " + envId.trim() + ".ZSHPHDR where CRUS = '"+userCode+"' and OSTAT = '10'";
			stmt = conn.createStatement();
			stmt.execute(sql);
			rs = (ResultSet) stmt.getResultSet();

			while (rs.next()) {
				result = rs.getString("SHPNO");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				rs.close();
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result ;
	}

	/**
	 * 获取日期number，减去了1900000
	 * @return
	 */
	private String getDate() {
		// TODO Auto-generated method stub
		String result = "";
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		result = String.valueOf(Integer.parseInt(dateFormat.format(new Date()))-19000000);
		return result;
	}

	/**
	 * 获取时间number
	 * @return
	 */
	private String getTime() {
		// TODO Auto-generated method stub
		String result = "";
		SimpleDateFormat dateFormat = new SimpleDateFormat("HHmmss");
		result = dateFormat.format(new Date());
		return result;
	}


	/**
	 * 返回三位数的序列号
	 * @return
	 */
	private String getSNO(Connection conn) {
		int num = 1;
		Statement statement = null;
		ResultSet executeQuery = null ;
		try {
			statement = conn.createStatement();
			String sql = "select SHPNO from " + envId.trim() + ".ZSHPHDR where CRUS = '"+userCode+"' and CRDT = "+getDate() +" order by CRTM desc";
			System.out.println("the getsno sql is "+sql);
			executeQuery = statement.executeQuery(sql);
			if(executeQuery.next()){
				String result = executeQuery.getString("SHPNO").trim();
				System.out.println("step 1 the result is "+result);
				if(result.length()-result.lastIndexOf("-") == 4){
					result = result.substring(result.lastIndexOf("-")+1,result.length());
					num = Integer.valueOf(result)+1;
					System.out.println("step 2 the num is "+num);
				}
			}
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}finally{
			try {
				statement.close();
				executeQuery.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		String result = String.valueOf(num);
		if(result.length() == 1)
			result = "00"+result;
		if(result.length() == 2)
			result = "0"+result ;

		return result;
	}
}
