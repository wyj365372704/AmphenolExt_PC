<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="javax.xml.bind.annotation.XmlElementDecl.GLOBAL"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.amphenol.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%
	String item1 = new String(request.getParameter("item1").getBytes(
			"ISO8859-1"), "utf-8");
	String item2 = new String(request.getParameter("item2").getBytes(
			"ISO8859-1"), "utf-8");
	String item3 = new String(request.getParameter("item3").getBytes(
			"ISO8859-1"), "utf-8");
	String item4 = new String(request.getParameter("item4").getBytes(
			"ISO8859-1"), "utf-8");
	String item5 = new String(request.getParameter("item5").getBytes(
			"ISO8859-1"), "utf-8");
	String item6 = new String(request.getParameter("item6").getBytes(
			"ISO8859-1"), "utf-8");
	String item9 = new String(request.getParameter("item9").getBytes(
			"ISO8859-1"), "utf-8");
	String BLCFT9 = new String(request.getParameter("BLCFT9").getBytes(
			"ISO8859-1"), "utf-8");
	String PISQJI = new String(request.getParameter("PISQJI").getBytes(
			"ISO8859-1"), "utf-8");
	String ORDRJI = new String(request.getParameter("ORDRJI").getBytes(
			"ISO8859-1"), "utf-8");
	String BKSQJI = new String(request.getParameter("BKSQJI").getBytes(
			"ISO8859-1"), "utf-8");
	String SCTKJI = new String(request.getParameter("SCTKJI").getBytes(
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
	function save(o) {

		var checkboxs = document.getElementsByName("checkbox");
		var isselected = false;
		for ( var i = 0; i < checkboxs.length; i++) {
			if (checkboxs[i].checked) {
				isselected = true;
				break;
			}
		}
		if (!isselected) {
			alert("请选择分录生成发票！");
			return false;
		}
		document.getElementsByName("operate")[0].value = "update";
		document.getElementsByName("modifyBuyIn")[0].submit();
	}
	function goList() {
		document.getElementsByName("modifyBuyIn")[0].action = "buyIn.jsp";
		document.getElementsByName("modifyBuyIn")[0].submit();
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
	function selectBuyIn() {
		window.location.href = "buyIn.jsp?isSelect=1&flag=fp";
	}

	function addShd() {
document.getElementById("modifyBuyIn").submit();
	}

	function printshd() {
		window.open('<%=request.getContextPath()%>/getShdServlet?shpno='+ shpno,'newwindow','height=800,width=800,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
	}
	function addBatch() {
		var insertSpareEpt = document.getElementById("insertSpareEpt");
		var newChild = document.createElement("tr");
		newChild.innerHTML = "<tr><td>批号：</td><td><input name ='batch_name' type='text' class='input_w' /></td></tr>";
		insertSpareEpt.parentNode.insertBefore(newChild, insertSpareEpt);

		insertSpareEpt = document.getElementById("insertSpareEpt");
		newChild = document.createElement("tr");
		newChild.innerHTML = "<tr><td>数量：</td><td><input name ='batch_num' type='text' class='input_w' /></td></tr>";
		insertSpareEpt.parentNode.insertBefore(newChild, insertSpareEpt);

	}
	function check(){
	console.log(111111111111);
		var wjl = parseFloat(document.getElementsByName("wjl")[0].value);
		var SHQTY = parseFloat(document.getElementsByName("SHQTY")[0].value);
		
		if(SHQTY<=0){
			alert("交货量必须大于0");
			return false;
		}else if(SHQTY>wjl){
			alert("交货量不能大于未交量");
			return false ;
		}else
		return true;
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




	<form method="post" id="modifyBuyIn" action="<%=request.getContextPath()%>/addShdServlet" onsubmit="return check()" >
		<div class="public_div">
			<h2>
				<br> <span class="fl"></span>
			</h2>
			<h2>
				<span class="fl">送货单信息</span> <span class="fr"></span>
				<!--  span里无内容时，此span不能删除  -->
			</h2>
			<div class="public_inner">
				<%
					Connection conn = null;
					Statement stmt = null;
					ResultSet rs = null;
					String result = "";
					String itrvt9 = "";
					java.sql.DriverManager
							.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
					Class.forName("com.ibm.as400.access.AS400JDBCDriver");
					String url = "jdbc:as400://" + ConstantUtils.DATABASE_IP + "/"
							+ envIdXA + ";translate binary=true";
					conn = DriverManager.getConnection(url,
							ConstantUtils.DATABASE_NAME,
							ConstantUtils.DATABASE_PASSWORD);
					String sql = "select * from " + envIdXA.trim()
							+ ".ITMSIT where STIDT9 = '" + stid.trim()
							+ "' and ITNOT9 ='" + item2.trim() + "'";
					if (conn != null) {
						stmt = conn.createStatement();
						stmt.execute(sql);
						rs = (ResultSet) stmt.getResultSet();

						if (rs.next()) {
							itrvt9 = rs.getString("ITRVT9");

						}

						rs.close();
						stmt.close();
					}
					try {
						sql = "select * from " + envIdXA
								+ ".ITMRVA AS ITMRVA  WHERE STID = '" + stid
								+ "' AND ITNBR = '" + item2 + "' AND ITRV = '" + itrvt9
								+ "'";
						stmt = (Statement) conn.createStatement();
						stmt.execute(sql);//执行select语句用executeQuery()方法，执行insert、update、delete语句用executeUpdate()方法。
						rs = (ResultSet) stmt.getResultSet();
						if (rs.next()) {
				%>
				<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="public_table">
					<input type="hidden" name="PISQJI" value="<%=PISQJI%>"/>
					<input type="hidden" name="ORDRJI" value="<%=ORDRJI%>"/>
					<input type="hidden" name="BKSQJI" value="<%=BKSQJI%>"/>
					<input type="hidden" name="BLCF" value="<%=BLCFT9%>"/>
					<input type="hidden" name="SCTKJI" value="<%=SCTKJI%>"/>
					<tr>
						<th colspan="2">送货单信息</th>
					</tr>
					<tr>
						<td>采购单号-项次：</td>
						<td><input name=fds40ji type="text" class="input_w"
							value="<%out.print(item1);%>" readonly="readonly" />
						</td>
					</tr>
					<tr>
						<td>物料：</td>
						<td><input name="ITNBR" type="text" class="input_w"
							value="<%out.print(item2.trim());%>" readonly="readonly" />
						</td>
					</tr>
					<tr>
						<td>描述：</td>
						<td><input name=fds40ji type="text" class="input_w"
							value="<%out.print(item3.trim());%>" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<td>采购单位：</td>
						<td><input name="PURUM" type="text" class="input_w"
							value="<%out.print(item4);%>"readonly="readonly" />
						</td>
					</tr>
					<tr>
						<td>库存单位：</td>
						<td><input name=fds40ji type="text" class="input_w"
							value="<%out.print(item5);%>" readonly="readonly" />
						</td>
					</tr>
					<tr>
						<td>采购单位转换系数：</td>
						<td><input name=UMCVJI type="text" class="input_w"
							value="<%out.print(item6);%>" readonly="readonly" />
						</td>
					</tr>
					<tr>
						<td>物料库存单位单重：</td>
						<td><input name="WEGHT" type="text" class="input_w"
							value="<%=rs.getString("WEGHT")%>" readonly="readonly" />
						</td>

					</tr>
					<tr>
						<td>单重单位：</td>
						<td><input name="B2CQCD" type="text" class="input_w"
							value="<%=rs.getString("B2CQCD")%>" readonly="readonly" />
						</td>
					</tr>
					<tr>
						<td>未交量(采购单位)：</td>
						<td><input name="wjl" type="text" class="input_w"
							value="<%out.print(item9);%>" readonly="readonly" />
						</td>
					</tr>
					<tr>
						<td>本次交货量：</td>
						<td><input name="SHQTY" type="text" class="input_w"
							value="0"/>
						</td>
					</tr>
				<%-- 	<tr>
						<td>本次交货重量：</td>
						<td><input name=fds40ji type="text" class="input_w"
							value="<%if (rs.getString("B2CQCD").toLowerCase().equals("g")
							|| rs.getString("B2CQCD").toLowerCase()
									.equals("gm")) {
						out.print(rs.getInt("WEGHT") * Integer.parseInt(item10)
								/ 1000);
					} else {
						out.print(rs.getInt("WEGHT") * Integer.parseInt(item10));
					}%>" />
						</td>
					</tr> --%>
					<tr align="center" id="insertSpareEpt">
						<td colspan="2"><input name="makeMark" type="submit"
							class="button_m" value="确定"/> <%
 	if (("1".equals(BLCFT9))) {
 				out.print("<input name='' type='button' class='button_m' value='新增批次' onclick='addBatch();' /> ");
 			}
 %></td>
					</tr>
				</table>


				<%
					}
					} catch (Exception e) {
						out.print("catch error " + e);
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


			</div>
		</div>

	</form>
</body>
<script type="text/javascript">

</script>
</html>
