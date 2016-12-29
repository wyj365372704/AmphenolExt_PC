<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>外协订单</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>
<script type="text/javascript">
	window.resizeTo(1000, 800);
</script>
<body>
	<!-- 为外协订单 -->
	<c:forEach items="${resultMap.item }" var="son1" varStatus="st">
		<table width="100%" cellpadding="5px" border="1"
			style="border-collapse: collapse;">
			<tr>
				<td>
					<table width="100%" border="0">
						<tr>
							<td align="center" colspan="4"><span
								style="font-weight: bold;font-size:18px;"> <c:choose>
										<c:when test="${language == 0}">${resultMap.nmchs}</c:when>
										<c:when test="${language != 0}">${resultMap.nmeng}</c:when>
									</c:choose> </span></td>
						</tr>
						<tr>
							<td align="center" colspan="4"><span
								style="font-weight: bold;font-size:18px;"> <c:choose>
										<c:when test="${language == 0}">外协采购订单</c:when>
										<c:when test="${language != 0}">Subcontract Purchase Order</c:when>
									</c:choose> </span></td>
						</tr>
						<tr>
							<td colspan="2">
								<table width="100%">
									<tr>
										<td nowrap="nowrap"><c:choose>
												<c:when test="${language == 0}">仓库:</c:when>
												<c:when test="${language != 0}">Warehouse:</c:when>
											</c:choose>
										</td>
										<td width="50%" align="left"><c:out
												value="${resultMap.house}" />
										</td>
										<td nowrap="nowrap"><c:choose>
												<c:when test="${language == 0}">订单日期:</c:when>
												<c:when test="${language != 0}">Order date:</c:when>
											</c:choose></td>
										<td width="50%" align="left"><c:out
												value="${resultMap.actdts}" /></td>
									</tr>
								</table></td>

							<td colspan="2"><c:out value="${resultMap.ordno}" />-<c:out
									value="${resultMap.revn}" /></td>
						</tr>
						<tr>
							<td nowrap="nowrap"><c:choose>
									<c:when test="${language == 0}">送货地:</c:when>
									<c:when test="${language != 0}">Ship To:</c:when>
								</c:choose></td>
							<td width="50%"><table>
									<tr align="left">
										<td><c:out value="${resultMap.sn35}" /></td>
									</tr>
									<tr align="left">
										<td><c:out value="${resultMap.s135}" /> <c:out
												value="${resultMap.s235}" /></td>
									</tr>
								</table></td>
							<td nowrap="nowrap"><c:choose>
									<c:when test="${language == 0}">供货方:</c:when>
									<c:when test="${language != 0}">Supplier:</c:when>
								</c:choose>
							</td>
							<td width="50%" align="left"><c:out
									value="${resultMap.vndnr}" /> <c:out value="${resultMap.vn35}" />
							</td>
						</tr>
						<tr>
							<td nowrap="nowrap"><c:choose>
									<c:when test="${language == 0}">采购员:</c:when>
									<c:when test="${language != 0}">Buyer:</c:when>
								</c:choose></td>
							<td align="left"><c:out value="${resultMap.buyno}" /> <c:out
									value="${resultMap.buynm}" /></td>
							<td nowrap="nowrap"><c:choose>
									<c:when test="${language == 0}">联系人:</c:when>
									<c:when test="${language != 0}">Contact:</c:when>
								</c:choose></td>
							<td align="left"><c:out value="${resultMap.vcont}" /></td>
						</tr>
						<tr>
							<td rowspan="2" nowrap="nowrap"><c:choose>
									<c:when test="${language == 0}">开票抬头:</c:when>
									<c:when test="${language != 0}">Bill To:</c:when>
								</c:choose></td>
							<td rowspan="2"><table width="100%">
									<tr>
										<td align="left"><c:out value="${resultMap.shpnm}" />
										</td>
									</tr>
									<tr>
										<td align="left"><c:out value="${resultMap.shpmst_s135}" />
											<c:out value="${resultMap.shpmst_s235}" />
										</td>
									</tr>
								</table></td>
							<td><c:choose>
									<c:when test="${language == 0}">币种:</c:when>
									<c:when test="${language != 0}">Currency:</c:when>
								</c:choose></td>
							<td><table border="0" width="100%" cellpadding="0"
									cellspacing="0">
									<tr>
										<td align="left" width="50%"><c:out
												value="${resultMap.curid}" />
										</td>
										<td nowrap="nowrap"><c:choose>
												<c:when test="${language == 0}">税率:</c:when>
												<c:when test="${language != 0}">Tax Rate:</c:when>
											</c:choose></td>
										<td align="left" width="50%"><c:out
												value="${resultMap.txsuf}" />%</td>
									</tr>

								</table></td>
						</tr>
						<tr>
							<td nowrap="nowrap"><c:choose>
									<c:when test="${language == 0}">付款条款:</c:when>
									<c:when test="${language != 0}">Terms:</c:when>
								</c:choose>
							</td>
							<td align="left" colspan="3"><c:out
									value="${resultMap.trmds}" /></td>
						</tr>
						<tr>
							<td nowrap="nowrap"><c:choose>
									<c:when test="${language == 0}">联系人:</c:when>
									<c:when test="${language != 0}">Contact:</c:when>
								</c:choose>
							</td>
							<td align="left"><c:out value="${resultMap.scont}" /></td>
							<td nowrap="nowrap"><c:choose>
									<c:when test="${language == 0}">运输方式:</c:when>
									<c:when test="${language != 0}">Ship Via:</c:when>
								</c:choose>
							</td>
							<td align="left"><c:out value="${resultMap.viads}" /></td>
						</tr>
					</table></td>
			</tr>
			<%-- <tr>
				<td>
					<table border="0" width="100%">
						<tr>
							<td>
								<table border="1" width="100%" cellpadding="5px"
									style="border-collapse: collapse;">
									<s:set var="count" value="0"></s:set>
									<s:set var="total" value="0"></s:set>
									<tr align="center">
										<td><s:if test="language == 0">
											序号
										</s:if> <s:else>
											No.
										</s:else></td>
										<td><s:if test="language == 0">
											料号 / 描述 / 交货日期 / 备注
										</s:if> <s:else>
											Item / Description / Delivery date / Comments
										</s:else></td>
										<td><s:if test="language == 0">
											数量
										</s:if> <s:else>
											Quantity
										</s:else></td>
										<td><s:if test="language == 0">
											单价
										</s:if> <s:else>
											Price
										</s:else></td>
										<td><s:if test="language == 0">
											金额
										</s:if> <s:else>
											Amount
										</s:else></td>
									</tr>
									<s:if test="#son1.staic == \"50\" && chk01 == \"false\""></s:if>
									<s:else>
										<s:if test="#son1.staic == \"99\" && chk03 == \"false\""></s:if>
										<s:else>
											<tr align="center">
												<td><s:property value="#st.count" />
												</td>

												<td>
													<table border="0" width="100%">
														<tr align="center">
															<td colspan="2"><s:property value="#son1.itnbr" />{<s:property
																	value="#son1.itdsc" />}</td>

														</tr>

														<s:if test="#son1.blcod==\"1\"">
															<!-- 外协且总括,实际情况下不存在 -->
															<s:if
																test="#son1.son1_.size == 0 && && chk02 == \"false\""></s:if>
															<s:else>
																<tr align="center">
																	<td><s:if test="language == 0">
											交货日期
										</s:if> <s:else>
											Delivery date
										</s:else>
																	</td>
																	<td><s:if test="language == 0">
											交货数量
										</s:if> <s:else>
											Release Quantity
										</s:else>
																	</td>
																</tr>
																<s:iterator value="#son1.son1_" var="son11">
																	<s:if
																		test="#son11.staic == \"50\" && chk01 == \"false\""></s:if>
																	<s:else>
																		<s:if
																			test="#son11.staic == \"99\" && chk01 == \"false\""></s:if>
																		<s:else>
																			<tr align="center">
																				<td><s:property value="#son11.dokdts" /></td>
																				<td><s:property value="#son11.relqt" /></td>
																			</tr>
																		</s:else>
																	</s:else>
																</s:iterator>
															</s:else>

														</s:if>
														<s:else>
															<tr>
																<td colspan="2" align="center"><s:if
																		test="language == 0">
											交货日期:
										</s:if> <s:else>
											Delivery date:
										</s:else> <s:property value="#son1.dokdts" /></td>
															</tr>
														</s:else>

													</table></td>
												<td><s:property value="#son1.ucorq" />
												</td>
												<td><s:property value="#son1.curpr" />
												</td>
												<s:set var="total" value="#total+#son1.ucorq"></s:set>
												<s:set var="count" value="#count+#son1.ucorq*#son1.curpr"></s:set>
												<td><fmt:formatNumber value="${son1.ucorq*son1.curpr}"
														pattern="#0.0000" /></td>

											</tr>
										</s:else>
									</s:else>
								</table></td>
						</tr>
						<tr>
							<td>
								<table width="100%">
									<tr>
										<td><s:if test="language == 0">
											生产信息
										</s:if> <s:else>
											Manufacturing Info.
										</s:else>
										</td>
									<tr>
										<td>&nbsp;&nbsp;<s:if test="language == 0">
											生产订单号:
										</s:if> <s:else>
											MO#:
										</s:else> <s:property value="#son1.son2.monr" />,&nbsp;<s:if
												test="language == 0">
											产品:
										</s:if> <s:else>
											Finished Item:
										</s:else> <s:property value="#son1.son2.fitem" />,&nbsp;<s:if
												test="language == 0">
											产品描述:
										</s:if> <s:else>
											Description:
										</s:else> <s:property value="#son1.son2.fdesc" />
										</td>
									</tr>
									<tr>
										<td>&nbsp;&nbsp;<s:if test="language == 0">
											工序:
										</s:if> <s:else>
											Operation:
										</s:else> <s:property value="#son1.son2.opsq" />(<s:property
												value="#son1.son2.opdsc" />),&nbsp;<s:if
												test="language == 0">
											生产数量:
										</s:if> <s:else>
											Quantity:
										</s:else> <fmt:formatNumber value="${son1.son2.orqty+son1.son2.qtdev}"
												pattern="#0.0000" />,&nbsp;<s:if test="language == 0">
											单位:
										</s:if> <s:else>
											UOM:
										</s:else> <s:property value="#son1.son2.umstt9" />
										</td>
									</tr>

								</table>
							</td>
						</tr>
						<tr>
							<td>
								<table border="1" width="100%" cellpadding="5px"
									style="border-collapse: collapse;">
									<tr align="center">
										<td><s:if test="language == 0">
											序号
										</s:if> <s:else>
											No.
										</s:else></td>
										<td><s:if test="language == 0">
											材料品号
										</s:if> <s:else>
											Component Item
										</s:else></td>
										<td><s:if test="language == 0">
											材料名称
										</s:if> <s:else>
											Component Item Description
										</s:else></td>
										<td><s:if test="language == 0">
											需领数量
										</s:if> <s:else>
											Required Qty
										</s:else></td>
										<td><s:if test="language == 0">
											单位
										</s:if> <s:else>
											UOM
										</s:else></td>
										<td><s:if test="language == 0">
											子库
										</s:if> <s:else>
											Sub-WHS
										</s:else></td>
									</tr>
									<s:iterator value="#son1.son2.son2_" var="son22" status="st">
										<tr align="center">
											<td><s:property value="#st.count" />
											</td>
											<td><s:property value="#son22.citem" />
											</td>
											<td><s:property value="#son22.cdesc" />
											</td>
											<td><fmt:formatNumber value="${son22.qtreq}"
													pattern="#0.0000" />
											</td>
											<td><s:property value="#son22.unmsr" />
											</td>
											<td><s:property value="#son22.whsub2" />
											</td>
										</tr>
									</s:iterator>
								</table></td>
						</tr>
						<tr>
							<td>
								<table width="100%">
									<tr align="center">
											<td><s:if test="language == 0">
											数量合计:
										</s:if> <s:else>
											Quantity:
										</s:else> <fmt:formatNumber value="${total }" pattern="#0.0000" /></td>
											<td><s:if test="language == 0">
											采购金额:
										</s:if> <s:else>
											Purchase amount:
										</s:else> <fmt:formatNumber value="${count }" pattern="#0.0000" /></td>
											<td><s:if test="language == 0">
											税额:
										</s:if> <s:else>
											Tax amount:
										</s:else> <fmt:formatNumber value="${count*resultMap.txsuf*0.01 }"
													pattern="#0.0000" />
											</td>
											<td><s:if test="language == 0">
											税价合计:
										</s:if> <s:else>
											Amount total:
										</s:else> <fmt:formatNumber value="${count+count*resultMap.txsuf*0.01 }"
													pattern="#0.0000" /></td>
										</tr>
								</table>
							</td>
						</tr>

					</table></td>

			</tr> --%>
			<tr>
				<td>
					<p>
						<c:choose>
							<c:when test="${language == 0}">条款说明:</c:when>
							<c:when test="${language != 0}">Remark.</c:when>
						</c:choose>
					</p>
					<p>
						<c:choose>
							<c:when test="${language == 0}">1.本合约书系立约双方(本公司、供应商)同意订立。</c:when>
							<c:when test="${language != 0}">Please be note that your parts should be ROHS comliant.</c:when>
						</c:choose>
					</p></td>
			</tr>
			<tr>
				<td>
					<table width="100%">
						<tr align="center">
							<c:choose>
								<c:when test="${language == 0}">
									<td width="33%">核准:</td>
									<td width="33%">审核:</td>
									<td width="33%">采购员:</td>
								</c:when>
								<c:when test="${language != 0}">
									<td width="50%">Authorized By</td>
									<td width="50%">Supplier Acceptance</td>
								</c:when>
							</c:choose>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</c:forEach>
</body>
</html>