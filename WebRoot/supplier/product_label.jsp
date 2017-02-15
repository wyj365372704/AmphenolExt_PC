<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	.tb{
	    border: solid 1px;
        margin-bottom: 50px;
	}
	.btabel tr td{ 
		border:1px solid;
	}
</style>
<title>生产标签</title>
</head>
<body>
	<table cellpadding="5px" width="400" class="tb"
		style="border-collapse: collapse;">
		<tr>
			<td rowspan="3"><img
				src="${qrcodeurl}" width="80px" />
			</td>
			<td>物料:${fordrji}</td>
		</tr>
		<tr>
			<td>描述:${fds40ji}</td>
		</tr>
		<tr>
			<td>批号:${fblcft9}</td>
		</tr>
		<tr>
			<td>数量:${fcout }</td>
			<td>单重:${fweight }${fweight_unit}</td>
		</tr>
		<tr>
			<td>净重:${fcout*fweight }${fweight_unit}</td>
			<td>毛重:${totalweight }g</td>
		</tr>
		<tr>
			<td>日期:${fdate }</td>
			<td>厂商:${fproducter}</td>
		</tr>
	</table>
</body>
</html>