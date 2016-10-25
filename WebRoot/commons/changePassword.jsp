<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="com.xy.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(basePath);
String oldPassWord=(String)request.getParameter("oldPassWord");
String newPassWord1=(String)request.getParameter("newPassWord1");
String newPassWord2=(String)request.getParameter("newPassWord2");
String userName=(String)session.getAttribute("userName");
String password=(String)session.getAttribute("password");
String operate=(String)request.getParameter("operate");
boolean issuccess=false;
DBUtil dbUtil = DBUtil.getInstance();
	Connection conn = null;
	Statement stmt = null;
	try{
		String sql="update t_pm_user set fpasswordnew='"+newPassWord1+"' where fnumber='"+userName+"'";
		
		if(operate.equals("update")){
			conn = dbUtil.getConnection();
			stmt = conn.createStatement();
			int r=stmt.executeUpdate(sql);
			if(r>0){
				issuccess=true;
				session.removeAttribute("userName");
				session.removeAttribute("password");
			}
		}
	}catch(Exception e){
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>新亚ERP系统</title>

<link href="../css/global.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript">
	var issuccess="<%=issuccess %>";
	var password="<%=password %>";
	var operate="<%=operate %>";
	if(issuccess=="true"){
		alert("修改成功，请重新登陆！");
		window.parent.location.href="<%=basePath%>"+"/index.jsp";
	}else{
		if(operate=="update"){
			alert("修改密码失败，请重试！");
		}
		
	}
	function saveP(){
		var oldPassWord=document.getElementsByName("oldPassWord")[0].value;
		var newPassWord1=document.getElementsByName("newPassWord1")[0].value;
		var newPassWord2=document.getElementsByName("newPassWord2")[0].value;
		if(oldPassWord==""){
			alert("旧密码必须输入！");
			return false;
		}
		if(newPassWord1!=newPassWord2){
			alert("新密码与确认密码不一致！");
			return false;
		}
		if(oldPassWord!=password){
			alert("旧密码错误！");
			return false;
		}
		document.getElementsByName("operate")[0].value="update";
		document.getElementsByName("changePassword")[0].submit();
	}
</script>
<body class="right_body">

<form action="changePassword.jsp" method="post" name="changePassword">
	<input name="operate" type="hidden" value=""/>
	<div class="path">您现在的位置： 首页 &gt; 修改密码</div>
		
			<div class="public_div">
				<h2>
					<span class="fl">用户基本信息</span>
					<span class="fr"></span><!--  span里无内容时，此span不能删除  -->
				</h2>
				
				<div class="public_inner">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" class="public_table">
					  <tr>
					    <td class="td_w_s text_r">旧密码：</td>
					    <td><input type="password" name="oldPassWord" class="input_prompt" /><!--  input_prompt 样式为此处信息不符合要求，系统提示 所应用的样式  -->
                            <span class="red">*</span></td>
			            <td class="td_w_s text_r">&nbsp;</td>
			            <td>&nbsp;</td>
				  </tr>
					  <tr>
                        <td class="td_w_s text_r"> 新密码：</td>
					    <td><input type="password" name="newPassWord1" class="input_s_1" />
                            <span class="red">*</span></td>
					    <td class="td_w_s text_r">确认密码：</td>
					    <td><input type="password" name="newPassWord2" class="input_s_1" />
                        <span class="red">*</span></td>
			      </tr>
					</table>
			  </div>
			  </div>
			  
			  <div class="button_div">
			    <input name="save" type="button" class="save_button" onclick="saveP();"/><input name="" type="button" class="return_button" onclick="javascript:history.go(-1)"/>
			</div>
</form>

</body>
</html>
