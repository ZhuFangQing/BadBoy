package com.i7colors.controller;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.i7colors.bean.customer.ResultBean;
import com.i7colors.commons.constant.ConstCookieFlag;
import com.i7colors.service.bbs.BbsService;
import com.i7colors.service.information.AdvertisementService;
import com.i7colors.service.information.InformationService;
import com.i7colors.service.member.MemberService;
import com.i7colors.service.member.PartnerService;
import com.i7colors.service.shop.*;
import com.i7colors.service.trade.BalanceService;
import com.i7colors.service.trade.CreditService;
import com.i7colors.service.trade.OrderService;
import com.i7colors.service.user.CompanyService;
import com.i7colors.service.user.MallInformService;
import com.i7colors.service.user.SmsService;
import com.i7colors.util.CookieUtils;
import com.i7colors.util.Logger;
import com.i7colors.util.PropertyUtils;
import com.i7colors.util.jedis.JedisCacheDB;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.i7colors.service.school.SchoolService;
import com.i7colors.service.user.UserService;

import java.util.Map;

@Controller
public class BaseController{
	protected HttpServletRequest request;           
	protected HttpServletResponse response;           
	protected HttpSession session;                      

	@Autowired
	public UserService userService;
	@Autowired
	public ShopService shopService;
	@Autowired
	public ProductService productService;
	@Autowired
	public SchoolService schoolService;
	@Autowired
	public InformationService informationService;
	@Autowired
	public MemberService memberService;
	@Autowired
	public PartnerService partnerService;
	@Autowired
	public AdvertisementService advertisementService;
	@Autowired
	public FavoriteService favoriteService;
	@Autowired
	public CartService cartService;
	@Autowired
	public OrderService orderService;
	@Autowired
	public BalanceService balanceService;
	@Autowired
	public CreditService creditService;
	@Autowired
	public CompanyService companyService;
	@Autowired
	public MallInformService mallInformService;
	@Autowired
	public SmsService smsService;
	@Autowired
	public BbsService bbsService;
	@ModelAttribute
	public void setReqAndRes(HttpServletRequest request, HttpServletResponse response){
	         this.request = request;
	         this.response = response;
	         this.session = request.getSession();
	 }
	
	public HttpServletRequest getHttpServletRequest(){
		return request;
	}

	/**
	 *获取用户ID
	 */
	public Long getUserId(){

		ResultBean resultBean = getUserInfo();
		return null == resultBean ? null : resultBean.getCustomerMain().getId();
//		return 0;
	}

	/**
	 * 获取用户信息
	 */
	public Map<String,Object> getUserInfoFromRedis(){
		Map<String,Object> userInfo=null;
		try{
			String cookieFlag=ConstCookieFlag.I7COLOR_USER_INFO;
			String cookieId =CookieUtils.getCookieValue(request,cookieFlag);
			if(StringUtils.isEmpty(cookieId)){
				return null;
			}
			String codeRedisKey=cookieFlag+CookieUtils.SPLIT_STR+cookieId;
			if(JedisCacheDB.getObject(codeRedisKey)!=null){
				userInfo=(Map<String,Object>)JedisCacheDB.getObject(codeRedisKey);
				return userInfo;
			}
		}catch(Exception e){
			Logger.error("",e);
			return null;
		}
		return userInfo;
	}

	/**
	 * 将对象存至redis缓存
	 * @param cookieFlag
	 * @param value
	 * @param expireSec
	 * @return
	 */
	public boolean saveObjectToRedis(String cookieFlag,Object value,Integer expireSec) {
		boolean res=false;
		try{
			String cookieId =CookieUtils.getCookieValue(request,cookieFlag);
			if(StringUtils.isEmpty(cookieId)){
				cookieId=CookieUtils.setGetCookieValue(response, cookieFlag);
			}
			String redisKey=cookieFlag+CookieUtils.SPLIT_STR+cookieId;
			Logger.info("saveObjectToRedis:key->"+redisKey);
			res=JedisCacheDB.saveObject(redisKey, value, expireSec);
		}catch(Exception e){
			Logger.error("",e);
		}
		return res;
	}

	/**
	 * 将对象存至redis缓存
	 * @param value
	 * @param expireSec
	 * @return
	 */
	public boolean saveObjectToRedisByKey(String redisKey,Object value,Integer expireSec) {
		boolean res=false;
		try{
			res=JedisCacheDB.saveObject(redisKey, value, expireSec);
		}catch(Exception e){
			Logger.error("",e);
		}
		return res;
	}

	/**
	 * 从redis缓存中获取对象
	 * @param cookieFlag
	 * @return
	 */
	public Object getObjectFromRedis(String cookieFlag){
		String cookieId=CookieUtils.getCookieValue(request, cookieFlag);
		if(StringUtils.isEmpty(cookieId)){
			return null;
		}
		String codeRedisKey=cookieFlag+CookieUtils.SPLIT_STR+cookieId;
		return JedisCacheDB.getObject(codeRedisKey);
	}

	/**
	 * 从redis缓存中获取对象
	 * @return
	 */
	public Object getObjectFromRedisByKey(String redisKey){
		return JedisCacheDB.getObject(redisKey);
	}

	/**
	 * 从redis缓存中删除对象
	 * @param cookieFlag
	 * @return
	 */
	public boolean deleteObjectFromRedis(String cookieFlag){
		String cookieId=CookieUtils.getCookieValue(request, cookieFlag);
		if(StringUtils.isNotEmpty(cookieId)){
			String codeRedisKey=cookieFlag+CookieUtils.SPLIT_STR+cookieId;
			return JedisCacheDB.deleteObject(codeRedisKey);
		}
		return true;
	}

	/**
	 * 将用户信息保存至redis缓存中
	 * @param userInfo
	 * @return
	 */
	public boolean saveUserInfoToRedis(Map<String,Object> userInfo){
		String cookieFalg=ConstCookieFlag.I7COLOR_USER_INFO;
		int expireSec=Integer.parseInt(PropertyUtils.getProperty("userInfoExistSec").toString());
		return saveObjectToRedis(cookieFalg,userInfo,expireSec);
	}

	/**
	 * 获取当前页面链接
	 * @return
	 */
	public String getRequestUrl() {
		String url="";
		String domain=PropertyUtils.getProperty("domain");
		String requestUri=request.getRequestURI();
		if(requestUri.startsWith("//")){
			requestUri=requestUri.substring(1, requestUri.length());
		}
		Logger.info("domain:"+domain+"|requestUri:"+requestUri);
		url=domain+requestUri;
		String queryStr=request.getQueryString();
		if(StringUtils.isNotEmpty(queryStr)){
			url=url +"?"+queryStr;
		}
		return url;
	}

	/**
	 * 获取用户信息
	 */
	public ResultBean getUserInfo(){
		String token = CookieUtils.getCookieValue(request,ConstCookieFlag.I7COLOR_USER_LOGIN_TOKEN);
		return StringUtils.isEmpty(token) ? null : (ResultBean)JedisCacheDB.getObject(token);
	}

	//获取用户登陆的ip
	public String getIP() {
		String ip = request.getHeader("X-Real-IP");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-Forwarded-For");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
}
