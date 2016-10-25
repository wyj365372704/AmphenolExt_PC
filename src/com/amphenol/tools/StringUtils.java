package com.amphenol.tools;

public class StringUtils {

	public static boolean isEmpty(String str){
		if(str==null){
			return true;
		}else{
			if("".equals(str.trim())){
				return true;
			}
		}
		return false;
	}
}
