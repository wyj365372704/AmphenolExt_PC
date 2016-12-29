<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
String ordno = request.getParameter("ordno");

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<head>
 <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/customsDeclaration.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
		function submitp(){
			var ordno = document.getElementsByName("ordno")[0].value;
			var chk01 = document.getElementsByName("chk01")[0].checked;
			var chk02 = document.getElementsByName("chk02")[0].checked;
			var chk03 = document.getElementsByName("chk03")[0].checked;
			var language = document.getElementById("language").value;
			//alert(ordno+"-"+chk01+"-"+chk02);
			window.open('getSubcontractPurchaseOrderServlet?ordno='+ordno+'&chk01='+chk01+'&chk02='+chk02+'&chk03='+chk03+'&language='+language,
			'newwindow',
						'height=400,width=500,top=50,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
		}
		
	</script>
</head>

<body>
	<form action="getSubcontractPurchaseOrderServlet" method="post">
		<div class="public_div">

			<div class="public_inner">
				<table width="100%" border="0" cellspacing="1" cellpadding="0"
					class="public_table">

					<tr>
						<td class="td_w_s text_r">语言选择：</td>
						<td><select id="language">
								<option value="0" selected>中文</option>
								<option value="1">英文</option>
						</select> <input type="hidden" name="ordno" value="<%=ordno %>"></td>
					</tr>
					<tr>
						<td class="td_w_s text_r">已经完成接收的项目/下达</td>
						<td><input type="checkbox" name="chk01" /></td>
					</tr>
					<tr>
						<td class="td_w_s text_r">无下达的总括项目</td>
						<td><input type="checkbox" name="chk02" /></td>
					</tr>
					<tr>
						<td class="td_w_s text_r">已取消项目/下达</td>
						<td><input type="checkbox" name="chk03" /></td>
					</tr>
					<tr>
						<td class="td_w_s text_r"></td>
						<td><input type="button" id="printO" value="打印"
							class="gray_button" onclick="submitp();" /></td>
					</tr>
				</table>
			</div>
		</div>
	</form>
</body>
<script type="text/javascript">
		
	</script>
</html>
