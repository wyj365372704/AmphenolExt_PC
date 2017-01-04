<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String envName = (String)session.getAttribute("envName");

String userName = (String)session.getAttribute("userName");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Ampheno SRM</title>

<link href="../css/userCenter.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript">
	function logout(){
		window.parent.location.href="../logo.jsp";
	}
</script>
<body class="head_body_bg">

<div class="head">
	<div class="head_top">
		<img src="../images/logo.png" style="width: 200px;height: 51px;float: left;">
		<div class="head_top_r">
			<p class="p_t"><a href="../commons/right.jsp" target="exMainTFrame" title="" class="home">首页</a>  <a href="../userinterface/修改密码.html" target="exMainTFrame" title="" class="password">修改密码</a> <a href="#" title="" class="help">帮助中心</a> <a href="#" title="" class="logout" onclick="logout();">注销</a> </p>
			<p class="p_b"> <span class="welcome fr"><font color="red">环境：<%=envName %></font>&nbsp&nbsp&nbsp&nbsp用户：<%=userName %></span> </p>
		</div>
	</div>
	
	<div class="tabs">
		<ul>
		    <!--
			<li><a href="#" title=""><span>用户管理系统</span></a></li>
			<li><a href="#" title=""><span>货代系统</span></a></li>
			<li><a href="#" title=""><span>仓储管理系统</span></a></li>
			-->
			<li><a href="#" title="" class="tabs_s"><span>Amphenol</span></a></li><!--  tabs_s 样式为停留在当系统标签所应用的样式  -->
	  </ul>
	</div>

</div>

</body>
</html>
