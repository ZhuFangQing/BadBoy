package com.i7colors.service.user;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.customer.CustomerMain;
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

/**
 * Created by Max on 2017/2/14.
 */
@Service
public class WxService extends AbstractRemoteService {
    private static final Logger logger = Logger.getLogger(WxService.class);
    private String appid = PropertyUtils.getProperty("wx_appid");
    private String appsecret = PropertyUtils.getProperty("wx_appsecret");

    //检查微信 openId是否已经绑定账号
    public boolean checkWxOpenIDIsBindAccount(String openId){
        Map<String,String> map = new HashMap<String,String>();
        map.put("openId",String.valueOf(openId));
        try {
            BaseResponse data = post(ConstUrl.CHECK_WX_OPENID,map,new TypeToken<BaseResponse>(){}.getType());
            if(ResultCode.SUCCESS.equals(data.getCode())){
                return true;
            }
        }catch (Exception e){
            com.i7colors.util.Logger.error("",e);
        }
        return false;
    }

    //检查手机号是否已经存在
    public Long checkMobileWx(String mobile){
        Map<String,String> map = new HashMap<String,String>();
        map.put("phone",String.valueOf(mobile));
        try {
            BaseResponse<CustomerMain> data = post(ConstUrl.CHECK_IS_BIND_WX, map, new TypeToken<BaseResponse<CustomerMain>>() {
            }.getType());
            if(data.getData()!=null){
                if(data.getData().getId()>0){
                    if(data.getData().getOpen_id()==null||"".equals(data.getData().getOpen_id())){
                        return data.getData().getId();//手机号绑定账户，未绑定微信
                    }else{
                        return -1L;//已经绑定微信
                    }
                }

            }
        }catch (Exception e){
            com.i7colors.util.Logger.error("",e);
        }
        return 0L;//手机号既没有绑定账号也没有绑定微信
    }

    //绑定操作
    public boolean bindWxOpenId(String openId ,String userId,String nickname,String password){
        Map<String,String> map = new HashMap<String,String>();
        map.put("openId",String.valueOf(openId));
        map.put("userId",String.valueOf(userId));
        map.put("realName",String.valueOf(nickname));
        map.put("password",String.valueOf(password));
        try {
            BaseResponse data = post(ConstUrl.BIND_WX_OPENID,map,new TypeToken<BaseResponse>(){}.getType());
            return ResultCode.SUCCESS.equals(data.getCode());
        }catch (Exception e){
            com.i7colors.util.Logger.error("",e);
        }
        return false;
    }


    /**
     * 授权信息
     */
    public Map<String,String> getAccessToken(String code){


        Map<String,String> tokenMap=new HashMap<String, String>();
        String accessToken;
        String openid;
        String url=PropertyUtils.getProperty("wx_token_uri");
        url=getParms(url,"appid",appid);
        url=getParms(url,"secret",appsecret);
        url=getParms(url,"code",code);
        url=getParms(url,"grant_type","authorization_code");
        String result=sendGet(url);
        for (int i = 0;i<6;i++){
            if(result.contains("access_token")&&result.contains("openid")){
                tokenMap = getAccess(result);
                break;
            }else{
                result=sendGet(url);
            }
        }

        return tokenMap;
    }

    private Map<String,String> getAccess(String result){
        Map<String,String> tokenMap=new HashMap<String, String>();

        try{
            if(StringUtils.isNotEmpty(result)){
            	tokenMap = new Gson().fromJson(result, new TypeToken<HashMap<String, String>>(){}.getType());
            }
        }catch(Exception e){
            logger.error("",e);
        }
        return tokenMap;
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


    public Map<String, Object> getWechatUserInfo(String accessToken,String openid) {
        Map<String, Object> userInfo=new HashMap<String, Object>();
        String url=PropertyUtils.getProperty("wx_userinfo_uri");
        url=getParms(url,"access_token",accessToken);
        url=getParms(url,"openid",openid);
        url=getParms(url,"lang","zh_CN");
        String result=sendGet(url);
        try{
            if(StringUtils.isNotEmpty(result)){
                if(!result.contains("errcode")){
                    JSONObject jsonResult=new JSONObject(result);
                    if(null!=jsonResult.get("privilege")){
                        jsonResult.remove("privilege");
                    }
                    userInfo= JsonUtils.parseJSON2Map(jsonResult.toString());
                }else{
                    logger.info("getWechatUserInfo获取用户信息异常"+result);
                }
            }
        }catch(Exception e){
            logger.error("",e);
        }
        return userInfo;
    }

    public static void main(String[] args) {
        WxService service = new WxService();
        String access_token="7uwLViAyiuFjjMHXROimsCf4Bb7Z-KQFx-tZdJxSfUlUXbA063YfEpHQNOtr5_EfUThAwI-LRr1m32--NXTa84xW6ZpivrKiddPJhkHsR9M";
        String open_id = "orlqwwJVugSytfJ4qblGV-7blq80";
        Map<String,Object> map = service.getWechatUserInfo(access_token,open_id);
        System.out.println(map);
    }

    public boolean toBindingWx(String openId ,String userId){

        return true;
    }

    //第三方登录
    public BaseResponse<CustomerMain> thirdLogin(String open_id,String qq_openid){
        //检查用户是否登录
        Map<String,String> resMap = new HashMap<String, String>();
        Map<String,String> userMap = new HashMap<String,String>();
        if(open_id!=null){
            userMap.put("open_id",open_id);
        }
        if(qq_openid!=null){
            userMap.put("qq_openid",qq_openid);
        }
        String json = new Gson().toJson(userMap);
        userMap = new HashMap<String,String>();
        userMap.put("json",json);
        BaseResponse<CustomerMain> response = new BaseResponse<CustomerMain>();
        try{
            //请求登录接口
            response = post(ConstUrl.USER_LOGIN,userMap,new TypeToken<BaseResponse<CustomerMain>>(){}.getType());
        }catch (Exception e){
            com.i7colors.util.Logger.error("",e);
            response.setCode(ResultCode.FAIL);
            response.setMsg(ResultCode.FAIL.getDesc());
        }
        return response;
    }

    public String getAppHost() {
        return PropertyUtils.getProperty("cusUserUrl");
    }
}

