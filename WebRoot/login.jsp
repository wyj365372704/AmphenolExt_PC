<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="utf-8"%>
<%
String isLogin = request.getParameter("isLogin");
String envId = request.getParameter("envId");
String name=request.getParameter("name");
String password=request.getParameter("password");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String result="";
	String resultRet="";
	String stid  = "";
try{
		java.sql.DriverManager.registerDriver (new com.ibm.as400.access.AS400JDBCDriver ()); 
	Class.forName("com.ibm.as400.access.AS400JDBCDriver");	
	String url ="jdbc:as400://10.1.5.37/QGPL;translate binary=true"; 
 	conn = DriverManager.getConnection(url, "QSECOFR", "QSECOFR");
 	String sqlQ="select * from QGPL.ZMMLIST ";
 	if(conn!=null){
 		//result="已经成功连接数据库";
 	
	   stmt = (Statement) conn.createStatement();
	   stmt.execute(sqlQ);//执行select语句用executeQuery()方法，执行insert、update、delete语句用executeUpdate()方法。
	   rs=(ResultSet) stmt.getResultSet();
		while(rs.next()){ //当前记录指针移动到下一条记录上
		    String str = rs.getString("ENVID");//得到当前记录的第一个字段(id)的值
	 		String str2 = rs.getString("AMPHLIB");
	 		String str3 = rs.getString("AMFLIB");	 		
	   		 stid  = rs.getString("STID");
		    result=result+"<option value='"+str2+"-"+str3+"'>"+str+"</option>";
		   // String name =rs.getString(2);//得到第二个字段(name)的值
		   // String psw = rs.getString("ppassword");//得到(password)的值
		   // System.out.println(Integer.toString(i)+" "+name+" "+psw);
	  	 }
 	}
}catch(Exception e){
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
if("1".equals(isLogin)){
if(envId!=null && !"".equals(envId.trim())){
		String[] strtemp = envId.split("-");
		envId=strtemp[0];
		session.setAttribute("envId",envId);
		if(strtemp.length>1){
			session.setAttribute("envIdXA",strtemp[1]);
	   session.setAttribute("stid",stid);
		}
try{

	java.sql.DriverManager.registerDriver (new com.ibm.as400.access.AS400JDBCDriver ()); 
	Class.forName("com.ibm.as400.access.AS400JDBCDriver");	
	String url ="jdbc:as400://10.1.5.37/"+envId+";translate binary=true"; 
 	conn = DriverManager.getConnection(url, "QSECOFR", "QSECOFR");
 	String sql="select * from "+envId+".ZSRMUSR where SRMUSR='"+name+"' and PASSWD='"+password+"'";
 	if(conn!=null){
 		//result="已经成功连接数据库";
 	
	   stmt = (Statement) conn.createStatement();
	   stmt.execute(sql);//执行select语句用executeQuery()方法，执行insert、update、delete语句用executeUpdate()方法。
	   rs=(ResultSet) stmt.getResultSet();
	   while(rs.next()){
	   String tempstr = rs.getString("SRMUSR");
	   String userCode  = rs.getString("VNDNR");
	   String userHouse  = rs.getString("HOUSE");
	   if(tempstr!=null && !"".equals(tempstr.trim())){
	   session.setAttribute("userName",name);
	   session.setAttribute("userCode",userCode);
	   session.setAttribute("userHouse",userHouse);
%>
	<script type="text/javascript">
	window.location.href="index.jsp";

	</script>
<%	   	
	   }else{
	   	resultRet="登陆异常：找不到用户名密码!";
	   }
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
	}
}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    
    <title>登录页面</title>
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
  <%
  	if(resultRet!=null && !resultRet.trim().equals("") && !resultRet.trim().equalsIgnoreCase("null")){
   %>
<div><%=resultRet %></div>
<%} %>
   <form action="login.jsp" method="post">
   <input type="hidden" name="isLogin" value="1"/>
   <table>
   		<tr>
   			<td>环境：</td>
   			<td> 
   			<select id="envId" name="envId">
  				<%=result %>
  			</select>
  			</td>
   		</tr>
   		<tr>
   			<td>用户名：</td>
   			<td><input type="text" name="name"></td>
   		</tr>
   		<tr>
   			<td>密码：</td>
   			<td><input type="password" name="password"></td>
   		</tr>
   		<tr>
   			<td><input type="submit" value="提交"></td>
   			<td><input type="reset" value="取消"></td>
   		</tr>
   </table>
   	
	</form>
  </body>
</html>
