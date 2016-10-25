<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="javax.xml.bind.annotation.XmlElementDecl.GLOBAL"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.amphenol.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%
	String PISQJI = new String(request.getParameter("PISQJI").getBytes(
			"ISO8859-1"), "utf-8");
	String ORDRJI = new String(request.getParameter("ORDRJI").getBytes(
			"ISO8859-1"), "utf-8");
	String OLDDATE = new String(request.getParameter("OLDDATE").getBytes(
			"ISO8859-1"), "utf-8");
	String BKSQJI = new String(request.getParameter("BKSQJI").getBytes(
			"ISO8859-1"), "utf-8");
%>
<%
	String userName = (String) session.getAttribute("userName");
	String envIdXA = (String) session.getAttribute("envIdXA");
	String userCode = (String) session.getAttribute("userCode");
	String stid = (String) session.getAttribute("stid");
	if (userName == null || "".equals(userName.trim())) {
%>
<script type="text/javascript">
	window.location.href = "logo.jsp";
</script>
<%
	}
%>
<script type="text/javascript">
	function ensureDate() {
		document.getElementById("ensureDate").submit();
	}
</script>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title></title>

<link href="../css/customsDeclaration.css" rel="stylesheet"
	type="text/css" />
<script src="../js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
</head>

<body class="right_body">

	<form method="post" id="ensureDate"
		action="<%=request.getContextPath()%>/EnsureDateServlet">
		<input type="hidden" value="<%=PISQJI %>" name="PISQJI"/>
		<input type="hidden" value="<%=ORDRJI %>" name="ORDRJI"/>
		<input type="hidden" value="<%=OLDDATE %>" name="OLDDATE"/>
		<input type="hidden" value="<%=BKSQJI %>" name="BKSQJI"/>
		<div class="public_div">
			<h2>
				<br> <span class="fl"></span>
			</h2>
			<h2>
				<span class="fl">确认送货日期</span> <span class="fr"></span>
				<!--  span里无内容时，此span不能删除  -->
			</h2>
			<div class="public_inner">
				<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="public_table">
					<tr>
						<td>送货日期</td>
						<td>
						<%
						SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyyMMdd");
						SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
						Date oldDate = dateFormat1.parse(OLDDATE);
						 %>
						<input name="newDate" type="text" class="time_input" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-{%d}'})" onmouseout="dateIsValid(this,'开始日期')" value="<%=dateFormat2.format(oldDate)%>"/>
						</td>
					</tr>
					<tr align="center" id="insertSpareEpt">
						<td colspan="2"><input name="makeMark" type="button"
							class="button_m" value="确定" onclick="ensureDate();" /></td>
					</tr>
				</table>
			</div>
		</div>

	</form>
</body>
<script type="text/javascript">
	
</script>
</html>
