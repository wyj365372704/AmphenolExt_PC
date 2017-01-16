<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>生产标签</title>
</head>
<body>
<table  border="0" cellpadding="2px" style="border-collapse: collapse;">
<tr>
<td rowspan="3" align="center" valign="middle"><img src="${qrcodeurl}" width="80px"/></td><td>物料:${fordrji}</td>
</tr>
<tr><td>描述:${fds40ji}</td></tr>
<tr><td>批号:${fblcft9}</td></tr>
<tr><td>数量:${fcout }</td><td>单重:${fweight }${fweight_unit}</td></tr>
<tr><td>净重:${fcout*fweight }${fweight_unit}</td><td>毛重:${totalweight }g</td></tr>
<tr><td>日期:${fdate }</td><td>厂商:${fproducter}</td></tr>
</table>
</body>
</html>