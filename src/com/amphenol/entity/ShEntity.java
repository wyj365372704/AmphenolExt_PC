package com.amphenol.entity;

import java.util.List;

public class ShEntity {
	private String shcs ;
	private String shdz1 ;
	private String shdz2;
	private String shdz3;
	private String shdh ;
	private String lxr ;
	private String ewm ;
	private String phone ;
	private List<ShdItem> sdhItems ;
	public String getShcs() {
		return shcs;
	}
	public String getShdz1() {
		return shdz1;
	}
	public String getShdz2() {
		return shdz2;
	}
	public String getShdz3() {
		return shdz3;
	}
	public String getShdh() {
		return shdh;
	}
	public String getLxr() {
		return lxr;
	}
	public String getEwm() {
		return ewm;
	}
	public String getPhone() {
		return phone;
	}
	public List<ShdItem> getSdhItems() {
		return sdhItems;
	}
	public void setShcs(String shcs) {
		this.shcs = shcs;
	}
	public void setShdz1(String shdz1) {
		this.shdz1 = shdz1;
	}
	public void setShdz2(String shdz2) {
		this.shdz2 = shdz2;
	}
	public void setShdz3(String shdz3) {
		this.shdz3 = shdz3;
	}
	public void setShdh(String shdh) {
		this.shdh = shdh;
	}
	public void setLxr(String lxr) {
		this.lxr = lxr;
	}
	public void setEwm(String ewm) {
		this.ewm = ewm;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public void setSdhItems(List<ShdItem> sdhItems) {
		this.sdhItems = sdhItems;
	}
	
	public static class ShdItem{
		private String xc ;
		private String wl ;
		private String ms ;
		private String cgdw ;
		private float sl ;
		private float dz ;
		private float zl ;
		private String dw ;
		private List<ShdPcItem> pcItem ;
		public String getXc() {
			return xc;
		}
		public String getWl() {
			return wl;
		}
		public String getMs() {
			return ms;
		}
		public String getCgdw() {
			return cgdw;
		}
		public float getSl() {
			return sl;
		}
		public float getDz() {
			return dz;
		}
		public float getZl() {
			return zl;
		}
		public String getDw() {
			return dw;
		}
		public List<ShdPcItem> getPcItem() {
			return pcItem;
		}
		public void setXc(String xc) {
			this.xc = xc;
		}
		public void setWl(String wl) {
			this.wl = wl;
		}
		public void setMs(String ms) {
			this.ms = ms;
		}
		public void setCgdw(String cgdw) {
			this.cgdw = cgdw;
		}
		public void setSl(float sl) {
			this.sl = sl;
		}
		public void setDz(float dz) {
			this.dz = dz;
		}
		public void setZl(float zl) {
			this.zl = zl;
		}
		public void setDw(String dw) {
			this.dw = dw;
		}
		public void setPcItem(List<ShdPcItem> pcItem) {
			this.pcItem = pcItem;
		}
		
		
	}
	public static class ShdPcItem{
		private String pch ;
		private float sl ;
		public String getPch() {
			return pch;
		}
		public float getSl() {
			return sl;
		}
		public void setPch(String pch) {
			this.pch = pch;
		}
		public void setSl(float sl) {
			this.sl = sl;
		}
		
		
	}

}

