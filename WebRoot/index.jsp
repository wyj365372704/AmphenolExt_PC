<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="com.amphenol.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>Ampheno SRM</title>
			  <%
String userName=(String)session.getAttribute("userName");
if(userName==null || "".equals(userName.trim())){
%>
<script type="text/javascript">
window.location.href="/logo.jsp";
</script>
<%
}
 %>
</head>

<frameset rows="96,*,24" frameborder="no" border="5" framespacing="0">
  <frame src="commons/top.jsp" name="topFrame" scrolling="No" id="topFrame" />
  <frameset rows="*" cols="190,10,*" id="exFra" name="exFra" frameborder="no" border="5" framespacing="0">
    <frame src="commons/left.html" name="exLeftFrame" scrolling="auto" noresize="noresize" id="exLeftFrame" />
    <frame src="commons/explorer_scroll.html" name="exScrollFrame" scrolling="No" noresize="noresize" id="exScrollFrame" />
	<frame src="commons/right.jsp" name="exMainTFrame" scrolling="auto" noresize="noresize" id="exMainTFrame" />
	</frameset>
  <frame  src="commons/bottom.html"   name="exMainFrame" id="exMainFrame" frameborder="no"  />
</frameset>
<noframes><body>
</body>
</noframes>
</html>
