<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page import="com.xy.util.*" %>
<%@ page import="com.xy.action.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
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
		pagesize="10000";
	}
	int pagenum =1;
	int rownum = 1;
	
	String FExplanation = new String((request.getParameter("FExplanation")==null?"":request.getParameter("FExplanation")).getBytes("ISO8859-1"),"gb2312");
	String fnumber=new String((request.getParameter("fnumber")==null?"":request.getParameter("fnumber")).getBytes("ISO8859-1"),"gb2312");
	List result = null;
	String sqlcout= "SELECT  * FROM   OPENDATASOURCE ('SQLOLEDB', 'Data Source=202.105.135.227;    USER ID = sa ;Password=sunyes20091230 '"+
                    " ).AIS20090117160413.dbo.t_voucher where 1=1 and fgroupid=5 ";
	String sql =    "select top "+Integer.valueOf(pagesize)+" * from OPENDATASOURCE ('SQLOLEDB', 'Data Source=202.105.135.227;    USER ID = sa ;"+
	                "Password=sunyes20091230 ').AIS20090117160413.dbo.t_voucher where 1=1 and fgroupid=5 ";
	String sqlin =  "select top "+(Integer.valueOf(pageno)-1)*Integer.valueOf(pagesize)+"  FVoucherID from OPENDATASOURCE ('SQLOLEDB', "+
	                "'Data Source=202.105.135.227;    USER ID = sa ;Password=sunyes20091230 ').AIS20090117160413.dbo.t_voucher where 1=1 and fgroupid=5 " ;
	
	if(FExplanation!=null && FExplanation.trim().length()>0){
		sql=sql+" and FExplanation  like '%"+FExplanation+"%'";
		sqlcout=sqlcout+" and FExplanation  like '%"+FExplanation+"%'";
		sqlin=sqlin+" and FExplanation  like '%"+FExplanation+"%'";
	}
	if(fnumber!=null && fnumber.trim().length()>0){
		sql=sql+" and fnumber  like '%"+fnumber+"%'";
		sqlcout=sqlcout+" and fnumber  like '%"+fnumber+"%'";
		sqlin=sqlin+" and fnumber  like '%"+fnumber+"%'";
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
			if(operate.equals("createfkd")){System.out.println("operate="+operate+";ids="+ids);
				callStmt = conn.prepareCall("{call proBillCreatefkd(?)}");
				callStmt.setString(1,ids);
				callStmt.execute();
				isoperatesuccess=true;
			}	
			if(operate.equals("createpz")){System.out.println("operate="+operate+";ids="+ids);
                System.out.println(ids);
				isoperatesuccess=true;
				String[] temp = ids.split(";");
				List lstID = new ArrayList();
				for(int i =0;i < temp.length;i++){
				  lstID.add(temp[i]);
				}
				ActionPZ aPZ = new ActionPZ(); 
				aPZ.convertRkd2PZ(lstID);
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
			sql=sql+" and fDate>='"+startDate+"'";
			sqlcout=sqlcout+" and fDate>='"+startDate+"'";
			sqlin=sqlin+" and fDate>='"+startDate+"'";
		}
		if(endDate!=null && endDate.trim().length()>0){
			sql=sql+" and fDate<'"+endDate+"'";
			sqlcout=sqlcout+" and fDate<'"+endDate+"'";
			sqlin=sqlin+" and fDate<'"+endDate+"'";
		}
			rs=stmt.executeQuery(sqlcout);
		if(rs.next()){
			rownum=rs.getInt(1);
		}
		rs.close();
		if(Integer.valueOf(rownum)%Integer.valueOf(pagesize)==0){
			pagenum=Integer.valueOf(rownum)/Integer.valueOf(pagesize);
		}else{
			pagenum=Integer.valueOf(rownum)/Integer.valueOf(pagesize)+1;
		}
		System.out.println(sql+" and FVoucherID not in ("+sqlin+")"+ "order by fnumber ");	
		rs=stmt.executeQuery(sql+" and FVoucherID not in ("+sqlin+")"  + "order by fnumber ");
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
	function submit2(){
		// 
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
		
		document.getElementsByName("byInPz")[0].submit();
	}
		function onclear(){
		// 
		document.getElementsByName("FExplanation").value  = null;
	}
	
	
	function first(){
		if(document.getElementsByName("pageno")[0].value=="1"){
		
		}else{
			document.getElementsByName("pageno")[0].value="1";
			document.getElementsByName("byInPz")[0].submit();
		}
		
	}
	function pre(){
		
		if(parseInt(document.getElementsByName("pageno")[0].value)>1){
			document.getElementsByName("pageno")[0].value=parseInt(document.getElementsByName("pageno")[0].value)-1;
			document.getElementsByName("byInPz")[0].submit();
		}else{
			document.getElementsByName("pageno")[0].value="1";
		}
		
	}
	function next(){
		
		if(parseInt(pagenum)-parseInt(document.getElementsByName("pageno")[0].value)>0){
			document.getElementsByName("pageno")[0].value=parseInt(document.getElementsByName("pageno")[0].value)+1;
			document.getElementsByName("byInPz")[0].submit();
		}else{
			document.getElementsByName("pageno")[0].value=pagenum;
		}
		
	}
	function last(){
		//alert(document.getElementsByName("pageno")[0].value==pagenum);
		if(document.getElementsByName("pageno")[0].value==pagenum){
		
		}else{
			document.getElementsByName("pageno")[0].value=pagenum;
			document.getElementsByName("byInPz")[0].submit();
		}
		//document.getElementsByName("byInPz")[0].submit();
	}


	function editpz(id){
		//if(null!=id && id!="null" && id!=""){
			document.getElementsByName("byInPz")[0].action="buyInPzModify.jsp?id="+id;
			document.getElementsByName("byInPz")[0].submit();
		//}else{
		//	alert("暂无付款单！");
		//}
		
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
		document.getElementsByName("FExplanation")[0].value="";
		document.getElementsByName("fnumber")[0].value="";
	}
	
</script>
<body class="right_body">
	<div class="path">您现在的位置： 首页 &gt; 新亚ERP &gt; 材料入库凭证管理</div>
	<form action="buyInPz.jsp" method="post" name="byInPz">
	<div class="top_button_div">
	<!-- 
	    <input type="button" class="metastasis"  onclick="createpz();"/>
		<input type="button" class="customsDeclaration"  onclick="createfkd();"/>
		<input type="button" class="declaresAuxiliary"  onclick=""/>
	 -->	
		<input name="" type="button" class="delete_commission"  />
		<input name="operate" type="hidden" value=""/>
		<input name="ids" type="hidden" value=""/>
	</div>
	
	<div class="search">
		<h2>
			<span class="fl">材料入库凭证查询</span>			
			<span class="fr"><input name="" type="button" class="search_button" onclick="submit2();"/><input name="rs" type="button" class="purge_button"  onclick="onclear();" /></span><!--  span里无内容时，此span不能删除  -->
		</h2>
		
		<ul>			
			<li><div class="w_s">日期：</div><input name="startDate" type="text" class="time_input" onclick="WdatePicker()" onmouseout="dateIsValid(this,'开始日期')" value="<%=(startDate==null?"":startDate) %>"/>-<input name="endDate" type="text" class="time_input" onclick="WdatePicker()" onmouseout="dateIsValid(this,'结束日期')" value="<%=(endDate==null?"":endDate) %>"/></li>
			<li><div class="w_s">摘要：</div><input name="FExplanation" type="text" class="input_w" value="<%=(FExplanation==null?"":FExplanation) %>"/></li>
			<li><div class="w_s">凭证号：</div><input name="fnumber" type="text" class="input_w" value="<%=(fnumber==null?"":fnumber) %>"/></li>
				
		</ul>
	</div>
	
	<div class="data_list">
		<h2>
			<span class="fl">材料入库凭证列表</span>
			<span class="fr"></span><!--  span里无内容时，此span不能删除  -->
		</h2>
		
		<div class="list_inner">
			<div class="verflow_s">
			<table width="100%" border="0" cellspacing="1" cellpadding="0" class="list_table_s">
			   <tr>
				<th><input type="checkbox" name="checkboxall" value="all" onclick="selectAll();"/></th>
				<th style="width:40px">凭证号</th>
				<th style="width:80px">日期</th>
				<th>年</th>
				<th>月</th>
				<th>摘要</th>
				<th>借方总额</th>
				<th>贷方总额</th>
				<th>描述	</th>			
		      </tr>
			  <%
			  	if(null!=rs){
			  		while(rs.next()){
			   %>
			  <tr>
				<th><input type="checkbox" name="checkbox" value="<%=rs.getString("FVoucherID") %>" /></th>
				<td ><a href="#" onclick="editpz('<%=rs.getString("FVoucherID") %>');" style="color:blue"><%=rs.getString("fnumber") %></a></td>
				<td  ><%=ObjectConvertUtils.getDateFormat(rs.getDate("fdate"))%></td>
				<td   ><%=rs.getString("fyear") %></td>
				<td  ><%=rs.getString("fperiod") %></td>
				<td  ><%=rs.getString("fexplanation") %></td>
				<td  ><%=rs.getBigDecimal("FDebitTotal").setScale(4) %></td>
				<td ><%=rs.getBigDecimal("FCreditTotal").setScale(4) %></td>
				<td ><%=rs.getString("FReference") %></td>
		      </tr>
		     <%}} %>
			 
		  </table>
		  </div>
		  <div class="page">共有&nbsp;<%=pagenum %>&nbsp;页&nbsp;&nbsp;<%=rownum %>&nbsp;条记录，当前为第&nbsp;<%=pageno %>&nbsp;页    <a href="#" title="" onclick="first();">首页</a> <a href="#" title="" onclick="pre();">上一页</a> <a href="#" title="" onclick="next();">下一页</a> <a href="#" title="" onclick="last();">尾页</a> 每页
		    <input type="text" class="page_input" name="pagesize" value="10000" readonly="readonly"/>
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
 	if(operate=="createfkd" && isoperatesuccess=="true"){
 		alert("生成付款单操作成功！");
 	}
 	if(operate=="createpz" && isoperatesuccess=="true"){
 		alert("生成凭证操作成功！");
 	}
 </script>
</html>