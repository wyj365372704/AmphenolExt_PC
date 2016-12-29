<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.amphenol.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.math.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Ampheno SRM</title>
<link href="../css/customsDeclaration.css" rel="stylesheet"
	type="text/css" />
<script src="../js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
</head>
<script type="text/javascript">
	var pagenum = "1";
	function submit2() {
		// 

		document.getElementsByName("buyIn")[0].submit();
	}
	function first() {
		if (document.getElementsByName("pageno")[0].value == "1") {

		} else {
			document.getElementsByName("pageno")[0].value = "1";
			document.getElementsByName("buyIn")[0].submit();
		}

	}
	function pre() {
		XA
		if (parseInt(document.getElementsByName("pageno")[0].value) > 1) {
			document.getElementsByName("pageno")[0].value = parseInt(document
					.getElementsByName("pageno")[0].value) - 1;
			document.getElementsByName("buyIn")[0].submit();
		} else {
			document.getElementsByName("pageno")[0].value = "1";
		}

	}
	function next() {

		if (parseInt(pagenum)
				- parseInt(document.getElementsByName("pageno")[0].value) > 0) {
			document.getElementsByName("pageno")[0].value = parseInt(document
					.getElementsByName("pageno")[0].value) + 1;
			document.getElementsByName("buyIn")[0].submit();
		} else {
			document.getElementsByName("pageno")[0].value = pagenum;
		}

	}
	function last() {
		//alert(document.getElementsByName("pageno")[0].value==pagenum);
		if (document.getElementsByName("pageno")[0].value == pagenum) {

		} else {
			document.getElementsByName("pageno")[0].value = pagenum;
			document.getElementsByName("buyIn")[0].submit();
		}
		//document.getElementsByName("buyIn")[0].submit();
	}
	function edit(id) {
		/**
			var checkboxs=document.getElementsByName("checkbox");
			var isChecked = false;
			var count = 0;
			var id;
			for(var i=0;i<checkboxs.length;i++){
				if(checkboxs[i].checked){
					id=checkboxs[i].value;
					isChecked=true;
					count++;
				}
			}
			if(count>1){
				alert("只能选择一条记录");
				return false;
			}
			if(count==0){
				alert("请选择一条记录");
				return false;
			}
		 */
		//window.location.href="modifyBuyIn.html?id="+id;
		document.getElementsByName("buyIn")[0].action = "modifyBuyIn.jsp?id="
				+ id;
		document.getElementsByName("buyIn")[0].submit();
	}
	function editfkd(id, billid) {
		//if(null!=id && id!="null" && id!=""){
		document.getElementsByName("buyIn")[0].action = "modifyFkd.jsp?id="
				+ id + "&billid=" + billid;
		document.getElementsByName("buyIn")[0].submit();
		//}else{
		//	alert("暂无付款单！");
		//}

	}
	function editpz(id, billid) {
		//if(null!=id && id!="null" && id!=""){
		document.getElementsByName("buyIn")[0].action = "modifyFkd.jsp?id="
				+ id + "&billid=" + billid;
		document.getElementsByName("buyIn")[0].submit();
		//}else{
		//	alert("暂无付款单！");
		//}

	}
	function createfkd() {
		var checkboxs = document.getElementsByName("checkbox");
		var isChecked = false;
		var count = 0;
		var ids = "";
		for ( var i = 0; i < checkboxs.length; i++) {
			if (checkboxs[i].checked) {
				ids = ids + checkboxs[i].value + ";";
				isChecked = true;
				count++;
			}
		}

		if (count == 0) {
			alert("请选择一条记录");
			return false;
		}
		document.getElementsByName("ids")[0].value = ids;
		document.getElementsByName("operate")[0].value = "createfkd";
		document.getElementsByName("buyIn")[0].submit();
	}
	function createpz() {
		var checkboxs = document.getElementsByName("checkbox");
		var isChecked = false;
		var count = 0;
		var ids = "";
		for ( var i = 0; i < checkboxs.length; i++) {
			if (checkboxs[i].checked) {
				ids = ids + checkboxs[i].value + ";";
				isChecked = true;
				count++;
			}
		}

		if (count == 0) {
			alert("请选择一条记录");
			return false;
		}
		document.getElementsByName("ids")[0].value = ids;
		document.getElementsByName("operate")[0].value = "createpz";
		document.getElementsByName("buyIn")[0].submit();
	}
	function selectAll() {
		var checkboxs = document.getElementsByName("checkbox");
		var checkboxall = document.getElementsByName("checkboxall")[0];
		for ( var i = 0; i < checkboxs.length; i++) {
			if (checkboxall.checked) {
				checkboxs[i].checked = true;
			} else {
				checkboxs[i].checked = false;
			}

		}
	}
	function onclear() {
		//document.byInPz.reset();

		document.getElementsByName("fwarehouse")[0].value = "";
		document.getElementsByName("fordrji")[0].value = "";
		document.getElementsByName("finfoji")[0].value = "";
		document.getElementsByName("fds40ji")[0].value = "";
	}
	function selectrkd() {
		var supplier = document.getElementsByName("suppliers");
		var tempList = new Array();

		var checkboxs = document.getElementsByName("checkbox");

		var ids = "";
		for ( var i = 0; i < checkboxs.length; i++) {
			if (checkboxs[i].checked) {
				ids = ids + "'" + checkboxs[i].value + "',";
				tempList.push(supplier[i].value);
			}
		}
		var flag = "fp";

		//alert(tempList[0]);
		document.getElementsByName("ids")[0].value = ids;
		document.getElementsByName("supplierid")[0].value = tempList[0];
		if (flag == "fp") {
			if (tempList.length > 1) {
				for ( var j = 1; j < tempList.length; j++) {
					if (tempList[j - 1] != tempList[j]) {
						alert("请选择同一供应商开票！");
						return false;

					}
				}
			}
			document.getElementsByName("buyIn")[0].action = "buyInFpModify.jsp";
		} else {
			document.getElementsByName("buyIn")[0].action = "buyInFkdModify.jsp";
		}

		document.getElementsByName("buyIn")[0].submit();
	}

	function createfp() {

		var supplier = document.getElementsByName("suppliers");
		var tempList = new Array();

		var checkboxs = document.getElementsByName("checkbox");
		var isChecked = false;
		var count = 0;
		var ids = "";
		for ( var i = 0; i < checkboxs.length; i++) {
			if (checkboxs[i].checked) {
				tempList.push(supplier[i].value);

				ids = ids + "'" + checkboxs[i].value + "',";
				isChecked = true;
				count++;
			}
		}

		if (count == 0) {
			alert("请选择一条记录");
			return false;
		}
		if (tempList.length > 1) {
			for ( var j = 1; j < tempList.length; j++) {
				if (tempList[j - 1] != tempList[j]) {
					alert("请选择同一供应商开票！");
					return false;

				}
			}
		}
		//alert(tempList[0]);
		document.getElementsByName("ids")[0].value = ids;
		document.getElementsByName("supplierid")[0].value = tempList[0];
		document.getElementsByName("buyIn")[0].action = "buyInFpModify.jsp";
		document.getElementsByName("buyIn")[0].submit();
	}
	function goshd(flag) {
		window.location.href = "buyInFpModify.jsp" + encodeURI(flag);
		//buyInFpModify.jsp
	}
	
	function print(shpno,stat){
window.open('<%=request.getContextPath()%>/getShdServlet?shpno='+ shpno + '&stat=' + stat,'newwindow','height=800,width=800,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
	}
	function modifyInvoice(shpno, lgwno) {
		window
				.open(
						'modifyInvoice.jsp?SHPNO=' + shpno + '&LGWNO=' + lgwno,
						'newwindow',
						'height=400,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
	}
	function gopage(shdState, shdNum, shdDate) {
		var pageno = document.getElementById("gpageno").value;
		window.location.href = "myFhd_all.jsp?page=" + pageno + "&shdState="
				+ shdState + "&shdNum=" + shdNum + "&shdDate=" + shdDate;

	}
</script>
<%
	int currentPage = 1;//当前页码
	int pageSpace = 10;//每页显示条数
	int itemCount = 0;//总条数
	int pageCount = 0;
	String userName = (String) session.getAttribute("userName");
	String envId = (String) session.getAttribute("envId");
	String envIdXA = (String) session.getAttribute("envIdXA");
	String userCode = (String) session.getAttribute("userCode");
	String userHouse = (String) session.getAttribute("userHouse");
	String stid = (String) session.getAttribute("stid");
	//fwarehouse fordrji finfoji fds40ji
	String shdNum = new String((request.getParameter("shdNum") == null
			? ""
			: request.getParameter("shdNum")).getBytes("ISO8859-1"),
			"utf-8");
	String shdState = new String(
			(request.getParameter("shdState") == null ? "" : request
					.getParameter("shdState")).getBytes("ISO8859-1"),
			"utf-8");
	String shdDate = new String(
			(request.getParameter("shdDate") == null ? "" : request
					.getParameter("shdDate")).getBytes("ISO8859-1"),
			"utf-8");
	//	if(!shdDate.equals(""))
	//	shdDate = String.valueOf(Integer.parseInt(shdDate)-Integer.valueOf(19000000));
	//new String((request.getParameter("fds40ji")==null?"":request.getParameter("fds40ji")).getBytes("ISO8859-1"),"utf-8");
	if (userName == null || "".equals(userName.trim())) {
%>
<script type="text/javascript">
	window.location.href = "logo.jsp";
</script>
<%
	}
%>
<body class="right_body">
	<div class="path">您现在的位置： 首页 &gt; Ampheno SRM &gt; 我的送货单</div>
	<form action="myFhd_all.jsp" method="post" name="buyIn">
		<div class="top_button_div">

			<input name="operate" type="hidden" value="" /> <input name="ids"
				type="hidden" value="" /> <input name="supplierid" type="hidden"
				value="" />
		</div>

		<div class="search">
			<h2>
				<span class="fl">送货单查询</span> <span class="fr"><input name=""
					type="button" class="search_button" onclick="submit2();" /><input
					name="rs" type="button" class="purge_button" onclick="onclear();" />
				</span>
				<!--  span里无内容时，此span不能删除  -->
			</h2>

			<ul>
				<li><div class="w_s">送货单号码：</div> <input name=shdNum
					type="text" class="input_w" value="<%=shdNum%>" /></li>
				<li><div class="w_s">送货单状态：</div> <select name="shdState"
					class="input_w" style="widows: 120px">
						<option value="" selected="selected">所有</option>
						<option value="10" <%if (shdState.equals("10")) {%>
							selected="selected" <%}%>>下达，未打印</option>
						<option value="20" <%if (shdState.equals("20")) {%>
							selected="selected" <%}%>>下达，已打印</option>
						<option value="40" <%if (shdState.equals("40")) {%>
							selected="selected" <%}%>>部分收货</option>
						<option value="50" <%if (shdState.equals("50")) {%>
							selected="selected" <%}%>>完成</option>
				</select></li>
				<li><div class="w_s">创建日期：</div> <input name=shdDate
					type="text" class="input_w" value="<%=shdDate%>" /></li>
			</ul>
		</div>

		<div class="data_list">
			<h2>
				<span class="fl">送货单列表</span> <span class="fr"></span>
				<!--  span里无内容时，此span不能删除  -->
			</h2>

			<div class="list_inner">
				<div class="verflow_s">
					<table width="100%" border="0" cellspacing="1" cellpadding="0"
						class="list_table_s">
						<tr>
							<th>送货单号码</th>
							<th>发票号码</th>
							<th>送货单状态</th>
							<th>创建日期</th>
							<th>操作</th>
						</tr>
						<%
							String path = request.getContextPath();
							String basePath = request.getScheme() + "://"
									+ request.getServerName() + ":" + request.getServerPort()
									+ path + "/";

							Connection conn = null;
							Statement stmt = null;
							ResultSet rs = null;
							String result = "";
							try {
								java.sql.DriverManager
										.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
								Class.forName("com.ibm.as400.access.AS400JDBCDriver");
								String url = "jdbc:as400://" + ConstantUtils.DATABASE_IP + "/"
										+ envId + ";translate binary=true";
								conn = DriverManager.getConnection(url,
										ConstantUtils.DATABASE_NAME,
										ConstantUtils.DATABASE_PASSWORD);

								//----------查询总条数
								String sql = "select count(*) as c from " + envId.trim()
										+ ".ZSHPHDR where VNDNR = '" + userCode + "'";
								if (!"".equals(shdNum)) {
									sql = sql + " AND SHPNO like '%" + shdNum + "%'";
								}
								if (!"".equals(shdState)) {
									sql = sql + " AND OSTAT = " + shdState;
								}
								if (!"".equals(shdDate)) {
									sql = sql
											+ " AND CRDT = "
											+ String.valueOf(Integer.parseInt(shdDate)
													- Integer.valueOf(19000000));
								}
								System.out.println("the get count sql is " + sql);
								stmt = conn.createStatement();
								rs = stmt.executeQuery(sql);
								System.out.println("execute finished");
								if (rs.next()) {
									itemCount = rs.getInt("c");
									System.out.println("the count is " + itemCount);
								}
								if (rs != null) {
									rs.close();
								}
								if (stmt != null) {
									stmt.close();
								}
								//-----------维护pageCount
								pageCount = itemCount % pageSpace == 0 ? itemCount / pageSpace
										: itemCount / pageSpace + 1;

								//-----------维护currentPage
								try {
									currentPage = Integer
											.parseInt(request.getParameter("page"));
									if (currentPage < 1)
										currentPage = 1;
									if (currentPage > pageCount)
										currentPage = pageCount;
								} catch (Exception e) {
									currentPage = 1;
								}

								sql = "select * from (select ZSHPHDR.*,rownumber() over() as rn from "
										+ envId.trim()
										+ ".ZSHPHDR as ZSHPHDR  where VNDNR = '"
										+ userCode + "'";
								if (!"".equals(shdNum)) {
									sql = sql + " AND SHPNO like '%" + shdNum + "%'";
								}
								if (!"".equals(shdState)) {
									sql = sql + " AND OSTAT = " + shdState;
								}
								if (!"".equals(shdDate)) {
									sql = sql
											+ " AND CRDT = "
											+ String.valueOf(Integer.parseInt(shdDate)
													- Integer.valueOf(19000000));
								}
								sql += " ) AS a1 WHERE a1.rn BETWEEN "
										+ ((currentPage - 1) * pageSpace + 1) + " AND "
										+ (currentPage * pageSpace);
								sql += " order by SHPNO desc ";
								System.out.println("the myfindall get sql is " + sql);
								if (conn != null) {
									//result="已经成功连接数据库";

									stmt = (Statement) conn.createStatement();
									rs = stmt.executeQuery(sql);//执行select语句用executeQuery()方法，执行insert、update、delete语句用executeUpdate()方法。
									while (rs.next()) { //当前记录指针移动到下一条记录上
						%>
						<tr>
							<td><%=rs.getString("SHPNO")%></td>
							<td><%=rs.getString("LGWNO")%></td>
							<td><%=rs.getString("OSTAT").equals("10") ? "下达，未打印"
								: rs.getString("OSTAT").equals("40") ? "部分收货"
										: rs.getString("OSTAT").equals("20") ? "下达，已打印"
												: "完成"%></td>
							<td><%=(rs.getInt("CRDT") + Integer
								.valueOf(19000000))%></td>
							<td><input type="button" value="打印"
								onclick="print('<%=rs.getString("SHPNO")%>','<%=rs.getString("OSTAT")%>')" />
								&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="修改发票号"
								onclick="modifyInvoice('<%=rs.getString("SHPNO")%>','<%=rs.getString("LGWNO")%>')" />
							</td>
						</tr>
						<%
							}
								} else {
									out.print("conn error");
								}
							} catch (Exception e) {
								result = e.getMessage();
								e.printStackTrace();
								try {
									rs.close();//后定义，先关闭
									stmt.close();
									conn.close();//先定义，后关闭
								} catch (Exception ex) {

								}
							} finally {
								try {
									rs.close();//后定义，先关闭
									stmt.close();
									conn.close();//先定义，后关闭
								} catch (Exception e) {

								}
							}
						%>


					</table>
				</div>
				<div class="page">
					共有&nbsp;<%=pageCount%>&nbsp;页&nbsp;&nbsp;<%=itemCount%>&nbsp;条记录，当前为第&nbsp;<%=currentPage%>&nbsp;页
					<a
						href="myFhd_all.jsp?page=1&shdState=<%=shdState%>&shdNum=<%=shdNum%>&shdDate=<%=shdDate%>"
						title="" onclick="first();">首页</a> <a
						href="myFhd_all.jsp?page=<%=currentPage - 1 > 0 ? currentPage - 1 : 1%>&shdState=<%=shdState%>&shdNum=<%=shdNum%>&shdDate=<%=shdDate%>"
						title="" onclick="pre();">上一页</a> <a
						href="myFhd_all.jsp?page=<%=currentPage + 1 > pageCount ? pageCount : currentPage + 1%>&shdState=<%=shdState%>&shdNum=<%=shdNum%>&shdDate=<%=shdDate%>"
						title="" onclick="next();">下一页</a> <a
						href="myFhd_all.jsp?page=<%=pageCount%>&shdState=<%=shdState%>&shdNum=<%=shdNum%>&shdDate=<%=shdDate%>"
						title="" onclick="last();">尾页</a> 每页<%=pageSpace%>条 到第<input
						type="text" class="page_input" id="gpageno" value="1" />页 <input
						type="button" value="" class="go_button"
						onclick="javascript:gopage('<%=shdState%>','<%=shdNum%>','<%=shdDate%>')" />

				</div>
	</form>
	</div>



</body>

</html>