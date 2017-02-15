package com.amphenol.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.amphenol.util.QRcoderUtil;

public class getProductionLabelServlet extends HttpServlet {
	private String fordrji = "";//物料
	private String fds40ji = "";//描述
	private String fldesc = "";//规格
	private String fcout = "";//每箱数量
	private String fumstt9 = "";//库存单位
	private String fblcft9 = "";//批号
	private String fweight = "";//净重
	private String outer_weight = "";//包材重
	private String fdate = "";//日期
	private String fproducter = "";//厂商
	private String outer_weight_unit = "kg";//包材重单位
	private String fweight_unit = "g";//单重单位
	
	

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
	
		fordrji = 	new String(request.getParameter("fordrji").getBytes(
				"ISO8859-1"), "utf-8");
		fds40ji = 	new String(request.getParameter("fds40ji").getBytes(
				"ISO8859-1"), "utf-8");
		fldesc = 	new String(request.getParameter("fldesc").getBytes(
				"ISO8859-1"), "utf-8");
		fcout = new String(request.getParameter("fcout").getBytes(
				"ISO8859-1"), "utf-8");
		fumstt9 =  new String(request.getParameter("fumstt9").getBytes(
				"ISO8859-1"), "utf-8");
		try {
			fblcft9 = new String(request.getParameter("fblcft9").getBytes(
					"ISO8859-1"), "utf-8");
		} catch (Exception e) {
			fblcft9 = "";
		}
		fweight = new String(request.getParameter("fweight").getBytes(
				"ISO8859-1"), "utf-8");
		outer_weight = new String(request.getParameter("outer_weight").getBytes(
				"ISO8859-1"), "utf-8");
		fdate = new String(request.getParameter("fdate").getBytes(
				"ISO8859-1"), "utf-8");
		fproducter = new String(request.getParameter("fproducter").getBytes(
				"ISO8859-1"), "utf-8");
		fweight_unit = new String(request.getParameter("fweight_unit").getBytes(
				"ISO8859-1"), "utf-8");
		outer_weight_unit = new String(request.getParameter("outer_weight_unit").getBytes(
				"ISO8859-1"), "utf-8");
		
		String result = "*M"+fordrji;
		result += "*B"+fblcft9;
		result+="*Q"+fcout;
		
		String encoderQRCoder = QRcoderUtil.encoderQRCoder(result, (String) request.getSession().getAttribute("userName"),request.getSession().getServletContext().getRealPath("/"));
		System.out.println("encoderQRCoder is "+encoderQRCoder);
		
		request.setAttribute("fordrji", fordrji);
		request.setAttribute("fds40ji", fds40ji);
		request.setAttribute("fldesc", fldesc);
		request.setAttribute("fcout", fcout);
		request.setAttribute("fumstt9", fumstt9);
		request.setAttribute("fblcft9", fblcft9);
		request.setAttribute("fweight", fweight);
		request.setAttribute("fdate", fdate);
		request.setAttribute("fproducter", fproducter);
		request.setAttribute("qrcodeurl", encoderQRCoder);
		request.setAttribute("fweight_unit", fweight_unit);
		double totalweight = Double.parseDouble(fweight)*Double.parseDouble(fcout);
		if(!"g".equals(fweight_unit)){//单重单位
			totalweight *=1000;
		}
		if(!"g".equals(outer_weight_unit)){//包材单位
			totalweight +=Double.parseDouble(outer_weight)*1000;
		}else{
			totalweight +=Double.parseDouble(outer_weight);
		}
		request.setAttribute("totalweight", totalweight);
		request.getRequestDispatcher("supplier/product_label.jsp").forward(request, response);
		
	}

}
