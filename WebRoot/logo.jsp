<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="utf-8"%>
<%@ page import="com.amphenol.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Ampheno SRM</title>
<style type="text/css">
<!--
body,html{height:100%;}
-->
</style>
<link href="css/userCenter.css" rel="stylesheet" type="text/css" />
</head>
<%
	session.removeAttribute(ConstantUtils.CURRENT_USERNUMBER);
				//session.removeAttribute(ConstantUtils.CURRENT_USERPASSWORD);
 %>
 
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
	String url ="jdbc:as400://"+ConstantUtils.DATABASE_IP+"/QGPL;translate binary=true"; 
 	conn = DriverManager.getConnection(url, ConstantUtils.DATABASE_NAME, ConstantUtils.DATABASE_PASSWORD);
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
		    result=result+"<option value='"+str2+"-"+str3+"-"+str+"'>"+str+"</option>";
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
			session.setAttribute("envName",strtemp[2]);
	   		session.setAttribute("stid",stid);
		}
try{

	java.sql.DriverManager.registerDriver (new com.ibm.as400.access.AS400JDBCDriver ()); 
	Class.forName("com.ibm.as400.access.AS400JDBCDriver");	
	String url ="jdbc:as400://"+ConstantUtils.DATABASE_IP+"/"+envId+";translate binary=true"; 
 	conn = DriverManager.getConnection(url, ConstantUtils.DATABASE_NAME, ConstantUtils.DATABASE_PASSWORD);
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
<body >
<table class="logo_div" >
<form action="logo.jsp" method="post" >

<input type="hidden" name="isLogin" value="1"/>
	<tr>
		<td><div class="logo_info" >
			<table border="0" cellspacing="0" cellpadding="0" class="logo_table">
				<tr>
				<td class="text_r">环境：</td>
				<td class="text_l"><label>
			<select id="envId" name="envId">
  				<%=result %>
  			</select>
				</label></td>
			  </tr>
			  <tr>
				<td class="text_r">用户名：</td>
				<td class="text_l"><label>
				  <input type="text" name="name" class="logo_i_1" />
				</label></td>
			  </tr>
			  <tr>
				<td class="text_r">密码：</td>
				<td class="text_l"><label>
				  <input type="password" name="password" class="logo_i_1" />
				</label></td>
			  </tr>
			   
			  <tr>
				<td>&nbsp;</td>
				<td class="text_l"><label>
				  <input type="submit" name="Submit" value="" class="logo_button" />
				</label></td>
			  </tr>
		  </table>

		</div></td>
	</tr>
</form>
</table>
</body>
</html>