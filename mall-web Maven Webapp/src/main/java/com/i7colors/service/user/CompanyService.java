package com.i7colors.service.user;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.customer.Company;
import com.i7colors.commons.constant.ConstUrl;
import com.i7colors.domain.BaseResponse;
import com.i7colors.domain.PageResponse;
import com.i7colors.enums.ResultCode;
import com.i7colors.remoteService.AbstractRemoteService;
import com.i7colors.remoteService.ResponseInvokeException;
import com.i7colors.util.Logger;
import com.i7colors.util.PropertyUtils;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Max on 2016/12/6.
 */
@Service
public class CompanyService extends AbstractRemoteService{
    /**
     * 企业认证Service
     */
    public Boolean enterpriseCertificationService(Company company){
        String url = ConstUrl.CREATE_COMPANY_ACCOUNT;
        BaseResponse<Company> data = new BaseResponse<Company>();
        Map<String,String> map = new HashMap<String, String>();
        String parameter = new Gson().toJson(company);
        map.put("parameter",parameter);
        try {
            data = post(url,map,new TypeToken<BaseResponse<Company>>(){}.getType());
        } catch (ResponseInvokeException e) {
            Logger.error("",e);
        }
        return data.getCode().equals(ResultCode.SUCCESS);
    }

    /**
     * 完善企业信息Service
     */
    public BaseResponse updateCompanyService(Company company){
        String url = ConstUrl.UPDATE_COMPANY_ACCOUNT;
        BaseResponse<Company> data = new BaseResponse<Company>();
        Map<String,String> map = new HashMap<String, String>();
        String parameter = new Gson().toJson(company);
        map.put("parameter",parameter);
        try {
            data = post(url,map,new TypeToken<BaseResponse<Company>>(){}.getType());
        } catch (ResponseInvokeException e) {
            Logger.error("",e);
        }
        return data;
    }

    /**
     * 查询企业认证
     * @return
     */
    public PageResponse<List<Company>> getCompanySingleInfo(Company company){
        Map<String,String> map = new HashMap<String, String>();
        PageResponse<List<Company>> data = new PageResponse<List<Company>>();
        map.put("queryCond",new Gson().toJson(company));
        map.put("pageNo","");
        map.put("pageSize","");
        try {
            data = get(ConstUrl.SELECT_SINGLE_COMPANY_ACCOUNT,map,new TypeToken<PageResponse<List<Company>>>(){}.getType());
        } catch (ResponseInvokeException e) {
            Logger.error("",e);
            data.setCode(ResultCode.FAIL);
            data.setMsg("获取企业认证状态失败");
        }
        return data;
    }

    public String getAppHost() {
        return PropertyUtils.getProperty("cusUserUrl");
    }

}
