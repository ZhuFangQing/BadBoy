package com.i7colors.service.user;

import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.info.MallInform;
import com.i7colors.bean.trade.CreditFlow;
import com.i7colors.bean.user.CashFlow;
import com.i7colors.bean.user.CompanyApply;
import com.i7colors.bean.user.UserBalanceInfo;
import com.i7colors.commons.constant.ConstUrl;
import com.i7colors.domain.BaseResponse;
import com.i7colors.domain.PageResponse;
import com.i7colors.enums.CompanyApplyType;
import com.i7colors.remoteService.AbstractRemoteService;
import com.i7colors.util.Logger;
import com.i7colors.util.PropertyUtils;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Max on 2016/12/15.
 */
@Service
public class MoneyService extends AbstractRemoteService {
    public UserBalanceInfo getMoneyInfoService(Long userId){
        Map<String,String> map = new HashMap<String,String>();
        map.put("userId",String.valueOf(userId));
        BaseResponse<UserBalanceInfo> data = new BaseResponse<UserBalanceInfo>();
        try {
            data= post(ConstUrl.GET_USER_MONEY_INFO,map,new TypeToken<BaseResponse<UserBalanceInfo>>(){}.getType());
        }catch (Exception e){
            Logger.error("",e);
        }
        return data.getData();
    }

    /**
     * 获取现金流水信息
     * @param map
     * @return
     */
    public PageResponse<List<CashFlow>> getCashFlowService(Map<String,String> map){
        PageResponse<List<CashFlow>> data = new PageResponse<List<CashFlow>>();
        try {
            data= post(ConstUrl.GET_USER_CASH_FLOW,map,new TypeToken<PageResponse<List<CashFlow>>>(){}.getType());
            int totalCount = data.getTotalCount();
            int a = totalCount%Integer.parseInt(map.get("pageSize"));
            int perPageNo = totalCount/Integer.parseInt(map.get("pageSize"));
            if(a!=0){
                perPageNo = perPageNo+1;
            }
            data.setPerPageNo(perPageNo);
        }catch (Exception e){
            Logger.error("",e);
        }

        return data;
    }

    /**
     * 获取信用额度使用列表
     * @param map
     * @return
     */
    public PageResponse<List<CreditFlow>> getCreditFlowService(Map<String,String> map){
        PageResponse<List<CreditFlow>> data = new PageResponse<List<CreditFlow>>();
        try {
            data= post(ConstUrl.GET_USER_CREDIT_FLOW,map,new TypeToken<PageResponse<List<CreditFlow>>>(){}.getType());
            int totalCount = data.getTotalCount();
            int a = totalCount%Integer.parseInt(map.get("pageSize"));
            int perPageNo = totalCount/Integer.parseInt(map.get("pageSize"));
            if(a!=0){
                perPageNo = perPageNo+1;
            }
            data.setPerPageNo(perPageNo);
        }catch (Exception e){
            Logger.error("",e);
        }
        return data;
    }

    /**
     * 获取申请List
     * @param map
     * @return
     */
    public PageResponse<List<CompanyApply>> getApplyService(Map<String,String> map){
        PageResponse<List<CompanyApply>> data = new PageResponse<List<CompanyApply>>();
        try {
            data= post(ConstUrl.GET_APPLY_LIST,map,new TypeToken<PageResponse<List<CompanyApply>>>(){}.getType());
            int totalCount = data.getTotalCount();
            int a = totalCount%Integer.parseInt(map.get("pageSize"));
            int perPageNo = totalCount/Integer.parseInt(map.get("pageSize"));
            if(a!=0){
                perPageNo = perPageNo+1;
            }
            data.setPerPageNo(perPageNo);
            for(int i =0;i<data.getData().size();i++){
                data.getData().get(i).setStatus(CompanyApplyType.valueOf(data.getData().get(i).getStatus()).getDesc());
                data.getData().get(i).setType(CompanyApplyType.valueOf(data.getData().get(i).getType()).getDesc());
            }

        }catch (Exception e){
            Logger.error("",e);
        }
        return data;
    }


    /**
     * 申请提额以及延长账期
     * @param map
     * @return
     */
    public BaseResponse applyService(Map<String,String> map){
        BaseResponse data = new BaseResponse();
        try {
            data= post(ConstUrl.APPLY_USER_MONEY,map,new TypeToken<BaseResponse>(){}.getType());
        }catch (Exception e){
            Logger.error("",e);
        }
        return data;
    }
    public String getAppHost() {
        return PropertyUtils.getProperty("tradeAppServiceHost");
    }
}
