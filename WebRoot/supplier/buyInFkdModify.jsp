<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page import="com.xy.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新亚ERP系统</title>

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
					<span class="fl">付款单信息</span>
					<span class="fr"></span><!--  span里无内容时，此span不能删除  -->
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
					    <th colspan="6">付款单基本信息</th>
			      </tr>
					 <%
					 	if(rs.next()){
					 	System.out.println(rs.getString("单据状态"));
					  %> 
					  <tr>
					    <td class="td_w_s text_r"> 付款单编号：</td>
					    <td><input type="text" name="fknumber" class="input_s_1" value="<%=rs.getString("付款单编号") %>"/>
                            <span class="red">*</span></td>
                            <td class="td_w_s text_r"> 付款单位名称：</td>
                         <td><input type="text" name="fkclient" class="input_s_1" value="<%=rs.getString("付款单位名称") %>"/>
                            <span class="red">*</span></td>
                        <td class="td_w_s text_r"><span class="text_r">单据状态：</span></td>
					    <td><select name="select3" class="select_s_1" value="<%=rs.getString("单据状态") %>">
                          
                          <%
                          	if(rs.getString("单据状态")!=null && rs.getString("单据状态").equals("1")){
                           %>
                           <option value="-1">---请选择---</option>
                          <option value="1" selected>新增</option>
                          <option value="2">保存</option>
                          <option value="4">审核</option>
                          <%}else if(rs.getString("单据状态")!=null && rs.getString("单据状态").equals("2")){ %>
                          <option value="-1">---请选择---</option>
                          <option value="1" >新增</option>
                          <option value="2" selected>保存</option>
                          <option value="4">审核</option>
                          <%}else if(rs.getString("单据状态")!=null && rs.getString("单据状态").equals("4")){ %>
                          <option value="-1">---请选择---</option>
                           <option value="1" >新增</option>
                          <option value="2" >保存</option>
                          <option value="4" selected>审核</option>
                          <%}else{ %>
                          <option value="-1" selected>---请选择---</option>
                           <option value="1" >新增</option>
                          <option value="2" >保存</option>
                          <option value="4" >审核</option>
                          
                          <%} %>
                          
                        </select>
				        <span class="red">*</span></td>
			      	</tr>
			      	<tr>
					    <td class="td_w_s text_r"> 付款项目：</td>
					    <td><input type="text" name="fkxm" class="input_s_1" value="<%=rs.getString("付款项目") %>"/>
                            <span class="red">*</span></td>
                            <td class="td_w_s text_r"> &nbsp;</td>
                         <td>&nbsp;</td>
                        <td class="td_w_s text_r">&nbsp;</td>
					    <td>&nbsp;</td>
			      	</tr>
			      	<tr>
					    <td class="td_w_s text_r"> 付款条件：</td>
					    <td><select name="select3" class="select_s_1" value="<%=rs.getString("付款条件") %>">
                          <option value="-1">---请选择---</option>
                          <option value="1">三十天付款</option>
                        </select>
                            <span class="red">*</span></td>
                            <td class="td_w_s text_r"> 付款方式：</td>
                         <td><select name="select3" class="select_s_1" value="<%=rs.getString("付款方式") %>">
                          <option value="-1">---请选择---</option>
                          <option value="1">现结</option>
                        </select>
                            <span class="red">*</span></td>
                        <td class="td_w_s text_r"><span class="text_r">&nbsp;</span></td>
					    <td>&nbsp;</td>
			      	</tr>
			      	<tr>
					    <td class="td_w_s text_r"> 应付合计：</td>
					    <td><input type="text" name="fkyfhj" class="input_s_1" value="<%=rs.getString("应付合计") %>"/>
                            <span class="red">*</span></td>
                            <td class="td_w_s text_r"> 实付合计：</td>
                         <td><input type="text" name="fkyfhj" class="input_s_1" value="<%=rs.getString("实付合计") %>"/>
                            <span class="red">*</span></td>
                        <td class="td_w_s text_r"> 余额：</td>
                         <td><input type="text" name="fkye" class="input_s_1" value="<%=rs.getString("余额") %>"/>
                            <span class="red">*</span></td>
			      	</tr>
			      	<tr>
					    <td class="td_w_s text_r"> 付款日期：</td>
					    <td>
					    <input name="fkrq" type="text" class="time_input2" onclick="WdatePicker()" onmouseout="dateIsValid(this,'开始日期')" value="<%=(rs.getString("付款日期")==null?"":rs.getString("付款日期").substring(0,10)) %>"/>
                            <span class="red">*</span></td>
                            <td class="td_w_s text_r"> 备注：</td>
                         <td><input type="text" name="fkbz" class="input_s_1" value="<%=rs.getString("备注") %>"/>
                            <span class="red">*</span></td>
                        <td class="td_w_s text_r"> &nbsp;</td>
                         <td>&nbsp;</td>
			      	</tr>
					<%
					}else{
					 %>
					 <tr>
					    <td class="td_w_s text_r"> 付款单编号：</td>
					    <td><input type="text" name="fknumber" class="input_s_1" value=""/>
                            <span class="red">*</span></td>
                            <td class="td_w_s text_r"> 付款单位名称：</td>
                         <td><input type="text" name="fkclient" class="input_s_1" value=""/>
                            <span class="red">*</span></td>
                        <td class="td_w_s text_r"><span class="text_r">单据状态：</span></td>
					    <td><select name="select3" class="select_s_1" value="">
                          <option value="-1">---请选择---</option>
                          <option value="1">新增</option>
                          <option value="2">保存</option>
                          <option value="4">审核</option>
                        </select>
				        <span class="red">*</span></td>
			      	</tr>
			      	<tr>
					    <td class="td_w_s text_r"> 付款项目：</td>
					    <td><input type="text" name="fkxm" class="input_s_1" value=" "/>
                            <span class="red">*</span></td>
                            <td class="td_w_s text_r"> &nbsp;</td>
                         <td>&nbsp;</td>
                        <td class="td_w_s text_r">&nbsp;</td>
					    <td>&nbsp;</td>
			      	</tr>
			      	<tr>
					    <td class="td_w_s text_r"> 付款条件：</td>
					    <td><select name="select3" class="select_s_1" value="">
                          <option value="-1">---请选择---</option>
                          <option value="1">三十天付款</option>
                        </select>
                            <span class="red">*</span></td>
                            <td class="td_w_s text_r"> 付款方式：</td>
                         <td><select name="select3" class="select_s_1" value="">
                          <option value="-1">---请选择---</option>
                          <option value="1">现结</option>
                        </select>
                            <span class="red">*</span></td>
                        <td class="td_w_s text_r"><span class="text_r">&nbsp;</span></td>
					    <td>&nbsp;</td>
			      	</tr>
			      	<tr>
					    <td class="td_w_s text_r"> 应付合计：</td>
					    <td><input type="text" name="fkyfhj" class="input_s_1" value=" "/>
                            <span class="red">*</span></td>
                            <td class="td_w_s text_r"> 实付合计：</td>
                         <td><input type="text" name="fkyfhj" class="input_s_1" value=" "/>
                            <span class="red">*</span></td>
                        <td class="td_w_s text_r"> 余额：</td>
                         <td><input type="text" name="fkye" class="input_s_1" value=" "/>
                            <span class="red">*</span></td>
			      	</tr>
			      	<tr>
					    <td class="td_w_s text_r"> 付款日期：</td>
					    <td><input name="fkrq" type="text" class="time_input2" onclick="WdatePicker()" onmouseout="dateIsValid(this,'开始日期')" value=""/>
                            </td>
                            <td class="td_w_s text_r"> 备注：</td>
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
					<span class="fl">发票</span>
					<span class="fr"><input type="button" class="button_m" value="选择发票" onclick="selectBuyIn();"/></span><!--  span里无内容时，此span不能删除  -->
				</h2>				
				<div class="list_inner">
					<table width="100%" border="0" cellspacing="1" cellpadding="0" class="list_table_s">
					  <tr>
					    <th>单据编码</th>
					    <th>业务日期</th>
					    <th>供应商</th>
					    <th>数量</th>
					    <th>不含税金额</th>
					    <th>税额</th>
					    <th>含税金额</th>
					    <th>报关费</th>
					    <th>关税</th>
					    <th>仓储物流费</th>
					    <th>商检</th>
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
					    <td><%=rs.getString("单据编码") %></td>
					    <td><%=ObjectConvertUtils.getDateFormat(rs.getDate("业务日期")) %></td>
					    <td><%=rs.getString("供应商") %></td>
					    <td><%=rs.getString("数量") %></td>
					    <td><%=rs.getString("不含税金额") %></td>
					    <td><%=rs.getString("税额") %></td>
					    <td><%=rs.getString("含税金额") %></td>					    
					    <td><%=rs.getString("报关费") %></td>
					    <td><%=rs.getString("关税") %></td>
					    <td><%=rs.getString("仓储物流费") %></td>
					    <td><%=rs.getString("商检") %></td>
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