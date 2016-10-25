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
	String isSelect=request.getParameter("isSelect");
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
	String sqlcout="select count(ai.fid) from T_AP_ApInvoice ai left outer join t_bd_supplier s on ai.FAsstActID=s.fid where 1=1 ";
	String sql = "select top "+Integer.valueOf(pagesize)+" ai.*,s.fname_l1,s.faddress from T_AP_ApInvoice ai left outer join t_bd_supplier s on ai.FAsstActID=s.fid where 1=1 ";
	String sqlin = "select top "+(Integer.valueOf(pageno)-1)*Integer.valueOf(pagesize)+"  ai.FID from T_AP_ApInvoice ai left outer join t_bd_supplier s on ai.FAsstActID=s.fid where 1=1 " ;
	
	
	if(supplier!=null && supplier.trim().length()>0){
		sql=sql+" and fname_l1  like '%"+supplier+"%'";
		sqlcout=sqlcout+" and fname_l1  like '%"+supplier+"%'";
		sqlin=sqlin+" and fname_l1  like '%"+supplier+"%'";
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
			
			if(operate.equals("createfkd")){
				//callStmt = conn.prepareCall("{call proBillCreatefkd(?)}");
				//callStmt.setString(1,ids);
				//callStmt.execute();
				isoperatesuccess=true;
			}else if(operate.equals("createpz")){
				//TODO:���ɷ�Ʊƾ֤
			}else if(operate.equals("delete")){
				//����ɾ���Ĵ洢����
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
			sql=sql+" and FBillDate>='"+startDate+"'";
			sqlcout=sqlcout+" and FBillDate>='"+startDate+"'";
			sqlin=sqlin+" and FBillDate>='"+startDate+"'";
		}
		if(endDate!=null && endDate.trim().length()>0){
			sql=sql+" and FBillDate<'"+endDate+"'";
			sqlcout=sqlcout+" and FBillDate<'"+endDate+"'";
			sqlin=sqlin+" and FBillDate<'"+endDate+"'";
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
		System.out.println(sql+" and ai.FID not in("+sqlin+")");
		//if(null==operate || operate.trim().length()==0){
		//	rs=stmt.executeQuery(sql+" and 1<>1");
		//}else{
			rs=stmt.executeQuery(sql+" and ai.FID not in("+sqlin+")");
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
<title>����ERPϵͳ</title>
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
			alert("��ѡ��ʼ���ڣ�");
			return false;
		}
		if(endDate==""){
			alert("��ѡ��������ڣ�");
			return false;
		}
		document.getElementsByName("buyInfp")[0].submit();
	}
	function first(){
		if(document.getElementsByName("pageno")[0].value=="1"){
		
		}else{
			document.getElementsByName("pageno")[0].value="1";
			document.getElementsByName("buyInfp")[0].submit();
		}
		
	}
	function pre(){
		
		if(parseInt(document.getElementsByName("pageno")[0].value)>1){
			document.getElementsByName("pageno")[0].value=parseInt(document.getElementsByName("pageno")[0].value)-1;
			document.getElementsByName("buyInfp")[0].submit();
		}else{
			document.getElementsByName("pageno")[0].value="1";
		}
		
	}
	function next(){
		
		if(parseInt(pagenum)-parseInt(document.getElementsByName("pageno")[0].value)>0){
			document.getElementsByName("pageno")[0].value=parseInt(document.getElementsByName("pageno")[0].value)+1;
			document.getElementsByName("buyInfp")[0].submit();
		}else{
			document.getElementsByName("pageno")[0].value=pagenum;
		}
		
	}
	function last(){
		//alert(document.getElementsByName("pageno")[0].value==pagenum);
		if(document.getElementsByName("pageno")[0].value==pagenum){
		
		}else{
			document.getElementsByName("pageno")[0].value=pagenum;
			document.getElementsByName("buyInfp")[0].submit();
		}
		//document.getElementsByName("buyIn")[0].submit();
	}
	function edit(id){

		document.getElementsByName("buyInfp")[0].action="buyInFpModify.jsp?id="+id;
		document.getElementsByName("buyInfp")[0].submit();
	}
	function add(){
        //id='';
        //alert(id);
		document.getElementsByName("buyInfp")[0].action="buyInFpModify.jsp";
		document.getElementsByName("buyInfp")[0].submit();
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
			alert("��ѡ��һ����¼");
			return false;
		}
		document.getElementsByName("ids")[0].value=ids;
		document.getElementsByName("operate")[0].value="createfp";
		document.getElementsByName("buyInfp")[0].submit();
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
			alert("��ѡ��һ����¼");
			return false;
		}
		document.getElementsByName("ids")[0].value=ids;
		document.getElementsByName("operate")[0].value="createpz";
		document.getElementsByName("buyInfp")[0].submit();
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
			alert("��ѡ��һ����¼");
			return false;
		}
		document.getElementsByName("ids")[0].value=ids;
		document.getElementsByName("operate")[0].value="delete";
		document.getElementsByName("buyInfp")[0].submit();
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
	function selectfp(){
		
		var checkboxs=document.getElementsByName("checkbox");
		
		var ids="";
		for(var i=0;i<checkboxs.length;i++){
			if(checkboxs[i].checked){
				ids=ids+"'"+checkboxs[i].value+"',";		
			}
		}
		
		document.getElementsByName("ids")[0].value=ids;
		
			document.getElementsByName("buyInfp")[0].action="buyInFkdModify.jsp";
		
		document.getElementsByName("buyInfp")[0].submit();
	}
</script>
<body class="right_body">
	<div class="path">�����ڵ�λ�ã� ��ҳ &gt; ����ERP &gt; ���Ʊ����</div>
	<form action="buyInFp.jsp" method="post" name="buyInfp">
	<div class="top_button_div">
		
		<%
			if(null==isSelect || isSelect.trim().length()==0){
		 %>
	   <input name="" type="button" class="add_commission"  onclick="add();"/>
		<input type="button" class="metastasis"  onclick="createpz();"/>
		<input name="" type="button" class="delete_commission"  onclick="deleteP();"/>
		<%}else{ %>
		<input name="" type="button" class="button_m"  value="ȷ��" onclick="selectfp();"  />
		<%} %>
		<input name="operate" type="hidden" value=""/>
		<input name="ids" type="hidden" value=""/>
	</div>
	
	<div class="search">
		<h2>
			<span class="fl">���Ʊ��ѯ</span>			
			<span class="fr"><input name="" type="button" class="search_button" onclick="submit1();"/><input name="rs" type="button" class="purge_button" onclick="onclear();"/></span><!--  span��������ʱ����span����ɾ��  -->
		</h2>
		
		<ul>			
			<li><div class="w_s">��Ʊ���ڣ�</div><input name="startDate" type="text" class="time_input" onclick="WdatePicker()" onmouseout="dateIsValid(this,'��ʼ����')" value="<%=(startDate==null?"":startDate) %>"/>-<input name="endDate" type="text" class="time_input" onclick="WdatePicker()" onmouseout="dateIsValid(this,'��������')" value="<%=(endDate==null?"":endDate) %>"/></li>
			<li><div class="w_s">��Ӧ�̣�</div><input name="supplier" type="text" class="input_w" value="<%=(supplier==null?"":supplier) %>"/></li>
			<li><div class="w_s">��Ʊ��ţ�</div><input name="fnumber" type="text" class="input_w" value="<%=(fnumber==null?"":fnumber) %>"/></li>
		</ul>
	</div>
	
	<div class="data_list">
		<h2>
			<span class="fl">���Ʊ�б�</span>
			<span class="fr"></span><!--  span��������ʱ����span����ɾ��  -->
		</h2>
		
		<div class="list_inner">
			<div class="verflow_s">
			<table width="100%" border="0" cellspacing="1" cellpadding="0" class="list_table_s">
			   <tr>
				<th><input type="checkbox" name="checkboxall" value="all" onclick="selectAll();"/></th>
				<th>��Ʊ���</th>
				<th>��Ӧ������</th>
				<th>��Ʊ����</th>
				<th>��˾�ո����˺�</th>
				<th>��Ӧ�������˺�</th>
				<th>��Ӧ�̵�ַ</th>
				<th>��Ӧ������</th>
				<th>��Ӧ�̵绰</th>
				<th>��Ʊ����</th>
				<th>��Ʊ��</th>
				<th>��ע</th>
			
		      </tr>
			  <%
			  	if(null!=rs){
			  		while(rs.next()){
			   %>
			  <tr>
				<th><input type="checkbox" name="checkbox" value="<%=rs.getString("FID") %>" /></th>
				<td><a href="#" onclick="edit('<%=rs.getString("FID") %>');" style="color:blue"><%=rs.getString("fnumber") %></a></td>
				
				<td><%=rs.getString("fnumber") %></td>
				<td><%=rs.getString("fname_l1") %></td>
				<td><%=rs.getString("FType") %></td>
				<td>&nbsp;</td>
				<td><%=rs.getString("FCussAcctBank") %></td>
				<td><%=rs.getString("FCussAddress") %></td>
				<td><%=rs.getString("FCussBank") %></td>
				<td><%=rs.getString("FCussPhone") %></td>
				<td><%=rs.getString("FBillDate") %></td>
				<td><%=rs.getString("FDrawer") %></td>
				<td><%=rs.getString("FDescription") %></td>
		      </tr>
		     <%}} %>
			 
		  </table>
		  </div>
		  <div class="page">����&nbsp;<%=pagenum %>&nbsp;ҳ&nbsp;&nbsp;<%=rownum %>&nbsp;����¼����ǰΪ��&nbsp;<%=pageno %>&nbsp;ҳ    <a href="#" title="" onclick="first();">��ҳ</a> <a href="#" title="" onclick="pre();">��һҳ</a> <a href="#" title="" onclick="next();">��һҳ</a> <a href="#" title="" onclick="last();">βҳ</a> ÿҳ
		    <input type="text" class="page_input" name="pagesize" value="100" readonly="readonly"/>
		    �� ����<input type="text" class="page_input" name="gpageno" value="<%=pageno %>" />
		    ҳ <input type="button" value="" class="go_button" />
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
 		alert("�����ɹ���");
 	}
 </script>
</html>