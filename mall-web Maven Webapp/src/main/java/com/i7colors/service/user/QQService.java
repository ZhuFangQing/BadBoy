package com.i7colors.service.user;

import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.customer.CustomerMain;
import com.i7colors.bean.user.UserBalanceInfo;
import com.i7colors.commons.constant.ConstUrl;
import com.i7colors.domain.BaseResponse;
import com.i7colors.enums.ResultCode;
import com.i7colors.remoteService.AbstractRemoteService;
import com.i7colors.util.JsonUtils;
import com.i7colors.util.PropertyUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Max on 2017/2/23.
 */
@Service
public class QQService extends AbstractRemoteService{
    private static final Logger logger = Logger.getLogger(QQService.class);
    private String appid = PropertyUtils.getProperty("qq_appid");
    private String appsecret = PropertyUtils.getProperty("qq_appsecret");
    private String redirect_uri = PropertyUtils.getProperty("qq_redirect_uri");

    //检查qq openId是否已经绑定账号
    public boolean checkQQOpenIDIsBindAccount(String openId){
        Map<String,String> map = new HashMap<String,String>();
        map.put("openId",String.valueOf(openId));
        try {
            BaseResponse data = post(ConstUrl.CHECK_QQ_OPENID,map,new TypeToken<BaseResponse>(){}.getType());
            if(ResultCode.SUCCESS.equals(data.getCode())){
                return true;
            }
        }catch (Exception e){
            com.i7colors.util.Logger.error("",e);
        }
        return false;
    }

    //检查手机号是否已经存在
    public Long checkMobileQQ(String mobile){
        Map<String,String> map = new HashMap<String,String>();
        map.put("phone",String.valueOf(mobile));
        try {
            BaseResponse<CustomerMain> data = post(ConstUrl.CHECK_IS_BIND_QQ, map, new TypeToken<BaseResponse<CustomerMain>>() {
            }.getType());
            if(data.getData()!=null){
                if(data.getData().getQq_openid()==null||"".equals(data.getData().getQq_openid())){
                    return data.getData().getId();//手机号绑定账户，未绑定QQ
                }else{
                    return -1L;//已经绑定QQ
                }
            }
        }catch (Exception e){
            com.i7colors.util.Logger.error("",e);
        }
        return 0L;//手机号既没有绑定账号也没有绑定QQ
    }


    //绑定操作QQ
    public boolean bindQQOpenId(String openId ,String userId,String nickname,String password){
        Map<String,String> map = new HashMap<String,String>();
        map.put("openId",String.valueOf(openId));
        map.put("userId",String.valueOf(userId));
        map.put("realName",String.valueOf(nickname));
        map.put("password",String.valueOf(password));
        try {
            BaseResponse data = post(ConstUrl.BIND_QQ_OPENID,map,new TypeToken<BaseResponse>(){}.getType());
            return ResultCode.SUCCESS.equals(data.getCode());
        }catch (Exception e){
            com.i7colors.util.Logger.error("",e);
        }
        return false;
    }

    /////////////////////////////////////////////////////////


    //获取QQ UserInfo
    public Map<String,Object> getQQUserInfo(String code){
        Map<String,Object> userInfoMap = new HashMap<String, Object>();
        String access_token = getQQAccessToken(code);
        String open_id = getQQOpenIdByAccessToken(access_token);
        userInfoMap = getUserInfoByOpenId(access_token, open_id);
        userInfoMap.put("open_id",open_id);
        return userInfoMap;
    }

    //获取QQ openId
    public String getQQopenId(String code){
        String access_token = getQQAccessToken(code);
        String open_id = getQQOpenIdByAccessToken(access_token);
        return open_id;
    }

    //获取QQ openId
    public String getQQopenIdByToken(String access_token){
        String open_id = getQQOpenIdByAccessToken(access_token);
        return open_id;
    }

    //获取qq access_token
    private String getQQAccessToken(String code) {
        Map<String, Object> resultMap=new HashMap<String, Object>();
        String url=PropertyUtils.getProperty("qq_token_uri");
        url=getParms(url,"grant_type","authorization_code");
        url=getParms(url,"client_id",appid);
        url=getParms(url,"client_secret",appsecret);
        url=getParms(url,"code",code);
        url=getParms(url,"redirect_uri",redirect_uri);
        String result=sendGet(url);
        try{
            if(StringUtils.isNotEmpty(result)&&(!result.contains("error"))){
                resultMap = getResultString(result);
            }
        }catch(Exception e){
            logger.error("",e);
        }
        if(resultMap.get("access_token")!=null){
            return resultMap.get("access_token").toString();
        }else{
            logger.info("获取QQAccessToken失败！--"+result);
            return null;
        }
    }

    //获取qq openId
    private String getQQOpenIdByAccessToken(String access_token) {
        Map<String, Object> resultMap=new HashMap<String, Object>();
        String url=PropertyUtils.getProperty("qq_openid_uri");
        url=getParms(url,"access_token",access_token);
        String result=sendGet(url);
        try{
            if(StringUtils.isNotEmpty(result)){
                result = result.substring(result.indexOf("(") + 1, result.indexOf(")"));
                JSONObject jsonResult=new JSONObject(result);
                resultMap= JsonUtils.parseJSON2Map(jsonResult.toString());
            }
        }catch(Exception e){
            logger.error("",e);
        }
        if(resultMap.get("openid")!=null){
            logger.info(resultMap);
            return resultMap.get("openid").toString();
        }else{
            logger.info("获取QQOpenId失败！");
            return null;
        }
    }

    //获取qq UserInfo
    private Map<String,Object> getUserInfoByOpenId(String access_token,String openId) {
        Map<String, Object> resultMap=new HashMap<String, Object>();
        String url=PropertyUtils.getProperty("qq_userinfo_uri");
        url=getParms(url,"access_token",access_token);
        url=getParms(url,"oauth_consumer_key",appid);
        url=getParms(url,"openid",openId);

        String result=sendGet(url);
        try{
            if(StringUtils.isNotEmpty(result)){
                JSONObject jsonResult=new JSONObject(result);
                resultMap=JsonUtils.parseJSON2Map(jsonResult.toString());
            }
        }catch(Exception e){
            logger.error("",e);
        }
        logger.info("getQQUserInfo:"+resultMap);
        return resultMap;
    }

    // 组织get方式请求参数
    private String getParms(String returnStr, String key, String value) {
        if (StringUtils.isNotEmpty(returnStr)) {
            if (returnStr.contains("?")) {
                returnStr += "&" + key + "=" + value;
            } else {
                returnStr += "?" + key + "=" + value;
            }
        }
        return returnStr;
    }

    // get方式请求URL
    public String sendGet(String url) {
        logger.info("send get url:" + url);
        String result = "";
        BufferedReader in = null;
        try {
            URL realUrl = new URL(url);
            // 打开和URL之间的连接
            URLConnection conn = realUrl.openConnection();
            // 设置通用的请求属性
            conn.setRequestProperty("accept", "*/*");
            conn.setRequestProperty("connection", "Keep-Alive");
            conn.setRequestProperty("user-agent",
                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)");
            // 建立实际的连接
            conn.connect();

            // 定义BufferedReader输入流来读取URL的响应
            in = new BufferedReader(new InputStreamReader(
                    conn.getInputStream(), "utf-8"));
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }
        } catch (Exception e) {
            logger.error("发送GET请求出现异常！", e);
        }
        // 使用finally块来关闭输入流
        finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (IOException ex) {
                logger.error("", ex);
            }
        }
        logger.info("send get result :" + result);
        return result;
    }

    private Map<String,Object> getResultString(String result){
        String str[] = result.split("&");
        Map<String,Object> map = new HashMap<String, Object>();
        if(str.length>0){
            for (int i = 0; i < str.length; i++) {
                String info = str[i];
                String temp[] = info.split("=");
                if(temp.length>0){
                    map.put(temp[0], temp[1]);
                }

            }
        }
        return map;
    }

    public static void main(String[] args) {
        QQService service = new QQService();
//        service.getQQUserInfo("BA55892064582EBDDDD5117683E91E69");
        String access_token ="83E35AC4D23A09C030122B9EDB090557";
//		service.getQQOpenIdByAccessToken(access_token);
        String openid = "08C6A5686B2C73FBD1D8A1775B855D86";
        String code = "7C023CB872935A8574829EEB4FDC446F";
//		service.getQQAccessToken(code);
		service.getUserInfoByOpenId(access_token, openid);
    }
    public String getAppHost() {
        return PropertyUtils.getProperty("cusUserUrl");
    }
}

