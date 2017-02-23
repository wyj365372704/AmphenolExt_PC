<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/global.css" rel="stylesheet" type="text/css" />
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
	<table cellpadding="5px" width="400" height="250" class="tb"
		align="center"
		style='page-break-after: always;border-collapse: collapse;'>
		<tbody>
			<tr>
				<td>
					<table width="100%">
						<tbody>
							<tr>
								<td align="center" width="100%"><span
									style="font-weight: bold;font-size:18px;">安费诺供应商 - 生产标签</span>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table width="100%" height="100%" cellpadding="3px" border="0">
						<tbody>
							<tr>
								<td>物料:${fordrji}</td>
								<td>批号:${fblcft9}</td>
								<td rowspan="3" align="left"><img src="${qrcodeurl}" width="80px" /></td>
							</tr>
							<tr>
								<td colspan="2">描述:${fds40ji}</td>
							</tr>
							<tr>
								<td>数量:${fcout }</td>
								<td>单重:${fweight }${fweight_unit}</td>
							</tr>
							<tr>
								<td>净重:${fcout*fweight }${fweight_unit}</td>
								<td colspan="2">毛重:${totalweight }g</td>
							</tr>
							<tr>
								<td>日期:${fdate }</td>
								<td colspan="2">厂商:${fproducter}</td>
							</tr>
					</table></td>
			</tr>
		</tbody>
	</table>
</body>
</html>