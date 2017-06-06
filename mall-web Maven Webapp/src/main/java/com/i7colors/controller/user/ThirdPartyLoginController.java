package com.i7colors.controller.user;

import com.google.gson.Gson;
import com.i7colors.bean.customer.CustomerMain;
import com.i7colors.bean.customer.ResultBean;
import com.i7colors.commons.constant.ConstCookieFlag;
import com.i7colors.controller.BaseController;
import com.i7colors.domain.BaseResponse;
import com.i7colors.enums.CompanyStatus;
import com.i7colors.enums.ResultCode;
import com.i7colors.service.user.QQService;
import com.i7colors.service.user.WxService;
import com.i7colors.util.CookieUtils;
import com.i7colors.util.PropertyUtils;
import com.i7colors.util.jedis.JedisCacheDB;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Max on 2017/2/14.
 */

@Controller
public class ThirdPartyLoginController extends BaseController {
    @Autowired
    public WxService wxService;
    @Autowired
    public QQService qqService;



    //微信登录
    @RequestMapping("/toWxLogin")
    public ModelAndView toWxLogin(@RequestParam String code) {
        System.out.println(code);
        Map<String,String> map = wxService.getAccessToken(code);
        if(map==null||map.size()<1){
            return new ModelAndView("user/login").addObject("code_err","二维码已过期，请重新扫描");
        }
        String openId = map.get("unionid");
        String accessToken = map.get("access_token");
        String nickname = wxService.getWechatUserInfo(accessToken,openId).get("nickname").toString();
        nickname = filterEmoji(nickname);
//        String openId ="openid111";
//        String nickname = "nicknametest";
        //检查openId是否已经绑定账号
        if(wxService.checkWxOpenIDIsBindAccount(openId)){
            //进行登录
            thirdLogin(openId,null);
            return new ModelAndView("redirect:/");
        }else{
            //绑定手机号
            return new ModelAndView("user/wxMobile").addObject("openId",openId).addObject("type","wx").addObject("nickname",nickname);
        }

    }

    //QQ登录
    @RequestMapping("/toQQLogin")
    @ResponseBody
    public ModelAndView toQQLogin(@RequestParam String code) {
        System.out.println(code);
        Map<String,Object> map = qqService.getQQUserInfo(code);
        String nickname = map.get("nickname").toString();
        nickname = filterEmoji(nickname);
        String openId = map.get("open_id").toString();
//        String openId = "qq1111111";
//        String nickname = "11asidghl";
        if(qqService.checkQQOpenIDIsBindAccount(openId)){
            //进行登录
            thirdLogin(null,openId);
            return new ModelAndView("redirect:/");
        }else{
            //绑定手机号
            return new ModelAndView("user/wxMobile").addObject("openId",openId).addObject("type","qq").addObject("nickname",nickname);
        }
    }

    //绑定第三方账号
    @RequestMapping("/toBindingAccount")
    @ResponseBody
    public Object toBindingAccount(@RequestParam String openId,@RequestParam String mobile,@RequestParam String password,
        @RequestParam String smsCode,@RequestParam String type,@RequestParam String VERIFY_CODE_TYPE,@RequestParam String nickname) {
        BaseResponse baseResponse = new BaseResponse();
        if (StringUtils.isEmpty(mobile)) {
            baseResponse.setCode(ResultCode.FAIL);
            baseResponse.setMsg("手机号码错误！");
            return baseResponse;
        }
        if (checkSmsCode(smsCode, mobile, VERIFY_CODE_TYPE)) {
            baseResponse.setMsg(toBinding(type,openId,mobile,nickname,password).getMsg());
        } else {
            baseResponse.setCode(ResultCode.FAIL);
            baseResponse.setMsg("验证码错误");
        }
        return baseResponse;
    }

    /**
     * 验证短信验证码
     */
    private boolean checkSmsCode(String smsCode, String mobile, String VERIFY_CODE_TYPE) {
        String smsCodeRedisKey = CookieUtils.getCookieValue(getHttpServletRequest(), VERIFY_CODE_TYPE);
        String redisImgCode;
        if (JedisCacheDB.getObject(smsCodeRedisKey) != null) {
            redisImgCode = JedisCacheDB.getObject(smsCodeRedisKey).toString();
        } else {
            return false;
        }
        return (mobile + smsCode).equals(redisImgCode);
    }

    //进行绑定
    private BaseResponse toBinding(String type,String openId,String mobile,String nickname,String password){
        BaseResponse baseResponse = new BaseResponse();
        if("wx".equals(type)){
            return toBindingWx( openId, mobile,nickname,password);
        }else if("qq".equals(type)){
            return toBindingQQ( openId, mobile,nickname,password);
        }
        baseResponse.setCode(ResultCode.FAIL);
        baseResponse.setMsg("绑定异常");
        return baseResponse;
    }

    //将手机号与微信openid绑定
    private BaseResponse toBindingWx(String openId,String mobile,String nickname,String password){
        BaseResponse baseResponse = new BaseResponse();
        Long status = wxService.checkMobileWx(mobile);
        if (status==0L){//手机号未注册未绑定
            //调用注册接口
            if(registerAccount(mobile,openId,null,nickname,password)){
                baseResponse.setCode(ResultCode.SUCCESS);
                baseResponse.setMsg("自动注册以及绑定微信成功！");
            }else{
                baseResponse.setCode(ResultCode.FAIL);
                baseResponse.setMsg("绑定异常");
            }
        }else if(status>0){//调用绑定接口
            if(wxService.bindWxOpenId(openId,status.toString(),nickname,password)){
                baseResponse.setCode(ResultCode.SUCCESS);
                baseResponse.setMsg("绑定微信成功！");
                if(!thirdLogin(openId,null)){
                    baseResponse.setMsg("微信登录异常！");
                }
            }else{
                baseResponse.setCode(ResultCode.SUCCESS);
                baseResponse.setMsg("绑定微信异常！");
            }
        }else{
            //已经被绑定 需要换手机号
            baseResponse.setCode(ResultCode.SUCCESS);
            baseResponse.setMsg("该手机号已经绑定过微信号，请更换手机号后重试！");
        }
        return baseResponse;
    }

    //将手机号与QQopenid绑定
    private BaseResponse toBindingQQ(String openId,String mobile,String nickname,String password){
        BaseResponse baseResponse = new BaseResponse();
        Long status = qqService.checkMobileQQ(mobile);
        if (status==0L){//手机号未注册未绑定
            //调用注册接口
            if(registerAccount(mobile,null,openId,nickname,password)){
                baseResponse.setCode(ResultCode.SUCCESS);
                baseResponse.setMsg("自动注册以及绑定QQ成功！");
            }else{
                baseResponse.setCode(ResultCode.FAIL);
                baseResponse.setMsg("绑定异常");
            }
        }else if(status>0){//调用绑定接口
            if(qqService.bindQQOpenId(openId,status.toString(),nickname,password)){
                baseResponse.setCode(ResultCode.SUCCESS);
                baseResponse.setMsg("绑定QQ成功！");
                if(!thirdLogin(null,openId)){
                    baseResponse.setMsg("QQ登录异常！");
                }
            }else{
                baseResponse.setCode(ResultCode.FAIL);
                baseResponse.setMsg("绑定QQ异常！");
            }
        }else{
            //已经被绑定 需要换手机号
            baseResponse.setCode(ResultCode.SUCCESS);
            baseResponse.setMsg("该手机号已经绑定过QQ号，请更换手机号后重试！");
        }
        return baseResponse;
    }

    //注册
    private Boolean registerAccount(String mobile, String openId, String qq, String realname, String password){
        Map<String, String> jsonParams = new HashMap<String, String>();
        realname = filterEmoji(realname);
        BaseResponse<CustomerMain> baseResponse = new BaseResponse<CustomerMain>();
        jsonParams.put("login_name", "i7colors"+mobile);
        jsonParams.put("password", password);
        jsonParams.put("phone", mobile);
        jsonParams.put("status", CompanyStatus.AUDIT.getCode());
        jsonParams.put("groupId", "1");
        jsonParams.put("open_id", openId);
        jsonParams.put("qq_openid", qq);
        jsonParams.put("real_name", realname);
        Map<String, String> param = new HashMap<String, String>();
        param.put("json", new Gson().toJson(jsonParams));
        baseResponse = userService.register(param);

        //success, write token
        if (baseResponse.getCode() == ResultCode.SUCCESS) {
            String nickname = baseResponse.getData().getLogin_name();
            if(baseResponse.getData().getReal_name()!=null&&(!("".equals(baseResponse.getData().getReal_name())))){
                nickname = baseResponse.getData().getReal_name();
            }
            CookieUtils.setGetCookieValue(response, ConstCookieFlag.I7COLOR_USER_LOGIN_TOKEN, baseResponse.getData().getToken(), Integer.parseInt(PropertyUtils.getProperty("userInfoExistSec")));
            CookieUtils.setGetCookieValue(response, ConstCookieFlag.I7COLOR_USER_NAME, nickname, Integer.parseInt(PropertyUtils.getProperty("userInfoExistSec")));
            return true;
        }
        return false;
    }

    //登录
    private Boolean thirdLogin(String open_id,String qq_openid){
        BaseResponse<CustomerMain> baseResponse = new BaseResponse<CustomerMain>();
        baseResponse = wxService.thirdLogin(open_id,qq_openid);
        if (baseResponse.getCode() == ResultCode.SUCCESS) {
            if (CookieUtils.setGetCookieValue(response, ConstCookieFlag.I7COLOR_USER_LOGIN_TOKEN, baseResponse.getData().getToken(), Integer.parseInt(PropertyUtils.getProperty("userInfoExistSec")))) {
                String nickName = "";
                String redisKey = baseResponse.getData().getToken();
                Object obj = JedisCacheDB.getObject(redisKey);
                if (obj != null) {
                    nickName = ((ResultBean) obj).getCustomerMain().getLogin_name();
                }
                if(baseResponse.getData().getReal_name()!=null&&(!("".equals(baseResponse.getData().getReal_name())))){
                    nickName = baseResponse.getData().getReal_name();
                }
                CookieUtils.setGetCookieValueCh(response, ConstCookieFlag.I7COLOR_USER_NAME, nickName, Integer.parseInt(PropertyUtils.getProperty("userInfoExistSec")));
            }
            return true;
        }else{
            return false;
        }

    }


    //过滤emoji表情
    private String filterEmoji(String realname) {
        if(realname != null) {
            Pattern emoji = Pattern.compile ("[\ud83c\udc00-\ud83c\udfff]|[\ud83d\udc00-\ud83d\udfff]|[\u2600-\u27ff]",Pattern.UNICODE_CASE | Pattern . CASE_INSENSITIVE ) ;
            Matcher emojiMatcher = emoji.matcher(realname);
            if ( emojiMatcher.find()) {
                realname = emojiMatcher.replaceAll("*");
                return realname ;
            }
            return realname;
        }else{
            return "";
        }
    }
}
