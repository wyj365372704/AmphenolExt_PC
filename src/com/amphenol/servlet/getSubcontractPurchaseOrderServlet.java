package com.amphenol.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.amphenol.util.ConstantUtils;

public class getSubcontractPurchaseOrderServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");

		String userName = "";
		String envId = "";
		String envIdXA = "";
		String userCode = "";
		String userHouse = "";
		String stid = "";

		int language = 0;

		String ordno;

		String chk01;

		String chk02;

		String chk03;

		Map resultMap ;

		Connection connXA = null ;
		Connection conn = null ;

		
		userName = (String) request.getSession().getAttribute("userName");
		userHouse = (String) request.getSession().getAttribute("userHouse");
		envId = (String) request.getSession().getAttribute("envId");
		envIdXA = (String) request.getSession().getAttribute("envIdXA");
		userCode = (String) request.getSession().getAttribute("userCode");
		stid = (String) request.getSession().getAttribute("stid");

		ordno = request.getParameter("ordno");
		chk01 = request.getParameter("chk01");
		chk02 = request.getParameter("chk02");
		chk03 = request.getParameter("chk03");
		language = Integer.valueOf(request.getParameter("language"));

		resultMap = new HashMap();

		try {
			java.sql.DriverManager.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
			Class.forName("com.ibm.as400.access.AS400JDBCDriver");
			String url = "jdbc:as400://" + ConstantUtils.DATABASE_IP + "/"
					+ envIdXA + ";translate binary=true";
			connXA = DriverManager.getConnection(url,
					ConstantUtils.DATABASE_NAME,
					ConstantUtils.DATABASE_PASSWORD);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		try {
			java.sql.DriverManager.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
			Class.forName("com.ibm.as400.access.AS400JDBCDriver");
			String url = "jdbc:as400://" + ConstantUtils.DATABASE_IP + "/"
					+ envId + ";translate binary=true";
			conn = DriverManager.getConnection(url,
					ConstantUtils.DATABASE_NAME,
					ConstantUtils.DATABASE_PASSWORD);

		} catch (Exception e) {
			e.printStackTrace();
		}

		////
		/*Connection conn,Connection connXA,Map resultMap,String userName,String userCode,
		String userHouse,String envId,String envIdXA,String stid,String ordno,String chk01,String chk02,
		String chk03,int language*/
		getPOMAST(conn,connXA,resultMap,userName,userCode,
				userHouse,envId,envIdXA,stid,ordno,chk01,chk02,
				chk03,language);
		getZBMSCTL(conn,connXA,resultMap,userName,userCode,
				userHouse,envId,envIdXA,stid,ordno,chk01,chk02,
				chk03,language);

		try {
			connXA.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		request.setAttribute("resultMap", resultMap);
		request.setAttribute("chk01", chk01);
		request.setAttribute("chk02", chk02);
		request.setAttribute("chk03", chk03);
		request.setAttribute("language", language);
		request.getRequestDispatcher("supplier/subcontract_purchase_order.jsp").forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	private void getZBMSCTL(Connection conn,Connection connXA,Map resultMap,String userName,String userCode,
			String userHouse,String envId,String envIdXA,String stid,String ordno,String chk01,String chk02,
			String chk03,int language){
		Statement statement = null;
		ResultSet executeQuery = null ;
		try {
			statement = conn.createStatement();
			String sql = "SELECT * FROM "+envId.trim()+".ZBMSCTL WHERE SITE = '"+stid+"'";
			executeQuery = statement.executeQuery(sql);
			if(executeQuery!=null){
				if(executeQuery.next()){
					resultMap.put("nmchs", executeQuery.getString("NMCHS"));
					resultMap.put("nmeng", executeQuery.getString("NMENG"));
					resultMap.put("curid", executeQuery.getString("CURID").trim().isEmpty()?"CNY":executeQuery.getString("CURID").trim());
				}
			}
		}catch (Exception e) {
			System.out.print(e);
		}finally{
			try {
				if(executeQuery!=null)
					executeQuery.close();
				if(statement!=null)
					statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}


	private void getPOMAST(Connection conn,Connection connXA,Map resultMap,String userName,String userCode,
			String userHouse,String envId,String envIdXA,String stid,String ordno,String chk01,String chk02,
			String chk03,int language) {
		Statement statement = null;
		ResultSet executeQuery = null ;
		try {
			statement = connXA.createStatement();
			String sql = "SELECT * FROM "+envIdXA.trim()+".POMAST WHERE ORDNO = '"+ordno+"'";
			System.out.println("getPOMAST sql is "+sql);
			executeQuery = statement.executeQuery(sql);
			if(executeQuery!=null){
				if(executeQuery.next()){
					resultMap.put("house", executeQuery.getString("HOUSE"));
					resultMap.put("actdt", getActdt(executeQuery.getString("ACTDT")));
					resultMap.put("ordno", executeQuery.getString("ORDNO"));
					resultMap.put("revnb", executeQuery.getString("REVNB"));

					resultMap.put("sn35", executeQuery.getString("SN35"));
					resultMap.put("s135", executeQuery.getString("S135"));
					resultMap.put("s235", executeQuery.getString("S235"));
					resultMap.put("buyno", executeQuery.getString("BUYNO"));
					resultMap.put("buynm", getBuynm(executeQuery.getString("BUYNO"),
							conn,connXA,resultMap,userName,userCode,
							userHouse,envId,envIdXA,stid,ordno,chk01,chk02,
							chk03,language));
					resultMap.put("curid", executeQuery.getString("CURID"));

					System.out.println("a01");
					getSHPMST(executeQuery.getString("BILID"),
							conn,connXA,resultMap,userName,userCode,
							userHouse,envId,envIdXA,stid,ordno,chk01,chk02,
							chk03,language);

					System.out.println("a02");

					resultMap.put("vndnr", executeQuery.getString("VNDNR"));

					System.out.println("a03");

					getVENNAM(executeQuery.getString("VNDNR"),
							conn,connXA,resultMap,userName,userCode,
							userHouse,envId,envIdXA,stid,ordno,chk01,chk02,
							chk03,language);

					System.out.println("a04");
					resultMap.put("trmds", executeQuery.getString("TRMDS"));
					resultMap.put("viads", executeQuery.getString("VIADS"));

					getPOITEM(executeQuery.getString("ORDNO"),
							conn,connXA,resultMap,userName,userCode,
							userHouse,envId,envIdXA,stid,ordno,chk01,chk02,
							chk03,language);
					System.out.println("item's size is "+((List)resultMap.get("item")).size());
					System.out.println("a05");
				}
			}
		}catch (Exception e) {
			System.out.print(e);
		}finally{
			try {
				if(executeQuery!=null)
					executeQuery.close();
				if(statement!=null)
					statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	private String getActdt(String result) {
		if(result.trim().isEmpty())
			return "";
		result = new BigDecimal(result).add(new BigDecimal(19000000L)).toString();
		return result.substring(0, 4)+"/"+result.substring(4,6)+"/"+result.substring(6, 8);
	}

	private String getBuynm(String buyno,Connection conn,Connection connXA,Map resultMap,String userName,String userCode,
			String userHouse,String envId,String envIdXA,String stid,String ordno,String chk01,String chk02,
			String chk03,int language){
		String result = "";
		if(buyno ==null || buyno.trim().isEmpty())
			return result;

		Statement statement = null;
		ResultSet executeQuery = null ;
		try {
			statement = connXA.createStatement();
			String sql = "SELECT BUYNM FROM "+envIdXA.trim()+".BUYERF WHERE BUYNO = '"+buyno+"'";
			executeQuery = statement.executeQuery(sql);
			if(executeQuery!=null){
				if(executeQuery.next()){
					result = executeQuery.getString("BUYNM").trim();
				}
			}
		}catch (Exception e) {
			System.out.print(e);
		}finally{
			try {
				if(executeQuery!=null)
					executeQuery.close();
				if(statement!=null)
					statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return result;
	}

	private void getSHPMST(String bilid,Connection conn,Connection connXA,Map resultMap,String userName,String userCode,
			String userHouse,String envId,String envIdXA,String stid,String ordno,String chk01,String chk02,
			String chk03,int language){
		if(bilid ==null || bilid.trim().isEmpty())
			return ;

		Statement statement = null;
		ResultSet executeQuery = null ;
		try {
			statement = connXA.createStatement();
			String sql = "SELECT * FROM "+envIdXA.trim()+".SHPMST WHERE HOUSE = '"+stid+"' AND SHPID = '"+bilid+"'";
			executeQuery = statement.executeQuery(sql);
			if(executeQuery!=null){
				if(executeQuery.next()){
					resultMap.put("shpnm", executeQuery.getString("SHPNM").trim());
					resultMap.put("shpmst_s135", executeQuery.getString("S135").trim());
					resultMap.put("shpmst_s235", executeQuery.getString("S235").trim());
					resultMap.put("scont", executeQuery.getString("SCONT").trim());
				}
			}
		}catch (Exception e) {
			System.out.print(e);
		}finally{
			try {
				if(executeQuery!=null)
					executeQuery.close();
				if(statement!=null)
					statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	private void getVENNAM(String vndnr,Connection conn,Connection connXA,Map resultMap,String userName,String userCode,
			String userHouse,String envId,String envIdXA,String stid,String ordno,String chk01,String chk02,
			String chk03,int language){
		if(vndnr ==null || vndnr.trim().isEmpty())
			return ;

		Statement statement = null;
		ResultSet executeQuery = null ;
		try {
			statement = connXA.createStatement();
			String sql = "SELECT * FROM "+envIdXA.trim()+".VENNAM WHERE VNDNR = '"+vndnr+"'";
			executeQuery = statement.executeQuery(sql);
			if(executeQuery!=null){
				if(executeQuery.next()){
					resultMap.put("vn35", executeQuery.getString("VN35").trim());
					resultMap.put("vcont", executeQuery.getString("VCONT").trim());
					String txsuf = executeQuery.getString("TXSUF").trim();
					if(!txsuf.equals("")){
						txsuf = txsuf.substring(1, 3);
					} else {
						txsuf = "0";
					}
					resultMap.put("txsuf",Integer.parseInt(txsuf));
				}
			}
		}catch (Exception e) {
			System.out.print(e);
		}finally{
			try {
				if(executeQuery!=null)
					executeQuery.close();
				if(statement!=null)
					statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	private void getPOITEM(String poitem,Connection conn,Connection connXA,Map resultMap,String userName,String userCode,
			String userHouse,String envId,String envIdXA,String stid,String ordno,String chk01,String chk02,
			String chk03,int language){
		if(poitem ==null || poitem.trim().isEmpty())
			return ;

		Statement statement = null;
		ResultSet executeQuery = null ;
		try {
			statement = connXA.createStatement();
			String sql = "SELECT * FROM "+envIdXA.trim()+".POITEM WHERE ORDNO = '"+ordno+"'";
			executeQuery = statement.executeQuery(sql);
			if(executeQuery!=null){
				List<Map> item = new ArrayList<Map>();
				resultMap.put("item", item);
				while(executeQuery.next()){
					Map son1 = new HashMap();
					item.add(son1);
					son1.put("staic", executeQuery.getString("STAIC").trim());
					son1.put("itnbr", executeQuery.getString("ITNBR").trim());
					son1.put("itdsc", executeQuery.getString("ITDSC").trim());
					son1.put("ucorq", executeQuery.getString("UCORQ").trim());
					son1.put("curpr", executeQuery.getString("CURPR").trim());
					{
						BigDecimal dokdt = executeQuery.getBigDecimal("DOKDT");
						String d= (dokdt==null || dokdt.doubleValue()==0.0)?"":dokdt.add(BigDecimal.valueOf(19000000)).toString().trim();
						son1.put("dokdts",(d.length()<8?d: (d.substring(0, 4)+"-"+d.substring(4, 6)+"-"+d.substring(6, 8)+" ")));

						Map son2=  new HashMap();
						son1.put("son2", son2);

						getMOPORF(son2,ordno,executeQuery.getString("POISQ"),executeQuery.getString("LINSQ"),
								conn,connXA,resultMap,userName,userCode,
								userHouse,envId,envIdXA,stid,ordno,chk01,chk02,
								chk03,language);
					}
				}
			}
		}catch (Exception e) {
			System.out.print(e);
		}finally{
			try {
				if(executeQuery!=null)
					executeQuery.close();
				if(statement!=null)
					statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	private void getMOPORF(Map map,String ponr,String posq,String lseq,
			Connection conn,Connection connXA,Map resultMap,String userName,String userCode,
			String userHouse,String envId,String envIdXA,String stid,String ordno,String chk01,String chk02,
			String chk03,int language){
		Statement statement = null;
		ResultSet executeQuery = null ;
		try {
			statement = connXA.createStatement();
			String sql = "SELECT * FROM "+envIdXA.trim()+".MOPORF WHERE PONR = '"+ponr+"' AND PISQ = '"+posq+"' AND LSEQ = '"+lseq+"'";
			executeQuery = statement.executeQuery(sql);
			if(executeQuery!=null){
				if(executeQuery.next()){
					map.put("monr", executeQuery.getString("MONR"));
					map.put("opsq", executeQuery.getString("OPSQ"));
					System.out.println("b01");
					getMOMAST(map,executeQuery.getString("MONR"),
							conn,connXA,resultMap,userName,userCode,
							userHouse,envId,envIdXA,stid,ordno,chk01,chk02,
							chk03,language);
					System.out.println("b02");
					getMOROUT(map,executeQuery.getString("MONR"),executeQuery.getString("OPSQ"),
							conn,connXA,resultMap,userName,userCode,
							userHouse,envId,envIdXA,stid,ordno,chk01,chk02,
							chk03,language);
					System.out.println("b03");
					getITMSIT(map,(String) (map.containsKey("fitem")?map.get("fitem"):""),
							conn,connXA,resultMap,userName,userCode,
							userHouse,envId,envIdXA,stid,ordno,chk01,chk02,
							chk03,language);
					System.out.println("b04");
					getMODATA(map,executeQuery.getString("MONR"),
							conn,connXA,resultMap,userName,userCode,
							userHouse,envId,envIdXA,stid,ordno,chk01,chk02,
							chk03,language);
					System.out.println("b05");
					/*MOPORFVO moporf2 = new  MOPORFVO();
					moporf2.setPonr(poitem.getOrdno());
					moporf2.setPisq(poitem.getPoisq());
					moporf2.setLseq((int)(poitem.getLinsq()));
					List<MOPORFVO> moporfList2 = xadataService.queryMoporf(moporf2);
					if(moporfList2!=null && moporfList2.size()>0){//为外协订单
						moporf2 = moporfList2.get(0);
						poitem.setMoporf(moporf2);
						son2.put("monr", moporf2.getMonr());
						son2.put("opsq", moporf2.getOpsq());

						//取momast
						MOMASTVO momast = new MOMASTVO();
						momast.setOrdno(moporf2.getMonr());
						List<MOMASTVO> momastList = xadataService.queryMomastByordno(momast);
						System.out.println("momastList size is "+momastList.size());
						if(momastList!=null && momastList.size()>0){
							MOMASTVO momastvo = momastList.get(0);
							poitem.setMomast(momastvo);
							son2.put("fitem", momastvo.getFitem());
							son2.put("fdesc", momastvo.getFdesc());
							son2.put("orqty", momastvo.getOrqty());
							son2.put("qtdev", momastvo.getQtdev());
						}

						//取morout
						Map<String,String> moroutMap = new HashMap<String, String>();
						moroutMap.put("ordno", moporf2.getMonr());
						moroutMap.put("opseq", moporf2.getOpsq());
						List<MOROUTVO> moroutList = xadataService.queryMorout(moroutMap);
						System.out.println("moroutList size is "+moroutList.size());
						if(moroutList!=null && moroutList.size()>0){
							MOROUTVO moroutvo = moroutList.get(0);
							poitem.setMorout(moroutList.get(0));
							son2.put("opdsc", moroutvo.getOpdsc());
						}

						//取itmsit
						ITMSITVO itmsitvo = new ITMSITVO();
						itmsitvo.setHouse(pomast.getHouse());
						itmsitvo.setItnot9(momast.getFitem());
						List<ITMSITVO> itmsitvos = this.xadataService.queryItrvtAll(itmsitvo);
						System.out.println("itmsitvos size is "+itmsitvos.size());
						if(itmsitvos!=null && itmsitvos.size()>0){
							poitem.setItmsit(itmsitvos.get(0));
							son2.put("umstt9", itmsitvos.get(0).getUmstt9());
						}



						//取modata
						MODATAVO modata = new MODATAVO();
						modata.setOrdno(moporf2.getMonr());
						List<MODATAVO> modataList = xadataService.queryModatas(modata);
						System.out.println("modataList size is "+modataList.size());
						poitem.setModataList(modataList);
						List<Map> son2_ = new ArrayList<Map>();
						son2.put("son2_", son2_);
						for(MODATAVO modatavo:modataList){
							Map son22 = new HashMap();
							son2_.add(son22);
							son22.put("citem", modatavo.getCitem());
							son22.put("cdesc", modatavo.getCdesc());
							son22.put("qtreq", modatavo.getQtreq());
							son22.put("unmsr", modatavo.getUnmsr());

							ZITEMBXVO zitembx = new ZITEMBXVO();
							zitembx.setHouse(modatavo.getCitwh());
							zitembx.setItnbr(modatavo.getCitem());
							List<ZITEMBXVO> zitembxList = zitmbxService.queryItemBx(zitembx);
							if(zitembxList!=null && zitembxList.size()>0){
								modatavo.setZitembx(zitembxList.get(0));
								son22.put("whsub2", zitembxList.get(0).getWhsub2());
							}
						}
					}*/
				}
			}
		}catch (Exception e) {
			System.out.print(e);
		}finally{
			try {
				if(executeQuery!=null)
					executeQuery.close();
				if(statement!=null)
					statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}


	private void getMOMAST(Map map,String ordnoNew,
			Connection conn,Connection connXA,Map resultMap,String userName,String userCode,
			String userHouse,String envId,String envIdXA,String stid,String ordno,String chk01,String chk02,
			String chk03,int language){
		Statement statement = null;
		ResultSet executeQuery = null ;
		try {
			statement = connXA.createStatement();
			String sql = "SELECT * FROM "+envIdXA.trim()+".MOMAST WHERE ORDNO = '"+ordnoNew+"'";
			executeQuery = statement.executeQuery(sql);
			if(executeQuery!=null){
				if(executeQuery.next()){
					map.put("fitem", executeQuery.getString("FITEM"));
					map.put("fdesc", executeQuery.getString("FDESC"));
					map.put("orqty", executeQuery.getString("ORQTY"));
					map.put("qtdev", executeQuery.getString("QTDEV"));
				}
			}
		}catch (Exception e) {
			System.out.print(e);
		}finally{
			try {
				if(executeQuery!=null)
					executeQuery.close();
				if(statement!=null)
					statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}


	private void getMOROUT(Map map,String ordnoNew,String opseq,
			Connection conn,Connection connXA,Map resultMap,String userName,String userCode,
			String userHouse,String envId,String envIdXA,String stid,String ordno,String chk01,String chk02,
			String chk03,int language){
		Statement statement = null;
		ResultSet executeQuery = null ;
		try {
			statement = connXA.createStatement();
			String sql = "SELECT * FROM "+envIdXA.trim()+".MOROUT WHERE ORDNO = '"+ordnoNew+"' AND OPSEQ  = '"+opseq+"'";
			executeQuery = statement.executeQuery(sql);
			if(executeQuery!=null){
				if(executeQuery.next()){
					map.put("opdsc", executeQuery.getString("OPDSC"));
				}
			}
		}catch (Exception e) {
			System.out.print(e);
		}finally{
			try {
				if(executeQuery!=null)
					executeQuery.close();
				if(statement!=null)
					statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	private void getITMSIT(Map map,String itnot9,
			Connection conn,Connection connXA,Map resultMap,String userName,String userCode,
			String userHouse,String envId,String envIdXA,String stid,String ordno,String chk01,String chk02,
			String chk03,int language){
		Statement statement = null;
		ResultSet executeQuery = null ;
		try {
			statement = connXA.createStatement();
			String sql = "SELECT UMSTT9 FROM "+envIdXA.trim()+".ITMSIT WHERE STIDT9 = '"+stid+"' AND ITNOT9  = '"+itnot9+"'";
			executeQuery = statement.executeQuery(sql);
			if(executeQuery!=null){
				if(executeQuery.next()){
					map.put("umstt9", executeQuery.getString("UMSTT9"));
				}
			}
		}catch (Exception e) {
			System.out.print(e);
		}finally{
			try {
				if(executeQuery!=null)
					executeQuery.close();
				if(statement!=null)
					statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	private void getMODATA(Map map,String monr,
			Connection conn,Connection connXA,Map resultMap,String userName,String userCode,
			String userHouse,String envId,String envIdXA,String stid,String ordno,String chk01,String chk02,
			String chk03,int language){
		Statement statement = null;
		ResultSet executeQuery = null ;
		try {
			statement = connXA.createStatement();
			String sql = "SELECT * FROM "+envIdXA.trim()+".MODATA WHERE ORDNO = '"+monr+"'";
			System.out.println("getMODATA sql is "+sql);
			executeQuery = statement.executeQuery(sql);
			List<Map> son2_ = new ArrayList<Map>();
			map.put("son2_", son2_);
			if(executeQuery!=null){
				if(executeQuery.next()){
					Map son22 = new HashMap();
					son2_.add(son22);
					son22.put("citem", executeQuery.getString("CITEM"));
					son22.put("cdesc", executeQuery.getString("CDESC"));
					son22.put("qtreq", executeQuery.getString("QTREQ"));
					son22.put("unmsr", executeQuery.getString("UNMSR"));

					getZITEMBX(son22,executeQuery.getString("CITWH"),executeQuery.getString("CITEM"),
							conn,connXA,resultMap,userName,userCode,
							userHouse,envId,envIdXA,stid,ordno,chk01,chk02,
							chk03,language);
				}
			}
		}catch (Exception e) {
			System.out.print(e);
		}finally{
			try {
				if(executeQuery!=null)
					executeQuery.close();
				if(statement!=null)
					statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	private void getZITEMBX(Map map,String house,String itnbr,
			Connection conn,Connection connXA,Map resultMap,String userName,String userCode,
			String userHouse,String envId,String envIdXA,String stid,String ordno,String chk01,String chk02,
			String chk03,int language){
		Statement statement = null;
		ResultSet executeQuery = null ;
		try {
			statement = conn.createStatement();
			String sql = "SELECT * FROM "+envId.trim()+".ZITEMBX WHERE HOUSE = '"+house+"' AND ITNBR = '"+itnbr+"'";
			executeQuery = statement.executeQuery(sql);
			if(executeQuery!=null){
				if(executeQuery.next()){
					map.put("whsub2", executeQuery.getString("WHSUB2"));
				}
			}
		}catch (Exception e) {
			System.out.print(e);
		}finally{
			try {
				if(executeQuery!=null)
					executeQuery.close();
				if(statement!=null)
					statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}