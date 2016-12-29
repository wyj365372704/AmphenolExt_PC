<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.amphenol.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.math.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Ampheno SRM</title>
<link href="../css/customsDeclaration.css" rel="stylesheet" type="text/css" />
<script src="../js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
</head>
<script type="text/javascript">
	var pagenum="1";
	function submit2(){
		// 
		
		
		document.getElementsByName("buyIn")[0].submit();
	}
	function first(){
		if(document.getElementsByName("pageno")[0].value=="1"){
		
		}else{
			document.getElementsByName("pageno")[0].value="1";
			document.getElementsByName("buyIn")[0].submit();
		}
		
	}
	function pre(){
		XA
		if(parseInt(document.getElementsByName("pageno")[0].value)>1){
			document.getElementsByName("pageno")[0].value=parseInt(document.getElementsByName("pageno")[0].value)-1;
			document.getElementsByName("buyIn")[0].submit();
		}else{
			document.getElementsByName("pageno")[0].value="1";
		}
		
	}
	function next(){
		
		if(parseInt(pagenum)-parseInt(document.getElementsByName("pageno")[0].value)>0){
			document.getElementsByName("pageno")[0].value=parseInt(document.getElementsByName("pageno")[0].value)+1;
			document.getElementsByName("buyIn")[0].submit();
		}else{
			document.getElementsByName("pageno")[0].value=pagenum;
		}
		
	}
	function last(){
		//alert(document.getElementsByName("pageno")[0].value==pagenum);
		if(document.getElementsByName("pageno")[0].value==pagenum){
		
		}else{
			document.getElementsByName("pageno")[0].value=pagenum;
			document.getElementsByName("buyIn")[0].submit();
		}
		//document.getElementsByName("buyIn")[0].submit();
	}
	function edit(id){
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
		document.getElementsByName("buyIn")[0].action="modifyBuyIn.jsp?id="+id;
		document.getElementsByName("buyIn")[0].submit();
	}
	function editfkd(id,billid){
		//if(null!=id && id!="null" && id!=""){
			document.getElementsByName("buyIn")[0].action="modifyFkd.jsp?id="+id+"&billid="+billid;
			document.getElementsByName("buyIn")[0].submit();
		//}else{
		//	alert("暂无付款单！");
		//}
		
	}
	function editpz(id,billid){
		//if(null!=id && id!="null" && id!=""){
			document.getElementsByName("buyIn")[0].action="modifyFkd.jsp?id="+id+"&billid="+billid;
			document.getElementsByName("buyIn")[0].submit();
		//}else{
		//	alert("暂无付款单！");
		//}
		
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
	function createpz(){
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
		document.getElementsByName("operate")[0].value="createpz";
		document.getElementsByName("buyIn")[0].submit();
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
		
		document.getElementsByName("fwarehouse")[0].value="";
		document.getElementsByName("fordrji")[0].value="";
		document.getElementsByName("finfoji")[0].value="";
		document.getElementsByName("fds40ji")[0].value="";
	}
	function selectrkd(){
		var supplier=document.getElementsByName("suppliers");
		var tempList = new Array();
		
		var checkboxs=document.getElementsByName("checkbox");
		
		var ids="";
		for(var i=0;i<checkboxs.length;i++){
			if(checkboxs[i].checked){
				ids=ids+"'"+checkboxs[i].value+"',";	
				tempList.push(supplier[i].value);			
			}
		}
		var flag="fp";
		
		//alert(tempList[0]);
		document.getElementsByName("ids")[0].value=ids;
		document.getElementsByName("supplierid")[0].value=tempList[0];	
		if(flag=="fp"){
			if(tempList.length>1){
				for(var j=1;j<tempList.length;j++){
					if(tempList[j-1]!=tempList[j]){
						alert("请选择同一供应商开票！");
						return false;
						
					}
				}
			}
			document.getElementsByName("buyIn")[0].action="buyInFpModify.jsp";
		}else{
			document.getElementsByName("buyIn")[0].action="buyInFkdModify.jsp";
		}
		
		document.getElementsByName("buyIn")[0].submit();
	}
	
	function createfp(){
		
		
		var supplier=document.getElementsByName("suppliers");
		var tempList = new Array();
		
		var checkboxs=document.getElementsByName("checkbox");
		var isChecked = false;
		var count = 0;
		var ids="";
		for(var i=0;i<checkboxs.length;i++){
			if(checkboxs[i].checked){
				tempList.push(supplier[i].value);
				
				ids=ids+"'"+checkboxs[i].value+"',";
				isChecked=true;
				count++;
			}
		}
		
		
		if(count==0){
			alert("请选择一条记录");
			return false;
		}
		if(tempList.length>1){
			for(var j=1;j<tempList.length;j++){
				if(tempList[j-1]!=tempList[j]){
					alert("请选择同一供应商开票！");
					return false;
					
				}
			}
		}
		//alert(tempList[0]);
		document.getElementsByName("ids")[0].value=ids;
		document.getElementsByName("supplierid")[0].value=tempList[0];		
		document.getElementsByName("buyIn")[0].action="buyInFpModify.jsp";
		document.getElementsByName("buyIn")[0].submit();
	}
	function goshd(flag){
	   window.location.href="buyInFpModify.jsp"+encodeURI(flag);
	   //buyInFpModify.jsp
	}
	
		function gopage(fwarehouse,fordrji,finfoji,fds40ji){
		var pageno = document.getElementById("gpageno").value;
		console.log("the pageno is "+ parseInt(pageno));
		window.location.href="buyIn.jsp?page="+parseInt(pageno)+"&fwarehouse="+fwarehouse+"&fordrji="+fordrji+"&finfoji="+finfoji+"&fds40ji="+fds40ji;
	
	}
</script>
			  <%
			  int currentPage = 1;//当前页码
			  int pageSpace = 10 ;//每页显示条数
			  int itemCount = 0 ;//总条数
			  int pageCount = 0;
		
String userName=(String)session.getAttribute("userName");
String envId = (String)session.getAttribute("envId");
String envIdXA = (String)session.getAttribute("envIdXA");
String userCode = (String)session.getAttribute("userCode");
String userHouse = (String)session.getAttribute("userHouse");
String stid = (String)session.getAttribute("stid");
//fwarehouse fordrji finfoji fds40ji
String fwarehouse = new String((request.getParameter("fwarehouse")==null?"":request.getParameter("fwarehouse")).getBytes("ISO8859-1"),"utf-8");
String fordrji = new String((request.getParameter("fordrji")==null?"":request.getParameter("fordrji")).getBytes("ISO8859-1"),"utf-8");
String finfoji = new String((request.getParameter("finfoji")==null?"":request.getParameter("finfoji")).getBytes("ISO8859-1"),"utf-8");
String fds40ji = new String((request.getParameter("fds40ji")==null?"":request.getParameter("fds40ji")).getBytes("ISO8859-1"),"utf-8");
//new String((request.getParameter("fds40ji")==null?"":request.getParameter("fds40ji")).getBytes("ISO8859-1"),"utf-8");
if(userName==null || "".equals(userName.trim())){
%>
<script type="text/javascript">
window.location.href="logo.jsp";

</script>
<%} %>
<body class="right_body">
	<div class="path">您现在的位置： 首页 &gt; Ampheno SRM &gt; 采购单管理</div>
	<form action="buyIn.jsp" method="post" name="buyIn">
	<div class="top_button_div">
		
		<input name="operate" type="hidden" value=""/>
		<input name="ids" type="hidden" value=""/>
		<input name="supplierid" type="hidden" value=""/>
	</div>
	
	<div class="search">
		<h2>
			<span class="fl">采购单查询</span>			
			<span class="fr"><input name="" type="button" class="search_button" onclick="submit2();"/><input name="rs" type="button" class="purge_button" onclick="onclear();"/></span><!--  span里无内容时，此span不能删除  -->
		</h2>
		
		<ul>			
			<!-- <li><div class="w_s">日期：</div><input name="startDate" type="text" class="time_input" onclick="WdatePicker()" onmouseout="dateIsValid(this,'开始日期')" />-<input name="endDate" type="text" class="time_input" onclick="WdatePicker()" onmouseout="dateIsValid(this,'结束日期')" /></li>
			<li><div class="w_s">供应商：</div><input name="supplier" type="text" class="input_w" value=""/></li>
			<li><div class="w_s">单据编码：</div><input name="fnumber" type="text" class="input_w" value=""/></li>
			<li><div class="w_s">仓库名称：</div><input name=fwarehouse type="text" class="input_w" value=""/></li>
			 -->
			<li><div class="w_s">仓库：</div><input name=fwarehouse type="text" class="input_w" value="<%=fwarehouse %>"/></li>
			<li><div class="w_s">采购单号：</div><input name=fordrji type="text" class="input_w" value="<%=fordrji %>"/></li>
			<li><div class="w_s">物料：</div><input name=finfoji type="text" class="input_w" value="<%=finfoji %>"/></li>
			<li><div class="w_s">描述：</div><input name=fds40ji type="text" class="input_w" value="<%=fds40ji %>"/></li>
				
		
		</ul>
	</div>
	
	<div class="data_list">
		<h2>
			<span class="fl">采购单列表</span>
			<span class="fr"></span><!--  span里无内容时，此span不能删除  -->
		</h2>
		
		<div class="list_inner">
			<div class="verflow_s">
			<table width="100%" border="0" cellspacing="1" cellpadding="0" class="list_table_s">
			   <tr>
			   <th>选择</th>
				<th>工厂</th>
				<th>采购单号 项次</th>
				<th>物料</th>
				<th>描述</th>
				<th>采购单位</th>
				<th>采购量</th>
			<th>未交量(采购单位)</th>
				<th>采购交期</th>
				<th>是否批次控制</th>
				<!-- 
				<th>审核人</th>
			    -->
		      </tr>


<%	

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String result="";
try{
	java.sql.DriverManager.registerDriver (new com.ibm.as400.access.AS400JDBCDriver ()); 
	Class.forName("com.ibm.as400.access.AS400JDBCDriver");	
	String url ="jdbc:as400://"+ConstantUtils.DATABASE_IP+"/"+envIdXA+";translate binary=true"; 
 	conn = DriverManager.getConnection(url, ConstantUtils.DATABASE_NAME, ConstantUtils.DATABASE_PASSWORD);
 	String sql="Select UUA1VM from "+envIdXA+".VENNAM where VNDNR = '"+userCode+"'";
 	int uua1 = 0;
 	stmt = (Statement) conn.createStatement();
	stmt.execute(sql);//执行select语句用executeQuery()方法，执行insert、update、delete语句用executeUpdate()方法。
	rs=(ResultSet) stmt.getResultSet();
	while(rs.next()){
		uua1 = rs.getInt("UUA1VM");
	}
 	rs.close();//后定义，先关闭
	stmt.close();
	
	//----------查询总条数
	 sql = "select count(*) as c from "+envIdXA+".SCHRCP as SCHRCP,"+envIdXA+".ITMSIT as ITMSIT where VNDRJI='"+userCode+"' and SCHRCP.ITNOJI=ITMSIT.ITNOT9 and ITMSIT.STIDT9='"+stid+"' and (SCHRCP.RCPSJI='10' or SCHRCP.RCPSJI='35') ";
	 	if(!"*ALL".equals(userHouse)){
 		sql=sql+" AND SCHRCP.WHIDJI='"+userHouse+"'";
 	}else{
 		if(!"".equals(fwarehouse)){
 		sql=sql+" AND SCHRCP.WHIDJI like '%"+fwarehouse+"%'";
 		}
 	}
 	//fwarehouse fordrji finfoji fds40ji
 	if(!"".equals(fordrji)){
 	sql=sql+" AND SCHRCP.ORDRJI like '%"+fordrji+"%'";
 	}
 	if(!"".equals(finfoji)){
 	sql=sql+" AND SCHRCP.ITNOJI like '%"+finfoji+"%'";
 	}
 	if(!"".equals(fds40ji)){
 	sql=sql+" AND SCHRCP.DS40JI like '%"+fds40ji+"%'";
 	}
 	System.out.println("the get count sql is "+sql);
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql) ;
	System.out.println("execute finished");
	if(rs.next()){
		itemCount = rs.getInt("c");
		System.out.println("the count is "+ itemCount);
	}
	if(rs !=null){
	rs.close();
	}
	if(stmt!= null){
	stmt.close();
	}
	//-----------维护pageCount
	pageCount = itemCount%pageSpace == 0?itemCount/pageSpace:itemCount/pageSpace+1;
	
	//-----------维护currentPage
		  try{
			  	currentPage = Integer.parseInt(request.getParameter("page"));
			  	if(currentPage<1)
			  	currentPage = 1 ;
			  	if(currentPage>pageCount)
			  	currentPage = pageCount ;
			  }catch(Exception e){
			  	currentPage = 1 ;
			  }
	
	
	
 	sql="select * from (select SCHRCP.*,ITMSIT.BLCFT9,rownumber() over() as rn from "+envIdXA+".SCHRCP as SCHRCP,"
 	+envIdXA+".ITMSIT as ITMSIT where VNDRJI='"+userCode+"' and SCHRCP.ITNOJI=ITMSIT.ITNOT9 and ITMSIT.STIDT9='"
 	+stid+"' and (SCHRCP.RCPSJI='10' or SCHRCP.RCPSJI='35') ";
 	//String sql="select SCHRCP.*,ITMSIT.BLCFT9 from "+envIdXA+".SCHRCP as SCHRCP,"+envIdXA+".ITMSIT as ITMSIT where VNDRJI='"+userCode+"' and SCHRCP.ITNOJI=ITMSIT.ITNOT9 and ITMSIT.STIDT9='"+stid+"' and (SCHRCP.RCPSJI='10' or SCHRCP.RCPSJI='35') ";
// SELECT * FROM (Select 字段1,字段2,字段3,rownumber() over(ORDER BY 排序用的列名 ASC) AS rn from 表名) AS a1 WHERE a1.rn BETWEEN 10 AND 20 
 	//String sql="select SCHRCP.* from "+envIdXA+".SCHRCP as SCHRCP where VNDRJI='"+userCode+"' ";
 	if(!"*ALL".equals(userHouse)){
 		sql=sql+" AND SCHRCP.WHIDJI='"+userHouse+"'";
 	}else{
 		if(!"".equals(fwarehouse)){
 		sql=sql+" AND SCHRCP.WHIDJI like '%"+fwarehouse+"%'";
 		}
 	}
 	//fwarehouse fordrji finfoji fds40ji
 	if(!"".equals(fordrji)){
 	sql=sql+" AND SCHRCP.ORDRJI like '%"+fordrji+"%'";
 	}
 	if(!"".equals(finfoji)){
 	sql=sql+" AND SCHRCP.ITNOJI like '%"+finfoji+"%'";
 	}
 	if(!"".equals(fds40ji)){
 	sql=sql+" AND SCHRCP.DS40JI like '%"+fds40ji+"%'";
 	}
 	sql+=" ) AS a1 WHERE a1.rn BETWEEN "+((currentPage-1)*pageSpace+1)+" AND "+(currentPage*pageSpace);
 	/* sql +=" order by ORDRJI desc,PISQJI desc,BKSQJI desc"; */
 	sql +=" order by CRDTJI desc,CRTMJI desc";
 	System.out.print("the byin sql is "+sql);
 	if(conn!=null){
 		//result="已经成功连接数据库";
 	
	   stmt = (Statement) conn.createStatement();
	   stmt.execute(sql);//执行select语句用executeQuery()方法，执行insert、update、delete语句用executeUpdate()方法。
	   rs=(ResultSet) stmt.getResultSet();
	while(rs.next()){ //当前记录指针移动到下一条记录上
	int datei=rs.getInt("DKDTJI") +Integer.valueOf(19000000);
		Calendar calendar=Calendar.getInstance();   
   	calendar.setTimeInMillis(System.currentTimeMillis());
	calendar.set(Calendar.DAY_OF_MONTH,calendar.get(Calendar.DAY_OF_MONTH)+uua1);
	//int dateP=calendar.get(Calendar.DATE);
	SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
	int dateP= Integer.valueOf(format.format(calendar.getTime()));
	if(dateP<datei){
%>
<tr >
	<td></td>
	<td><font color="red"><%=rs.getString("WHIDJI") %></font></td>
	<td><font color="red"><%=rs.getString("ORDRJI")+"-"+rs.getInt("PISQJI")+"-"+rs.getInt("BKSQJI") %></font></td>
	<td><font color="red"><%=rs.getString("ITNOJI") %></font></td>
	<td><font color="red"><%=rs.getString("DS40JI")%></font></td>
	<td><font color="red"><%=rs.getString("ORUMJI") %></font></td>
	<td><font color="red"><%=rs.getString("UCOQJI") %></font></td>
	<td><font color="red"><%=rs.getFloat("UMCVJI")==0?0:(rs.getFloat("QTYOJI")/rs.getFloat("UMCVJI")) %></font></td>
	<td><font color="red"><%=(rs.getInt("DKDTJI") +Integer.valueOf(19000000))%> </font></td>
	<td><font color="red"><%=("1".equals(rs.getString("BLCFT9"))?"是":"否") %></font></td>
</tr>
<%
}else{
%>
<tr>
	<td><input type="button" value="添加送货单" onclick="goshd('?item1=<%=rs.getString("ORDRJI") + "-"
								+ rs.getInt("PISQJI") + "-"
								+ rs.getInt("BKSQJI")%>&item2=<%=rs.getString("ITNOJI")%>&item3=<%=rs.getString("DS40JI")%>&item4=<%=rs.getString("ORUMJI")%>&item5=<%=rs.getString("UMSTJI")%>&item6=<%=rs.getString("UMCVJI")%>&item9=<%=rs.getInt("UMCVJI")==0?0:(rs.getInt("QTYOJI") / rs.getInt("UMCVJI"))%>&BLCFT9=<%=rs.getString("BLCFT9")%>&PISQJI=<%=rs.getString("PISQJI")%>&ORDRJI=<%=rs.getString("ORDRJI")%>&BKSQJI=<%=rs.getString("BKSQJI")%>&SCTKJI=<%=rs.getString("SCTKJI")%>');"></td>
	<td><%=rs.getString("WHIDJI") %></td>
	<td><%=rs.getString("ORDRJI")+"-"+rs.getInt("PISQJI")+"-"+rs.getInt("BKSQJI") %></td>
	<td><%=rs.getString("ITNOJI") %></td>
	<td><%=rs.getString("DS40JI")%></td>
	<td><%=rs.getString("ORUMJI") %></td>
	<td><%=rs.getString("UCOQJI") %></td>
	<td><%=rs.getFloat("UMCVJI")==0?0:(rs.getFloat("QTYOJI")/rs.getFloat("UMCVJI")) %></td>
	<td><%=(rs.getInt("DKDTJI") +Integer.valueOf(19000000))%> </td>
	<td><%=("1".equals(rs.getString("BLCFT9"))?"是":"否") %></td>
</tr>
<%
}
  	 }
	}
}catch(Exception e){
result=e.getMessage();
e.printStackTrace();
	try{
	rs.close();//后定义，先关闭
	stmt.close();
	conn.close();//先定义，后关闭
	}catch(Exception ex){
		
	}
}finally{
	try{
	rs.close();//后定义，先关闭
	stmt.close();
	conn.close();//先定义，后关闭
	}catch(Exception e){
		
	}
}
%>

	 
		  </table>
		  </div>
		   <div class="page">共有&nbsp;<%=pageCount %>&nbsp;页&nbsp;&nbsp;<%=itemCount %>&nbsp;条记录，当前为第&nbsp;<%=currentPage %>&nbsp;页  
		    <a href="buyIn.jsp?page=1&fwarehouse=<%=fwarehouse%>&fordrji=<%=fordrji%>&finfoji=<%=finfoji%>&fds40ji=<%=fds40ji%>" title="" onclick="first();">首页</a> 
		    <a href="buyIn.jsp?page=<%=currentPage-1>0?currentPage-1:1 %>&fwarehouse=<%=fwarehouse%>&fordrji=<%=fordrji%>&finfoji=<%=finfoji%>&fds40ji=<%=fds40ji%>" title="" onclick="pre();">上一页</a> 
		    <a href="buyIn.jsp?page=<%=currentPage+1>pageCount?pageCount:currentPage+1 %>&fwarehouse=<%=fwarehouse%>&fordrji=<%=fordrji%>&finfoji=<%=finfoji%>&fds40ji=<%=fds40ji%>" title="" onclick="next();">下一页</a> 
		    <a href="buyIn.jsp?page=<%=pageCount %>&fwarehouse=<%=fwarehouse%>&fordrji=<%=fordrji%>&finfoji=<%=finfoji%>&fds40ji=<%=fds40ji%>" title="" onclick="last();">尾页</a> 每页<%=pageSpace %>条 到第
		    <input type="text" class="page_input" id="gpageno" value="1" />页
		     <input type="button" value="" class="go_button" onclick="gopage('<%=fwarehouse%>','<%=fordrji%>','<%=finfoji%>','<%=fds40ji%>')"/>
		  </div>
		  
		</div>
		</form>
	</div>
	


</body>

</html>