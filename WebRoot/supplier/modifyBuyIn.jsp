<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="com.xy.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%
	String id=request.getParameter("id");
	String operate = (String)request.getParameter("operate");
	String FFkdID = (String)request.getParameter("FFkdID");
	String FFpID = (String)request.getParameter("FFpID");
	//�̼�
	String sjs = (String)request.getParameter("sjs");
	//���ط�
	String bgs = (String)request.getParameter("bgs");
	//�ִ�������
	String wls = (String)request.getParameter("wls");
	//��˰
	String gs = (String)request.getParameter("gs");
	
	//System.out.println(operate+";"+FFkdID+";"+FFpID);
	String sql = "select * from v_purinwarehsbilledit where FBillID='"+id+"'";
	String sqlEntry = "select * from v_purinwarehsentryedit where fparentid='"+id+"'";
	//System.out.println(sql);
	DBUtil dbUtil = DBUtil.getInstance();
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs=null;
	int r=-1;
	try{
		conn = dbUtil.getConnection();
		stmt = conn.createStatement();
		if(null!=operate && operate.equals("update")){
			r=stmt.executeUpdate("update t_im_purinwarehsbill set Fbgf='"+bgs+"',Fgs='"+gs+"',Fccwlf='"+wls+"',Fsj='"+sjs+"' where fid='"+id+"'");
		}
		//System.out.println(sql);
		rs=stmt.executeQuery(sql);
		System.out.println("ttt:"+sql);
	}catch(Exception e){
	 e.printStackTrace();
	}
	
 %>
 <script type="text/javascript">
 	function save(o){
 		
 		document.getElementsByName("operate")[0].value="update";
 		document.getElementsByName("modifyBuyIn")[0].submit();
 	}
 	function goList(){
 		document.getElementsByName("modifyBuyIn")[0].action="buyIn.jsp";
		document.getElementsByName("modifyBuyIn")[0].submit();
 	}
 </script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>����ERPϵͳ</title>

<link href="../css/customsDeclaration.css" rel="stylesheet" type="text/css" />
</head>

<body class="right_body">



	
		
			<div class="public_div">
				<h2><br> 
					<span class="fl"></span></h2><h2><span class="fl">�ɹ���ⵥ��Ϣ</span> 
					<span class="fr"></span><!--  span��������ʱ����span����ɾ��  --> 
				</h2>
				<div class="public_inner">
				<form action="modifyBuyIn.jsp" method="post" name="modifyBuyIn">
				<div class="top_button_div">
					<input type="button" class="save_button2"  onclick="save('update');"/>
					<input type="button" class="metastasis"  onclick=""/>
					<input type="button" class="customsDeclaration"  onclick=""/>
					<input type="button" class="declaresAuxiliary"  onclick=""/>
					<input type="button" class="return_button"  onclick="goList();"/>
					<input name="operate" type="hidden" value="" />
					<input name="id" type="hidden" value="<%=id %>" />
					<!--<input name="" type="button" class="move_button" />
					<input name="" type="button" class="customsDeclaration" />
					<input name="" type="button" class="print_button"  />-->
				</div>
				
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="public_table">
					  <tr>
					    <th colspan="6">�ɹ���ⵥ������Ϣ</th>
			      </tr>
			      			  <%
			  	if(null!=rs){
			  		if(rs.next()){
			   %>
			      	<input name="FFkdID" type="hidden" value="<%=rs.getString("FFkdID") %>" />
			      	<input name="FFpID" type="hidden" value="<%=rs.getString("FFpID") %>" />
			      	<input name="FPzID" type="hidden" value="<%=rs.getString("FPzID") %>" />
					  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">���ݱ��룺</span></td>
					    <td width="23%"><input type="text" name="textfield3" class="input_s_1" value="<%=rs.getString("���ݱ���") %>"  disabled/>
                            </td>
					    <td width="10%" class="td_w_s text_r"> �������ͣ�</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("��������") %>" disabled/>
                            </td>
                            <td width="10%" class="td_w_s text_r"> ҵ�����ڣ�</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("ҵ������") %>" disabled/>
                            </td>
				  </tr>
					  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">��Ӧ�̣�</span></td>
					    <td width="23%"><input type="text" name="textfield3" class="input_s_1" value="<%=rs.getString("��Ӧ��") %>"  disabled/>
                            </td>
					    <td width="10%" class="td_w_s text_r"> �����֯��</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("�����֯") %>" disabled/>
                            </td>
                            <td width="10%" class="td_w_s text_r"> ����״̬��</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("����״̬") %>" disabled/>
                            </td>
				  </tr>
			       <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">�ұ�</span></td>
					    <td width="23%"><input type="text" name="textfield3" class="input_s_1" value="<%=rs.getString("�ұ�") %>"  disabled/>
                            </td>
					    <td width="10%" class="td_w_s text_r"> ���ʣ�</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("����") %>" disabled/>
                            </td>
                            <td width="10%" class="td_w_s text_r"> ժҪ��</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("ժҪ") %>" disabled/>
                            </td>
				  </tr>
				  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">����״̬��</span></td>
					    <td width="23%"><input type="text" name="textfield3" class="input_s_1" value="<%=rs.getString("����״̬") %>"  disabled/>
                            </td>
					    <td width="10%" class="td_w_s text_r"> ������룺</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("�������") %>" disabled/>
                            </td>
                            <td width="10%" class="td_w_s text_r"> �����</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("�Ѹ����") %>" disabled/>
                            </td>
				  </tr>
					  
					 <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">��Ʊ״̬��</span></td>
					    <td width="23%"><input type="text" name="textfield3" class="input_s_1" value="<%=rs.getString("��Ʊ״̬") %>"  disabled/>
                            </td>
					    <td width="10%" class="td_w_s text_r"> ��Ʊ��ţ�</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("��Ʊ���") %>" disabled/>
                            </td>
                            <td width="10%" class="td_w_s text_r"> ��Ʊ��</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("�ѿ�Ʊ���") %>" disabled/>
                            </td>
				  </tr>
				  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">ƾ֤״̬��</span></td>
					    <td width="23%"><input type="text" name="textfield3" class="input_s_1" value="<%=rs.getString("ƾ֤״̬") %>"  disabled/>
                            </td>
					    <td width="10%" class="td_w_s text_r"> ƾ֤��ţ�</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("ƾ֤��") %>" disabled/>
                            </td>
                            <td width="10%" class="td_w_s text_r"> ƾ֤��</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("ƾ֤���") %>" disabled/>
                            </td>
				  </tr>
				  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">���طѣ�</span></td>
					    <td width="23%"><input type="text" name="bgs" class="input_s_1" value="<%=rs.getString("���ط�") %>"  />
                            <span class="red">*</span> </td>
					    <td width="10%" class="td_w_s text_r"> �ִ������ѣ�</td>
					    <td width="23%"><input type="text" name="wls" class="input_s_1"  value="<%=rs.getString("�ִ�������") %>" />
                            <span class="red">*</span></td>
                            <td width="10%" class="td_w_s text_r"> ��˰��</td>
					    <td width="23%"><input type="text" name="gs" class="input_s_1"  value="<%=rs.getString("��˰") %>" />
                            <span class="red">*</span></td>
				  </tr>
				  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">�̼죺</span></td>
					    <td width="23%"><input type="text" name="sjs" class="input_s_1" value="<%=rs.getString("�̼�") %>"  />
                            <span class="red">*</span> </td>
					    <td width="10%" class="td_w_s text_r"> �ɱ���</td>
					    <td width="23%"><input type="text" name="cbs" class="input_s_1"  value="<%=rs.getString("�ܳɱ�") %>" disabled/>
                            </td>
                            <td width="10%" class="td_w_s text_r"> ��</td>
					    <td width="23%"><input type="text" name="jes" class="input_s_1"  value="<%=rs.getString("�ܽ��") %>" disabled/>
                            </td>
				  </tr>
                      		     <%}
                      		     if(rs!=null){
                      		     	rs.close();
                      		     }
                      		     } %>
                      
				  </table>
			  </div>
			</div>
			  </form>
			  <div class="data_list">
				<h2>
					<span class="fl">��Ʒ��Ϣ</span>
					<span class="fr">		</span><!--  span��������ʱ����span����ɾ��  -->
				</h2>
				
				<div class="list_inner">
					<table width="100%" border="0" cellspacing="1" cellpadding="0" class="list_table_s">
					  <tr>
					    <th>���ϱ���</th>
					    <th>��������</th>
					    <th>����ͺ�</th>
					    <th>������λ</th>
					    <th>����</th>
					    <th>˰��</th>
					    <th>�ɱ�����</th>
					    <th>��˰����</th>
					    <th>�ɱ�</th>
					    <th>˰��</th>
					    <th>��˰�ϼ�</th>
					    <th>�ֿ�</th>
					    <th>��ע</th>
				      </tr>
				      <%
				      	try{
							
							rs=stmt.executeQuery(sqlEntry);
						}catch(Exception e){
						 e.printStackTrace();
						}
						while(rs.next()){
				       %>
					  <tr>
					    <td><%=rs.getString("���ϱ���") %></td>
					    <td><%=rs.getString("��������") %></td>
					    <td><%=rs.getString("����ͺ�") %></td>
					    <td><%=rs.getString("������λ") %></td>					    
					    <td><%=rs.getString("����") %></td>
					    <td><%=rs.getString("˰��") %></td>
					    <td><%=rs.getString("�ɱ�����") %></td>
					    <td><%=rs.getString("��˰����") %></td>
					    <td><%=rs.getString("�ɱ�") %></td>
					    <td><%=rs.getString("˰��") %></td>
					    <td><%=rs.getString("��˰�ϼ�") %></td>
					    <td><%=rs.getString("�ֿ�") %></td>
					    <td><%=rs.getString("��ע") %></td>
				      </tr>
					  <%}
					  	if(null!=rs){
					  		rs.close();
					  	}
					   %>

				  </table>
				</div>
			</div>  
			
</body>
<script type="text/javascript">
	var r="<%=r %>";
	if(r!="-1"){
		alert("����ɹ���");
	}
</script>
</html>
