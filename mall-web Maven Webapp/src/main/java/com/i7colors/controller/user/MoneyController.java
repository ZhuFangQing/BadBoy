package com.i7colors.controller.user;

import com.google.gson.Gson;
import com.i7colors.bean.info.MallInform;
import com.i7colors.bean.user.CashFlow;
import com.i7colors.bean.user.CompanyApply;
import com.i7colors.controller.BaseController;
import com.i7colors.domain.PageResponse;
import com.i7colors.enums.CompanyApplyType;
import com.i7colors.service.user.MoneyService;
import com.i7colors.service.user.SmsService;
import com.i7colors.util.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Max on 2016/12/15.
 */
@Controller
@RequestMapping("/money")
public class MoneyController extends BaseController {
    private static final String moneyPageSize = PropertyUtils.getProperty("mallMoneyPageSize");
    @Autowired

    private MoneyService moneyService;

    /**
     * 获取用户账户金额使用情况
     * @return
     */
    @RequestMapping("")
    public ModelAndView money() {
        return new ModelAndView("user/money/moneyInfo")
                .addObject("moneyInfo",moneyService.getMoneyInfoService(getUserId()));
    }

    /**
     * 获取现金流水信息
     */
    @RequestMapping("/getCashFlow")
    @ResponseBody
    public Object getCashFlow(@RequestParam(defaultValue="1") Integer beginPage) {
        Map<String,String> pageMap = new HashMap<String, String>();
        pageMap.put("beginPage",String.valueOf(beginPage));
        pageMap.put("pageSize",moneyPageSize);
        pageMap.put("userId",String.valueOf(getUserId()));
        return moneyService.getCashFlowService(pageMap);
    }

    /**
     * 获取信用额使用详情
     */
    @RequestMapping("/getCreditFlow")
    @ResponseBody
    public Object CreditFlow(@RequestParam(defaultValue="1") Integer beginPage) {
        Map<String,String> pageMap = new HashMap<String, String>();
        pageMap.put("beginPage",String.valueOf(beginPage));
        pageMap.put("pageSize",moneyPageSize);
        pageMap.put("userId",String.valueOf(getUserId()));
        return moneyService.getCreditFlowService(pageMap);
    }

    /**
     * 获取申请列表信息
     */
    @RequestMapping("/getApply")
    @ResponseBody
    public Object getApply(@RequestParam(defaultValue="1") Integer beginPage) {
        Map<String,String> pageMap = new HashMap<String, String>();
        pageMap.put("beginPage",String.valueOf(beginPage));
        pageMap.put("pageSize",moneyPageSize);
        pageMap.put("userId",String.valueOf(getUserId()));
        return moneyService.getApplyService(pageMap);
    }


    /**
     * 申请账期以及提额
     */
    @RequestMapping("/apply")
    @ResponseBody
    public Object Apply(CompanyApply companyApply) {
        Map<String,String> pageMap = new HashMap<String, String>();
        companyApply.setCompany_id(getUserId());
        companyApply.setCreated_by(getUserId());
        companyApply.setStatus(CompanyApplyType.APPLYING.getCode());
        pageMap.put("parameter",new Gson().toJson(companyApply));
        pageMap.put("userId",String.valueOf(getUserId()));
        return moneyService.applyService(pageMap);
    }

}

