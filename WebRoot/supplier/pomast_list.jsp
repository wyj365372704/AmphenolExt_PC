<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.amphenol.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.math.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/customsDeclaration.css" rel="stylesheet" type="text/css" />
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
</head>
<script type="text/javascript">
	function submit2(toPage) {
		document.getElementById("currentPage").value = toPage;
		document.getElementsByName("queryform")[0].submit();
	}
	function gopage(){
	submit2(document.getElementById("gpageno").value);
	}
	function printOdr(ordno) {
		//alert(house);
		window
				.open(
						"./supplier/pomast_pre.jsp?ordno=" + ordno,
						'newwindow',
						'height=251,width=400,top='
								+ (window.outerHeight / 3)
								+ ',left='
								+ (window.outerWidth / 2)
								+ ',toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
	}
		function onclear(){
		document.getElementsByName("buyno")[0].value="";
		document.getElementsByName("ordno")[0].value="";
		document.getElementsByName("startDate")[0].value="";
		document.getElementsByName("endDate")[0].value="";
		document.getElementsByName("currentPage")[0].value="0";
	}
</script>


<body class="right_body">
	<div class="path">您现在的位置： 首页 &gt; 生产 &gt; 采购订单</div>
	<form action="SubcontractPurchaseServlet" method="post"
		name="queryform">
		<input type="hidden" id="currentPage" name="currentPage"
			value="${currentPage }">
		<div class="search">
			<h2>
				<span class="fl">外协订单查询</span> <span class="fr"><input
					name="" type="button" class="search_button" onclick="submit2(1);" />
					<input name="rs" type="button" class="purge_button"
					onclick="onclear();" /> </span>
				<!--  span里无内容时，此span不能删除  -->
			</h2>

			<ul>
				<li><div class="w_s">采购员：</div> <input type="text"
					class="input_w" name="buyno" value="${buyno }">
				</li>
				<li><div class="w_s">订单：</div> <textarea rows="" cols=""
						class="input_w" name="ordno" style="height:30px" value="${ordno }"></textarea>
				</li>
				<li><div class="w_s">创建日期：</div> <input type="text"
					id="startDate" name="startDate" class="time_input"
					onclick="WdatePicker()" autocomplete="on" value="${startDate }">
					- <input type="text" id="endDate" name="endDate" class="time_input"
					onclick="WdatePicker()" autocomplete="on" value="${endDate }">
				</li>
			</ul>
		</div>
		<div class="data_list">
			<h2>
				<span class="fl">外协订单列表</span> <span class="fr"></span>
				<!--  span里无内容时，此span不能删除  -->
			</h2>

			<div class="list_inner">
				<table width="100%" border="0" cellspacing="1" cellpadding="0"
					class="list_table_s">
					<tr>
						<th>单号</th>
						<th>仓库</th>
						<th>币种</th>
						<th>采购员</th>
						<th>订单状态</th>
						<th>创建日期</th>
						<th>操作</th>
					</tr>
					<c:forEach var="item" items="${results}" varStatus="st">
						<c:if test="${st.count%2==0}">
							<tr class="td_bgcolor">
						</c:if>
						<c:if test="${st.count%2!=0}">
							<tr class="td_bgcolor2">
						</c:if>
						<td><c:out value="${item.ordno}"></c:out></td>
						<td><c:out value="${item.house}"></c:out></td>
						<td><c:out value="${item.curid}"></c:out>
						</td>
						<td><c:out value="${item.buyno}"></c:out>
						</td>
						<td><c:choose>
								<c:when test="${item.pstts==10}">
					需要供应商确认
					</c:when>
								<c:when test="${item.pstts==20}">
					供应商已接受
					</c:when>
								<c:when test="${item.pstts==30}">
					部分收货
					</c:when>
								<c:when test="${item.pstts==35}">
					发票完成
					</c:when>
								<c:when test="${item.pstts==40}">
					收货完成
					</c:when>
								<c:when test="${item.pstts==50}">
					发票、收货都完成
					</c:when>
								<c:when test="${item.pstts==99}">
					已取消
					</c:when>
							</c:choose></td>
						<td><c:out value="${item.actdt}"></c:out></td>
						<td><input type="button" id="printO" value="打印"
							class="gray_button" onclick="printOdr('${item.ordno}');" />
						</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="page">
			共有&nbsp;${pageCount}&nbsp;页&nbsp;&nbsp;${itemCount}&nbsp;条记录，当前为第&nbsp;${currentPage}&nbsp;页
			<a title="" onclick="submit2(1);">首页</a> <a title=""
				onclick="submit2(${currentPage-1});">上一页</a> <a title=""
				onclick="submit2(${currentPage+1});">下一页</a> <a title=""
				onclick="submit2(${pageCount});">尾页</a> 每页${pageSpace}条 到第<input
				type="text" class="page_input" id="gpageno" value="1" />页 <input
				type="button" value="" class="go_button" onclick="gopage()" />
		</div>
	</form>
</body>
</html>