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
	//商检
	String sjs = (String)request.getParameter("sjs");
	//报关费
	String bgs = (String)request.getParameter("bgs");
	//仓储物流费
	String wls = (String)request.getParameter("wls");
	//关税
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
<title>新亚ERP系统</title>

<link href="../css/customsDeclaration.css" rel="stylesheet" type="text/css" />
</head>

<body class="right_body">



	
		
			<div class="public_div">
				<h2><br> 
					<span class="fl"></span></h2><h2><span class="fl">采购入库单信息</span> 
					<span class="fr"></span><!--  span里无内容时，此span不能删除  --> 
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
					    <th colspan="6">采购入库单基本信息</th>
			      </tr>
			      			  <%
			  	if(null!=rs){
			  		if(rs.next()){
			   %>
			      	<input name="FFkdID" type="hidden" value="<%=rs.getString("FFkdID") %>" />
			      	<input name="FFpID" type="hidden" value="<%=rs.getString("FFpID") %>" />
			      	<input name="FPzID" type="hidden" value="<%=rs.getString("FPzID") %>" />
					  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">单据编码：</span></td>
					    <td width="23%"><input type="text" name="textfield3" class="input_s_1" value="<%=rs.getString("单据编码") %>"  disabled/>
                            </td>
					    <td width="10%" class="td_w_s text_r"> 事务类型：</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("事物类型") %>" disabled/>
                            </td>
                            <td width="10%" class="td_w_s text_r"> 业务日期：</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("业务日期") %>" disabled/>
                            </td>
				  </tr>
					  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">供应商：</span></td>
					    <td width="23%"><input type="text" name="textfield3" class="input_s_1" value="<%=rs.getString("供应商") %>"  disabled/>
                            </td>
					    <td width="10%" class="td_w_s text_r"> 库存组织：</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("库存组织") %>" disabled/>
                            </td>
                            <td width="10%" class="td_w_s text_r"> 单据状态：</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("单据状态") %>" disabled/>
                            </td>
				  </tr>
			       <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">币别：</span></td>
					    <td width="23%"><input type="text" name="textfield3" class="input_s_1" value="<%=rs.getString("币别") %>"  disabled/>
                            </td>
					    <td width="10%" class="td_w_s text_r"> 汇率：</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("汇率") %>" disabled/>
                            </td>
                            <td width="10%" class="td_w_s text_r"> 摘要：</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("摘要") %>" disabled/>
                            </td>
				  </tr>
				  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">付款状态：</span></td>
					    <td width="23%"><input type="text" name="textfield3" class="input_s_1" value="<%=rs.getString("付款状态") %>"  disabled/>
                            </td>
					    <td width="10%" class="td_w_s text_r"> 付款单编码：</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("付款单编码") %>" disabled/>
                            </td>
                            <td width="10%" class="td_w_s text_r"> 付款金额：</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("已付金额") %>" disabled/>
                            </td>
				  </tr>
					  
					 <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">发票状态：</span></td>
					    <td width="23%"><input type="text" name="textfield3" class="input_s_1" value="<%=rs.getString("开票状态") %>"  disabled/>
                            </td>
					    <td width="10%" class="td_w_s text_r"> 发票编号：</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("发票编号") %>" disabled/>
                            </td>
                            <td width="10%" class="td_w_s text_r"> 开票金额：</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("已开票金额") %>" disabled/>
                            </td>
				  </tr>
				  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">凭证状态：</span></td>
					    <td width="23%"><input type="text" name="textfield3" class="input_s_1" value="<%=rs.getString("凭证状态") %>"  disabled/>
                            </td>
					    <td width="10%" class="td_w_s text_r"> 凭证编号：</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("凭证号") %>" disabled/>
                            </td>
                            <td width="10%" class="td_w_s text_r"> 凭证金额：</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("凭证金额") %>" disabled/>
                            </td>
				  </tr>
				  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">报关费：</span></td>
					    <td width="23%"><input type="text" name="bgs" class="input_s_1" value="<%=rs.getString("报关费") %>"  />
                            <span class="red">*</span> </td>
					    <td width="10%" class="td_w_s text_r"> 仓储物流费：</td>
					    <td width="23%"><input type="text" name="wls" class="input_s_1"  value="<%=rs.getString("仓储物流费") %>" />
                            <span class="red">*</span></td>
                            <td width="10%" class="td_w_s text_r"> 关税：</td>
					    <td width="23%"><input type="text" name="gs" class="input_s_1"  value="<%=rs.getString("关税") %>" />
                            <span class="red">*</span></td>
				  </tr>
				  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">商检：</span></td>
					    <td width="23%"><input type="text" name="sjs" class="input_s_1" value="<%=rs.getString("商检") %>"  />
                            <span class="red">*</span> </td>
					    <td width="10%" class="td_w_s text_r"> 成本：</td>
					    <td width="23%"><input type="text" name="cbs" class="input_s_1"  value="<%=rs.getString("总成本") %>" disabled/>
                            </td>
                            <td width="10%" class="td_w_s text_r"> 金额：</td>
					    <td width="23%"><input type="text" name="jes" class="input_s_1"  value="<%=rs.getString("总金额") %>" disabled/>
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
					<span class="fl">商品信息</span>
					<span class="fr">		</span><!--  span里无内容时，此span不能删除  -->
				</h2>
				
				<div class="list_inner">
					<table width="100%" border="0" cellspacing="1" cellpadding="0" class="list_table_s">
					  <tr>
					    <th>物料编码</th>
					    <th>物料名称</th>
					    <th>规格型号</th>
					    <th>计量单位</th>
					    <th>数量</th>
					    <th>税率</th>
					    <th>成本单价</th>
					    <th>含税单价</th>
					    <th>成本</th>
					    <th>税额</th>
					    <th>价税合计</th>
					    <th>仓库</th>
					    <th>备注</th>
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
					    <td><%=rs.getString("物料编码") %></td>
					    <td><%=rs.getString("物料名称") %></td>
					    <td><%=rs.getString("规格型号") %></td>
					    <td><%=rs.getString("计量单位") %></td>					    
					    <td><%=rs.getString("数量") %></td>
					    <td><%=rs.getString("税率") %></td>
					    <td><%=rs.getString("成本单价") %></td>
					    <td><%=rs.getString("含税单价") %></td>
					    <td><%=rs.getString("成本") %></td>
					    <td><%=rs.getString("税额") %></td>
					    <td><%=rs.getString("价税合计") %></td>
					    <td><%=rs.getString("仓库") %></td>
					    <td><%=rs.getString("备注") %></td>
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
		alert("保存成功！");
	}
</script>
</html>
