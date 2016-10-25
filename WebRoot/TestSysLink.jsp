<%@ page language="java" import="java.util.*,com.amphenol.tools.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String url = "http://10.1.5.37:36001/SystemLink/servlet/SystemLinkServlet";
String xml="<?xml version='1.0' encoding='UTF-8'?>"
	+"<!DOCTYPE System-Link SYSTEM 'SystemLinkRequest.dtd'>"
	+" <System-Link> "
	+"<Login userId='qsecofr' password='qsecofr' maxIdle='900000'"
	+" properties='com.pjx.cas.domain.EnvironmentId=M1,"
    +"com.pjx.cas.domain.SystemName=S844DD1W,"
    +"com.pjx.cas.user.LanguageId=zh' />"
	+"<Request sessionHandle='*current' workHandle='*new' broker='EJB'  maxIdle='1000'>"
	+"<Create name='receiveScheduleReceipt'  domainClass='com.mapics.mm.ReceiveScheduledReceiptTxn'>"
	+"<DomainEntity><Key><Property path='scheduledReceiptToken'><Value><![CDATA[Z1844DD1W032372216120100640AAAC2]]></Value>"
	+"</Property></Key>"
	+"<Property path='batchLot'>"
	+"<Value><![CDATA[]]></Value>"
	+"</Property>"
	+"<Property path='receivedToStockWarehouseLocation'>"
	+"<Value><![CDATA[DJ01]]></Value>"
	+"</Property>"
	
		+"<Property path='reference'>"
	+"<Value><![CDATA[REF1234]]></Value>"
	
	+"</Property>"
		+"<Property path='transactionDate'>"
	+"<Value><![CDATA[20160620]]></Value>"
	
	+"</Property>"
		+"<Property path='receivedToStockQuantity'>"
	+"<Value><![CDATA[2.100]]></Value>"
	+"</Property>"
	
			+"<Property path='grnInvoiceFlag'>"
	+"<Value><![CDATA[true]]></Value>"
	+"</Property>"
	
			+"<Property path='receivedToStockReason'>"
	+"<Value><![CDATA[RP99]]></Value>"
	+"</Property>"
	
				+"<Property path='receivedToStockFlag'>"
	+"<Value><![CDATA[true]]></Value>"
	+"</Property>"
	
	+"<Property path='goodsReceivedNote'>"
	+"<Value><![CDATA[GRN1234]]></Value>"
	+"</Property>"
	
	+"</DomainEntity>"
	+"</Create>"
	+"</Request>"
	+"</System-Link>";
	
	String returnVal = HttpServer.postXMLRequest(url,xml);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>test System link</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <%=returnVal %> <br>
  </body>
</html>
