package com.amphenol.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.amphenol.entity.ShEntity;
import com.amphenol.entity.ShEntity.ShdItem;
import com.amphenol.entity.ShEntity.ShdPcItem;
import com.amphenol.util.ConstantUtils;
import com.amphenol.util.QRcoderUtil;
import com.sun.corba.se.spi.orbutil.fsm.State;
import com.sun.org.apache.bcel.internal.generic.LXOR;

public class getShdServlet extends HttpServlet {
	PrintWriter out = null ;
	ShEntity shEntity  = new ShEntity();
	String userName = "";
	String envId = "";
	String envIdXA = "";
	String userCode = "";
	String userHouse = "";
	String stid = "";
	String shpno = "" ;
	String stat = "";

	Connection connXA = null ;
	Connection conn = null ;
	
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		out = response.getWriter();

		userName = (String) request.getSession().getAttribute("userName");
		userHouse = (String) request.getSession().getAttribute("userHouse");
		envId = (String) request.getSession().getAttribute("envId");
		envIdXA = (String) request.getSession().getAttribute("envIdXA");
		userCode = (String) request.getSession().getAttribute("userCode");
		stid = (String) request.getSession().getAttribute("stid");
		shpno = request.getParameter("shpno");
		stat = request.getParameter("stat");
		System.out.println("getshdservlet 's shpno is "+shpno);

		shEntity.setShdh(shpno);


		try {
			java.sql.DriverManager.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
			Class.forName("com.ibm.as400.access.AS400JDBCDriver");
			String url = "jdbc:as400://" + ConstantUtils.DATABASE_IP + "/"
					+ envIdXA + ";translate binary=true";
			connXA = DriverManager.getConnection(url,
					ConstantUtils.DATABASE_NAME,
					ConstantUtils.DATABASE_PASSWORD);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		try {
			java.sql.DriverManager.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
			Class.forName("com.ibm.as400.access.AS400JDBCDriver");
			String url = "jdbc:as400://" + ConstantUtils.DATABASE_IP + "/"
					+ envId + ";translate binary=true";
			conn = DriverManager.getConnection(url,
					ConstantUtils.DATABASE_NAME,
					ConstantUtils.DATABASE_PASSWORD);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		getVENNAM(connXA);
		getSHPMST(connXA);

		getZSHPITM(conn);
		
		if(stat.equals("10"))
			changeOSTAT(conn);

		try {
			connXA.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		String encoderQRCoder = QRcoderUtil.encoderQRCoder(shEntity.getShdh(), userName,request.getSession().getServletContext().getRealPath("/"));
		shEntity.setEwm(encoderQRCoder) ;
		System.out.println("encoderQRCoder is "+encoderQRCoder);
		request.setAttribute("shEntity", shEntity);
		request.setAttribute("date", new SimpleDateFormat("yyyy/MM/dd").format(new Date()));
		//		request.setCharacterEncoding("utf-8");
		request.getRequestDispatcher("supplier/Shd.jsp").forward(request, response);
//		response.sendRedirect("supplier/Shd.jsp");
		//		out.print("shdz1="+shEntity.getShdz1()+",shdz2="+shEntity.getShdz2()+",shdz3="+shEntity.getShdz3()+"shcs="+shEntity.getShcs()+",phone="+shEntity.getPhone());
		out.flush();
		out.close();
	}

	private void changeOSTAT(Connection conn2) {
		// TODO Auto-generated method stub

		Statement statement = null;
		try {
			statement = conn.createStatement();
			String sql = "update ZSHPHDR set OSTAT = '20' where SHPNO = '"+shpno+"'";
			int i = statement.executeUpdate(sql);
			
			System.out.println("update shphdr success the i is "+i);
		}catch (Exception e) {
			System.out.println("update shphdr error");
			e.printStackTrace();
			out.print(e);
		}finally{
			try {
				if(statement!=null)
					statement.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	private String getDS40JI(Connection connXA,String SCTKJI) {
		String result = "" ;

		Statement statement = null;
		ResultSet executeQuery = null ;
		try {
			statement = connXA.createStatement();
			String sql = "select DS40JI from "+envIdXA.trim()+".SCHRCP where SCTKJI = '"+SCTKJI+"'";

			executeQuery = statement.executeQuery(sql);
			if(executeQuery!=null){
				if(executeQuery.next()){
					result = executeQuery.getString("DS40JI");
				}
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			out.print(e);
		}finally{
			try {
				if(executeQuery!=null)
					executeQuery.close();
				if(statement!=null)
					statement.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return result ;

	}

	private void getZSHPITM(Connection conn) {

		List<ShdItem> sdhItems = new ArrayList<ShdItem>();
		shEntity.setSdhItems(sdhItems);

		Statement statement = null;
		ResultSet executeQuery = null ;
		try {
			statement = conn.createStatement();
			String sql = "select * from "+envId.trim()+".ZSHPITM where SHPNO = '"+shpno+"'";
			executeQuery = statement.executeQuery(sql);
			System.out.println("the getZSHPITM sql is "+sql);
			if(executeQuery!=null){
				ShdItem shdItem ;
				while(executeQuery.next()){
					shdItem = new ShdItem();
					System.out.println("get shpno "+executeQuery.getString("SHPNO"));
					shdItem.setXc(executeQuery.getString("ORDNO").trim()+"-"+executeQuery.getString("POISQ").trim()+"-"+executeQuery.getString("BLKSQ").trim());
					shdItem.setWl(executeQuery.getString("ITNBR").trim());
					shdItem.setCgdw(executeQuery.getString("PURUM").trim());
					shdItem.setSl(executeQuery.getFloat("SHQTY"));
					shdItem.setDz(executeQuery.getFloat("TWHT")/executeQuery.getFloat("SHQTY"));
					shdItem.setZl(executeQuery.getFloat("TWHT"));
					shdItem.setDw(executeQuery.getString("WHTUM").trim());
					shdItem.setMs(getDS40JI(connXA,executeQuery.getString("SCTKJI")).trim());
					shdItem.setPcItem(getPc(conn, executeQuery.getString("SHPNO").trim(), executeQuery.getInt("SHPLN")));
					sdhItems.add(shdItem);
				}
				shEntity.setSdhItems(sdhItems);
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			out.print(e);
		}finally{
			try {
				if(executeQuery!=null)
					executeQuery.close();
				if(statement!=null)
					statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

	private ArrayList<ShdPcItem> getPc(Connection conn,String SHPNO,int SHPLN) {

		Statement statement = null;
		ResultSet executeQuery = null ;
		ArrayList<ShdPcItem> shdPcItems = new ArrayList<ShEntity.ShdPcItem>();
		try {
			statement = conn.createStatement();
			String sql = "select * from "+envId.trim()+".ZSHPBCH where SHPNO = '"+SHPNO+"' and SHPLN ="+SHPLN;
			out.print("the getPc sql is "+sql);
			executeQuery = statement.executeQuery(sql);
			if(executeQuery!=null){
				while(executeQuery.next()){
					ShdPcItem shdPcItem = new ShdPcItem();
					shdPcItem.setPch(executeQuery.getString("LBHNO"));
					shdPcItem.setSl(executeQuery.getFloat("BHQTY"));
					shdPcItems.add(shdPcItem);
				}

			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			out.print(e);
		}finally{
			try {
				if(executeQuery!=null)
					executeQuery.close();
				if(statement!=null)
					statement.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return shdPcItems;

	}

	private void getSHPMST(Connection connXA) {

		Statement statement = null;
		ResultSet executeQuery = null ;
		try {
			statement = connXA.createStatement();
			String sql = "select * from "+envIdXA.trim()+".SHPMST where HOUSE = '"+userHouse+"' and SHPID = 999";
			//			String sql = "select * from "+envIdXA.trim()+".SHPMST where HOUSE like '%"+userHouse+"%'";
			out.print("the getSHPMST sql is "+sql);
			executeQuery = statement.executeQuery(sql);
			if(executeQuery!=null){
				if(executeQuery.next()){
					shEntity.setShdz1(executeQuery.getString("SHPNM").trim());
					shEntity.setShdz2(executeQuery.getString("SHIP1").trim());
					shEntity.setShdz3(executeQuery.getString("SHIP2").trim());
					shEntity.setLxr(executeQuery.getString("SCONT").trim());
					shEntity.setPhone(executeQuery.getString("STELE").trim());
				}

			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			out.print(e);
		}finally{
			try {
				if(executeQuery!=null)
					executeQuery.close();
				if(statement!=null)
					statement.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

	private void getVENNAM(Connection connXA) {
		Statement statement = null;
		ResultSet executeQuery = null ;
		try {
			statement = connXA.createStatement();
			String sql = "select VN35 from "+envIdXA.trim()+".VENNAM";
			out.print("the getvennam sql is "+sql);
			executeQuery = statement.executeQuery(sql);
			if(executeQuery!=null){
				while(executeQuery.next()){
					shEntity.setShcs(executeQuery.getString("VN35").trim());
				}

			}
		}catch (Exception e) {
			// TODO: handle exception
			out.print(e);
		}finally{
			try {
				if(executeQuery!=null)
					executeQuery.close();
				if(statement!=null)
					statement.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}


}
