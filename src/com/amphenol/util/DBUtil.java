package com.amphenol.util;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class DBUtil {
    private String OI = "O";
    
	private String url = "";
	private String userName = "";
	private String password = "";
	private String driverName = "";
	private static DBUtil instance = null;
	private String path = "";
	public static String strBMREC ="";
	public static DBUtil getInstance(){
		if(instance == null){
			instance = new DBUtil();
		}
		return instance;
		
	}
	private DBUtil(){
		try {
//			InputStream is = new BufferedInputStream(new FileInputStream(this.getClass().getResource("/").getPath()+"/config.properties"));
			InputStream is = new BufferedInputStream(new FileInputStream("D:/ningfengyue/work/config.properties"));
			Properties properties = new Properties();
			properties.load(is);
			if(OI.equals("I")){
				url=properties.getProperty("Iurl");		
			}else{
				url=properties.getProperty("Ourl");				
			}
			userName=properties.getProperty("ERPusername");
			password=properties.getProperty("ERPpassword");
			driverName=properties.getProperty("driverName");
		} catch (Exception e) {	
			e.printStackTrace();
		}
	}
	public  Connection getConnection(){
		Connection conn = null;
		try{
			Class.forName(driverName);
			conn=DriverManager.getConnection(url, userName, password);
		}catch(Exception e){
			e.printStackTrace();
		}
		return conn;
	}

	public  Connection getERPConnection(){
		Connection conn = null;
		try{
			Class.forName(driverName);
			conn=DriverManager.getConnection(url, userName, password);
		}catch(Exception e){
			e.printStackTrace();
		}
		return conn;
	}
	
	public  Connection getK3Connection(String dbName){
		Connection conn = null,conn1=null;
	    Statement pst = null;
		ResultSet rs = null;
		try{
			Class.forName(driverName);
			conn=DriverManager.getConnection(url, userName, password);
			pst=conn.createStatement();
			rs = pst.executeQuery("select * from t_xy_dbscheme where name='"+dbName+"'");
			while(rs.next()){
				String strName=rs.getString("kingdeeUserName");
				String strPassword=rs.getString("kingdeePassword");
				String strDB=rs.getString("kingdeeDBName");				
				String strIP=rs.getString("kingdeeIP");	
				if(OI.equals("I")){
					strIP="192.168.0.5";		
				}else{
					strIP="202.105.135.227";				
				}

				String strURL="jdbc:jtds:sqlserver://"+strIP+":1433;DatabaseName="+strDB;
				conn1=DriverManager.getConnection(strURL, strName, strPassword);
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally
        {
            cleanup(rs, pst, conn);
        }
		return conn1;
	}
	
	
	public  Connection getConnection(String dbName){
		Connection conn = null,conn1=null;
	    Statement pst = null;
		ResultSet rs = null;
		try{
			Class.forName(driverName);
			conn=DriverManager.getConnection(url, userName, password);
			pst=conn.createStatement();
			rs = pst.executeQuery("select * from t_xy_dbscheme where fname='"+dbName+"'");
			while(rs.next()){
				String strName=rs.getString("kingdeeUserName");
				String strPassword=rs.getString("kingdeePassword");
				String strDB=rs.getString("kingdeeDBName");				
				String strIP=rs.getString("kingdeeIP");	
				/**TODO   */
				strIP="202.105.135.227";
				String strURL="jdbc:jtds:sqlserver://"+strIP+":1433;DatabaseName="+strDB;
				conn1=DriverManager.getConnection(strURL, strName, strPassword);
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally
        {
            cleanup(rs, pst, conn);
        }
		return conn1;
	}
	


	   public static void ERPexecute(String sql)
	    {
	        Connection conn = null;
	        Statement st = null;
	        try
	        {
	            conn = new DBUtil().getERPConnection();
	            st = conn.createStatement();
	            st.execute(sql);
	        }
	        catch(SQLException ex){
	            ex.printStackTrace();
	        }
	        finally{
	            cleanup(null, st, conn);
	        }
	    }
	
	   public static void K3execute(String strDBName, String sql)
	    {
	        Connection conn = null;
	        Statement st = null;
	        try
	        {
	            conn = new DBUtil().getK3Connection(strDBName);
	            st = conn.createStatement();
	            st.execute(sql);
	        }
	        catch(SQLException ex){
	            ex.printStackTrace();
	        }
	        finally{
	            cleanup(null, st, conn);
	        }
	    }
	
	
	    public static ResultSet ERPexecuteQuery(String sql)
	    {
	        Connection conn = null;
	        Statement st = null;
	        ResultSet rs = null;
	        try
	        {
	            conn = new DBUtil().getERPConnection();
	            st = conn.createStatement();
	            rs = st.executeQuery(sql);
	        }
	        catch(SQLException ex)
	        {
	            ex.printStackTrace();
	        }
	        finally
	        {
	            cleanup(null, null, null);
	        }
	        return rs;
	    }

	    public static ResultSet K3executeQuery(String strDBName,String sql)
	    {
	        Connection conn = null;
	        Statement st = null;
	        ResultSet rs = null;
	        try
	        {
	        	conn = new DBUtil().getK3Connection(strDBName);
	            st = conn.createStatement();
	            rs = st.executeQuery(sql);
	        }
	        catch(SQLException ex){
	            ex.printStackTrace();
	        }
	        finally{
	            cleanup(null, st, conn);
	        }
	        return rs;
	    }
	
	
	
/**********************************************************************************************************************************************************************************************/
	
	
	
	
	
	
	
    public static ResultSet executeQuery(String sql, Object param[])
    {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try
        {
            conn = new DBUtil().getConnection();
            pst = conn.prepareStatement(sql);
            int i = 0;
            for(int size = param.length; i < size; i++)
                pst.setObject(i + 1, param[i]);

            rs = pst.executeQuery(sql);
        }
        catch(SQLException ex) {
            ex.printStackTrace();
        }
        finally {
            cleanup(rs, pst, conn);
        }
        return rs;
    }

    public static void execute(String sql, Object param[])
    {
        Connection conn = null;
        PreparedStatement pst = null;
        try
        {
            conn = new DBUtil().getConnection();
            pst = conn.prepareStatement(sql);
            int i = 0;
            for(int size = param.length; i < size; i++)
                pst.setObject(i + 1, param[i]);

            pst.execute(sql);
        }
        catch(SQLException ex)
        {
            ex.printStackTrace();
        }
        finally
        {
            cleanup(null, pst, conn);
        }
    }

    public static void execute(String sql)
    {
        Connection conn = null;
        Statement st = null;
        try
        {
            conn = new DBUtil().getConnection();
            st = conn.createStatement();
            st.execute(sql);
        }
        catch(SQLException ex)
        {
            ex.printStackTrace();
        }
        finally
        {
            cleanup(null, st, conn);
        }
    }

    public static void execute(Connection conn, String sql)
    {
        Statement st = null;
        try
        {
            st = conn.createStatement();
            st.execute(sql);
        }
        catch(SQLException ex)
        {
            ex.printStackTrace();
        }
        finally
        {
            cleanup(null, st, conn);
        }
    }

    public static ResultSet executeQuery(String sql)
    {
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        try
        {
            conn = new DBUtil().getConnection();
            st = conn.createStatement();
            rs = st.executeQuery(sql);
        }
        catch(SQLException ex)
        {
            ex.printStackTrace();
        }
        finally
        {
            cleanup(rs, st, conn);
        }
        return rs;
    }

    public static ResultSet executeQuery(Connection conn, String sql)
    {
        Statement st = null;
        ResultSet rs = null;
        try
        {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
        }
        catch(SQLException ex)
        {
            ex.printStackTrace();
        }
        finally
        {
            cleanup(rs, st, conn);
        }
        return rs;
    }

    public static void cleanup(ResultSet rs, Statement st, Connection conn)
    {
        try
        {
            if(rs != null)
                rs.close();
            if(st != null)
                st.close();
            if(conn != null)
                conn.close();
        }
        catch(SQLException ex)
        {
            ex.printStackTrace();
        }
    }	
	
	
	
	
}
