<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.amphenol.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.math.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	Calendar calendar = Calendar.getInstance();
	calendar.setTimeInMillis(System.currentTimeMillis());
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	String userName = (String) session.getAttribute("userName");
	String envId = (String) session.getAttribute("envId");
	String envIdXA = (String) session.getAttribute("envIdXA");
	String userCode = (String) session.getAttribute("userCode");
	String userHouse = (String) session.getAttribute("userHouse");
	String stid = (String) session.getAttribute("stid");

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String result = "";
	String sql0 = "";
	String changshang = "";
	String blcft9 = "1";
	try {
		java.sql.DriverManager
				.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
		Class.forName("com.ibm.as400.access.AS400JDBCDriver");
		String url = "jdbc:as400://" + ConstantUtils.DATABASE_IP + "/"
				+ envIdXA + ";translate binary=true";
		conn = DriverManager.getConnection(url,
				ConstantUtils.DATABASE_NAME,
				ConstantUtils.DATABASE_PASSWORD);
		//select * from (select a.*,rownumber() over() as rowid from (select * from tbl_net_order) a) tmp 
		//where tmp.rowid >=#{startIndex} and tmp.rowid <= #{endIndex};
		sql0 = "select temp.* from (select a.*,rownumber() over() as rowid from (Select * from "
				+ envIdXA.trim()
				+ "."
				+ ConstantUtils.ITNFROM
				+ ") a ) temp ";
		sql0 = sql0 + " where temp.rowid >=0 and temp.rowid <= 10";

		stmt = (Statement) conn.createStatement();
		stmt.execute(sql0);//执行select语句用executeQuery()方法，执行insert、update、delete语句用executeUpdate()方法。
		rs = (ResultSet) stmt.getResultSet();
		int i = 0;
		while (rs.next()) {
			String str = "";
			if ("ITMRVA".equalsIgnoreCase(ConstantUtils.ITNFROM)) {
				str = rs.getString("ITNBR");
			} else {
				str = rs.getString("ITNO");
			}
			result = result + "<option value='" + str.trim() + "'>"
					+ str.trim() + "</option>";
			i++;
			//if(i>10){
			//	break;
			//}
		}
		rs.close();
		stmt.close();
		String sql3 = "select VN35 from " + envIdXA.trim()
				+ ".VENNAM where vndnr='" + userCode + "'";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql3);
		if (rs != null) {
			while (rs.next()) {
				changshang = rs.getString("VN35");
			}
		}
	} catch (Exception e) {
		//result=e.getMessage();
		//e.printStackTrace();
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
<script src="../js/jquery-1.5.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.qrcode.js"></script>
<script type="text/javascript" src="../js/qrcode.js"></script>

<script type="text/javascript" src="../js/jquery.selectseach.min.js"></script>
<script type="text/javascript">

 	function check(form) {
		document.getElementById("qrtlb").innerHTML = "<div id='qrcodeTable'></div>";

		if (form.fordrji.value == null || form.fordrji.value == "") {
			alert("物料不能为空!");
			return false;
		}
		if (isNaN(form.fcout.value)) {
			alert("每包装数量输入非法");
			return false;
		}

		if (form.fcout.value == null || form.fcout.value == "") {
			alert("每包装数量不能为空!");
			return false;
		}
		if (form.fblcft9.disabled == "disabled") {
			if (form.fblcft9.value == null || form.fblcft9.value == "") {
				alert("批号不能为空!");
				return false;
			}
		}
		if (isNaN(form.fweight.value)) {
			alert("单重输入非法");
			return false;
		}

		if (form.fweight.value == null || form.fweight.value == "") {
			alert("单重不能为空!");
			return false;
		}
		if (isNaN(form.outer_weight.value)) {
			alert("包材重输入非法");
			return false;
		}
		if (form.outer_weight.value == null || form.outer_weight.value == "") {
			alert("包材重不能为空!");
			return false;
		}
		return true;
	}

 	function changeF() {
	  var selVal=document.getElementById('sel').value;
	  htmlobj=$.ajax({url:"./test2.jsp?itnot9="+selVal,async:false, datatype: "json", type: "GET", contentType: "application/json"
	  , success:function(data) {//这里的data是由请求页面返回的数据    
                 var dataJson = JSON.parse(data); // 使用json2.js中的parse方法将data转换成json格式   
                 //$("#show").html("data=" + data + " name="+dataJson.name+"  age=" + dataJson.age);     
             document.getElementsByName('fds40ji')[0].value=dataJson.ldesc;
             document.getElementsByName('fldesc')[0].value=dataJson.guige;
             document.getElementsByName('fumstt9')[0].value=dataJson.kcdw;
             document.getElementsByName('fweight')[0].value=dataJson.weight;
             var blcft9 = dataJson.blcft9;
             if(blcft9 == 0){
             document.getElementsByName("fblcft9")[0].value="";
				document.getElementsByName("fblcft9")[0].disabled=true;
             }else{
             document.getElementsByName("fblcft9")[0].disabled=false;
             }
			var b2cqcd = dataJson.b2cqcd;
             if(b2cqcd == "g"){
         	    document.getElementsByName("fweight_unit")[0].options[1].selected = false;
          	   document.getElementsByName("fweight_unit")[0].options[0].selected = true;
             }else{
				document.getElementsByName("fweight_unit")[0].options[0].selected = false;
             	document.getElementsByName("fweight_unit")[0].options[1].selected = true;
             }
                 }});
         //  alert(htmlobj.responseText);
	} 

	$(document).ready(function() {
		$('select').selectseach();
		//alert(document.getElementsByName("searcht")[0].value);onchange='getItems();'

	});
	function getItems() {
		//alert(document.getElementsByName("searcht")[0].value);
		var itnot9 = document.getElementsByName("searcht")[0].value;
		$.ajax({
			url : "./test3.jsp?itnot9=" + itnot9,
			async : false,
			type : "GET",
			success : function(data) {//这里的data是由请求页面返回的数据    
				//var dataJson = JSON.parse(data); // 使用json2.js中的parse方法将data转换成json格式   
				//$("#show").html("data=" + data + " name="+dataJson.name+"  age=" + dataJson.age);  
				//alert(data);   
				document.getElementById('sel').innerHTML = data;
			}
		});
	}
</script>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>

<link href="../css/customsDeclaration.css" rel="stylesheet"
	type="text/css" />
<script src="../js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
</head>

<body class="right_body">
	<div class="public_div">
		<h2>
			<br> <span class="fl"></span>
		</h2>
		<h2>
			<span class="fl">生产标签信息</span> <span class="fr"></span>
			<!--  span里无内容时，此span不能删除  -->
		</h2>
		<div class="public_inner" style="width:98%">
			<form action="../getProductionLabelServlet" method="post" name="makeMark" target="_blank">


				<table border="0" cellpadding="0" cellspacing="1"
					class="public_table">
					<tr>
						<td align="right">物料：<font color="red">*</font>
						</td>
						<td><select id="sel" name="fordrji" m='search'
							class='input_w' onchange="changeF();">
								<%=result%>
						</select>
						</td>
						<td rowspan="11" width="55%">
							<div id="qrtlb">
								<div id="qrcodeTable"></div>
							</div>
						</td>
					</tr>
					<tr>
						<td align="right">描述：<font color="red"></font>
						</td>
						<td><input name=fds40ji type="text" class="input_w" value=""
							readonly="readonly" /></td>
					</tr>
					<tr>
						<td align="right">规格：<font color="red"></font>
						</td>
						<td><input name=fldesc type="text" class="input_w" value=""
							readonly="readonly" /></td>
					</tr>
					<tr>
						<td align="right">每包装数量：<font color="red">*</font>
						</td>
						<td><input name=fcout type="text" class="input_w" value="" />
						</td>
					</tr>
					<tr>
						<td align="right">库存单位：<font color="red"></font>
						</td>
						<td><input name=fumstt9 type="text" class="input_w" value="" /></td>
					</tr>
					<tr id="blanch_tr">
						<td align="right">批号：<font color="red">*</font>
						</td>
						<td><input name=fblcft9 type="text" class="input_w" value="" />
						</td>
					</tr>
					<tr>
						<td align="right">单重：<font color="red">*</font>
						</td>
						<td><input name=fweight type="text" class="input_w" value="" />
							<select name="fweight_unit" class="input_w" style="width: 40px">
								<option value="g" selected="selected">g</option>
								<option value="kg">kg</option>
						</select></td>
					</tr>
					<tr>
						<td align="right">包材重：<font color="red">*</font>
						</td>
						<td><input name="outer_weight" type="text" class="input_w"
							value="" /> <select name="outer_weight_unit" class="input_w"
							style="width: 40px">
								<option value="g">g</option>
								<option value="kg" selected="selected">kg</option>
						</select>
						</td>
					</tr>
					<tr>
						<td align="right">日期：<font color="red"></font>
						</td>
						<td><input name=fdate type="text" class="time_input"
							value="<%=format.format(calendar.getTime())%>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-{%d}'})" onmouseout="dateIsValid(this,'开始日期')" /></td>
					</tr>
					<tr>
						<td align="right">厂商：<font color="red"></font>
						</td>
						<td><input name=fproducter type="text" class="input_w"
							value="<%=changshang.trim()%>"/></td>
					</tr>
					<tr align="center">
						<td><input name="makeMark" type="submit" class="button_m"
							value="打印" onclick="return check(this.form)" />
						</td>
						<td><input name="" type="button" class="button_m" value="返回" />
						</td>
					</tr>

				</table>
		</div>

	</div>
	</form>
</body>
<script language="javascript">
	window.onload = changeF();
</script>
</html>
