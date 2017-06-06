package com.i7colors.service.trade;

import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.trade.Balance;
import com.i7colors.bean.trade.Credit;
import com.i7colors.bean.trade.ParentOrder;
import com.i7colors.commons.constant.ConstUrl;
import com.i7colors.domain.PageResponse;
import com.i7colors.enums.ResultCode;
import com.i7colors.remoteService.AbstractRemoteService;
import com.i7colors.remoteService.ResponseInvokeException;
import com.i7colors.util.Logger;
import com.i7colors.util.PropertyUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by Echos on 2016/12/6.
 */
@Service
public class CreditService extends AbstractRemoteService {

    @Override
    public String getAppHost() {
        return PropertyUtils.getProperty("tradeAppServiceHost");
    }

    /**
     * 查询信用额详情
     * @param params
     * @return
     */
    public Credit get(Map<String, String> params){
        Credit credit = new Credit();

        PageResponse<List<Credit>> response = list(params);
        if(response.getCode() == ResultCode.SUCCESS && response.getData().size() > 0){
            credit = response.getData().get(0);
        }

        return credit;
    }

    /**
     * 查询信用额列表
     * @param params
     * @return
     */
    public PageResponse<List<Credit>> list(Map<String, String> params){
        PageResponse<List<Credit>> response = new PageResponse<List<Credit>>();
        try {
            response = get(ConstUrl.CREDIT_LIST, params, new TypeToken<PageResponse<List<Credit>>>(){}.getType());
        } catch (ResponseInvokeException e) {
            Logger.error(this, e);
        }

        return response;
    }
}
