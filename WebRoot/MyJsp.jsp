<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html >
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
 <script src="<%=basePath %>js/jquery-1.5.2.min.js"></script>
 <script type="text/javascript" src="<%=basePath %>js/jquery.qrcode.js"></script>
<script type="text/javascript" src="<%=basePath %>js/qrcode.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jquery.selectseach.min.js"></script>
<title>jquery 支持智能文本搜索select 插件 v3.0.0.0插件</title>
</head>
<script>
function getmydata(){
 alert($('#sssss').val());
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
<body style="height:">
<p>潇湘博客</p>
<p><a href="http://blog.111cn.net/fkedwgwy">http://blog.111cn.net/fkedwgwy</a></p>
<p>php教程 技术群：37304662</p>
<p></p>
<table width="805" border="0">
  <tr>
    <td><p>传统select</p>
    <p>&nbsp;</p></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><select name="sssss5" id="sssss5" onchange="return getmydata()"  >
      <option value="-1">所有学校</option>
      <option value="139" selected="selected"> a english book </option>
      <option value="140">浏阳市浏阳河小学</option>
      <option value="141">浏阳市人民路小学</option>
      <option value="142">浏阳市嗣同路小学</option>
      <option value="143">浏阳市集里街道长南路小学</option>
      <option value="144">浏阳市集里街道平水桥小学</option>
      <option value="145">浏阳市集里街道禧和岭小学</option>
      <option value="146">浏阳市集里龚家桥小学</option>
      <option value="147" >浏阳市集里街道百宜小学</option>
      <option value="148">浏阳市荷花街道杨家小学</option>
      <option value="149">浏阳市荷花街道净溪小学</option>
      <option value="150">浏阳市荷花街道牛石小学</option>
      <option value="151">浏阳市荷花街道云桥小学</option>
      <option value="152">浏阳市荷花街道早禾小学</option>
      <option value="153">浏阳市荷花街道光彩小学</option>
      <option value="154">浏阳市荷花街道小水小学</option>
      <option value="155">浏阳市荷花街道建新小学</option>
      <option value="156">a chinese man 胡</option>
      <option value="157">浏阳市荷花街道胡坪小学</option>
      <option value="158">liuyan</option>
      <option value="159">changsha</option>
    </select></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><p>超级select插件</p>
    <p>&nbsp;</p></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><select name="sssss1" id="sssss1" m='search'>
      <option value="-1">所有学校</option>
      <option value="139">浏阳市黄泥湾小学</option>
      <option value="140">浏阳市浏阳河小学</option>
      <option value="141">浏阳市人民路小学</option>
      <option value="142">浏阳市嗣同路小学</option>
      <option value="143">浏阳市集里街道长南路小学</option>
      <option value="144">浏阳市集里街道平水桥小学</option>
      <option value="145">浏阳市集里街道禧和岭小学</option>
      <option value="146">浏阳市集里龚家桥小学</option>
      <option value="147" selected="selected">浏阳市集里街道百宜小学</option>
      <option value="148">浏阳市荷花街道杨家小学</option>
      <option value="149">浏阳市荷花街道净溪小学</option>
      <option value="150">浏阳市荷花街道牛石小学</option>
      <option value="151">浏阳市荷花街道云桥小学</option>
      <option value="152">浏阳市荷花街道早禾小学</option>
      <option value="153">浏阳市荷花街道光彩小学</option>
      <option value="154">浏阳市荷花街道小水小学</option>
      <option value="155">浏阳市荷花街道建新小学</option>
      <option value="156">浏阳市荷花街道罗直小学</option>
      <option value="157">浏阳市荷花街道胡坪小学</option>
      <option value="158">浏阳市荷花街道唐洲小学</option>
      <option value="159">浏阳市荷花街道金沙路小学</option>
    </select></td>
    
  </tr>
</table>

