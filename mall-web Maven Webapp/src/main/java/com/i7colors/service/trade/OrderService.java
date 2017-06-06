package com.i7colors.service.trade;

import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.trade.Inquiry;
import com.i7colors.bean.trade.ParentOrder;
import com.i7colors.commons.constant.ConstUrl;
import com.i7colors.domain.BaseResponse;
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
public class OrderService extends AbstractRemoteService{

    @Override
    public String getAppHost() {
        return PropertyUtils.getProperty("tradeAppServiceHost");
    }

    /**
     * 查询订单详情
     * @param params
     * @return
     */
    public ParentOrder getOrderDetails(Map<String, String> params){
        ParentOrder parentOrder = new ParentOrder();

        PageResponse<List<ParentOrder>> response = list(params);
        if(response.getCode() == ResultCode.SUCCESS && response.getData().size() > 0){
            parentOrder = response.getData().get(0);
        }

        return parentOrder;
    }

    /**
     * 查询订单列表
     * @param params
     * @return
     */
    public PageResponse<List<ParentOrder>> list(Map<String, String> params){
        PageResponse<List<ParentOrder>> response = new PageResponse<List<ParentOrder>>();
        try {
            response = get(ConstUrl.ORDER_LIST, params, new TypeToken<PageResponse<List<ParentOrder>>>(){}.getType());
        } catch (ResponseInvokeException e) {
            Logger.error(this, e);
        }

        return response;
    }


    /**
     * 创建支付
     * @param params
     * @return
     */
    public BaseResponse createPayment(Map<String, String> params){
        BaseResponse response = new BaseResponse();
        try {
            response = post(ConstUrl.PAYMENT_CREATE, params, new TypeToken<BaseResponse>(){}.getType());
        } catch (ResponseInvokeException e) {
            Logger.error(this, e);
        }

        return response;
    }


}
