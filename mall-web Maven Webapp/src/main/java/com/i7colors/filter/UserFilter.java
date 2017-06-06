package com.i7colors.filter;

import com.i7colors.bean.customer.ResultBean;
import com.i7colors.bean.product.Product;
import com.i7colors.commons.constant.ConstCookieFlag;
import com.i7colors.commons.constant.ConstType;
import com.i7colors.service.shop.ProductService;
import com.i7colors.util.CookieUtils;
import com.i7colors.util.Logger;
import com.i7colors.util.StringUtil;
import com.i7colors.util.jedis.JedisCacheDB;
import org.apache.commons.lang.StringUtils;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Max on 2016/11/25.
 */
public class UserFilter implements Filter {
    private List<String> checkURLList = new ArrayList<String>();    //不进行登录检验的URL列表
    private List<String> loginURLList = new ArrayList<String>();    //登录注册Url
    
    public static String RLZIP = "";
    public static String RLZGameIP = "";

    public void destroy() {

    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpServletRequest req = (HttpServletRequest) request;
        
        try{
        	if(req.getRequestURL().indexOf("/game/download")!=-1){
        		
        		System.out.println(req.getRemoteAddr());
        		
        		if(req.getRemoteAddr().equals(RLZIP)){
        			resp.sendRedirect("http://"+RLZGameIP+":8080/SiHao.apk");
            		return;
        		}else{
	        		resp.sendRedirect("http://manager.app.randioo.com/Public/assets/APK/SiHao/SiHao.apk");
	        		return;
        		}
        	}
        	
        	if(req.getRequestURL().indexOf("www.i7colors.com/qrcode")!=-1){
        		resp.sendRedirect("http://mobile.i7colors.com/regist2/regist.html");
        		return;
        	}
        	
        	if(check(req, resp)){
        		if(req.getRequestURL().indexOf("www.i7colors.com/bbs")!=-1){
        			resp.sendRedirect("http://mobile.i7colors.com/bbs/index.html");
        		}else if(req.getRequestURL().indexOf("www.i7colors.com")!=-1){
        			resp.sendRedirect("http://mobile.i7colors.com");
        		}else if(req.getRequestURL().indexOf("bbs.i7colors.com")!=-1){
        			resp.sendRedirect("http://mobile.i7colors.com/bbs/index.html");
        		}else if(req.getRequestURL().indexOf("dyebbs.com")!=-1){
        			resp.sendRedirect("http://mobile.i7colors.com/bbs/index.html");
        		}else if(req.getRequestURL().indexOf("bbs2.i7colors.com")!=-1){
        			resp.sendRedirect("http://mobile.i7colors.com/bbs/index.html");
        		}
        		else{
        			resp.sendRedirect("http://mobile.i7colors.com");
        		}
        		return;
        	}
        }catch(Exception ex){
        	ex.printStackTrace();
        }
        
        String token = CookieUtils.getCookieValue((HttpServletRequest) request, ConstCookieFlag.I7COLOR_USER_LOGIN_TOKEN);
        ResultBean resultBean = null;
        if (token != null) {
            request.setAttribute("isLogin", "true");

            resultBean = (ResultBean) JedisCacheDB.getObject(token);
            if (resultBean == null) {
                CookieUtils.deleteCookies(resp, ConstCookieFlag.I7COLOR_USER_LOGIN_TOKEN);
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            if (resultBean.getCustomerGroup() != null) {
                JedisCacheDB.expireObject(token, 1800);
                JedisCacheDB.expireObject(ConstCookieFlag.I7COLOR_USER_NAME, 1800);
                request.setAttribute("groupId", resultBean.getCustomerGroup().getId());
            } else {
                resp.sendRedirect(req.getContextPath() + "/login?back_url=" + req.getServletPath());
                return;
            }

        }
        CookieUtils.setGetCookieValue(resp, ConstCookieFlag.I7COLOR_LAST_URL, req.getServletPath(), 180);
        if (isRequestURIIntFilterList(req)) {
            if (StringUtils.isEmpty(token)) {
                resp.sendRedirect(req.getContextPath() + "/login?back_url=" + req.getServletPath());
                return;
            }
        }
//		if(JedisCacheDB.getObject(ConstCookieFlag.I7COLOR_INDEX_SELECT_GOODS)!=null){
//            List<Product> list = (List<Product>)JedisCacheDB.getObject(ConstCookieFlag.I7COLOR_INDEX_SELECT_GOODS);
//			request.setAttribute("selectGoodsList",list);
//		}else{
//		    ProductService productService = new ProductService();
//            List<Product> list  =  productService.getProductsList(ConstType.RM,3);
//            request.setAttribute("selectGoodsList",list);
//            JedisCacheDB.saveObject(ConstCookieFlag.I7COLOR_INDEX_SELECT_GOODS,list,60*60*24*7);
//        }
        chain.doFilter(request, response);
    }

    /**
     * 获取用户信息
     */
    private Map<String, Object> getUserInfoFromRedis(HttpServletRequest request) {
        Map<String, Object> userInfo = null;
        try {
            String cookieFlag = ConstCookieFlag.I7COLOR_USER_LOGIN_TOKEN;
            String token = CookieUtils.getCookieValue(request, cookieFlag);
            if (StringUtils.isEmpty(token)) {
                return null;
            }
            if (JedisCacheDB.getObject(token) != null) {
                userInfo = (Map<String, Object>) JedisCacheDB.getObject(token);
                return userInfo;
            }
        } catch (Exception e) {
            Logger.error("", e);
            return null;
        }
        return userInfo;
    }

    /**
     * 判断链接是否需要拦截
     *
     * @param request
     * @return
     */
    private boolean isRequestURIIntFilterList(HttpServletRequest request) {
        String uri = request.getServletPath();
        return !uri.contains("/js/") && !uri.contains("/css/") && !uri.contains("/images/") && checkURLList.contains(uri);
    }

    /**
     * 添加需要拦截的链接
     *
     * @param config
     * @throws ServletException
     */
    public void init(FilterConfig config) throws ServletException {
        checkURLList.add("/carts");
        checkURLList.add("/orders");
        checkURLList.add("/company");
//        checkURLList.add("/kefu");
        checkURLList.add("/user/");
        checkURLList.add("/money");
        checkURLList.add("/u");
        checkURLList.add("/bbs/u");
//		checkURLList.add("/about");
        //====================
    }
    
    
	// \b 是单词边界(连着的两个(字母字符 与 非字母字符) 之间的逻辑上的间隔),
	// 字符串在编译时会被转码一次,所以是 "\\b"
	// \B 是单词内部逻辑间隔(连着的两个字母字符之间的逻辑上的间隔)
	static String phoneReg = "\\b(ip(hone|od)|android|opera m(ob|in)i"
			+ "|windows (phone|ce)|blackberry"
			+ "|s(ymbian|eries60|amsung)|p(laybook|alm|rofile/midp"
			+ "|laystation portable)|nokia|fennec|htc[-_]"
			+ "|mobile|up.browser|[1-4][0-9]{2}x[1-4][0-9]{2})\\b";
	static String tableReg = "\\b(ipad|tablet|(Nexus 7)|up.browser"
			+ "|[1-4][0-9]{2}x[1-4][0-9]{2})\\b";

	// 移动设备正则匹配：手机端、平板
	static Pattern phonePat = Pattern.compile(phoneReg,
			Pattern.CASE_INSENSITIVE);
	static Pattern tablePat = Pattern.compile(tableReg,
			Pattern.CASE_INSENSITIVE);

	/**
	 * 检测是否是移动设备访问
	 * 
	 * @Title: check
	 * @param userAgent
	 *            浏览器标识
	 * @return true:移动设备接入，false:pc端接入
	 */
	public static boolean check(String userAgent) {
		if (null == userAgent) {
			userAgent = "";
		}
		// 匹配
		Matcher matcherPhone = phonePat.matcher(userAgent);
		Matcher matcherTable = tablePat.matcher(userAgent);
		if (matcherPhone.find() || matcherTable.find()) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 检查访问方式是否为移动端
	 * 
	 * @Title: check
	 * @param request
	 * @throws IOException
	 */
	public static boolean check(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		boolean isFromMobile = false;
		// 检查是否已经记录访问方式（移动端或pc端）
		try {
			// 获取ua，用来判断是否为移动端访问
			String userAgent = request.getHeader("USER-AGENT").toLowerCase();
			if (null == userAgent) {
				userAgent = "";
			}
			isFromMobile = check(userAgent);
			// 判断是否为移动端访问
			if (isFromMobile) {
				System.out.println("移动端访问");
				return isFromMobile;
			} else {
				System.out.println("pc端访问");
				return isFromMobile;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isFromMobile;
	}
    
}
