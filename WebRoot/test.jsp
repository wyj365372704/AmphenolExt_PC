<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.amphenol.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.math.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

 %>
 <script src="<%=basePath %>js/jquery-1.5.2.min.js"></script>
 <script type="text/javascript" src="<%=basePath %>js/jquery.qrcode.js"></script>
<script type="text/javascript" src="<%=basePath %>js/qrcode.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jquery.selectseach.min.js"></script>
 <script type="text/javascript">
 	function check(o){
 		
 		document.getElementsByName("operate")[0].value="update";
 		document.getElementsByName("buyApply")[0].submit();
 	}
 	function goList(){
 		document.getElementsByName("buyApply")[0].action="buyApply.jsp";
		document.getElementsByName("buyApply")[0].submit();
 	}
 	function show(){
 		//alert(document.getElementById("qrtlb").innerHTML);
 		document.getElementById("qrtlb").innerHTML="<div id='qrcodeTable'></div>";
 		//fordrji fblcft9 fcout
 		var fordrji =document.getElementsByName("fordrji")[0].value;
 		var fblcft9 =document.getElementsByName("fblcft9")[0].value;
 		var fcout =document.getElementsByName("fcout")[0].value;
		if(fordrji==null || fordrji==""){
			alert("物料不能为空!");
			return ;
		}
		if(fblcft9==null || fblcft9==""){
			alert("批次信息不能为空!");
			return ;
		}
		if(fcout==null || fcout==""){
			alert("每箱数量不能为空!");
			return ;
		}
 		jQuery('#qrcodeTable').qrcode({
			render	: "table",
			text	: "*M"+fordrji+"*B"+fblcft9+"*Q"+fcout
		});	
 	}
 	function show1(){
 		document.getElementById("show1").style.color="red";
 		//document.getElementById("show").style.color="";
 		document.getElementById("show2").style.color="";
 		
 		document.getElementById("showdata1").style.display="";
 		//document.getElementById("showdata").style.display="none";
 		document.getElementById("showdata2").style.display="none";
 		
 		//alert("1");
 	}
 	function show2(){
 		document.getElementById("show1").style.color="";
 		//document.getElementById("show").style.color="";
 		document.getElementById("show2").style.color="red";
 		
 		document.getElementById("showdata1").style.display="none";
 		//document.getElementById("showdata").style.display="none";
 		document.getElementById("showdata2").style.display="";
 	}
 	function getMore(id,idx){//alert(//document.getElementById("g"+idx).style.backgroundColor);
 		//document.getElementById("g"+idx).style.backgroundColor="red";
 		//alert("dd");
 		document.getElementsByName("mid")[0].value=id;
 		document.getElementsByName("buyApply")[0].action="buyApplyCheck.jsp";
		document.getElementsByName("buyApply")[0].submit();
 	}
 	function fordrjiChange(){
 		alert("test");
 	}
 	function changeF() {
	  document.getElementById('txt').value = document.getElementById('sel').options[document.getElementById('sel').selectedIndex].value;
	} 
	function research(){//alert("123");
		htmlobj=$.ajax({url:"./supplier/test2.jsp",async:false});
         //  alert(htmlobj.responseText);
             document.getElementById('sel').innerHTML=htmlobj.responseText;
             
	}
	function showmore(){
	//sel.multiple="multiple";
		//document.getElementById('sel').multiple="multiple";
	}
	$(document).ready(function(){
	   $('select').selectseach(); 
	 // $('#sssss2').selectseach(); 
	 // $('#sssss').selectseach(); 
	 // $('#sssss1').selectseach(); 
	  
	/*  $('select').focus(
	     function(){ 
	     
	     $('#msg').html($(this).text());
	    }  );*/
	});
 </script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>

<link href="<%=basePath %>css/customsDeclaration.css" rel="stylesheet" type="text/css" />
</head>

<body class="right_body">
<div class="public_div">
				<h2><br> 
					<span class="fl"></span></h2><h2><span class="fl">生产标签信息</span> 
					<span class="fr"></span><!--  span里无内容时，此span不能删除  --> 
				</h2>
				<div class="public_inner" style="width:100%">
				<form action="makeMark.jsp" method="post" name="makeMark">
				
				
				<table  border="0" cellpadding="0" cellspacing="1" class="public_table">
				<tr>
					   <td align="right">物料：<font color="red">*</font> </td>
					   <td>
					   <div style="position:relative; width: 240px;height:20px;margin-bottom:10px;margin-left:26px;">
						  <select id="sel" name="fordrji" m='search'  style="float: right; height: 22px;width: 140px; z-index:88; position:absolute; left:0px; top:0px;" onchange="changeF();">
						<option value="111">111</option>
						<option value="222">222</option>
						
						<option value="333">333</option>
						</select>
						<!--   <input type="text" id="txt" onmouseover="showmore();" value="" style="position:absolute; width:118px; height:14px; left:1px;top:1px;z-index:99; border:1px #FFF solid" onkeyup="research();"/>  
						 -->
						</div>
						
					   </td>
					   <td rowspan="11" width="55%">
					   <div id="qrtlb">
					   <div id="qrcodeTable"></div>
					   </div>
					   </td>
			      </tr>		
			      
				  </table>
				  
			  </div>
			  
			</div>
</form>
</body>

</html>
