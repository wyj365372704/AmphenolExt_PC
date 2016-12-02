<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.amphenol.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.math.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//from %AMFLIB%.ITMSIT where STIDT9 = %STID% and ITNOT9 =
String envId = (String)session.getAttribute("envId");
String envIdXA = (String)session.getAttribute("envIdXA");
String userCode = (String)session.getAttribute("userCode");
String userHouse = (String)session.getAttribute("userHouse");
String stid = (String)session.getAttribute("stid");
String itnot9 = request.getParameter("itnot9");
Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String result="";
	String sql0="";
	String itrvt9 ="";
	String ldesc="";
try{
	java.sql.DriverManager.registerDriver (new com.ibm.as400.access.AS400JDBCDriver ()); 
	Class.forName("com.ibm.as400.access.AS400JDBCDriver");	
	String url ="jdbc:as400://"+ConstantUtils.DATABASE_IP+"/"+envIdXA+";translate binary=true"; 
 	conn = DriverManager.getConnection(url, ConstantUtils.DATABASE_NAME, ConstantUtils.DATABASE_PASSWORD);
 		//select * from (select a.*,rownumber() over() as rowid from (select * from tbl_net_order) a) tmp 
	//where tmp.rowid >=#{startIndex} and tmp.rowid <= #{endIndex};
 	// sql0="select * from "+envIdXA.trim()+".ITMSIT where STIDT9 = '"+stid+"' and ITNOT9 ='"+itnot9+"'" ;
 	//sql0=sql0+" where temp.rowid >=0 and temp.rowid <= 10";
 	String strt = "";
			if ("ITMRVA".equalsIgnoreCase(ConstantUtils.ITNFROM)) {
				strt = "ITNBR";
			} else {
				strt = "ITNO";
			}
			
 	sql0 = "select temp.* from (select a.*,rownumber() over() as rowid from (Select * from "
				+ envIdXA.trim()
				+ "."
				+ ConstantUtils.ITNFROM
				+ " where "+strt+" like '%"+itnot9+"%') a ) temp ";
		sql0=sql0+" where temp.rowid >=0 and temp.rowid <= 10";
 	System.out.println("sql0="+sql0);
 	stmt = (Statement) conn.createStatement();
		stmt.execute(sql0);//执行select语句用executeQuery()方法，执行insert、update、delete语句用executeUpdate()方法。
		rs = (ResultSet) stmt.getResultSet();
		int i=0;
		while (rs.next()) {
			String str = "";
			if ("ITMRVA".equalsIgnoreCase(ConstantUtils.ITNFROM)) {
				str = rs.getString("ITNBR");
			} else {
				str = rs.getString("ITNO");
			}
			result = result + "<option value='" + str.trim() + "'>"
					+ str.trim() + "</option>";
					i++;
					//if(i>10){
					//	break;
					//}
		}
		rs.close();
		stmt.close();
	}catch(Exception e){
//result=e.getMessage();
e.printStackTrace();
	try{
	rs.close();//后定义，先关闭
	stmt.close();
	conn.close();//先定义，后关闭
	}catch(Exception ex){
		
	}
}finally{
	try{
	rs.close();//后定义，先关闭
	stmt.close();
	conn.close();//先定义，后关闭
	}catch(Exception e){
		
	}
}
%>
<%=(result) %>