package com.i7colors.util;

public class StringUtil {
	
	public static boolean isEmpty(String str){
		return str==null||"".equals(str)?true:false;
	}
	
	
	public static boolean isBlank(String str){
		return str==null||"".equals(str.trim())?true:false;
	}

}
