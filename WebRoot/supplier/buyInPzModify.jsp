<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page import="com.xy.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%
	String id=request.getParameter("id");
	//id="68749";
	String operate = (String)request.getParameter("operate");
	String FVoucherID = id;
	
	//System.out.println(operate+";"+FFkdID+";"+FFpID);
	String sql = "select *  FROM   OPENDATASOURCE ('SQLOLEDB', 'Data Source=202.105.135.227;    USER ID = sa ;Password=sunyes20091230 '"+
                    " ).AIS20090117160413.dbo.t_voucher where FVoucherID="+id+"";
                    
	String sqlEntry = "select * from v_purinwarehsentryedit where fparentid in (select fid from t_im_purinwarehsbill where FPzID ="+id+")";
	//System.out.println(sql);
	DBUtil dbUtil = DBUtil.getInstance();
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs=null;
	int r=-1;
	try{
		conn = dbUtil.getConnection();
		stmt = conn.createStatement();
//		if(null!=operate && operate.equals("update")){
//			r=stmt.executeUpdate("update t_im_purinwarehsbill set Fbgf='"+bgs+"',Fgs='"+gs+"',Fccwlf='"+wls+"',Fsj='"+sjs+"' where fid='"+id+"'");
//		}
		//System.out.println(sql);
		rs=stmt.executeQuery(sql);
	}catch(Exception e){
	 e.printStackTrace();
	}
	
 %>
 <script type="text/javascript">
 	function save(o){
 		
 		document.getElementsByName("operate")[0].value="update";
 		document.getElementsByName("buyInPzModify")[0].submit();
 	}
 	function goList(){
 		document.getElementsByName("buyInPzModify")[0].action="buyInPz.jsp";
		document.getElementsByName("buyInPzModify")[0].submit();
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
					<span class="fl"></span></h2><h2><span class="fl">�������ƾ֤��Ϣ</span> 
					<span class="fr"></span><!--  span��������ʱ����span����ɾ��  --> 
				</h2>
				<div class="public_inner">
				<form action="buyInPzModify.jsp" method="post" name="buyInPzModify">
				<div class="top_button_div">
					<input type="button" class="return_button"  onclick="goList();"/>
					<input name="operate" type="hidden" value="" />
					<input name="id" type="hidden" value="<%=id %>" />
					<!--<input name="" type="button" class="move_button" />
					<input name="" type="button" class="customsDeclaration" />
					<input name="" type="button" class="print_button"  />-->
				</div>
				
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="public_table">
					  <tr>
					    <th colspan="6">�������ƾ֤��Ϣ������Ϣ</th>
			      </tr>
			      			  <%
			  	if(null!=rs){
			  		if(rs.next()){
			   %>
					  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">ƾ֤�ţ�</span></td>
					    <td width="23%"><input type="text" name="textfield3" class="input_s_1" value="<%=rs.getString("fnumber") %>"  disabled/>
                        </td>
                        <td width="10%" class="td_w_s text_r"> ƾ֤���ڣ�</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("fdate") %>" disabled/>
                            </td>
				  </tr>
					  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">�跽��</span></td>
					    <td width="23%"><input type="text" name="textfield3" class="input_s_1" value="<%=rs.getString("FDebitTotal") %>"  disabled/>
                            </td>
					    <td width="10%" class="td_w_s text_r"> �����ܶ</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("FCreditTotal") %>" disabled/>
                            </td>
				  </tr>
			       <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">ժҪ��</span></td>
					    <td width="23%"><input type="text" name="textfield3" class="input_s_1" value="<%=rs.getString("fexplanation") %>"  disabled/>
                            </td>
					    <td width="10%" class="td_w_s text_r"> ������</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("FReference") %>" disabled/>
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
					    <th>��Ӧ������</th>
					    <th>���ݱ��</th>
					    <th>ҵ������</th>
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
						while(rs.next()){
				       %>
					  <tr>
					    <td><%=rs.getString("��Ӧ��") %></td>
					    <td><%=rs.getString("���ݱ��") %></td>
					    <td><%=ObjectConvertUtils.getDateFormat(rs.getDate("ҵ������")) %></td>
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
<script type="text/javascript">
	var r="<%=r %>";
	if(r!="-1"){
		alert("����ɹ���");
	}
</script>
</html>
