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
	private String fTotalweight = "";//毛重
	private String fdate = "";//日期
	private String fproducter = "";//厂商
	private String fTotalweight_unit = "kg";//毛重单位
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
		fblcft9 = new String(request.getParameter("fblcft9").getBytes(
				"ISO8859-1"), "utf-8");
		fweight = new String(request.getParameter("fweight").getBytes(
				"ISO8859-1"), "utf-8");
		fTotalweight = new String(request.getParameter("fTotalweight").getBytes(
				"ISO8859-1"), "utf-8");
		fdate = new String(request.getParameter("fdate").getBytes(
				"ISO8859-1"), "utf-8");
		fproducter = new String(request.getParameter("fproducter").getBytes(
				"ISO8859-1"), "utf-8");
		fweight_unit = new String(request.getParameter("fweight_unit").getBytes(
				"ISO8859-1"), "utf-8");
		fTotalweight_unit = new String(request.getParameter("fTotalweight_unit").getBytes(
				"ISO8859-1"), "utf-8");
		
		System.out.println("fordrji is "+fordrji);
		System.out.println("fds40ji is "+fds40ji);
		System.out.println("fldesc is "+fldesc);
		System.out.println("fcout is "+fcout);
		System.out.println("fumstt9 is "+fumstt9);
		System.out.println("fblcft9 is "+fblcft9);
		System.out.println("fweight is "+fweight);
		System.out.println("fTotalweight is "+fTotalweight);
		System.out.println("fdate is "+fdate);
		System.out.println("fproducter is "+fproducter);
		
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
		request.setAttribute("fTotalweight", fTotalweight);
		request.setAttribute("fdate", fdate);
		request.setAttribute("fproducter", fproducter);
		request.setAttribute("qrcodeurl", encoderQRCoder);
		request.setAttribute("fTotalweight_unit", fTotalweight_unit);
		request.setAttribute("fweight_unit", fweight_unit);
		request.getRequestDispatcher("supplier/product_label.jsp").forward(request, response);
	}

}
