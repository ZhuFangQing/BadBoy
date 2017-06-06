package com.i7colors.util;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

import com.i7colors.commons.constant.ConstCookieFlag;
import sun.misc.BASE64Encoder;

public class CookieUtils {
	
	private static final Logger logger=Logger.getLogger(CookieUtils.class);
	
	/**
	 * 间隔符
	 */
	public static final String SPLIT_STR="_";
	
	//创建一个新的可用的SESSIONID
	public static String createSessionID(){
		UUID uuid = UUID.randomUUID();
		return uuid.toString();
	}
	
	/**
	 * 生成Cookie值的随机字符串
	 */
	public static String getNonceCookieValue(){
		StringBuffer nonceStr=new StringBuffer();
		long currentTime=System.currentTimeMillis();
		//由当前时间和指定位数的随机字符串组成
		nonceStr=nonceStr.append(String.valueOf(currentTime));
		nonceStr=nonceStr.append(NonceStrUtils.generateCommonStr(10));
		return nonceStr.toString();
	}
	
	public static String  setGetCookieValue(HttpServletResponse resp,String key){
		String  cookieValue=getNonceCookieValue();
		try{
			Cookie cookie = new Cookie(key,cookieValue);
			cookie.setPath("/");
			resp.addCookie(cookie);
		}catch(Exception e){
			cookieValue=null;
			logger.error("",e);
		}
		return cookieValue;
	}
	
	public static boolean  setGetCookieValue(HttpServletResponse resp,String key,String value,int maxAge){
		try{
			Cookie cookie = new Cookie(key,value);
			cookie.setPath("/");
			cookie.setMaxAge(maxAge);
			resp.addCookie(cookie);
		}catch(Exception e){
			logger.error("",e);
			return false;
		}
		return true;
	}

	public static boolean  setGetCookieValueCh(HttpServletResponse resp,String key,String value,int maxAge){
		try{
			value = URLEncoder.encode(value,"utf-8");
			Cookie cookie = new Cookie(key,value);
			cookie.setPath("/");
			cookie.setMaxAge(maxAge);
			resp.addCookie(cookie);
		}catch(Exception e){
			logger.error("",e);
			return false;
		}
		return true;
	}
	

	
	
	public static String  getCookieValue(HttpServletRequest req,String key){
		String value=null;
		try{
			Cookie[] cookies = req.getCookies();
			if(cookies == null)
				return value;
			//遍历方式查找Cookies中是否存在 name
			for(Cookie c : cookies){
				if(c.getName().equals(key)){//在cookies中找到name的cookie
					value = c.getValue();
					break;
				}
			}
		}catch(Exception e){
			value = null;
			logger.error("",e);
		}
		return value;
	}

	//删除Cookies
	public static void deleteCookies(HttpServletResponse resp ,String key){
		Cookie newCookie=new Cookie(key,null); //假如要删除名称为username的Cookie
		newCookie.setMaxAge(0); //立即删除型
		newCookie.setPath("/"); //项目所有目录均有效，这句很关键，否则不敢保证删除
		resp.addCookie(newCookie); //重新写入，将覆盖之前的
	}
	
	//获取验证码的cookie标识
	public static Map<String, String> getVerifyCodeCookieFlagByType(
			String codeType) {
		Map<String,String> cookieFlagMap=new HashMap<String,String>();
		String codeCookieFlag="";
		String phoneCookieFlag="";
		if(codeType.equals("regist")){//注册
			codeCookieFlag=ConstCookieFlag.I7COLOR_VERIFY_CODE;
			phoneCookieFlag=ConstCookieFlag.I7COLOR_MOBILE_PHONE;
		}else if(codeType.equals("resetPwd")){//重置密码
			codeCookieFlag=ConstCookieFlag.I7COLOR_RESET_PWD_VERIFY_CODE;
			phoneCookieFlag=ConstCookieFlag.I7COLOR_RESET_PWD_MOBILE_PHONE;
		}else if(codeType.equals("updateMobile")){//修改手机号码
			codeCookieFlag=ConstCookieFlag.I7COLOR_UPDATE_VERIFY_CODE;
			phoneCookieFlag=ConstCookieFlag.I7COLOR_UPDATE_MOBILE_PHONE;
		}else if(codeType.equals("login")){//登录
			codeCookieFlag=ConstCookieFlag.I7COLOR_LOGIN_VERIFY_CODE;
			phoneCookieFlag=ConstCookieFlag.I7COLOR_LOGIN_MOBILE_PHONE;
		}
		cookieFlagMap.put("codeCookieFlag", codeCookieFlag);
		cookieFlagMap.put("phoneCookieFlag", phoneCookieFlag);
		return cookieFlagMap;
	}
	
}
