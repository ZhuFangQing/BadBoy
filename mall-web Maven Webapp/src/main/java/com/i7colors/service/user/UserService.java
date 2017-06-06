package com.i7colors.service.user;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.BaseBean;
import com.i7colors.bean.customer.CustomerMain;
import com.i7colors.bean.customer.ResultBean;
import com.i7colors.commons.constant.ConstCookieFlag;
import com.i7colors.commons.constant.ConstUrl;
import com.i7colors.domain.BaseResponse;
import com.i7colors.enums.ResultCode;
import com.i7colors.remoteService.AbstractRemoteService;
import com.i7colors.remoteService.ResponseInvokeException;
import com.i7colors.util.CookieUtils;
import com.i7colors.util.Logger;
import com.i7colors.util.NonceStrUtils;
import com.i7colors.util.PropertyUtils;
import com.i7colors.util.jedis.JedisCacheDB;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.Result;

import java.util.*;

@Service
public class UserService extends AbstractRemoteService{

	/**
	 * 用户登录
	 */
	public BaseResponse<CustomerMain> login(String login_name,String password){
		//检查用户是否登录
		Map<String,String> resMap = new HashMap<String, String>();
		String token = "";
		String url = ConstUrl.USER_LOGIN;
		Map<String,String> userMap = new HashMap<String,String>();
		userMap.put("login_name",login_name);
		userMap.put("password",password);
		String json = new Gson().toJson(userMap);
		userMap = new HashMap<String,String>();
		userMap.put("json",json);
		BaseResponse<CustomerMain> map2 = new BaseResponse<CustomerMain>();
		try{
			//请求登录接口
			map2 = post(url,userMap,new TypeToken<BaseResponse<CustomerMain>>(){}.getType());
		}catch (Exception e){
			Logger.error("",e);
			map2.setCode(ResultCode.FAIL);
			map2.setMsg(ResultCode.FAIL.getDesc());
		}
		return map2;
	}

	/**
	 *更新用户信息
	 * id
	 */
	public boolean updateUserInfo(CustomerMain customerMain){

		Map<String,String> map = new HashMap<String, String>();
		String json = new Gson().toJson(customerMain);
		map.put("json",json);
		try {
			BaseResponse<CustomerMain> map2 = post(ConstUrl.USER_INFO_UPDATR,map,new TypeToken<BaseResponse<CustomerMain>>(){}.getType());
			return map2.getCode().equals(ResultCode.SUCCESS);
		} catch (ResponseInvokeException e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * 获取用户权限
	 * @return
	 */
	public void getUserAuth(String userId,String token){
		String url = ConstUrl.USER_AUTH_GET;
		Map<String,String> map = new HashMap<String, String>();
		map.put("userId",userId);
		map.put("token",token);
		try {
			BaseResponse<ResultBean> data = get(url,map,new TypeToken<BaseResponse<ResultBean>>(){}.getType());
			for(int i=0 ;i<data.getData().getCustomerAuthList().size();i++){
				System.out.println(data.getData().getCustomerAuthList().get(i));
			}
		} catch (ResponseInvokeException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 用户信息
	 * @return
	 */
	public BaseResponse<CustomerMain> register(Map<String, String> params){
		BaseResponse<CustomerMain> data = new BaseResponse<CustomerMain>();
		try {
			data = post(ConstUrl.USER_REGISTER,params,new TypeToken<BaseResponse<CustomerMain>>(){}.getType());
		} catch (ResponseInvokeException e) {
			Logger.error("", e);
		}

		return data;
	}

	/**
	 * 找回密码
	 * 判断手机号是否存在
	 * @return
	 */
	public Boolean checkFindPwdMobile(String mobile, HttpServletResponse response){
		Map<String,String> map = new HashMap<String, String>();
		map.put("loginName",mobile);
		try{
			BaseResponse<CustomerMain> data = get(ConstUrl.CHECK_FIND_PWD_PHONE,map,new TypeToken<BaseResponse<CustomerMain>>(){}.getType());
		  	String str = NonceStrUtils.generateNumStr(6);
			CookieUtils.setGetCookieValue(response,ConstCookieFlag.I7COLOR_RESET_USER_ID,str+ConstCookieFlag.I7COLOR_RESET_USER_ID,1800);
			JedisCacheDB.saveObject(str+ConstCookieFlag.I7COLOR_RESET_USER_ID,data.getData().getId(),1800);
			return data.getCode().equals(ResultCode.SUCCESS);
		}catch(Exception e){
			Logger.error("",e);
			return false;
		}
	}

	/**
	 * 更新用户密码
	 * @return
	 */
	public Boolean resetPassword(String mobile,String password,Long id){
		CustomerMain customerMain = new CustomerMain();
		customerMain.setPassword(password);
		if(mobile!=null){
			customerMain.setPhone(mobile);
		}
		customerMain.setId(id);
		Gson gson = new Gson();
		Map<String,String> map = new HashMap<String, String>();
		map.put("json",gson.toJson(customerMain));
		try{
			BaseResponse data = post(ConstUrl.USER_INFO_UPDATR,map,new TypeToken<BaseResponse<CustomerMain>>(){}.getType());
			return data.getCode().equals(ResultCode.SUCCESS);
		}catch(Exception e){
			Logger.error("",e);
			return false;
		}
	}

	/**
	 * 获取用户信息
	 * @return
	 */
	public CustomerMain getUserInfo(Long userId){
		Map<String,String> map = new HashMap<String,String>();
		map.put("id",String.valueOf(userId));
		try{
			BaseResponse<CustomerMain> data = get(ConstUrl.USER_INFO_GET,map,new TypeToken<BaseResponse<CustomerMain>>(){}.getType());
			return data.getData();
		}catch(Exception e){
			Logger.error("",e);
			return new CustomerMain();
		}
	}

	public String getAppHost() {
		return PropertyUtils.getProperty("cusUserUrl");
	}
	
	/**
	 * 获取用户数量
	 * @param customerMain
	 * @return
	 */
	public Integer getUserCount(CustomerMain customerMain){
		BaseResponse<Integer> pageResponse = new BaseResponse<Integer>();
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("queryCond", new Gson().toJson(customerMain));

			pageResponse = get(ConstUrl.GET_USER_COUNT, map,
					new TypeToken<BaseResponse<Integer>>() {
					}.getType());
		} catch (Exception e) {
			Logger.error("", e);
		}
		return pageResponse.getData();
	}
}
