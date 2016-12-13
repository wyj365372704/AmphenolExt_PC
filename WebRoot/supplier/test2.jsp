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
Connection connLoc = null;
Connection connXA = null;
	Statement stmt = null;
	ResultSet rs = null;
	String result="";
	String sql0="";
	String itrvt9 ="";
	String ldesc="";
	String guige = "";
	String kcdw = "";
	String BLCFT9 ="1";
	float weight = 0.0f;
try{
	java.sql.DriverManager.registerDriver (new com.ibm.as400.access.AS400JDBCDriver ()); 
	Class.forName("com.ibm.as400.access.AS400JDBCDriver");	
	String urlXa ="jdbc:as400://"+ConstantUtils.DATABASE_IP+"/"+envIdXA+";translate binary=true"; 
 	connXA = DriverManager.getConnection(urlXa, ConstantUtils.DATABASE_NAME, ConstantUtils.DATABASE_PASSWORD);
	String urlLoc ="jdbc:as400://"+ConstantUtils.DATABASE_IP+"/"+envId+";translate binary=true"; 
 	connLoc = DriverManager.getConnection(urlLoc, ConstantUtils.DATABASE_NAME, ConstantUtils.DATABASE_PASSWORD);
 		//select * from (select a.*,rownumber() over() as rowid from (select * from tbl_net_order) a) tmp 
	//where tmp.rowid >=#{startIndex} and tmp.rowid <= #{endIndex};
 	 sql0="select * from "+envIdXA.trim()+".ITMSIT where STIDT9 = '"+stid+"' and ITNOT9 ='"+itnot9+"'" ;
 	//sql0=sql0+" where temp.rowid >=0 and temp.rowid <= 10";
 	
 	stmt = (Statement) connXA.createStatement();
	stmt.execute(sql0);//执行select语句用executeQuery()方法，执行insert、update、delete语句用executeUpdate()方法。
	rs=(ResultSet) stmt.getResultSet();
	while(rs.next()){
		itrvt9 = rs.getString("ITRVT9");
		kcdw = rs.getString("UMSTT9");
		BLCFT9 =rs.getString("BLCFT9");
	}
	rs.close();
	stmt.close();
	String sql1="select * From "+envId.trim()+".ZITMEXT where STID = '"+stid+"' and ITNBR = '"+itnot9+"' and ITRV = 

'"+itrvt9+"'";
	stmt = (Statement) connLoc.createStatement();
	stmt.execute(sql1);//执行select语句用executeQuery()方法，执行insert、update、delete语句用executeUpdate()方法。
	rs=(ResultSet) stmt.getResultSet();
	while(rs.next()){
		//itrvt9 = rs.getString("ITRVT9");
		ldesc=rs.getString("LDESC");
		guige = rs.getString("SDESC");
	}
	rs.close();
	stmt.close();
	//From %AMFLIB%.ITMRVA% where STID = ITMSIT.STIDT9 and ITNBR = ITMSIT.ITNOT9 and ITRV = ITMSIT.ITRVT9
	
		String sql2="select * From "+envIdXA.trim()+".ITMRVA where STID = '"+stid+"' and ITNBR = '"+itnot9+"' and 

ITRV = '"+itrvt9+"'";
		stmt = (Statement) connXA.createStatement();
		stmt.execute(sql2);//执行select语句用executeQuery()方法，执行insert、update、delete语句用executeUpdate()方法

。
System.out.println("sql2 = "+sql2 );
		rs=(ResultSet) stmt.getResultSet();
		while(rs.next()){
			//itrvt9 = rs.getString("ITRVT9");
		    if(null==ldesc || ldesc.trim().equals("")){
			ldesc=rs.getString("ITDSC");
		    }
			weight = rs.getFloat("WEGHT");
			
		}
		//ldesc=ldesc+"123";
	
	rs.close();
	stmt.close();
	}catch(Exception e){
	e.printStackTrace();
}finally{
	try{
	rs.close();//后定义，先关闭
	stmt.close();
	connXA.close();//先定义，后关闭
	connLoc.close();//先定义，后关闭
	}catch(Exception e){
		
	}
System.out.println("----->the blcft9 is "+BLCFT9.trim());
}
%>
{"ldesc":"<%=ldesc.trim() %>","guige":"<%=guige.trim() %>","kcdw":"<%=kcdw.trim() %>","blcft9":"<%=BLCFT9.trim() 

%>","weight":"<%=weight %>"}
