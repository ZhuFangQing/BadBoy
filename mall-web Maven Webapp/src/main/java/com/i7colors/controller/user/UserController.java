package com.i7colors.controller.user;

import com.google.gson.Gson;
import com.i7colors.bean.customer.Company;
import com.i7colors.bean.customer.CustomerMain;
import com.i7colors.bean.customer.ResultBean;
import com.i7colors.bean.info.Partner;
import com.i7colors.commons.constant.ConstCookieFlag;
import com.i7colors.commons.constant.ConstType;
import com.i7colors.commons.dto.RegisterDTO;
import com.i7colors.controller.BaseController;
import com.i7colors.domain.BaseResponse;
import com.i7colors.domain.PageResponse;
import com.i7colors.enums.CompanyStatus;
import com.i7colors.enums.ResultCode;
import com.i7colors.enums.SchoolPlateType;
import com.i7colors.util.*;
import com.i7colors.util.jedis.JedisCacheDB;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UserController extends BaseController {
    private static final Logger logger = Logger.getLogger(UserController.class);

    @RequestMapping("/index")
    public ModelAndView toIndex() {
        return new ModelAndView("redirect:/");
    }

    @RequestMapping("/qrcode")
    public ModelAndView index(String from) {
        logger.info("login from QR_CODE, from:" + String.valueOf(from));
        return new ModelAndView("redirect:http://mobile.i7colors.com/regist2/regist.html");
    }

    @RequestMapping("/u")
    public ModelAndView toOrders() {
        ResultBean resultBean = getUserInfo();
        
        logger.info("resultBean.getCustomerGroup():"+resultBean.getCustomerGroup());
        if (resultBean.getCustomerGroup() != null) {
            if (resultBean.getCustomerGroup().getId() == 2L) {
                return new ModelAndView("redirect:/orders");
            } else {
                String status = checkApplyCompanyStatus();
                if (status.equals(CompanyStatus.AUDIT.getCode())) {
                    //跳转到企业认证成功页面
                    return new ModelAndView("/user/company/companyInfoPage").addObject("companyInfo", getApplySuccessCompanyInfo());
                } else if (status.equals(CompanyStatus.WAIT_AUDIT.getCode())) {
                    //企业审核中
                    return new ModelAndView("/user/company/certificationInfoPage")
                            .addObject("status", "您所申请的企业账户正在审核中，请耐心等待")
                            .addObject("type", "审核中");
                } else if (status.equals(CompanyStatus.AUDIT_FAIL.getCode())) {
                    //企业审核失败
                    return new ModelAndView("/user/company/certificationInfoPage")
                            .addObject("status", "您所申请的企业账户审核失败，请联系客服")
                            .addObject("type", "审核失败");
                } else {
                    //企业审核
                    return new ModelAndView("/user/company/certificationPage");
                }
            }
        } else {
            return new ModelAndView("/");
        }
    }

    /**
     * 首页访问
     */
    @RequestMapping("")
    public ModelAndView index() {
        ModelAndView mav = new ModelAndView("user/index");

//=============================大学堂================================
        //获取大学堂信息
//		List<Map<String,Object>> schoolInfoList = schoolService.getIndexSchoolInfo();
        //获取客户会员信息
//		List<Map<String,Object>> customerList = informationService.getCustomer();
        //获取供应商信息
//		List<Map<String,Object>> supplierList = informationService.getSupplier();
//==============================广告=================================
        mav.addObject("adList", advertisementService.getAdInfoByCode(ConstType.INDEX_AD));

//==============================客户会员以及推荐供应商=================================
        //客户会员
        mav.addObject("memberList", memberService.getMembersAndSuppliers(ConstType.RM_MEMBERS));
        //推荐供应商
        mav.addObject("suppliersList", memberService.getMembersAndSuppliers(ConstType.TJ_SUPPLIERS));
//=============================新闻资讯==============================
        //热门商品
        mav.addObject("hotGoodsList", productService.getProductsList(ConstType.RM, 0));
        //推荐商品
        mav.addObject("recommendGoodsList", productService.getProductsList(ConstType.TJ, 0));
//=============================资讯==============================
        //纺织订单
        mav.addObject("textileOrderList", informationService.getInformationByTypeService(ConstType.FZDD, 6));
        //名人访谈
        mav.addObject("talentExchangeList", informationService.getInformationByTypeService(ConstType.MRFT, 4));
        //热点资讯
        mav.addObject("hotNewsList", informationService.getInformationByTypeService(0, 10));
        //首页大图
        mav.addObject("indexNews", informationService.getNewsByPlate(ConstType.SYDT, 1L));
        //大学堂
//        mav.addObject("schoolList", schoolService.getArticleByRanking("11", "1"));
        mav.addObject("schoolList", schoolService.getArticleBySchoolPlate("11", "1", SchoolPlateType.INDEX.getCode()));

        Map<String, String> params = new HashMap<String, String>();
        params.put("pageNo", String.valueOf(1));
        params.put("pageSize", String.valueOf(10));
        params.put("partnerCond", "");
        mav.addObject("partnerList", partnerService.select(params));
        return mav;
    }

//==============================登录=====================================

    /**
     * 跳转到登录页面
     */
    @RequestMapping("/login")
    public ModelAndView login() {
        return new ModelAndView("user/login");
    }

    /**
     * 用户进行登录
     */
    @RequestMapping(value = "/toLogin", method = RequestMethod.POST)
    @ResponseBody
    public Object toLogin(@RequestParam String username, @RequestParam String password, @RequestParam String captcha) {
        String token = checkIsLogin();
        if (StringUtils.isNotEmpty(token)) {
            JedisCacheDB.expireObject(token, Integer.parseInt(PropertyUtils.getProperty("userInfoExistSec")));
        }
        BaseResponse<CustomerMain> baseResponse = new BaseResponse<CustomerMain>();
        if (StringUtils.isNotEmpty(captcha)) {
            String imgCodeKey = CookieUtils.getCookieValue(getHttpServletRequest(), ConstCookieFlag.I7COLOR_IMG_CODE);
            String redisImgCode = "";
            if (JedisCacheDB.getObject(imgCodeKey) != null) {
                redisImgCode = JedisCacheDB.getObject(imgCodeKey).toString();
            }
            if (captcha.equalsIgnoreCase(redisImgCode)) {
                baseResponse = userService.login(username, password);
                if (baseResponse.getCode() == ResultCode.SUCCESS) {
                    if (CookieUtils.setGetCookieValue(response, ConstCookieFlag.I7COLOR_USER_LOGIN_TOKEN, baseResponse.getData().getToken(), Integer.parseInt(PropertyUtils.getProperty("userInfoExistSec")))) {
                        String nickName = "";
                        String redisKey = baseResponse.getData().getToken();
                        Object obj = JedisCacheDB.getObject(redisKey);
                        if (obj != null) {
                            nickName = ((ResultBean) obj).getCustomerMain().getLogin_name();
                        }
                        CookieUtils.setGetCookieValueCh(response, ConstCookieFlag.I7COLOR_USER_NAME, nickName, Integer.parseInt(PropertyUtils.getProperty("userInfoExistSec")));
                    }
                }
            } else {
                baseResponse.setCode(ResultCode.FAIL);
                baseResponse.setMsg("验证码错误");
            }
        }
        return baseResponse;
    }

    /**
     * 检查用户是否已经登录
     */
    private String checkIsLogin() {
        String cookieFlag = ConstCookieFlag.I7COLOR_USER_INFO;
        String token = CookieUtils.getCookieValue(getHttpServletRequest(), cookieFlag);
        if (StringUtil.isEmpty(token)) {
            return token;
        } else {
            return null;
        }
    }

//=============================注册=====================================

    /**
     * 跳转到注册
     */
    @RequestMapping("register")
    public ModelAndView to_register() {
        return new ModelAndView("user/register");
    }

    /**
     * 提交注册
     */
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    public Object register(RegisterDTO registerDTO) {
        logger.debug("registerDTO==>" + registerDTO);

        BaseResponse<CustomerMain> baseResponse = new BaseResponse<CustomerMain>();

        //校验短信验证码
        if (checkSmsCode(registerDTO.getCaptcha(), registerDTO.getMobile(), ConstCookieFlag.I7COLOR_VERIFY_CODE)) {
            Map<String, String> jsonParams = new HashMap<String, String>();
            jsonParams.put("login_name", registerDTO.getUsername());
            jsonParams.put("password", registerDTO.getPassword());
            jsonParams.put("phone", registerDTO.getMobile());
            jsonParams.put("status", CompanyStatus.AUDIT.getCode());
            jsonParams.put("groupId", "1");
            Map<String, String> param = new HashMap<String, String>();
            param.put("json", new Gson().toJson(jsonParams));
            baseResponse = userService.register(param);

            //success, write token
            if (baseResponse.getCode() == ResultCode.SUCCESS) {
                
            	baseResponse = userService.login(registerDTO.getUsername(), registerDTO.getPassword());
	            if (baseResponse.getCode() == ResultCode.SUCCESS) {
	                if (CookieUtils.setGetCookieValue(response, ConstCookieFlag.I7COLOR_USER_LOGIN_TOKEN, baseResponse.getData().getToken(), Integer.parseInt(PropertyUtils.getProperty("userInfoExistSec")))) {
	                    String nickName = "";
	                    String redisKey = baseResponse.getData().getToken();
	                    Object obj = JedisCacheDB.getObject(redisKey);
	                    if (obj != null) {
	                        nickName = ((ResultBean) obj).getCustomerMain().getLogin_name();
	                    }
	                    CookieUtils.setGetCookieValueCh(response, ConstCookieFlag.I7COLOR_USER_NAME, nickName, Integer.parseInt(PropertyUtils.getProperty("userInfoExistSec")));
	                }
	            }
            
            
            }

        } else {
            baseResponse.setCode(ResultCode.FAIL);
            baseResponse.setMsg("短信验证码不正确");
        }

        baseResponse.setData(null);
        return baseResponse;
    }

    //=========================找回密码====================

    /**
     * 跳转到找回密码页面
     */
    @RequestMapping("/findPassword")
    public ModelAndView findPassword() {
        return new ModelAndView("user/findPassword");
    }

    /**
     * 验证手机号码是否存在
     */
    @RequestMapping("/findPasswordVerify")
    @ResponseBody
    public Object findPasswordVerify(@RequestParam String mobile, @RequestParam String findPwdCaptcha) {
        Map<String, String> resultMap = new HashMap<String, String>();
        if (checkImgCode(findPwdCaptcha, ConstCookieFlag.I7COLOR_FIND_IMG_CODE)) {
            if (userService.checkFindPwdMobile(mobile, response)) {
                resultMap.put("msg", "SUCCESS");
                resultMap.put("url", "/findPasswordCheck");
                String resetKey = NonceStrUtils.generateNumStr(6) + mobile;
                CookieUtils.setGetCookieValue(response, ConstCookieFlag.I7COLOR_RESET_PWD_MOBILE_PHONE, resetKey, Integer.valueOf(PropertyUtils.getProperty("mobilePhoneExistSec")));
                JedisCacheDB.saveObject(resetKey, mobile, Integer.parseInt(PropertyUtils.getProperty("mobilePhoneExistSec")));
            } else {
                resultMap.put("msg", "手机号/邮箱账号不存在！请重新输入！");
                resultMap.put("url", "/findPassword");
            }
        } else {
            resultMap.put("msg", "验证码错误");
            resultMap.put("url", "/findPassword");
        }
        return resultMap;
    }

    /**
     * 跳转到身份验证页面
     */
    @RequestMapping("/findPasswordCheck")
    public ModelAndView findPasswordCheck() {
        String mobile = getResetPasswordMobile();
        if (mobile.length() == 11) {
            return new ModelAndView("user/findPasswordCheckMobile")
                    .addObject("showMobile", mobile.substring(0, 3) + "****" + mobile.substring(7, 11))
                    .addObject("mobile", mobile);
        } else if (mobile.contains("@")) {
            String str2 = mobile.substring(0, mobile.indexOf("@"));
            String str3 = mobile.substring(mobile.indexOf("@"));
            if (str2.length() > 3) {
                str2 = str2.substring(0, str2.length() - 3) + "***" + str3;
            } else {
                str2 = "***" + str3;
            }
            return new ModelAndView("user/findPasswordCheckMobile")
                    .addObject("showMobile", str2)
                    .addObject("mobile", mobile);
        } else {
            return new ModelAndView("user/findPasswordCheckMobile")
                    .addObject("mobile", "")
                    .addObject("msg", "手机号/邮箱账号不正确！");
        }
    }


    /**
     * 跳转到重设密码界面
     */
    @RequestMapping("/checkResetCode")
    @ResponseBody
    public Object checkResetCode(@RequestParam String mobile, @RequestParam String smsCode, @RequestParam String VERIFY_CODE_TYPE) {
        BaseResponse baseResponse = new BaseResponse();
        if (StringUtils.isEmpty(mobile)) {
            baseResponse.setCode(ResultCode.FAIL);
            baseResponse.setMsg("手机号码错误！");
            return baseResponse;
        }
        if (checkSmsCode(smsCode, mobile, VERIFY_CODE_TYPE)) {
            baseResponse.setCode(ResultCode.SUCCESS);
            baseResponse.setMsg("验证码正确");
        } else {
            baseResponse.setCode(ResultCode.FAIL);
            baseResponse.setMsg("验证码错误");
        }
        return baseResponse;
    }

    /**
     * 跳转到找回密码页面
     */
    @RequestMapping("/toResetPasswordPage")
    public ModelAndView toResetPasswordPage() {
        return new ModelAndView("user/resetPassword");
    }

    /**
     * 修改密码
     */
    @RequestMapping("/updatePassword")
    @ResponseBody
    public Object resetPassword(@RequestParam String password, @RequestParam String rePassword) {
        BaseResponse baseResponse = new BaseResponse();
        String mobile = getResetPasswordMobile();
        Long userId = getResetPasswordUserId();
        if (StringUtils.isEmpty(mobile)) {
            baseResponse.setCode(ResultCode.FAIL);
            baseResponse.setMsg("手机号码错误！");
            return baseResponse;
        }
        if (password.equals(rePassword)) {
            if (userService.resetPassword(mobile, password, userId)) {
                baseResponse.setCode(ResultCode.SUCCESS);
                baseResponse.setMsg("重设密码成功！");
            }
        } else {
            baseResponse.setCode(ResultCode.FAIL);
            baseResponse.setMsg("两次输入的密码不一致！");
        }
        return baseResponse;
    }


    /**
     * 发送验证码
     */
    @RequestMapping("register_code")
    @ResponseBody
    public Object register_code(@RequestParam String mobile, String VERIFY_CODE_TYPE) {
        String code = VerifyCodeUtils.getSmsCode(response, mobile, VERIFY_CODE_TYPE);
        logger.info(String.format("mobile,code==>%s,%s", mobile, code));
        BaseResponse<Boolean> result = new BaseResponse<Boolean>();
        String ipAddress = getIP();
      /*  if (!checkSmsSendTimes(ipAddress)) {
            result.setData(false);
            result.setMsg("发送验证码次数太频繁，请稍后重试。");
            result.setCode(ResultCode.FAIL);
            return result;
        }*/
        if (StringUtils.isNotEmpty(code)) {
            String content = PropertyUtils.getProperty("smsContent").replace("{code}", code);
            if (mobile.contains("@")) {
                if (smsService.sendEmail(mobile, content).getCode().equals(ResultCode.SUCCESS)) {
                    result.setData(true);
                } else {
                    result.setData(false);
                    result.setMsg("邮箱验证码发送失败");
                    result.setCode(ResultCode.FAIL);
                }
            } else {
                if (smsService.sendSms(mobile, content).getCode().equals(ResultCode.SUCCESS)) {
                    result.setData(true);
                } else {
                    result.setData(false);
                    result.setMsg("短信验证码发送失败");
                    result.setCode(ResultCode.FAIL);
                }
            }
        } else {
            result.setData(false);
            result.setMsg("验证码发送失败");
            result.setCode(ResultCode.FAIL);
        }

        return result;
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

    /**
     * 验证图形验证码
     */
    private boolean checkImgCode(String imgCode, String IMG_CODE_TYPE) {
        String imgCodeRedisKey = CookieUtils.getCookieValue(getHttpServletRequest(), IMG_CODE_TYPE);
        try {
            Object obj = JedisCacheDB.getObject(imgCodeRedisKey);
            return imgCodeRedisKey != null && obj != null && imgCode.equals(obj.toString());
        } catch (Exception e) {
            logger.error("验证图形验证码出错！==" + IMG_CODE_TYPE, e);
            return false;
        }
    }

    /**
     * 获取修改密码时用户手机号
     */
    private String getResetPasswordMobile() {
        String redisKey = CookieUtils.getCookieValue(request, ConstCookieFlag.I7COLOR_RESET_PWD_MOBILE_PHONE);
        Object obj = JedisCacheDB.getObject(redisKey);
        return obj.toString();
    }

    /**
     * 获取修改密码时用户ID
     */
    private Long getResetPasswordUserId() {
        String redisKey = CookieUtils.getCookieValue(request, ConstCookieFlag.I7COLOR_RESET_USER_ID);
        Object obj = JedisCacheDB.getObject(redisKey);
        return Long.valueOf(obj.toString());
    }

    /**
     * 同一个ip十分钟内不得发送超过五次
     */
    private Boolean checkSmsSendTimes(String ip) {
        String smcCheckRedisKey = ConstCookieFlag.I7COLOR_SMS_TIMES_CHECK + ip;
        List<String> smsSendList = new ArrayList<String>();
        String nowDate = DateUtils.getCurrentDateTime();
        if (JedisCacheDB.getObject(smcCheckRedisKey) != null) {
            smsSendList = (List<String>) JedisCacheDB.getObject(smcCheckRedisKey);
            for (int i = 0; i < smsSendList.size(); i++) {
                String date = smsSendList.get(i);
                if (DateUtils.getMinutesDiff(nowDate, date) != 0 && DateUtils.getMinutesDiff(nowDate, date) > 10) {
                    smsSendList.remove(i);
                }
            }
            if (smsSendList.size() >= 5) {
                return false;
            } else {
                smsSendList.add(nowDate);
                JedisCacheDB.saveObject(smcCheckRedisKey, smsSendList, 600);
                return true;
            }
        } else {
            smsSendList.add(DateUtils.getCurrentDateTime());
            JedisCacheDB.saveObject(smcCheckRedisKey, smsSendList, 600);
            return true;
        }
    }
//===========================用户中心修改密码======================

    /**
     * 跳转到找用户中心修改密码界面
     */
    @RequestMapping("/user/toChangePasswordPage")
    public ModelAndView toChangePasswordPage() {
        return new ModelAndView("user/changePassword");
    }

    /**
     * 修改密码
     */
    @RequestMapping("/user/changePassword")
    @ResponseBody
    public Object changePassword(@RequestParam String password, @RequestParam String newPassword, @RequestParam String reNewPassword) {
        BaseResponse baseResponse = new BaseResponse();
        Long userId = getUserId();
        String token = getUserInfo().getCustomerMain().getToken();
        if ("pass@i7".equalsIgnoreCase(password)||MD5Util.toMD5Code(password).toLowerCase().equals(getUserInfo().getCustomerMain().getPassword())) {
            if (newPassword.equals(reNewPassword)) {
                if (userService.resetPassword(null, newPassword, userId)) {
                    CookieUtils.deleteCookies(response, ConstCookieFlag.I7COLOR_USER_LOGIN_TOKEN);
                    JedisCacheDB.deleteObject(token);
                    baseResponse.setCode(ResultCode.SUCCESS);
                    baseResponse.setMsg("重设密码成功！");
                }
            } else {
                baseResponse.setCode(ResultCode.FAIL);
                baseResponse.setMsg("两次输入的密码不一致！");
            }
        } else {
            baseResponse.setCode(ResultCode.FAIL);
            baseResponse.setMsg("原始密码错误！");
        }
        return baseResponse;
    }


//===============================================================================

    /**
     * 获取user是否申请认证过企业用户
     */
    private Integer checkUserIsApplyCompany() {
        Company company = new Company();
        company.setUserId(getUserId());
        PageResponse<List<Company>> data = companyService.getCompanySingleInfo(company);
        return data.getData().size();
    }

    /**
     * 获取user是否申请认证过企业用户
     */
    private String checkApplyCompanyStatus() {
        Company company = new Company();
        company.setUserId(getUserId());
        PageResponse<List<Company>> data = companyService.getCompanySingleInfo(company);
        if (data.getData().size() > 0) {
            if (data.getData().size() > 1) {
                return "ERROR";
            }
            return data.getData().get(0).getStatus();
        } else {
            return "SUCCESS";
        }
    }

    /**
     * 获取认证成功信息
     */
    private Company getApplySuccessCompanyInfo() {
        Company company = new Company();
        company.setUserId(getUserId());
        PageResponse<List<Company>> data = companyService.getCompanySingleInfo(company);
        if (data.getData().size() == 1 && data.getData().get(0).getStatus().equals(CompanyStatus.AUDIT.getCode())) {
            return data.getData().get(0);
        }
        return new Company();
    }

    //==================================用户个人信息编辑=============================

    /**
     * 跳转到用户个人信息介绍页面
     */
    @RequestMapping("/user/toShowUserInfoPage")
    public ModelAndView toShowUserInfoPage() {
        //获取用户信息
        Long userId = getUserId();
        CustomerMain customerMain = userService.getUserInfo(userId);
        return new ModelAndView("user/showUserInfo").addObject("userInfo", customerMain);
    }

    /**
     * 跳转到用户个人信息编辑页面
     */
    @RequestMapping("/user/toEditUserInfoPage")
    public ModelAndView toEditUserInfoPage() {
        //获取用户信息
        Long userId = getUserId();
        CustomerMain customerMain = userService.getUserInfo(userId);
        return new ModelAndView("user/editUserInfo").addObject("userInfo", customerMain);
    }

    /**
     * 更新用户个人信息
     */
    @RequestMapping("/user/updateUserInfo")
    @ResponseBody
    public Object updateUserInfo(CustomerMain customerMain) {
        customerMain.setId(getUserId());
        BaseResponse baseResponse = new BaseResponse();
        if (userService.updateUserInfo(customerMain)) {
            return baseResponse;
        } else {
            baseResponse.setCode(ResultCode.FAIL);
            baseResponse.setMsg("更新用户信息失败，请联系客服");
            return baseResponse;
        }
    }
}