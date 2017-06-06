package com.i7colors.controller.user;

import com.google.gson.Gson;
import com.i7colors.bean.customer.Company;
import com.i7colors.bean.customer.CustomerMain;
import com.i7colors.bean.customer.ResultBean;
import com.i7colors.commons.constant.ConstType;
import com.i7colors.controller.BaseController;
import com.i7colors.domain.BaseResponse;
import com.i7colors.domain.PageResponse;
import com.i7colors.enums.CompanyStatus;
import com.i7colors.enums.ResultCode;
import com.i7colors.service.user.CompanyService;
import com.i7colors.util.FTPFileUploadUtils;
import com.i7colors.util.Logger;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.activation.MimetypesFileTypeMap;
import java.io.*;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Max on 2016/12/6.
 */
@Controller
@RequestMapping("/company")
public class CompanyController extends BaseController {
    /**
     * 跳转到企业认证页面
     */
    @RequestMapping(value = "/toReCertificationPage", method = RequestMethod.GET)
    public ModelAndView toReCertificationPage() {
        String status = checkApplyCompanyStatus();
        Company company = new Company();
        company.setStatus(status);
        company.setUserId(getUserId());
        PageResponse<List<Company>> data = companyService.getCompanySingleInfo(company);
        return new ModelAndView("/user/company/reCertificationPage").addObject("company", data.getData().get(0));
    }

    /**
     * 跳转到企业认证页面
     */
    @RequestMapping(value = "/toCertificationPage", method = RequestMethod.GET)
    public ModelAndView toCertificationPage() {
        ResultBean resultBean = getUserInfo();
        if (resultBean.getCustomerGroup() != null) {
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
        } else {
            return new ModelAndView("/");
        }
    }

    /**
     * 跳转到企业认证成功页面
     */
    @RequestMapping(value = "toSuccessCertificationPage", method = RequestMethod.GET)
    public ModelAndView toSuccessCertificationPage() {
        return new ModelAndView("/user/company/companyInfoPage").addObject("companyInfo", getApplySuccessCompanyInfo());
    }

    /**
     * 跳转到完善企业信息
     */
    @RequestMapping(value = "completeCompanyInfo", method = RequestMethod.GET)
    public ModelAndView completeCompanyInfo() {
        Company company = new Company();
        company.setCompanyId(getUserId());
        company.setStatus(CompanyStatus.AUDIT.getCode());
        company.setIsValid("1");
        List<Company> list = companyService.getCompanySingleInfo(company).getData();
        company = new Company();
        if (list.size() > 0) {
            company = list.get(0);
        }
        return new ModelAndView("/user/company/completeCompanyInfo").addObject("companyInfo", company);
    }

    /**
     * 重新编辑企业信息
     */
    @RequestMapping(value = "resetCompanyInfo", method = RequestMethod.POST)
    public
    @ResponseBody
    Object resetCompanyInfo(Company company) {
        company.setUserId(getUserId());
        BaseResponse<CustomerMain> baseResponse = new BaseResponse<CustomerMain>();
        company.setStatus(CompanyStatus.WAIT_AUDIT.getCode());
        CustomerMain customerMain = new CustomerMain();
        customerMain.setStatus(CompanyStatus.WAIT_AUDIT.getCode());
        customerMain.setId(company.getId());
        if (userService.updateUserInfo(customerMain)) {
            baseResponse = companyService.updateCompanyService(company);
        } else {
            baseResponse.setMsg("系统异常");
            baseResponse.setCode(ResultCode.FAIL);
        }

        return baseResponse;
    }


    /**
     * 完善企业信息
     */
    @RequestMapping(value = "updateCompany", method = RequestMethod.POST)
    public
    @ResponseBody
    Object updateCompany(Company company) {
        company.setCompanyId(getUserId());
        BaseResponse<CustomerMain> baseResponse = new BaseResponse<CustomerMain>();
        if (getCompanyInfo().getId() != null) {
            baseResponse = companyService.updateCompanyService(company);
        } else {
            baseResponse.setCode(ResultCode.FAIL);
            baseResponse.setMsg("系统异常");
        }
        return baseResponse;
    }


    /**
     * 注册企业账号
     */
    @RequestMapping(value = "registerCompany", method = RequestMethod.POST)
    public
    @ResponseBody
    Object registerCompany(Company company,@RequestParam Integer codeType, @RequestParam String password, @RequestParam String rePassword) {
        BaseResponse<CustomerMain> baseResponse = new BaseResponse<CustomerMain>();
        if (checkUserIsApplyCompany() > 0) {
            baseResponse.setCode(ResultCode.FAIL);
            baseResponse.setMsg("您已经申请过企业认证!无法继续申请。");
            return baseResponse;
        }
        if (password.equals(rePassword)) {
            BaseResponse<CustomerMain> response = registerCompanyUserAccount(password, company.getCompanyName());
//            Long companyId = registerCompanyUserAccount(company.getPhone(), password, company.getCompanyName());
            if(codeType==2){//三证合一
                String codeImgUrl = company.getBusLicenceUrl();
                String code = company.getBusLicenceCode();
                company.setTaxUrl(codeImgUrl);
                company.setInstitutionUrl(codeImgUrl);
                company.setTaxCode(code);
                company.setInstitutionCode(code);
            }
            if (response.getCode() == ResultCode.SUCCESS) {
                company.setCompanyId(response.getData().getId());
                //需要获取到当前登录用户的UserId
                company.setUserId(getUserId());
                company.setStatus(CompanyStatus.WAIT_AUDIT.getCode());
                if (companyService.enterpriseCertificationService(company)) {
                    baseResponse.setCode(ResultCode.SUCCESS);
                    baseResponse.setMsg("申请成功");
                } else {
                    baseResponse.setCode(ResultCode.FAIL);
                    baseResponse.setMsg("申请失败!");
                }
            } else {
                baseResponse.setCode(ResultCode.FAIL);
                baseResponse.setMsg(response.getMsg());
            }
        } else {
            baseResponse.setCode(ResultCode.FAIL);
            baseResponse.setMsg("两次密码不一致!");
        }
        return baseResponse;
    }

    /**
     * 注册企业账号User账号
     */
    private BaseResponse<CustomerMain> registerCompanyUserAccount(String password, String username) {
        BaseResponse<CustomerMain> baseResponse = new BaseResponse<CustomerMain>();
        Map<String, String> jsonParams = new HashMap<String, String>();
        Map<String, String> param = new HashMap<String, String>();
        jsonParams.put("login_name", username);
        jsonParams.put("password", password);
        jsonParams.put("groupId", "2");
        jsonParams.put("status", CompanyStatus.WAIT_AUDIT.getCode());
        param.put("json", new Gson().toJson(jsonParams));
        /*baseResponse = userService.register(param);
        if (baseResponse.getCode() == ResultCode.SUCCESS) {
            return baseResponse.getData().getId();
        } else {
            return -1L;
        }*/

        return userService.register(param);
    }


    /**
     * ajax上传图片
     */
    @RequestMapping(value = "/uploadImage", method = RequestMethod.POST)
    public
    @ResponseBody
    Object enterpriseCertification(@RequestParam(value = "fileImg", required = false) MultipartFile file) {
        try {
            return FTPFileUploadUtils.uploadFile("company", file);
        } catch (Exception e) {
            Logger.error(this, "文件上传失败！", e);
        }
        return null;
    }

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
    //=================================企业查看企业认证信息==========================
    /**
     * 根据CompanyId获取企业信息
     */
    private Company getCompanyInfo() {
        Company company = new Company();
        company.setCompanyId(getUserId());
        PageResponse<List<Company>> data = companyService.getCompanySingleInfo(company);
        if (data.getData().size() == 1 && data.getData().get(0).getStatus().equals(CompanyStatus.AUDIT.getCode())) {
            return data.getData().get(0);
        }
        return new Company();
    }

    /**
     * 跳转到企业认证成功页面
     */
    @RequestMapping(value = "toCompanyInfoPage", method = RequestMethod.GET)
    public ModelAndView toCompanyInfoPage() {
        return new ModelAndView("/user/company/companyInfoPage").addObject("companyInfo", getCompanyInfo());
    }

    //===================================获取省市区==================================

    /**
     * 获取省
     */
    @RequestMapping(value = "/getProvince", method = RequestMethod.GET)
    public
    @ResponseBody
    Object getProvince() {
        try {
            return informationService.getProvinceService();
        } catch (Exception e) {
            Logger.error(this, "获取省失败！", e);
        }
        return null;
    }

    /**
     * 获取市
     */
    @RequestMapping(value = "/getCity", method = RequestMethod.GET)
    public
    @ResponseBody
    Object getCity(@RequestParam String provinceCode) {
        try {
            return informationService.getCityService(provinceCode);
        } catch (Exception e) {
            Logger.error(this, "获取市失败！", e);
        }
        return null;
    }

    /**
     * 获取区
     */
    @RequestMapping(value = "/getArea", method = RequestMethod.GET)
    public
    @ResponseBody
    Object getArea(@RequestParam String cityCode) {
        try {
            return informationService.getCityService(cityCode);
        } catch (Exception e) {
            Logger.error(this, "获取区失败！", e);
        }
        return null;
    }

}
