package com.i7colors.controller.trade;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.trade.*;
import com.i7colors.controller.BaseController;
import com.i7colors.domain.BaseResponse;
import com.i7colors.domain.PageResponse;
import com.i7colors.enums.BusinessType;
import com.i7colors.enums.OrderStatus;
import com.i7colors.enums.PayType;
import com.i7colors.enums.ResultCode;
import com.i7colors.util.Logger;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

/**
 * Created by Echos on 2016/12/6.
 */
@Controller
@RequestMapping("/orders")
public class OrderController extends BaseController {


    /**
     * 订单列表
     * @return
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public ModelAndView goList() {
        Logger.info(this, "查看订单列表" );
        return new ModelAndView("/shop/trade/list");
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    @ResponseBody
    public Object search(@RequestParam String payType, @RequestParam String filter, @RequestParam Integer pageNo, @RequestParam Integer pageSize){
        PageResponse<List<ParentOrder>> data = new PageResponse<List<ParentOrder>>();

        try{

            Map<String, String> params = new HashMap<String, String>();
            ParentOrder orderCond = new ParentOrder();
            orderCond.setCompanyId(getUserId());
            if(StringUtils.isNotEmpty(payType) && OrderStatus.checkByCode(payType)){

                orderCond.setStatus(payType);
            }
            params.put("queryCond", new Gson().toJson(orderCond, new TypeToken<ParentOrder>(){}.getType()));
//            params.put("textCond", filter);
            params.put("textCond", new String(filter.getBytes("iso-8859-1"), "UTF-8"));
            params.put("pageNo", String.valueOf(pageNo));
            params.put("pageSize", String.valueOf(pageSize));

            data = orderService.list(params);
        }catch (Exception e){
            Logger.error(this, e);
        }

        return data;
    }


    /**
     * 查看交易详情
     * @return
     */
    @RequestMapping(value = "/{orderNo}", method = RequestMethod.GET)
    public ModelAndView get(@PathVariable String orderNo) {
        Logger.info(this, "查看订单详情：" + orderNo);
        Map<String, String> params = new HashMap<String, String>();

        //订单
        ParentOrder orderCond = new ParentOrder();
        orderCond.setOrderNum(orderNo);
        orderCond.setCompanyId(getUserId());
        params.put("queryCond", new Gson().toJson(orderCond, new TypeToken<ParentOrder>(){}.getType()));
        ParentOrder order = orderService.getOrderDetails(params);
//        order.setPaymentType(StringUtils.isEmpty(order.getPaymentType()) ? "未支付" : PayType.valueOf(order.getPaymentType()).getDesc());

        return new ModelAndView("/shop/trade/details").addObject("order", order);
    }


    /**
     * 进入支付页面
     * @return
     */
    @RequestMapping(value = "/{orderNo}/payments", method = RequestMethod.GET)
    public ModelAndView payment(@PathVariable String orderNo) {
        Logger.info(this, "进入支付：" + orderNo);
        ModelAndView mav = new ModelAndView("/shop/trade/payment");


        Map<String, String> params = new HashMap<String, String>();
        params.put("pageNo", String.valueOf("1"));
        params.put("pageSize", String.valueOf("1"));

        //订单
        ParentOrder orderCond = new ParentOrder();
        orderCond.setOrderNum(orderNo);
        orderCond.setCompanyId(getUserId());
        orderCond.setStatus(OrderStatus.NOT_PAY.getCode());
        params.put("queryCond", new Gson().toJson(orderCond, new TypeToken<ParentOrder>(){}.getType()));
        ParentOrder order = orderService.getOrderDetails(params);

        if(null != order && order.getId() != null){

            //余额
            Balance balanceCond = new Balance();
            balanceCond.setCompanyId(getUserId());
            params.put("queryCond", new Gson().toJson(balanceCond, new TypeToken<Balance>(){}.getType()));
            Balance balance = balanceService.get(params);

            //信用额
            Credit creditCond = new Credit();
            creditCond.setCompanyId(getUserId());
            params.put("queryCond", new Gson().toJson(creditCond, new TypeToken<Credit>(){}.getType()));
            Credit credit = creditService.get(params);

            mav.addObject("order", order).addObject("balance", balance).addObject("credit", credit);
        }else{

            mav.addObject("msg", "订单不存在");
        }

        return mav;
    }

    @RequestMapping(value = "/{orderId}/pay", method = RequestMethod.POST)
    @ResponseBody
    public Object goPay(PaymentInfo paymentInfo, @PathVariable Long orderId){
        Logger.info(this, paymentInfo);

        BaseResponse baseResponse = new BaseResponse();
        if(null != paymentInfo){
            Map<String, String> params = new HashMap<String, String>();

            paymentInfo.setCompanyId(getUserId());
            paymentInfo.setBusinessType(BusinessType.NORMAL.getCode());
            params.put("parameter", new Gson().toJson(paymentInfo, new TypeToken<PaymentInfo>(){}.getType()));

            orderService.createPayment(params);
        }else{
            baseResponse.setCode(ResultCode.RECORD_IMPERFECT);
            baseResponse.setMsg(ResultCode.RECORD_IMPERFECT.getDesc());
        }

        return baseResponse;
    }


}
