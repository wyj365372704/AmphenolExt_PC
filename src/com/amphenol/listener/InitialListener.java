package com.amphenol.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.amphenol.util.PropertyManage;

public class InitialListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		String url=arg0.getServletContext().getRealPath("/WEB-INF");
		PropertyManage.readPropertiesFile(url+"/config.properties");
	}

}
