﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="../css/userCenter.css" rel="stylesheet" type="text/css" />

<SCRIPT language=javascript>
	        function showHide(obj){
		        var oStyle = document.getElementById(obj).style;
		        oStyle.display == "none" ? oStyle.display = "block" : oStyle.display = "none";
		       
		        if(oStyle.display == "block")
		        {
		            var elseTableElement = document.getElementsByTagName("ul");
		            if(elseTableElement)
		            {
		                for(var i=0;i<elseTableElement.length;i++)
		                {
    		                if(elseTableElement.item(i).id != obj && elseTableElement.item(i).id.indexOf("M_")==0)
    		                {
    		                    if( elseTableElement.item(i).style.display=="block")
    		                    {
    		                        elseTableElement.item(i).style.display = "none";
    		                        break;
    		                    }
    		                }
		                }
		            }
		        }
	        }
</SCRIPT>


</head>

<body class="left_body">

	<div class="left_title"></div>
	
	<div class="menu">
		
		<h2 class="out" onClick="JavaScript:showHide('M_PersonalInfo');"><span>供应商管理</span></h2><!--  out 样式为菜单展开，所应用的样式  -->
			<ul id=M_PersonalInfo style="DISPLAY: none">
				<li class="li_opt"><a href="../supplier/makeMark.jsp" target="exMainTFrame" title=""><span>制作生产标签</span></a></li><!--  li_opt 样式为停留在当前二级菜单页面所应用的样式  -->
				<li><a href="../supplier/ensureDate.jsp" target="exMainTFrame" title=""><span>确认送货日期</span></a></li>
				<li><a href="../supplier/buyIn.jsp" target="exMainTFrame" title=""><span>采购单</span></a></li>
				<li><a href="../SubcontractPurchaseServlet" target="exMainTFrame" title=""><span>委外订单</span></a></li>
				<li><a href="../supplier/myFhd.jsp" target="exMainTFrame" title=""><span>打印送货单</span></a></li>
				<li><a href="../supplier/myFhd_all.jsp" target="exMainTFrame" title=""><span>我的送货单</span></a></li>
			</ul>
			<div class="clear"></div>
		
	</div>


</body>
</html>
