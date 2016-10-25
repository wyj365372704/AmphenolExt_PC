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
<title>新亚ERP系统</title>

<link href="../css/customsDeclaration.css" rel="stylesheet" type="text/css" />
</head>

<body class="right_body">		
			<div class="public_div">
				<h2><br> 
					<span class="fl"></span></h2><h2><span class="fl">材料入库凭证信息</span> 
					<span class="fr"></span><!--  span里无内容时，此span不能删除  --> 
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
					    <th colspan="6">材料入库凭证信息基本信息</th>
			      </tr>
			      			  <%
			  	if(null!=rs){
			  		if(rs.next()){
			   %>
					  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">凭证号：</span></td>
					    <td width="23%"><input type="text" name="textfield3" class="input_s_1" value="<%=rs.getString("fnumber") %>"  disabled/>
                        </td>
                        <td width="10%" class="td_w_s text_r"> 凭证日期：</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("fdate") %>" disabled/>
                            </td>
				  </tr>
					  <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">借方金额：</span></td>
					    <td width="23%"><input type="text" name="textfield3" class="input_s_1" value="<%=rs.getString("FDebitTotal") %>"  disabled/>
                            </td>
					    <td width="10%" class="td_w_s text_r"> 贷方总额：</td>
					    <td width="23%"><input type="text" name="textfield222" class="input_s_1"  value="<%=rs.getString("FCreditTotal") %>" disabled/>
                            </td>
				  </tr>
			       <tr>
					    <td width="10%" class="td_w_s text_r"><span class="text_r">摘要：</span></td>
					    <td width="23%"><input type="text" name="textfield3" class="input_s_1" value="<%=rs.getString("fexplanation") %>"  disabled/>
                            </td>
					    <td width="10%" class="td_w_s text_r"> 描述：</td>
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
					<span class="fl">商品信息</span>
					<span class="fr">		</span><!--  span里无内容时，此span不能删除  -->
				</h2>				
				<div class="list_inner">
					<table width="100%" border="0" cellspacing="1" cellpadding="0" class="list_table_s">
					  <tr>
					    <th>供应商名称</th>
					    <th>单据编号</th>
					    <th>业务日期</th>
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
						while(rs.next()){
				       %>
					  <tr>
					    <td><%=rs.getString("供应商") %></td>
					    <td><%=rs.getString("单据编号") %></td>
					    <td><%=ObjectConvertUtils.getDateFormat(rs.getDate("业务日期")) %></td>
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
		alert("保存成功！");
	}
</script>
</html>
