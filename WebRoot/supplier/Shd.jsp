<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String shdz1;
	String shdz2;
	String shdz3;
	String shcs;
	String shdh;
	String lsr;
	String ewtm;
	String phone;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>Amphenol</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<script type="text/javascript">
	window.onbeforeunload()
	{

	}
</script>

<body>
	<table border="0" cellpadding="5px">
		<tr>
			<td colspan="2">
				<table width="100%">
					<tr>
						<td align="center" width="100%"><span style="font-weight: bold;font-size:18px;">Amphenol 厂商送货单</span></td>
						<td align="right" nowrap="nowrap">日期:${date}&nbsp;&nbsp;</td>
					</tr>
				</table></td>

		</tr>
		<tr>
			<td colspan="2" nowrap="nowrap">----------------------------------------------------------------------------------------------------</td>
		</tr>
		<tr>
			<td colspan="2">
				<table width="100%" border="0"  cellpadding="5px"
					style="border-collapse: collapse;">
					<tr>
						<td nowrap="nowrap" width="100%">送货厂商:${shEntity.shcs}</td>
						<td rowspan="5"><img src="${shEntity.ewm }" />
						</td>
					</tr>
					<tr>
						<td nowrap="nowrap">Amphenol 送货单号:${shEntity.shdh}</td>
					</tr>
					<tr>
						<td nowrap="nowrap">送货地址:${shEntity.shdz1}</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;${shEntity.shdz2}&nbsp;${shEntity.shdz3}</td>
					</tr>
					<tr>
						<td nowrap="nowrap">联系人:${shEntity.lxr}&nbsp;&nbsp;${shEntity.phone}</td>
					</tr>
				</table></td>
		</tr>

		<tr>
			<td colspan="2">
				<table width="100%" border="1" cellpadding="5px"
					style="border-collapse: collapse;">
					<td align="center" nowrap="nowrap">序号</td>
					<td align="center" nowrap="nowrap">采购单-项次</td>
					<td align="center" nowrap="nowrap">物料</td>
					<td align="center" nowrap="nowrap">描述</td>
					<td align="center" nowrap="nowrap">采购单位</td>
					<td align="center" nowrap="nowrap">数量</td>
					<td align="center" nowrap="nowrap">单重</td>
					<td align="center" nowrap="nowrap">重量</td>
					<td align="center" nowrap="nowrap">单位(W)</td>
					<c:forEach items="${shEntity.sdhItems}" var="sdhItems"
						varStatus="status">
						<tr>
							<td align="center">${status.index+1 }</td>
							<td align="center">${sdhItems.xc}</td>
							<td align="center">${sdhItems.wl}</td>
							<td align="center">${sdhItems.ms}</td>
							<td align="center">${sdhItems.cgdw}</td>
							<td align="center">${sdhItems.sl}</td>
							<td align="center">${sdhItems.dz}</td>
							<td align="center">${sdhItems.zl}</td>
							<td align="center">${sdhItems.dw}</td>
						</tr>
						<c:if
							test="${sdhItems.pcItem!=null && fn:length(sdhItems.pcItem)>0 }">
							<tr>
								<td></td>
								<td colspan="8">
									<table border="0">
										<tr align="center">
											<td>批次号</td>
											<td>数量</td>
										</tr>
										<tr align="center">
											<td>----------</td>
											<td>----------</td>
										</tr>
										<c:forEach items="${sdhItems.pcItem}" var="pcItem">
											<tr align="center">
												<td>${pcItem.pch }</td>
												<td>${pcItem.sl }</td>
											</tr>
										</c:forEach>
									</table></td>
							</tr>
						</c:if>
					</c:forEach>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2" nowrap="nowrap">----------------------------------------------------------------------------------------------------</td>
		</tr>
		<tr>
			<td colspan="2">
				<table border="0" width="100%">
					<tr>
						<td>供应商：</td>
						<td>接收人：</td>
						<td>IQC：</td>
					</tr>
				</table></td>
		</tr>
	</table>
</body>

<script language=javascript>
	window.opener.location.href = window.opener.location.href;
</script>
</html>
