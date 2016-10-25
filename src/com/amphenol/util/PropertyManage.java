package com.amphenol.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

public class PropertyManage {

	//��ȡ��Դ�ļ�,��������������
     public static Properties readPropertiesFile(String filename)
     {
         Properties properties = new Properties();
         try
         {
             InputStream inputStream = new FileInputStream(filename);
             properties.load(inputStream);
             inputStream.close(); //�ر���
             ConstantUtils.DATABASE_IP=properties.getProperty("DATABASE_IP");
             ConstantUtils.DATABASE_NAME=properties.getProperty("DATABASE_NAME");
             ConstantUtils.DATABASE_PASSWORD=properties.getProperty("DATABASE_PASSWORD");
             ConstantUtils.ITNFROM=properties.getProperty("ITNFROM");
             ConstantUtils.ENSURE_DATE_URL=properties.getProperty("ENSUREDATEURL");
         }
         catch (IOException e)
         {
             e.printStackTrace();
         }
//         String username = properties.getProperty("username");
//         String passsword = properties.getProperty("password");
//         String chinese = properties.getProperty("chinese");
//         try
//         {
//             chinese = new String(chinese.getBytes("ISO-8859-1"), "GBK"); // ������������
//         }
//         catch (UnsupportedEncodingException e)
//         {
//             e.printStackTrace();
//         }
//         System.out.println(username);
//         System.out.println(passsword);
//         System.out.println(chinese);
         return properties;
     }
 
     //��ȡXML�ļ�,��������������
     public static Properties readPropertiesFileFromXML(String filename)
     {
         Properties properties = new Properties();
         try
         {
             InputStream inputStream = new FileInputStream(filename);
             properties.loadFromXML(inputStream);
             inputStream.close();
         }
         catch (IOException e)
         {
             e.printStackTrace();
         }
//         String username = properties.getProperty("username");
//         String passsword = properties.getProperty("password");
//         String chinese = properties.getProperty("chinese"); //XML�е����Ĳ��ô������룬����ʾ
//         System.out.println(username);
//         System.out.println(passsword);
//         System.out.println(chinese);
         return properties;
     }
}
