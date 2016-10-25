package com.amphenol.tools;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class HttpServer {
	
	/**
	 * 
	 * @Description: 发送XML请求
	 * @param xml
	 * @return String
	 */
	public static String postXMLRequest(String url, String xml){
		String responseStr = null;
		StringBuffer responseStrBuffer = new StringBuffer();
		
		OutputStream os = null;
		HttpURLConnection httpConn = null;
		InputStream is = null;
		if(!StringUtils.isEmpty(url) && !StringUtils.isEmpty(xml)){
			try {
				//1、得到http连接
				httpConn = (HttpURLConnection) new URL(url).openConnection();
				
				//2、设置http请求参数
				httpConn.setRequestMethod("POST");
		        httpConn.setDoInput(true);
		        httpConn.setDoOutput(true);
		        httpConn.setRequestProperty("Content-Type", "text/xml;charset=UTF-8"); 
		        
				//3、通过http连接服务器
		        httpConn.connect();
		        
		        //4、向服务器发送xml数据
		        os = httpConn.getOutputStream();
		        os.write(xml.getBytes());
		        os.flush();
		        
		        //5、得到http请求后，服务器返回的响应
		        if(200 == httpConn.getResponseCode()){
		        	is = httpConn.getInputStream();
		        	int length = 0;
	                byte[] buffer = new byte[1024];
	                while((length=is.read(buffer)) != -1){
	                    String s = new String(buffer,0,length, "utf-8");
	                    responseStrBuffer.append(s);
	                    System.out.println(responseStrBuffer.toString());
	                }
		        }
				
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				if(responseStrBuffer.length() > 1){
					responseStr = responseStrBuffer.toString();
				}
				
				try {
					if(os != null){
						os.close();
						os = null;
					}
					if(httpConn != null){
						httpConn.disconnect();
						httpConn = null;
					}
					if(is != null){
						is.close();
						is = null;
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return responseStr;
	}
}

