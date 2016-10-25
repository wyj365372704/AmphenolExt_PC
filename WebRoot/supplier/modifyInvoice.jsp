<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="javax.xml.bind.annotation.XmlElementDecl.GLOBAL"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.amphenol.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%
	String SHPNO = new String(request.getParameter("SHPNO").getBytes(
			"ISO8859-1"), "utf-8").trim();
	String LGWNO = new String(request.getParameter("LGWNO").getBytes(
			"ISO8859-1"), "utf-8").trim();
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
	function modifyInvoice() {
		document.getElementById("invoiceForm").submit();
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

	<form method="post" id="invoiceForm"
		action="<%=request.getContextPath()%>/modifyInvoiceServlet">
		<input type="hidden" value="<%=SHPNO %>" name="SHPNO"/>
		<div class="public_div">
			<h2>
				<br> <span class="fl"></span>
			</h2>
			<h2>
				<span class="fl">修改发票号</span> <span class="fr"></span>
				<!--  span里无内容时，此span不能删除  -->
			</h2>
			<div class="public_inner">
				<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="public_table">
					<tr>
						<td>发票号</td>
						<td>
						<input name="LGWNO" type="text" class="input_w" value="<%=LGWNO%>"/>
						</td>
					</tr>
					<tr align="center" id="insertSpareEpt">
						<td colspan="2"><input name="makeMark" type="button"
							class="button_m" value="确定" onclick="modifyInvoice();" /></td>
					</tr>
				</table>
			</div>
		</div>

	</form>
</body>
<script type="text/javascript">
	
</script>
</html>
