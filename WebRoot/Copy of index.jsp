<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    
    <title>test connect</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>
  <table>
  <tr>
  		<td>选择</td>
  		<td>工厂</td>
  		<td>采购单号 项次</td>
  		<td>物料</td>
  		<td>描述</td>
  		<td>采购单位</td>
  		<td>采购量</td>
  		<td>未交量</td>
  		<td>采购交期</td>
  		<td>是否批次控制</td>
  </tr>
<%
String userName=(String)session.getAttribute("userName");
String envId = (String)session.getAttribute("envId");
String envIdXA = (String)session.getAttribute("envIdXA");
String userCode = (String)session.getAttribute("userCode");
String userHouse = (String)session.getAttribute("userHouse");
String stid = (String)session.getAttribute("stid");
if(userName==null || "".equals(userName.trim())){
%>
<script type="text/javascript">
window.location.href="logo.jsp";

</script>


<%	
}
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String result="";
try{
	java.sql.DriverManager.registerDriver (new com.ibm.as400.access.AS400JDBCDriver ()); 
	Class.forName("com.ibm.as400.access.AS400JDBCDriver");	
	String url ="jdbc:as400://10.1.5.37/"+envIdXA+";translate binary=true"; 
 	conn = DriverManager.getConnection(url, "QSECOFR", "QSECOFR");
 	String sql="select SCHRCP.*,ITMSIT.BLCFT9 from "+envIdXA+".SCHRCP as SCHRCP,"+envIdXA+".ITMSIT as ITMSIT where VNDRJI='"+userCode+"' and SCHRCP.ITNOJI=ITMSIT.ITNOT9 and ITMSIT.STIDT9='"+stid+"'";
 	//String sql="select SCHRCP.* from "+envIdXA+".SCHRCP as SCHRCP where VNDRJI='"+userCode+"' ";
 	if(!"*ALL".equals(userHouse)){
 		sql=sql+" AND SCHRCP.WHIDJI='"+userHouse+"'";
 	}
 	if(conn!=null){
 		//result="已经成功连接数据库";
 	
	   stmt = (Statement) conn.createStatement();
	   stmt.execute(sql);//执行select语句用executeQuery()方法，执行insert、update、delete语句用executeUpdate()方法。
	   rs=(ResultSet) stmt.getResultSet();
	while(rs.next()){ //当前记录指针移动到下一条记录上
%>
<tr>
	<td><input type="button" value="添加送货单"></td>
	<td><%=rs.getString("WHIDJI") %></td>
	<td><%=rs.getString("ORDRJI")+"-"+rs.getInt("PISQJI")+"-"+rs.getInt("BKSQJI") %></td>
	<td><%=rs.getString("ITNOJI") %></td>
	<td><%=rs.getString("DS40JI") %></td>
	<td><%=rs.getString("ORUMJI") %></td>
	<td><%=rs.getString("UCOQJI") %></td>
	<td><%=rs.getInt("QTYOJI")/rs.getInt("UMCVJI") %></td>
	<td><%=(rs.getInt("DKDTJI") +Integer.valueOf(19000000))%> </td>
	<td><%=("1".equals(rs.getString("BLCFT9"))?"是":"否") %></td>
</tr>
<%

  	 }
	}
}catch(Exception e){
result=e.getMessage();
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
</table>
<%=result %>
  </body>
</html>
