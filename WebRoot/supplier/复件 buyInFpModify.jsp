<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="com.xy.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%
	String id=request.getParameter("id");
	//��ѡ��ⵥid
	String ids="";
	if(request.getParameter("ids")!=null){
		if(request.getParameter("ids").length()>3){
			ids=request.getParameter("ids").substring(1,request.getParameter("ids").length()-2);
		}
	}
	//��Ӧ��ID����Ҫ���ݹ�Ӧ��ID���ҳ���Ӧ�̵���Ϣ������������ϵ�˵���Ϣ��������ͼ����������
	String supplierid=request.getParameter("supplierid");
	String operate = (String)request.getParameter("operate");
	String FFkdID = (String)request.getParameter("FFkdID");
	String FFpID = (String)request.getParameter("FFpID");
	String[] FSourceBillEntryIds=(String[])request.getParameterValues("FSourceBillEntryId");
	String[] checkbox=(String[])request.getParameterValues("checkbox");
	String[] FMaterialID=(String[])request.getParameterValues("FMaterialID");
	String[] FQuantity=(String[])request.getParameterValues("FQuantity");

	String[] FTaxRate=(String[])request.getParameterValues("FTaxRate");
	String[] FUnitPrice=(String[])request.getParameterValues("FUnitPrice");
	String[] FAmount=(String[])request.getParameterValues("FAmount");
	String[] FTaxAmount=(String[])request.getParameterValues("FTaxAmount");
	String[] FActualAmount=(String[])request.getParameterValues("FActualAmount");
	
	String checkboxs="";
	if(checkbox!=null){
		for(int i=0;i<checkbox.length;i++){
			checkboxs=checkboxs+checkbox[i]+",";
		}
	}	
	
	String sql = "select * from t_bd_supplier where FID='"+supplierid+"'";
	String sqlEntry = "select * from v_purinwarehsentryedit where fparentid in('"+ids+"')";
	
	System.out.println(sqlEntry);
	DBUtil dbUtil = DBUtil.getInstance();
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs=null;
	int r=-1;
	try{
		conn = dbUtil.getConnection();
		stmt = conn.createStatement();
		if(null!=operate && operate.equals("update")){
			//��Ʊ����
			String insertsql="INSERT INTO [T_AP_ApInvoice]([FID], [FCreatorID], [FCreateTime], [FLastUpdateUserID], [FLastUpdateTime], [FControlUnitID], [FNumber], [FBizDate], [FHandlerID], [FDescription], [FHasEffected], [FAuditorID], [FSourceBillID], [FSourceFunction], [FCompanyID], [FBillDate], [FCurrencyId], [FTotalAmount], [FBillStatus], [FType], [FAccountBankId], [FCussAddress], [FCussPhone], [FCussBank], [FCussAcctBank], [FAsstActTypeID], [FAsstActID], [FAsstActNumber], [FAsstActName_L1], [FAsstActName_L2], [FAsstActName_L3], [FTxRegisterNo], [FAuditPersonId], [FInvPersonId], [FDrawer])"+
						"VALUES()";
						//stmt.executeUpdate(insertsql);
			//TODO:���UUID�����뷢Ʊ����Ʊ��¼��
			if(FSourceBillEntryIds!=null){
				//ѭ����ѡ��ķ�¼���жԷ�Ʊ��¼��������ݵĲ���
				for(int j=0;j<FSourceBillEntryIds.length;j++){
					if(checkboxs.indexOf(FSourceBillEntryIds[j])>=0){
						//FMaterialID  FMeasureUnitID  FQuantity FTaxRate FUnitPrice FAmount FTaxAmount FActualAmount
						System.out.println(FSourceBillEntryIds[j]+":"+FMaterialID[j]+":"+FQuantity[j] +":"+FTaxRate[j]+":"+FUnitPrice[j]+":"+FAmount[j]+":"+FTaxAmount[j]+":"+FActualAmount[j]);
						//�ȸ�������IDɾ����ϸ��Ȼ���������Ʊ��¼
						String deletesql="delete from T_AP_ApInvoiceEntry where FParentId='����ID'";
						//��Ʊ��¼��
						String insertsqlentry="INSERT INTO [T_AP_ApInvoiceEntry]([FID], [FSeq], [FMaterialID], [FMeasureUnitID], [FQuantity], [FAmount], [FUnitPrice], [FTaxRate], [FTaxAmount], [FActualAmount], [FParentId], [FSourceBillEntryId])"
											+"VALUES()";
						//stmt.executeUpdate(insertsql);
					}
				}
			}
			//r=stmt.executeUpdate(insertsql);
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
 		var checkboxs=document.getElementsByName("checkbox");
 		var isselected = false;
 		for(var i=0;i<checkboxs.length;i++){
			if(checkboxs[i].checked){
				isselected=true;
				break;
			}
		}
		if(!isselected){
			alert("��ѡ���¼���ɷ�Ʊ��");
			return false;
		}
 		document.getElementsByName("operate")[0].value="update";
 		document.getElementsByName("modifyBuyIn")[0].submit();
 	}
 	function goList(){
 		document.getElementsByName("modifyBuyIn")[0].action="buyIn.jsp";
		document.getElementsByName("modifyBuyIn")[0].submit();
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
	function selectBuyIn(){
 		window.location.href="buyIn.jsp?isSelect=1&flag=fp";
 	}
 </script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>����ERPϵͳ</title>

<link href="../css/customsDeclaration.css" rel="stylesheet" type="text/css" />
<script src="../js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
</head>

<body class="right_body">



	
		<form action="buyInFpModify.jsp" method="post" name="modifyBuyIn">
			<div class="public_div">
				<h2><br> 
					<span class="fl"></span></h2><h2><span class="fl">�ɹ���Ʊ��Ϣ</span> 
					<span class="fr"></span><!--  span��������ʱ����span����ɾ��  --> 
				</h2>
				<div class="public_inner">
				
				<div class="top_button_div">
					<input type="button" class="save_button2"  onclick="save('update');"/>
					
					<input type="button" class="return_button"  onclick="goList();"/>
					<input name="operate" type="hidden" value="" />
					<input name="id" type="hidden" value="<%=id %>" />
					<input name="ids" type="hidden" value="<%=request.getParameter("ids") %>" />					
					<input name="supplierid" type="hidden" value="<%=supplierid %>" />
					<!--<input name="" type="button" class="move_button" />
					<input name="" type="button" class="customsDeclaration" />
					<input name="" type="button" class="print_button"  />-->
				</div>
				
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="public_table">
					  <tr>
					    <th colspan="6">�ɹ���Ʊ������Ϣ</th>
			      </tr>
			      			  <%
			      			  String FName_L2="";
			      			  String FID="";
			      			  String FNumber="";
			  	if(null!=rs){
			  		if(rs.next()){
			  			FName_L2=rs.getString("FName_L2");
			  			FID=rs.getString("FID");
			  			FNumber=rs.getString("FNumber");
			  		}
                    if(rs!=null){
                      rs.close();
                    }
                  }
			   %>
			      	
					  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">���ݱ��룺</span></td>
					    <td width="23%"><input type="text" name="FNumber" class="input_s_1" />
                            </td>
					    <td width="10%" class="td_w_s text_r"> ��Ʊ���ͣ�</td>
					    <td width="23%"><input type="text" name="FType" class="input_s_1"  />
                            </td>
                            <td width="10%" class="td_w_s text_r"> ҵ�����ڣ�</td>
					    <td width="23%">
					    <input name="FBizDate" type="text" class="time_input" onclick="WdatePicker()" onmouseout="dateIsValid(this,'ҵ������')" />
                            </td>
				  </tr>
					  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">��˾�ո����˺ţ�</span></td>
					    <td width="23%"><input type="text" name="FAccountBank" class="input_s_1" />
                            </td>
					    <td width="10%" class="td_w_s text_r"> ��Ӧ�̣�</td>
					    <td width="23%"><input type="text" name="FAsstAct" class="input_s_1"  value="<%=FName_L2 %>" />
					    <input type="hidden" name="FAsstActID" class="input_s_1"  value="<%=FID %>" />
                            </td>
                            <td width="10%" class="td_w_s text_r"> ��Ӧ�̱��룺</td>
					    <td width="23%"><input type="text" name="FAsstActNumber" class="input_s_1"  value="<%=FNumber %>" />
                            </td>
				  </tr>
			       <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">�ұ�</span></td>
					    <td width="23%"><input type="text" name="FCurrency" class="input_s_1" />
                            </td>
					    <td width="10%" class="td_w_s text_r"> ��Ӧ�������˺ţ�</td>
					    <td width="23%"><input type="text" name=FCussAcctBank class="input_s_1"   />
                            </td>
                            <td width="10%" class="td_w_s text_r"> ��Ӧ�̵�ַ��</td>
					    <td width="23%"><input type="text" name="FCussAddress" class="input_s_1"   />
                            </td>
				  </tr>
				  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">��Ӧ�����У�</span></td>
					    <td width="23%"><input type="text" name="FCussBank" class="input_s_1" />
                            </td>
					    <td width="10%" class="td_w_s text_r">��Ӧ�̵绰��</td>
					    <td width="23%"><input type="text" name="FCussPhone" class="input_s_1" />
                            </td>
                            <td width="10%" class="td_w_s text_r"> ��Ʊ�ˣ�</td>
					    <td width="23%"><input type="text" name="FDrawer" class="input_s_1" />
                            </td>
				  </tr>
				
				  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">��ע��</span></td>
					    <td width="23%" colspan="5"><input type="text" name="FDescription" class="input_s_1"  />
                         
				  </tr>
				  </table>
			  </div>
			</div>
			 
			  <div class="data_list">
				<h2>
					<span class="fl">��Ʒ��Ϣ</span>
					<span class="fr"><input type="button" class="button_m" value="ѡ����ⵥ" onclick="selectBuyIn();"/></span>
					<span class="fr">		</span><!--  span��������ʱ����span����ɾ��  -->
				</h2>
				
				<div class="list_inner">
					<table width="100%" border="0" cellspacing="1" cellpadding="0" class="list_table_s">
					  <tr>
					  	<th><input type="checkbox" name="checkboxall" value="all" onclick="selectAll();"/></th>
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
					  	<td>
					  	<%
					  		if(checkboxs.indexOf(rs.getString("FID"))>=0){
					  	 %>
					  	<input type="checkbox" name="checkbox" value="<%=rs.getString("FID") %>" checked/>
					  	<%}else{ %>
					  	<input type="checkbox" name="checkbox" value="<%=rs.getString("FID") %>" />
					  	<%} %>
					  	<input type="hidden" name="FSourceBillEntryId" value="<%=rs.getString("FID") %>" />
					  	<input type="hidden" name="FMaterialID" value="<%=rs.getString("fmaterialid") %>" />
					  	<input type="hidden" name="FMeasureUnitID" value="<%=rs.getString("funitid") %>" />
					  	</td>
					    <td><%=rs.getString("���ϱ���") %></td>
					    <td><%=rs.getString("��������") %></td>
					    <td><%=rs.getString("����ͺ�") %></td>
					    <td><%=rs.getString("������λ") %></td>					    
					    <td><input type="text" name="FQuantity" class="input_s_1" value="<%=rs.getString("����") %>"/>  </td>
					    <td><input type="text" name="FTaxRate" class="input_s_1" value="<%=rs.getString("˰��") %>"/></td>
					    <td><%=rs.getString("�ɱ�����") %></td>
					    <td><input type="text" name="FUnitPrice" class="input_s_1" value="<%=rs.getString("��˰����") %>"/></td>
					    <td><input type="text" name="FAmount" class="input_s_1" value="<%=rs.getString("�ɱ�") %>"/></td>
					    <td><input type="text" name="FTaxAmount" class="input_s_1" value="<%=rs.getString("˰��") %>"/></td>
					    <td><input type="text" name="FActualAmount" class="input_s_1" value="<%=rs.getString("��˰�ϼ�") %>"/></td>
				      </tr>
					  <%}
					  	if(null!=rs){
					  		rs.close();
					  	}
					   %>

				  </table>
				</div>
			</div>  
			 </form>
</body>
<script type="text/javascript">
	var r="<%=r %>";
	if(r!="-1"){
		alert("����ɹ���");
	}
</script>
</html>
