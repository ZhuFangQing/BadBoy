package com.i7colors.util;

public class Logger {
	
	
	public static void info(Object ob,Throwable throwable,Object ... msg){
		if(ob==null){
			return;
		}
		
		org.apache.log4j.Logger.getLogger(ob.getClass()).info(getArrayMsg(msg),throwable);
	}
	
	public static void info(Object ob,Object ... msg ){
		
		if(ob==null){
			return;
		}
		
		org.apache.log4j.Logger.getLogger(ob.getClass()).info(getArrayMsg(msg));
	}
	
	public static void debug(Object ob,Throwable throwable,Object ... msg){
		if(ob==null){
			return;
		}
		
		org.apache.log4j.Logger.getLogger(ob.getClass()).debug(getArrayMsg(msg),throwable);
	}
	
	public static void debug(Object ob,Object ... msg ){
		
		if(ob==null){
			return;
		}
		
		org.apache.log4j.Logger.getLogger(ob.getClass()).debug(getArrayMsg(msg));
	}
	
	
	public static void error(Object ob,Throwable throwable,Object ... msg){
		
		if(ob==null){
			return;
		}
		
		org.apache.log4j.Logger.getLogger(ob.getClass()).error(getArrayMsg(msg),throwable);
	}
	
	public static void error(Object ob,Object ... msg ){
		
		if(ob==null){
			return;
		}
		
		org.apache.log4j.Logger.getLogger(ob.getClass()).error(getArrayMsg(msg));
	}
	
	private static String getArrayMsg(Object ... msg){
		if(msg==null||msg.length==0){
			return "";
		}
		
		StringBuffer sb = new StringBuffer();
		for(Object str : msg){
			if(str == null){
				continue;
			}
			sb.append(str.toString()).append(" ");
		}
		
		return sb.toString();
	}
	


}
