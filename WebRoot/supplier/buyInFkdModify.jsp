<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page import="com.xy.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>����ERPϵͳ</title>

<link href="../css/customsDeclaration.css" rel="stylesheet" type="text/css" />
<script src="../js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<%
	String id=request.getParameter("id");
	String billid=request.getParameter("billid");
	String FBillIDs=request.getParameter("ids");
	if(null!=FBillIDs && FBillIDs.length()>0){
		FBillIDs=FBillIDs.substring(0,FBillIDs.length()-1);
	}
	String operate = (String)request.getParameter("operate");
	String sql = "select * from v_fkdedit where FID='"+id+"'";
	String sqlEntry = "select * from v_purinwarehsbill where fbillid  in ("+FBillIDs+")";
	//System.out.println(sql);
	DBUtil dbUtil = DBUtil.getInstance();
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs=null;
	int r=-1;
	try{
		conn = dbUtil.getConnection();
		stmt = conn.createStatement();
		
		//System.out.println(sql);
		rs=stmt.executeQuery(sql);
	}catch(Exception e){
	 e.printStackTrace();
	}
 %>
</head>
<script type="text/javascript">
var billid="<%=billid%>";
function save(o){
 		
 		document.getElementsByName("operate")[0].value="update";
 		document.getElementsByName("modifyFkd")[0].submit();
 	}
 	function goList(){
 		if(billid!=null && billid!="null" && billid!=""){
 			document.getElementsByName("buyInFkdModify")[0].action="buyInFkd.jsp";
 		}else{
 			document.getElementsByName("buyInFkdModify")[0].action="buyInFkd.jsp";
 		}
 		
 		
		document.getElementsByName("buyInFkdModify")[0].submit();
 	}
 	function selectBuyIn(){
 		window.location.href="buyInFp.jsp?isSelect=1";
 	}
</script>
<body class="right_body">


			<div class="public_div">
				<h2>
					<span class="fl">�����Ϣ</span>
					<span class="fr"></span><!--  span��������ʱ����span����ɾ��  -->
				</h2>
				<form action="buyInFkdModify.jsp" method="post" name="buyInFkdModify">
				<div class="public_inner">
				
				<div class="top_button_div">
					<input type="button" class="save_button2"  onclick="save('update');"/>
					<input type="button" class="return_button"  onclick="goList();"/>
					<input name="operate" type="hidden" value="" />
					<input name="id" type="hidden" value="<%=id %>" />
					<input name="billid" type="hidden" value="<%=billid %>" />
				</div>
				
				<table border="0" cellpadding="0" cellspacing="1" class="public_table">
					  <tr>
					    <th colspan="6">���������Ϣ</th>
			      </tr>
					 <%
					 	if(rs.next()){
					 	System.out.println(rs.getString("����״̬"));
					  %> 
					  <tr>
					    <td class="td_w_s text_r"> �����ţ�</td>
					    <td><input type="text" name="fknumber" class="input_s_1" value="<%=rs.getString("������") %>"/>
                            <span class="red">*</span></td>
                            <td class="td_w_s text_r"> ���λ���ƣ�</td>
                         <td><input type="text" name="fkclient" class="input_s_1" value="<%=rs.getString("���λ����") %>"/>
                            <span class="red">*</span></td>
                        <td class="td_w_s text_r"><span class="text_r">����״̬��</span></td>
					    <td><select name="select3" class="select_s_1" value="<%=rs.getString("����״̬") %>">
                          
                          <%
                          	if(rs.getString("����״̬")!=null && rs.getString("����״̬").equals("1")){
                           %>
                           <option value="-1">---��ѡ��---</option>
                          <option value="1" selected>����</option>
                          <option value="2">����</option>
                          <option value="4">���</option>
                          <%}else if(rs.getString("����״̬")!=null && rs.getString("����״̬").equals("2")){ %>
                          <option value="-1">---��ѡ��---</option>
                          <option value="1" >����</option>
                          <option value="2" selected>����</option>
                          <option value="4">���</option>
                          <%}else if(rs.getString("����״̬")!=null && rs.getString("����״̬").equals("4")){ %>
                          <option value="-1">---��ѡ��---</option>
                           <option value="1" >����</option>
                          <option value="2" >����</option>
                          <option value="4" selected>���</option>
                          <%}else{ %>
                          <option value="-1" selected>---��ѡ��---</option>
                           <option value="1" >����</option>
                          <option value="2" >����</option>
                          <option value="4" >���</option>
                          
                          <%} %>
                          
                        </select>
				        <span class="red">*</span></td>
			      	</tr>
			      	<tr>
					    <td class="td_w_s text_r"> ������Ŀ��</td>
					    <td><input type="text" name="fkxm" class="input_s_1" value="<%=rs.getString("������Ŀ") %>"/>
                            <span class="red">*</span></td>
                            <td class="td_w_s text_r"> &nbsp;</td>
                         <td>&nbsp;</td>
                        <td class="td_w_s text_r">&nbsp;</td>
					    <td>&nbsp;</td>
			      	</tr>
			      	<tr>
					    <td class="td_w_s text_r"> ����������</td>
					    <td><select name="select3" class="select_s_1" value="<%=rs.getString("��������") %>">
                          <option value="-1">---��ѡ��---</option>
                          <option value="1">��ʮ�츶��</option>
                        </select>
                            <span class="red">*</span></td>
                            <td class="td_w_s text_r"> ���ʽ��</td>
                         <td><select name="select3" class="select_s_1" value="<%=rs.getString("���ʽ") %>">
                          <option value="-1">---��ѡ��---</option>
                          <option value="1">�ֽ�</option>
                        </select>
                            <span class="red">*</span></td>
                        <td class="td_w_s text_r"><span class="text_r">&nbsp;</span></td>
					    <td>&nbsp;</td>
			      	</tr>
			      	<tr>
					    <td class="td_w_s text_r"> Ӧ���ϼƣ�</td>
					    <td><input type="text" name="fkyfhj" class="input_s_1" value="<%=rs.getString("Ӧ���ϼ�") %>"/>
                            <span class="red">*</span></td>
                            <td class="td_w_s text_r"> ʵ���ϼƣ�</td>
                         <td><input type="text" name="fkyfhj" class="input_s_1" value="<%=rs.getString("ʵ���ϼ�") %>"/>
                            <span class="red">*</span></td>
                        <td class="td_w_s text_r"> ��</td>
                         <td><input type="text" name="fkye" class="input_s_1" value="<%=rs.getString("���") %>"/>
                            <span class="red">*</span></td>
			      	</tr>
			      	<tr>
					    <td class="td_w_s text_r"> �������ڣ�</td>
					    <td>
					    <input name="fkrq" type="text" class="time_input2" onclick="WdatePicker()" onmouseout="dateIsValid(this,'��ʼ����')" value="<%=(rs.getString("��������")==null?"":rs.getString("��������").substring(0,10)) %>"/>
                            <span class="red">*</span></td>
                            <td class="td_w_s text_r"> ��ע��</td>
                         <td><input type="text" name="fkbz" class="input_s_1" value="<%=rs.getString("��ע") %>"/>
                            <span class="red">*</span></td>
                        <td class="td_w_s text_r"> &nbsp;</td>
                         <td>&nbsp;</td>
			      	</tr>
					<%
					}else{
					 %>
					 <tr>
					    <td class="td_w_s text_r"> �����ţ�</td>
					    <td><input type="text" name="fknumber" class="input_s_1" value=""/>
                            <span class="red">*</span></td>
                            <td class="td_w_s text_r"> ���λ���ƣ�</td>
                         <td><input type="text" name="fkclient" class="input_s_1" value=""/>
                            <span class="red">*</span></td>
                        <td class="td_w_s text_r"><span class="text_r">����״̬��</span></td>
					    <td><select name="select3" class="select_s_1" value="">
                          <option value="-1">---��ѡ��---</option>
                          <option value="1">����</option>
                          <option value="2">����</option>
                          <option value="4">���</option>
                        </select>
				        <span class="red">*</span></td>
			      	</tr>
			      	<tr>
					    <td class="td_w_s text_r"> ������Ŀ��</td>
					    <td><input type="text" name="fkxm" class="input_s_1" value=" "/>
                            <span class="red">*</span></td>
                            <td class="td_w_s text_r"> &nbsp;</td>
                         <td>&nbsp;</td>
                        <td class="td_w_s text_r">&nbsp;</td>
					    <td>&nbsp;</td>
			      	</tr>
			      	<tr>
					    <td class="td_w_s text_r"> ����������</td>
					    <td><select name="select3" class="select_s_1" value="">
                          <option value="-1">---��ѡ��---</option>
                          <option value="1">��ʮ�츶��</option>
                        </select>
                            <span class="red">*</span></td>
                            <td class="td_w_s text_r"> ���ʽ��</td>
                         <td><select name="select3" class="select_s_1" value="">
                          <option value="-1">---��ѡ��---</option>
                          <option value="1">�ֽ�</option>
                        </select>
                            <span class="red">*</span></td>
                        <td class="td_w_s text_r"><span class="text_r">&nbsp;</span></td>
					    <td>&nbsp;</td>
			      	</tr>
			      	<tr>
					    <td class="td_w_s text_r"> Ӧ���ϼƣ�</td>
					    <td><input type="text" name="fkyfhj" class="input_s_1" value=" "/>
                            <span class="red">*</span></td>
                            <td class="td_w_s text_r"> ʵ���ϼƣ�</td>
                         <td><input type="text" name="fkyfhj" class="input_s_1" value=" "/>
                            <span class="red">*</span></td>
                        <td class="td_w_s text_r"> ��</td>
                         <td><input type="text" name="fkye" class="input_s_1" value=" "/>
                            <span class="red">*</span></td>
			      	</tr>
			      	<tr>
					    <td class="td_w_s text_r"> �������ڣ�</td>
					    <td><input name="fkrq" type="text" class="time_input2" onclick="WdatePicker()" onmouseout="dateIsValid(this,'��ʼ����')" value=""/>
                            </td>
                            <td class="td_w_s text_r"> ��ע��</td>
                         <td><input type="text" name="fkbz" class="input_s_1" value=" "/>
                            </td>
                        <td class="td_w_s text_r"> &nbsp;</td>
                         <td>&nbsp;</td>
			      	</tr>
					 <%} %>
                        </table></td>
			      </tr>
				  </table>
			  </div>
			  </form>
			</div>


			  <div class="data_list">
				<h2>
					<span class="fl">��Ʊ</span>
					<span class="fr"><input type="button" class="button_m" value="ѡ��Ʊ" onclick="selectBuyIn();"/></span><!--  span��������ʱ����span����ɾ��  -->
				</h2>				
				<div class="list_inner">
					<table width="100%" border="0" cellspacing="1" cellpadding="0" class="list_table_s">
					  <tr>
					    <th>���ݱ���</th>
					    <th>ҵ������</th>
					    <th>��Ӧ��</th>
					    <th>����</th>
					    <th>����˰���</th>
					    <th>˰��</th>
					    <th>��˰���</th>
					    <th>���ط�</th>
					    <th>��˰</th>
					    <th>�ִ�������</th>
					    <th>�̼�</th>
				      </tr>
				      <%
				      	try{
				      		if(null!=rs){
				      			rs.close();	
				      		}
				      							
							if(null!=FBillIDs && FBillIDs.trim().length()>0){
								rs=stmt.executeQuery(sqlEntry);
							}
							if(null!=rs){					
						while(rs.next()){
				       %>
					  <tr>
					    <td><%=rs.getString("���ݱ���") %></td>
					    <td><%=ObjectConvertUtils.getDateFormat(rs.getDate("ҵ������")) %></td>
					    <td><%=rs.getString("��Ӧ��") %></td>
					    <td><%=rs.getString("����") %></td>
					    <td><%=rs.getString("����˰���") %></td>
					    <td><%=rs.getString("˰��") %></td>
					    <td><%=rs.getString("��˰���") %></td>					    
					    <td><%=rs.getString("���ط�") %></td>
					    <td><%=rs.getString("��˰") %></td>
					    <td><%=rs.getString("�ִ�������") %></td>
					    <td><%=rs.getString("�̼�") %></td>
				      </tr>
					  <%}}
					  }catch(Exception e){
						 e.printStackTrace();
						}
					  	if(null!=rs){
					  		rs.close();
					  	}
					   %>
				  </table>
				</div>
			</div>  		


			  
</body>
</html>