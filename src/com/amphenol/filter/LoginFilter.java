package com.amphenol.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.amphenol.util.ConstantUtils;




public class LoginFilter implements Filter{

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain arg2) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String url = (String) req.getServletPath();
        String contextName = req.getContextPath();
        HttpSession session = req.getSession(true);
        String userName = (String) session.getAttribute(ConstantUtils.CURRENT_USERNUMBER);
//        String password = (String) session.getAttribute(ConstantUtils.CURRENT_USERPASSWORD);
        // �Ƿ�û�е�¼
        if (userName == null) {
        	if( url.contains("logo.jsp")){
        		arg2.doFilter(req, res);
        	}else{
        		res.sendRedirect(contextName + "/logo.jsp");
        	}
            
        }
        else {
            // �Ƿ���Ȩ��
//            HashSet actionSet = (HashSet) session
//                    .getAttribute(LoginDAO.SESSION_ACTIONSET);
//            if (!actionSet.contains(url)) {
//                res.setLocale(java.util.Locale.CHINESE);
//                PrintWriter out = res.getWriter();
//                String message = "��û�иù��ܵ���Ȩ������Ҫ����ϵͳ����Ա��ϵ!";
//                out.println("<SCRIPT>alert(\"" + message
//                        + "\");window.history.back();</SCRIPT>");
//            }
//            else {
//                chain.doFilter(req, res);
//            }
        	arg2.doFilter(req, res);
        }
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
