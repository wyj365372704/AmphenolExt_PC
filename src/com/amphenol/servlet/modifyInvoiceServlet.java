package com.amphenol.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.amphenol.util.ConstantUtils;

public class modifyInvoiceServlet extends HttpServlet {
	private String SHPNO = "" ;
	private String envId = "";
	private String LGWNO = "" ;
	
	Connection conn = null ;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		LGWNO = request.getParameter("LGWNO");
		SHPNO = request.getParameter("SHPNO");
		envId = (String) request.getSession().getAttribute("envId");
		Statement statement = null;

		try {
			java.sql.DriverManager.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
			Class.forName("com.ibm.as400.access.AS400JDBCDriver");
			String url = "jdbc:as400://" + ConstantUtils.DATABASE_IP + "/"
					+ envId + ";translate binary=true";
			conn = DriverManager.getConnection(url,
					ConstantUtils.DATABASE_NAME,
					ConstantUtils.DATABASE_PASSWORD);
			statement = conn.createStatement();
			String sql = "update ZSHPHDR set LGWNO = '"+LGWNO+"' where SHPNO = '"+SHPNO+"'";
			statement.executeUpdate(sql);
			System.out.println("update ZSHPHDR.LGWNO success the LGWNO is "+LGWNO);
		} catch (Exception e) {
			System.out.println("update ZSHPHDR.LGWNO error");
			e.printStackTrace();
		}finally{
			try {
				if(statement!=null)
					statement.close();
				if(conn!=null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			out.print("<script language=javascript>window.opener.location.href=window.opener.location.href;window.close();");
			out.print("</script>");
			out.flush();
			out.close();
		}
	}

}
