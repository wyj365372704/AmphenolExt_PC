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
		sql=sql+" and ���λ����  like '%"+supplier+"%'";
		sqlcout=sqlcout+" and ���λ����  like '%"+supplier+"%'";
		sqlin=sqlin+" and ���λ����  like '%"+supplier+"%'";
	}
	if(fnumber!=null && fnumber.trim().length()>0){
		sql=sql+" and ������  like '%"+fnumber+"%'";
		sqlcout=sqlcout+" and ������  like '%"+fnumber+"%'";
		sqlin=sqlin+" and ������  like '%"+fnumber+"%'";
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
			sql=sql+" and ��������>='"+startDate+"'";
			sqlcout=sqlcout+" and ��������>='"+startDate+"'";
			sqlin=sqlin+" and ��������>='"+startDate+"'";
		}
		if(endDate!=null && endDate.trim().length()>0){
			sql=sql+" and ��������<'"+endDate+"'";
			sqlcout=sqlcout+" and ��������<'"+endDate+"'";
			sqlin=sqlin+" and ��������<'"+endDate+"'";
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
			alert("��ѡ��һ����¼");
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
			alert("��ѡ��һ����¼");
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
	<div class="path">�����ڵ�λ�ã� ��ҳ &gt; ����ERP &gt; �������</div>
	<form action="buyInfkd" method="post" name="buyInfkd">
	<div class="top_button_div">
		<input name="" type="button" class="add_commission"  onclick="add();"/>
		<input name="" type="button" class="delete_commission"  onclick="deleteP();"/>
		<input name="operate" type="hidden" value=""/>
		<input name="ids" type="hidden" value=""/>
	</div>
	
	<div class="search">
		<h2>
			<span class="fl">�����ѯ</span>			
			<span class="fr"><input name="" type="button" class="search_button" onclick="submit1();"/><input name="rs" type="button" class="purge_button" onclick="onclear();"/></span><!--  span��������ʱ����span����ɾ��  -->
		</h2>
		
		<ul>			
			<li><div class="w_s">���ڣ�</div><input name="startDate" type="text" class="time_input" onclick="WdatePicker()" onmouseout="dateIsValid(this,'��ʼ����')" value="<%=(startDate==null?"":startDate) %>"/>-<input name="endDate" type="text" class="time_input" onclick="WdatePicker()" onmouseout="dateIsValid(this,'��������')" value="<%=(endDate==null?"":endDate) %>"/></li>
			<li><div class="w_s">���λ��</div><input name="supplier" type="text" class="input_w" value="<%=(supplier==null?"":supplier) %>"/></li>
			<li><div class="w_s">�����ţ�</div><input name="fnumber" type="text" class="input_w" value="<%=(fnumber==null?"":fnumber) %>"/></li>
		</ul>
	</div>
	
	<div class="data_list">
		<h2>
			<span class="fl">����б�</span>
			<span class="fr"></span><!--  span��������ʱ����span����ɾ��  -->
		</h2>
		
		<div class="list_inner">
			<div class="verflow_s">
			<table width="100%" border="0" cellspacing="1" cellpadding="0" class="list_table_s">
			   <tr>
				<th><input type="checkbox" name="checkboxall" value="all" onclick="selectAll();"/></th>
				<th>������</th>
				<th>���λ����</th>
				<th>����״̬</th>
				<th>������Ŀ</th>
				<th>��������</th>
				<th>���ʽ</th>
				<th>��������</th>
				<th>Ӧ���ϼ�	</th>
				<th>ʵ���ϼ�</th>
				<th>���</th>
				<th>��ע</th>
			
		      </tr>
			  <%
			  	if(null!=rs){
			  		while(rs.next()){
			   %>
			  <tr>
				<th><input type="checkbox" name="checkbox" value="<%=rs.getString("FID") %>" /></th>
				<td><a href="#" onclick="edit('<%=rs.getString("FID") %>');" style="color:blue"><%=rs.getString("������") %></a></td>
				
				<td><%=rs.getString("���λ����") %></td>
				<td><%=rs.getString("����״̬") %></td>
				<td><%=rs.getString("������Ŀ") %></td>
				<td><%=rs.getString("��������") %></td>
				<td><%=rs.getString("���ʽ") %></td>
				<td><%=rs.getString("��������") %></td>
				<td><%=rs.getString("Ӧ���ϼ�") %></td>
				<td><%=rs.getString("ʵ���ϼ�") %></td>
				<td><%=rs.getString("���") %></td>
				<td><%=rs.getString("��ע") %></td>
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