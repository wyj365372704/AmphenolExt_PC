<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page import="com.xy.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
	String pageno = request.getParameter("pageno");
	String pagesize = request.getParameter("pagesize");
	String operate = request.getParameter("operate");
	String ids = request.getParameter("ids");
	if(null==pageno || pageno.trim()==""){
		pageno="1";
	}
	if(null==pagesize || pagesize.trim()==""){
		pagesize="100";
	}
	int pagenum =1;
	int rownum = 1;
	
	String supplier = new String((request.getParameter("supplier")==null?"":request.getParameter("supplier")).getBytes("ISO8859-1"),"gb2312");
	String fnumber=new String((request.getParameter("fnumber")==null?"":request.getParameter("fnumber")).getBytes("ISO8859-1"),"gb2312");
	List result = null;
	String sqlcout="select count(*) from v_fkdedit where 1=1 ";
	String sql = "select top "+Integer.valueOf(pagesize)+" * from v_fkdedit where 1=1 ";
	String sqlin = "select top "+(Integer.valueOf(pageno)-1)*Integer.valueOf(pagesize)+"  FID from v_fkdedit where 1=1 " ;
	
	
	if(supplier!=null && supplier.trim().length()>0){
		sql=sql+" and 付款单位名称  like '%"+supplier+"%'";
		sqlcout=sqlcout+" and 付款单位名称  like '%"+supplier+"%'";
		sqlin=sqlin+" and 付款单位名称  like '%"+supplier+"%'";
	}
	if(fnumber!=null && fnumber.trim().length()>0){
		sql=sql+" and 付款单编号  like '%"+fnumber+"%'";
		sqlcout=sqlcout+" and 付款单编号  like '%"+fnumber+"%'";
		sqlin=sqlin+" and 付款单编号  like '%"+fnumber+"%'";
	}
	DBUtil dbUtil = DBUtil.getInstance();
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs=null;
	CallableStatement callStmt = null;
	boolean isoperatesuccess=false;
	try{
		Calendar today = Calendar.getInstance();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String todayS = format.format(today.getTime());
        String fromDateS = todayS.substring(0, 8) + "01";
		conn = dbUtil.getConnection();
		stmt = conn.createStatement();
		if(null!=operate && operate.trim().length()>0){
			
			if(operate.equals("createfkd")){
				//callStmt = conn.prepareCall("{call proBillCreatefkd(?)}");
				//callStmt.setString(1,ids);
				//callStmt.execute();
				isoperatesuccess=true;
			}else if(operate.equals("delete")){
				//调用删除的存储过程
			}
			
			
		}else{
			if(startDate==null || startDate.trim().length()==0){
				startDate=fromDateS;
			}
			if(endDate==null || endDate.trim().length()==0){
				endDate=todayS;
			}
		}

		if(startDate!=null && startDate.trim().length()>0){
			sql=sql+" and 付款日期>='"+startDate+"'";
			sqlcout=sqlcout+" and 付款日期>='"+startDate+"'";
			sqlin=sqlin+" and 付款日期>='"+startDate+"'";
		}
		if(endDate!=null && endDate.trim().length()>0){
			sql=sql+" and 付款日期<'"+endDate+"'";
			sqlcout=sqlcout+" and 付款日期<'"+endDate+"'";
			sqlin=sqlin+" and 付款日期<'"+endDate+"'";
		}
		//if(null==operate || operate.trim().length()==0){
		//	rs=stmt.executeQuery(sqlcout +" and 1<>1");
		//}else{
			rs=stmt.executeQuery(sqlcout);
		//}
		
		if(rs.next()){
			rownum=rs.getInt(1);
		}
		rs.close();
		if(Integer.valueOf(rownum)%Integer.valueOf(pagesize)==0){
			pagenum=Integer.valueOf(rownum)/Integer.valueOf(pagesize);
		}else{
			pagenum=Integer.valueOf(rownum)/Integer.valueOf(pagesize)+1;
		}
		System.out.println(sql+" and FID not in("+sqlin+")");
		//if(null==operate || operate.trim().length()==0){
		//	rs=stmt.executeQuery(sql+" and 1<>1");
		//}else{
			rs=stmt.executeQuery(sql+" and FID not in("+sqlin+")");
		//}
		
	}catch(Exception e){
	 e.printStackTrace();
	}finally{
		if(null!=callStmt){
			callStmt.close();
		}
	}
 %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>新亚ERP系统</title>
<link href="../css/customsDeclaration.css" rel="stylesheet" type="text/css" />
<script src="../js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
</head>
<script type="text/javascript">
	//var pageno="<%=pageno%>";
	var pagenum="<%=pagenum%>";
	function submit1(){
		
		var startDate = document.getElementsByName("startDate")[0].value;
		var endDate = document.getElementsByName("endDate")[0].value;
		document.getElementsByName("operate")[0].value="query";
		if(startDate==""){
			alert("请选择开始日期！");
			return false;
		}
		if(endDate==""){
			alert("请选择结束日期！");
			return false;
		}
		document.getElementsByName("payOut")[0].submit();
	}
	function first(){
		if(document.getElementsByName("pageno")[0].value=="1"){
		
		}else{
			document.getElementsByName("pageno")[0].value="1";
			document.getElementsByName("payOut")[0].submit();
		}
		
	}
	function pre(){
		
		if(parseInt(document.getElementsByName("pageno")[0].value)>1){
			document.getElementsByName("pageno")[0].value=parseInt(document.getElementsByName("pageno")[0].value)-1;
			document.getElementsByName("payOut")[0].submit();
		}else{
			document.getElementsByName("pageno")[0].value="1";
		}
		
	}
	function next(){
		
		if(parseInt(pagenum)-parseInt(document.getElementsByName("pageno")[0].value)>0){
			document.getElementsByName("pageno")[0].value=parseInt(document.getElementsByName("pageno")[0].value)+1;
			document.getElementsByName("payOut")[0].submit();
		}else{
			document.getElementsByName("pageno")[0].value=pagenum;
		}
		
	}
	function last(){
		//alert(document.getElementsByName("pageno")[0].value==pagenum);
		if(document.getElementsByName("pageno")[0].value==pagenum){
		
		}else{
			document.getElementsByName("pageno")[0].value=pagenum;
			document.getElementsByName("payOut")[0].submit();
		}
		//document.getElementsByName("buyIn")[0].submit();
	}
	function edit(id){

		document.getElementsByName("buyInfkd")[0].action="buyInFkdModify.jsp?id="+id;
		document.getElementsByName("buyInfkd")[0].submit();
	}
	function add(){
        id='';
        alert(id);
		document.getElementsByName("buyInfkd")[0].action="buyInFkdModify.jsp?id="+id;
		document.getElementsByName("buyInfkd")[0].submit();
	}
	
	function createfkd(){
		var checkboxs=document.getElementsByName("checkbox");
		var isChecked = false;
		var count = 0;
		var ids="";
		for(var i=0;i<checkboxs.length;i++){
			if(checkboxs[i].checked){
				ids=ids+checkboxs[i].value+";";
				isChecked=true;
				count++;
			}
		}
		
		if(count==0){
			alert("请选择一条记录");
			return false;
		}
		document.getElementsByName("ids")[0].value=ids;
		document.getElementsByName("operate")[0].value="createfkd";
		document.getElementsByName("buyIn")[0].submit();
	}
	function deleteP(){
		var checkboxs=document.getElementsByName("checkbox");
		var isChecked = false;
		var count = 0;
		var ids="";
		for(var i=0;i<checkboxs.length;i++){
			if(checkboxs[i].checked){
				ids=ids+checkboxs[i].value+";";
				isChecked=true;
				count++;
			}
		}
		
		if(count==0){
			alert("请选择一条记录");
			return false;
		}
		document.getElementsByName("ids")[0].value=ids;
		document.getElementsByName("operate")[0].value="delete";
		document.getElementsByName("payOut")[0].submit();
	}
	function selectAll(){
		var checkboxs=document.getElementsByName("checkbox");
		var checkboxall=document.getElementsByName("checkboxall")[0];
		for(var i=0;i<checkboxs.length;i++){
			if(checkboxall.checked){
				checkboxs[i].checked=true;
			}else{
				checkboxs[i].checked=false;
			}
			
		}
	}
	function onclear(){
		//document.byInPz.reset();
		document.getElementsByName("startDate")[0].value="";
		document.getElementsByName("endDate")[0].value="";
		document.getElementsByName("supplier")[0].value="";
		document.getElementsByName("fnumber")[0].value="";
	}
</script>
<body class="right_body">
	<div class="path">您现在的位置： 首页 &gt; 新亚ERP &gt; 付款单管理</div>
	<form action="buyInfkd" method="post" name="buyInfkd">
	<div class="top_button_div">
		<input name="" type="button" class="add_commission"  onclick="add();"/>
		<input name="" type="button" class="delete_commission"  onclick="deleteP();"/>
		<input name="operate" type="hidden" value=""/>
		<input name="ids" type="hidden" value=""/>
	</div>
	
	<div class="search">
		<h2>
			<span class="fl">付款单查询</span>			
			<span class="fr"><input name="" type="button" class="search_button" onclick="submit1();"/><input name="rs" type="button" class="purge_button" onclick="onclear();"/></span><!--  span里无内容时，此span不能删除  -->
		</h2>
		
		<ul>			
			<li><div class="w_s">日期：</div><input name="startDate" type="text" class="time_input" onclick="WdatePicker()" onmouseout="dateIsValid(this,'开始日期')" value="<%=(startDate==null?"":startDate) %>"/>-<input name="endDate" type="text" class="time_input" onclick="WdatePicker()" onmouseout="dateIsValid(this,'结束日期')" value="<%=(endDate==null?"":endDate) %>"/></li>
			<li><div class="w_s">付款单位：</div><input name="supplier" type="text" class="input_w" value="<%=(supplier==null?"":supplier) %>"/></li>
			<li><div class="w_s">付款单编号：</div><input name="fnumber" type="text" class="input_w" value="<%=(fnumber==null?"":fnumber) %>"/></li>
		</ul>
	</div>
	
	<div class="data_list">
		<h2>
			<span class="fl">付款单列表</span>
			<span class="fr"></span><!--  span里无内容时，此span不能删除  -->
		</h2>
		
		<div class="list_inner">
			<div class="verflow_s">
			<table width="100%" border="0" cellspacing="1" cellpadding="0" class="list_table_s">
			   <tr>
				<th><input type="checkbox" name="checkboxall" value="all" onclick="selectAll();"/></th>
				<th>付款单编号</th>
				<th>付款单位名称</th>
				<th>单据状态</th>
				<th>付款项目</th>
				<th>付款条件</th>
				<th>付款方式</th>
				<th>付款日期</th>
				<th>应付合计	</th>
				<th>实付合计</th>
				<th>余额</th>
				<th>备注</th>
			
		      </tr>
			  <%
			  	if(null!=rs){
			  		while(rs.next()){
			   %>
			  <tr>
				<th><input type="checkbox" name="checkbox" value="<%=rs.getString("FID") %>" /></th>
				<td><a href="#" onclick="edit('<%=rs.getString("FID") %>');" style="color:blue"><%=rs.getString("付款单编号") %></a></td>
				
				<td><%=rs.getString("付款单位名称") %></td>
				<td><%=rs.getString("单据状态") %></td>
				<td><%=rs.getString("付款项目") %></td>
				<td><%=rs.getString("付款条件") %></td>
				<td><%=rs.getString("付款方式") %></td>
				<td><%=rs.getString("付款日期") %></td>
				<td><%=rs.getString("应付合计") %></td>
				<td><%=rs.getString("实付合计") %></td>
				<td><%=rs.getString("余额") %></td>
				<td><%=rs.getString("备注") %></td>
		      </tr>
		     <%}} %>
			 
		  </table>
		  </div>
		  <div class="page">共有&nbsp;<%=pagenum %>&nbsp;页&nbsp;&nbsp;<%=rownum %>&nbsp;条记录，当前为第&nbsp;<%=pageno %>&nbsp;页    <a href="#" title="" onclick="first();">首页</a> <a href="#" title="" onclick="pre();">上一页</a> <a href="#" title="" onclick="next();">下一页</a> <a href="#" title="" onclick="last();">尾页</a> 每页
		    <input type="text" class="page_input" name="pagesize" value="100" readonly="readonly"/>
		    条 到第<input type="text" class="page_input" name="gpageno" value="<%=pageno %>" />
		    页 <input type="button" value="" class="go_button" />
		    <input type="hidden" class="page_input" name="pageno" value="<%=pageno %>" />
		  </div>
		  
		</div>
		</form>
	</div>
	


</body>
 <script type="text/javascript">
 	var operate="<%=operate%>";
 	var isoperatesuccess="<%=isoperatesuccess%>";
 	//alert(operate+isoperatesuccess);
 	if(operate=="delete" && isoperatesuccess=="true"){
 		alert("操作成功！");
 	}
 </script>
</html>