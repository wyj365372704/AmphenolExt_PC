<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="com.xy.util.*" %>
<%@ page import="com.xy.action.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.math.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
	String pageno = request.getParameter("pageno");
	String pagesize = request.getParameter("pagesize");
	String operate = request.getParameter("operate");
	String ids = request.getParameter("ids");
	String isSelect=request.getParameter("isSelect");
	//区分是分部总经理审批还是集团采购部经理审批FIsAudit1=1表示分部总经理审批通过，
	//集团采购部经理审批FIsAudit1=1并且fbasestatus='2'的采购申请单，审批后设置fbasestatus='4'
	String checkType=request.getParameter("checkType");
String FDefOrgUnitID=(String)session.getAttribute(ConstantUtils.CURRENT_ORGID);
	if(null==pageno || pageno.trim()==""){
		pageno="1";
	}
	if(null==pagesize || pagesize.trim()==""){
		pagesize="10000";
	}
	int pagenum =1;
	int rownum = 1;
	
	String supplier = new String((request.getParameter("supplier")==null?"":request.getParameter("supplier")).getBytes("ISO8859-1"),"gb2312");
	String fnumber=new String((request.getParameter("fnumber")==null?"":request.getParameter("fnumber")).getBytes("ISO8859-1"),"gb2312");
	String fstatuspz=new String((request.getParameter("fstatuspz")==null?"":request.getParameter("fstatuspz")).getBytes("ISO8859-1"),"gbk");
	String fstatusfkd=new String((request.getParameter("fstatusfkd")==null?"":request.getParameter("fstatusfkd")).getBytes("ISO8859-1"),"gbk");
	String fstatusfp=new String((request.getParameter("fstatusfp")==null?"":request.getParameter("fstatusfp")).getBytes("ISO8859-1"),"gbk");
	String fwarehouse=new String((request.getParameter("fwarehouse")==null?"":request.getParameter("fwarehouse")).getBytes("ISO8859-1"),"gbk");
	List result = null;
	String sqlcout="select count(*) from  T_SM_PurRequest  b where b.fbasestatus='2' and b.fcompanyorgunitid='"+FDefOrgUnitID+"'";
	String sql = "select top "+Integer.valueOf(pagesize)+" b.fid, b.fnumber 单据编号,c.fname_l2 公司名称,b.fcompanyorgunitid,bt.fname_l2 业务类型,p1.fname_l2 申请人,"+
	"p0.fname_l2 制单人,b.fcreatetime 制单时间,"+
	"p2.fname_l2 修改人,b.flastupdatetime 修改时间,p3.fname_l2 审核人,b.faudittime 审核时间,"+
	"b.fbizdate 申请日期,pg.fname_l2 采购组,p4.fname_l2 采购员,b.fdescription 备注,"+
	"b.fisurgent 加急,b.fismergebill 合并,b.fbasestatus from T_SM_PurRequest b "+
	"left outer join t_org_company c on c.fid COLLATE Chinese_PRC_CS_AS =b.fcompanyorgunitid COLLATE Chinese_PRC_CS_AS  "+
	"left outer join T_SCM_BizType bt on bt.fid COLLATE Chinese_PRC_CS_AS  =b.fbiztypeid COLLATE Chinese_PRC_CS_AS  "+
	"left outer join T_BD_Person p0 on p0.fid COLLATE Chinese_PRC_CS_AS  =b.fcreatorid  COLLATE Chinese_PRC_CS_AS "+
	"left outer join T_BD_Person p1 on p1.fid COLLATE Chinese_PRC_CS_AS  =b.fpersonid  COLLATE Chinese_PRC_CS_AS  "+
	"left outer join T_BD_Person p2 on p2.fid COLLATE Chinese_PRC_CS_AS  =b.fmodifierid  COLLATE Chinese_PRC_CS_AS  "+
	"left outer join T_BD_Person p3 on p3.fid COLLATE Chinese_PRC_CS_AS  =b.fauditorid COLLATE Chinese_PRC_CS_AS  "+
	"left outer join T_BD_PurchaseGroup pg on pg.fid COLLATE Chinese_PRC_CS_AS  =b.fpurchasegroupid COLLATE Chinese_PRC_CS_AS  "+	
	"left outer join T_BD_Person p4 on p4.fid COLLATE Chinese_PRC_CS_AS  =b.fpurchasepersonid COLLATE Chinese_PRC_CS_AS  "
	+"where b.fbasestatus='2' and b.fcompanyorgunitid COLLATE Chinese_PRC_CS_AS ='"+FDefOrgUnitID+"'";
	String sqlin = "select top "+(Integer.valueOf(pageno)-1)*Integer.valueOf(pagesize)+"  FID from  T_SM_PurRequest   where fbasestatus='2' and fcompanyorgunitid COLLATE Chinese_PRC_CS_AS ='"+FDefOrgUnitID+"'" ;
	
	if(supplier!=null && supplier.trim().length()>0){
		sql=sql+" and 供应商  like '%"+supplier+"%'";
		sqlcout=sqlcout+" and 供应商  like '%"+supplier+"%'";
		sqlin=sqlin+" and 供应商  like '%"+supplier+"%'";
	}
	if(fnumber!=null && fnumber.trim().length()>0){
		sql=sql+" and b.fnumber  like '%"+fnumber+"%'";
		sqlcout=sqlcout+" and fnumber  like '%"+fnumber+"%'";
		sqlin=sqlin+" and fnumber  like '%"+fnumber+"%'";
	}
	if(checkType!=null && checkType.equals("FIsAudit2")){
		sql=sql+" and b.FIsAudit1=1";
		sqlcout=sqlcout+" and  b.FIsAudit1=1";
		sqlin=sqlin+" and  b.FIsAudit1=1";
	}else if(checkType!=null && checkType.equals("FIsAudit1")){
		sql=sql+" and (b.FIsAudit1<>1 or b.FIsAudit1 is null)";
		sqlcout=sqlcout+" and  (b.FIsAudit1<>1 or b.FIsAudit1 is null)";
		sqlin=sqlin+" and  (b.FIsAudit1<>1 or b.FIsAudit1 is null)";
	}
	if(fstatuspz!=null && fstatuspz.trim().length()>0){
	    if("未生成凭证".equals(fstatuspz.trim())){
	      sql=sql+" and FPzID is null ";
		  sqlcout=sqlcout+" and FPzID  is null  ";
		  sqlin=sqlin+" and FPzID  is null  ";
	    }else if("已生成凭证".equals(fstatuspz.trim())){
	      sql=sql+" and FPzID >0 ";
		  sqlcout=sqlcout+" and FPzID >0 ";
		  sqlin=sqlin+" and FPzID >0 ";	    
	    }else{	    
	    }		
	}
	if(fstatusfkd!=null && fstatusfkd.trim().length()>0){
	    if("未生成付款单".equals(fstatusfkd.trim())){
	      sql=sql+" and FFKDID is null ";
		  sqlcout=sqlcout+" and FFKDID  is null  ";
		  sqlin=sqlin+" and FFKDID  is null  ";
	    }else if("已生成付款单".equals(fstatusfkd.trim())){
	      sql=sql+" and FFKDID >0 ";
		  sqlcout=sqlcout+" and FFKDID >0 ";
		  sqlin=sqlin+" and FFKDID >0 ";	    
	    }else{	    
	    }		
	}
	if(fstatusfp!=null && fstatusfp.trim().length()>0){
	    if("未生成发票".equals(fstatusfp.trim())){
	      sql=sql+" and FFpID is null ";
		  sqlcout=sqlcout+" and FFpID  is null  ";
		  sqlin=sqlin+" and FFpID  is null  ";
	    }else if("已生成发票".equals(fstatusfp.trim())){
	      sql=sql+" and FFpID >0 ";
		  sqlcout=sqlcout+" and FFpID >0 ";
		  sqlin=sqlin+" and FFpID >0 ";	    
	    }else{	    
	    }		
	}
	if(fwarehouse!=null && fwarehouse.trim().length()>0){
	    if(fwarehouse== null || fwarehouse.trim().equals("")){
	    }else{	    
	      sql=sql+" and FDefaultWarehouseName like '%"+fwarehouse.trim()+"'%";
		  sqlcout=sqlcout+" and FDefaultWarehouseName like '%"+fwarehouse.trim()+"'%";
		  sqlin=sqlin+" and FDefaultWarehouseName like '%"+fwarehouse.trim()+"'%";
	    }		
	}
	if(startDate!=null && startDate.trim().length()>0){
			sql=sql+" and b.fbizdate>='"+startDate+"'";
			sqlcout=sqlcout+" and fbizdate>='"+startDate+"'";
			sqlin=sqlin+" and fbizdate>='"+startDate+"'";
		}
		if(endDate!=null && endDate.trim().length()>0){
			sql=sql+" and b.fbizdate<='"+endDate+" 23:59:59'";
			sqlcout=sqlcout+" and fbizdate<='"+endDate+" 23:59:59'";
			sqlin=sqlin+" and fbizdate<='"+endDate+" 23:59:59'";
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
			
					
		}else{
			if(startDate==null || startDate.trim().length()==0){
				startDate=fromDateS;
			}
			if(endDate==null || endDate.trim().length()==0){
				endDate=todayS;
			}
		}
		
		//if(null==operate || operate.trim().length()==0){
		//	rs=stmt.executeQuery(sqlcout+" and 1<>1");
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
		System.out.println(sql+" and b.FID not in("+sqlin+")");
		
		//if(null==operate || operate.trim().length()==0){
		//	rs=stmt.executeQuery(sql+" and 1<>1");
		//}else{
			rs=stmt.executeQuery(sql+" and b.FID not in("+sqlin+")");
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
		document.getElementsByName("startDate")[0].value="";
		document.getElementsByName("endDate")[0].value="";
		document.getElementsByName("fnumber")[0].value="";
	}
	function selectrkd(){
		
		var checkboxs=document.getElementsByName("checkbox");
		
		var ids="";
		for(var i=0;i<checkboxs.length;i++){
			if(checkboxs[i].checked){
				ids=ids+"'"+checkboxs[i].value+"',";				
			}
		}
		
		document.getElementsByName("ids")[0].value=ids;
		document.getElementsByName("buyIn")[0].action="buyInFkdModify.jsp";
		document.getElementsByName("buyIn")[0].submit();
	}
	
	function check(fnumber,fid){
		document.getElementsByName("buyIn")[0].action="buyApplyCheck.jsp?fnumber="+fnumber+"&id="+fid+"&checkType=<%=checkType%>";
			document.getElementsByName("buyIn")[0].submit();
	}
</script>
<body class="right_body">
	<div class="path">您现在的位置： 首页 &gt; 新亚ERP &gt; 采购申请单审批管理</div>
	<form action="buyApply.jsp" method="post" name="buyIn">
	<div class="top_button_div">
		
		<input name="operate" type="hidden" value=""/>
		<input name="ids" type="hidden" value=""/>
		<input name="checkType" type="hidden" value="<%=checkType %>" />
	</div>
	
	<div class="search">
		<h2>
			<span class="fl">采购申请单审批查询</span>			
			<span class="fr"><input name="" type="button" class="search_button" onclick="submit2();"/><input name="rs" type="button" class="purge_button" onclick="onclear();"/></span><!--  span里无内容时，此span不能删除  -->
		</h2>
		
		<ul>			
			<li><div class="w_s">日期：</div><input name="startDate" type="text" class="time_input" onclick="WdatePicker()" onmouseout="dateIsValid(this,'开始日期')" value="<%=(startDate==null?"":startDate) %>"/>-<input name="endDate" type="text" class="time_input" onclick="WdatePicker()" onmouseout="dateIsValid(this,'结束日期')" value="<%=(endDate==null?"":endDate) %>"/></li>
			
			<li><div class="w_s">单据编码：</div><input name="fnumber" type="text" class="input_w" value="<%=(fnumber==null?"":fnumber) %>"/></li>
				
		
		</ul>
	</div>
	
	<div class="data_list">
		<h2>
			<span class="fl">采购申请单审批列表</span>
			<span class="fr"></span><!--  span里无内容时，此span不能删除  -->
		</h2>
		
		<div class="list_inner">
			<div class="verflow_s">
			<table width="100%" border="0" cellspacing="1" cellpadding="0" class="list_table_s">
			   <tr>
				<th><input type="checkbox" name="checkboxall" value="all" onclick="selectAll();"/></th>
				<th>单据编码</th>
				<th>公司名称</th>
				<th>业务类型</th>
				<th>申请人</th>
				<th>制单人</th>
				<th>制单时间</th>
				<th>申请日期</th>
				<th>采购组</th>
				<th>采购员</th>
				<th>加急</th>
				<th>合并</th>
				<th>备注</th>
				
				<!-- 
				<th>审核人</th>
			    -->
		      </tr>
			  <%
			   
			    
			  	if(null!=rs){
			  		while(rs.next()){
			  		
			   %>
			  <tr>
				<th><input type="checkbox" name="checkbox" value="<%=rs.getString("单据编号") %>" /></th>
				<td><a href="#" onclick="check('<%=rs.getString("单据编号") %>','<%=rs.getString("fid") %>');" style="color:blue"><%=rs.getString("单据编号") %></a></td>
				
				<td><%=rs.getString("公司名称") %></td>
				<td><%=rs.getString("业务类型") %></td>
				<td><%=rs.getString("申请人") %></td>
				<td><%=rs.getString("制单人") %></td>
				<td><%=ObjectConvertUtils.getDateFormat(rs.getDate("制单时间")) %></td>
				<td><%=ObjectConvertUtils.getDateFormat(rs.getDate("申请日期")) %></td>
				<td><%=rs.getString("采购组") %></td>
				<td><%=rs.getString("采购员") %></td>
				<td>
				<%
					if(rs.getString("加急").equals("0")){
				 %>
				<%=(rs.getString("加急").equals("0")?"不加急":"加急") %>
				<%}else{ %>
				<strong class="red"><%=(rs.getString("加急").equals("0")?"不加急":"加急") %></strong>
				<%} %>
				</td>
				<td><%=rs.getString("合并").equals("0")?"不合并":"合并" %></td>
				<td><%=rs.getString("备注") %></td>
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