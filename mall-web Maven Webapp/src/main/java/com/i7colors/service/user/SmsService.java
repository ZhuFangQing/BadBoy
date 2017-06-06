package com.i7colors.service.user;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.customer.CustomerMain;
import com.i7colors.bean.sms.EmailLog;
import com.i7colors.bean.sms.SmsLog;
import com.i7colors.commons.constant.ConstUrl;
import com.i7colors.domain.BaseResponse;
import com.i7colors.enums.ResultCode;
import com.i7colors.remoteService.AbstractRemoteService;
import com.i7colors.util.Logger;
import com.i7colors.util.PropertyUtils;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Max on 2016/12/12.
 */
@Service
public class SmsService extends AbstractRemoteService{
    /**
     * 短信息发送
     */
    public BaseResponse<SmsLog> sendSms(String mobile, String content){
        Map<String,String> pramMap = new HashMap<String, String>();
        BaseResponse<SmsLog> data = new BaseResponse<SmsLog>();
        SmsLog smsLog = new SmsLog();
        smsLog.setSmsMobile(mobile);
        smsLog.setSmsContent(content);
        String url = ConstUrl.SEND_SMS_CODE;
        pramMap.put("parameter",new Gson().toJson(smsLog));
        try{
            data = post(url,pramMap,new TypeToken<BaseResponse<SmsLog>>(){}.getType());
        }catch (Exception e){
            Logger.error("",e);
            data.setCode(ResultCode.FAIL);
            data.setMsg(ResultCode.FAIL.getDesc());
        }
        return data;
    }

    /**
     * 邮件发送
     */
    public BaseResponse<EmailLog> sendEmail(String email, String content){
        Map<String,String> pramMap = new HashMap<String, String>();
        BaseResponse<EmailLog> data = new BaseResponse<EmailLog>();
        EmailLog emailLog = new EmailLog();
        emailLog.setEmailAddress(email);
        emailLog.setEmailContent(content);
        String url = ConstUrl.SEND_EMAIL_CODE;
        pramMap.put("parameter",new Gson().toJson(emailLog));
        try{
            data = post(url,pramMap,new TypeToken<BaseResponse<EmailLog>>(){}.getType());
        }catch (Exception e){
            Logger.error("",e);
            data.setCode(ResultCode.FAIL);
            data.setMsg(ResultCode.FAIL.getDesc());
        }
        return data;
    }

    public String getAppHost() {
        return PropertyUtils.getProperty("smsAppServiceHost");
    }
}
