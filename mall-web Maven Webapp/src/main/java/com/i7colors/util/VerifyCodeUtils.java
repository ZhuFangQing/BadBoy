package com.i7colors.util;

import com.i7colors.commons.constant.ConstCookieFlag;
import com.i7colors.util.jedis.JedisCacheDB;

import javax.servlet.http.HttpServletResponse;

/**
 * Created by Max on 2016/12/1.
 */
public class VerifyCodeUtils {
    public static String getSmsCode(HttpServletResponse response,String mobile,String VERIFY_CODE_TYPE){
        String smsCode = NonceStrUtils.generateNumStr(6);
        String smsCodeRedisKey = VERIFY_CODE_TYPE+"_"+mobile;
        String smsCookieConstent = mobile+smsCode;
        try{
            CookieUtils.setGetCookieValue(response,VERIFY_CODE_TYPE,smsCodeRedisKey,180);
            JedisCacheDB.saveObject(smsCodeRedisKey,smsCookieConstent, Integer.parseInt(PropertyUtils.getProperty("smsVerifyCodeExistSec")));
        }catch (Exception e){
            Logger.error("",e);
            return null;
        }
        return smsCode;
    }
}
