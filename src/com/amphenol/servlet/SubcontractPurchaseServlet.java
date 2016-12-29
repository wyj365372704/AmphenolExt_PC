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
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.amphenol.util.ConstantUtils;
import com.sun.org.apache.bcel.internal.generic.NEW;

public class SubcontractPurchaseServlet extends HttpServlet {
	String userName = "";
	String envId = "";
	String envIdXA = "";
	String userCode = "";
	String userHouse = "";
	String stid = "";

	String buyno = "";
	String ordno = "";
	String startDate = "";
	String endDate = "";
	int pageCount ;
	int itemCount;
	int currentPage;
	
	
	List<Map> results;
	
	

	Connection connXA = null ;
	Connection conn = null ;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		results =  new ArrayList<Map>();
		response.setContentType("text/html;charset=UTF-8");

		userName = (String) request.getSession().getAttribute("userName");
		userHouse = (String) request.getSession().getAttribute("userHouse");
		envId = (String) request.getSession().getAttribute("envId");
		envIdXA = (String) request.getSession().getAttribute("envIdXA");
		userCode = (String) request.getSession().getAttribute("userCode");
		stid = (String) request.getSession().getAttribute("stid");
		
		buyno = request.getParameter("buyno");
		ordno = request.getParameter("ordno");
		startDate = request.getParameter("startDate");
		endDate = request.getParameter("endDate");

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


		////

		getPOMAST();


		try {
			connXA.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		request.setAttribute("buyno", buyno);
		request.setAttribute("ordno", ordno);
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		request.setAttribute("results", results);
		request.getRequestDispatcher("supplier/pomast_list.jsp").forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}


	private void getPOMAST() {
		Statement statement = null;
		ResultSet executeQuery = null ;
		try {
			statement = connXA.createStatement();
			StringBuilder sqlBuilder = new StringBuilder();
			sqlBuilder.append("SELECT A.* FROM ")
			.append(envIdXA.trim())
			.append(".POMAST A , ").
			append(envIdXA.trim()).
			append(".MOPORF B WHERE A.ORDNO = B.PONR AND A.ORDNO !='' AND A.VNDNR = '")
			.append(userCode)
			.append("' AND A.PSTTS != '99' ");
			if(buyno!=null && !buyno.trim().isEmpty()){
				sqlBuilder.append("AND A.BUYNO like '%").append(buyno.trim()).append("%' ");
			}
			if(startDate!=null && !startDate.trim().isEmpty()){
				long t = Long.parseLong(startDate.substring(0,4)+startDate.substring(5,7)+startDate.substring(8,10))-19000000L;
				sqlBuilder.append("AND A.ACTDT >= '").append(String.valueOf(t)).append("' ");
			}
			if(endDate!=null && !endDate.trim().isEmpty()){
				long t = Long.parseLong(endDate.substring(0,4)+endDate.substring(5,7)+endDate.substring(8,10))-19000000L;
				sqlBuilder.append("AND A.ACTDT <= '").append(String.valueOf(t)).append("' ");
			}
			if(ordno!=null && !ordno.trim().isEmpty()){
				String temp="";
				String[] ordnos = new String[]{ordno};
				if(ordno.indexOf(ConstantUtils.SPLIT_2)>=0){
					ordnos = ordno.split(ConstantUtils.SPLIT_2);
				}else if(ordno.indexOf(ConstantUtils.SPLIT_0)>=0){
					ordnos = ordno.split(ConstantUtils.SPLIT_0);
				}else if(ordno.indexOf(ConstantUtils.SPLIT_1)>=0){
					ordnos = ordno.split(ConstantUtils.SPLIT_1);
				}else{
				}
				for(int i=0;i<ordnos.length;i++){
					if(!ordnos[i].trim().equals("")){
						temp=temp+"'"+ordnos[i].trim()+"',";
					}
				}
				temp=temp.substring(0, temp.length()-1);
				sqlBuilder.append("AND (A.ORDNO IN (").append(temp).append(")");
				if(ordnos.length ==1){
					sqlBuilder.append(" OR A.ORDNO LIKE '%").append(temp.substring(1,temp.length()-1)).append("%')");
				}else{
					sqlBuilder.append(")");
				}
			}
			sqlBuilder.append(" ORDER BY A.ORDNO DESC");
//			String sql = "SELECT ORDNO,HOUSE,CURID,BUYNO,PSTTS,ACTDT FROM "+envIdXA.trim()+".POMAST WHERE VNDNR = '"+userCode+"' AND PSTTS != '99' "+"ORDER BY ORDNO DESC";
			System.out.println("sql is "+sqlBuilder.toString());
			executeQuery = statement.executeQuery(sqlBuilder.toString());
			if(executeQuery!=null){
				while(executeQuery.next()){
					Map<String,String> item = new HashMap();
					item.put("ordno", executeQuery.getString("ORDNO"));
					item.put("house", executeQuery.getString("HOUSE"));
					item.put("curid", getZbmsctlCurid(executeQuery.getString("CURID")));
					item.put("buyno", executeQuery.getString("BUYNO"));
					item.put("pstts", executeQuery.getString("PSTTS"));
					item.put("actdt", getActdt(executeQuery.getString("ACTDT")));
					results.add(item);
				}
			}
		}catch (Exception e) {
			System.out.print(e);
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

	private String getZbmsctlCurid(String result) {
		if(!result.trim().isEmpty())
			return result;
		Statement statement = null;
		ResultSet executeQuery = null ;
		try {
			statement = conn.createStatement();
			String sql = "SELECT CURID FROM "+envId.trim()+".ZBMSCTL WHERE SITE = '"+stid+"'";
			executeQuery = statement.executeQuery(sql);
			if(executeQuery!=null){
				if(executeQuery.next()){
					result = executeQuery.getString("CURID").trim().isEmpty()?"CNY":executeQuery.getString("CURID").trim();
				}
			}
		}catch (Exception e) {
			System.out.print(e);
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
		return result.trim();
	}

	private String getActdt(String result) {
		if(result.trim().isEmpty())
			return "";
		result = new BigDecimal(result).add(new BigDecimal(19000000L)).toString();
		return result.substring(0, 4)+"-"+result.substring(4,6)+"-"+result.substring(6, 8);
	}
}
