package com.i7colors.service.shop;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.trade.Inquiry;
import com.i7colors.bean.trade.InvoiceInfo;
import com.i7colors.bean.trade.OrderDetail;
import com.i7colors.bean.trade.ReceiptAddress;
import com.i7colors.commons.constant.ConstUrl;
import com.i7colors.domain.BaseResponse;
import com.i7colors.domain.PageResponse;
import com.i7colors.enums.InvoiceType;
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
 * Created by Echos on 2016/11/22.
 */
@Service
public class CartService extends AbstractRemoteService{

    @Override
    public String getAppHost() {
        return PropertyUtils.getProperty("tradeAppServiceHost");
    }

    /**
     * 获取购物车所有商品
     * @return
     */
    public List<Inquiry> list(Map<String, String> params){
        PageResponse<List<Inquiry>> response = new PageResponse<List<Inquiry>>();
        try {
            response = get(ConstUrl.INQUIRY_LIST, params, new TypeToken<PageResponse<List<Inquiry>>>(){}.getType());
        } catch (ResponseInvokeException e) {
            Logger.error(this, e);
        }
        return response.getData();
    }
    /**
     * 获取购物车指定商品
     * @return
     */
    public String getByIds(String productIds){
        Logger.info("获取购物车中指定商品");
        return "";
    }
    /**
     * 删除购物车指定商品
     * @return
     */
    public BaseResponse delete(Map<String, String> params){
        Logger.info(this, "删除购物车中指定商品:" + params);

        BaseResponse response = new BaseResponse();
        try {
            response = post(ConstUrl.INQUIRY_MULTI_DELETE, params, new TypeToken<BaseResponse>(){}.getType());
        } catch (ResponseInvokeException e) {
            Logger.error(this, e);
        }

        return response;
    }
    /**
     * 更新购物车中某件商品的数量
     * @return
     */
    public BaseResponse updateProductNum(Map<String, String> params){
        Logger.info(String.format("更新商品：", params));

        BaseResponse response = new BaseResponse();
        try {
            response = post(ConstUrl.INQUIRY_UPDATE_NUM, params, new TypeToken<BaseResponse>(){}.getType());
        } catch (ResponseInvokeException e) {
            Logger.error(this, e);
        }

        return response;
    }

    /**
     * 添加到询价
     * @return
     */
    public Inquiry addInquiry(Map<String, String> params){
        Logger.info(String.format("添加到询价：", params));
        BaseResponse<Inquiry> response = new BaseResponse<Inquiry>();
        try {
            response = post(ConstUrl.INQUIRY_CREATE, params, new TypeToken<BaseResponse<Inquiry>>(){}.getType());
        } catch (ResponseInvokeException e) {
            Logger.error(this, e);
        }
        return response.getData();
    }

    /**
     * 添加到购物车
     * @return
     */
    public Inquiry addToShopInquiry(Map<String, String> params){
        Logger.info(String.format("添加到购物车：", params));
        BaseResponse<Inquiry> response = new BaseResponse<Inquiry>();
        try {
            response = post(ConstUrl.ADD_TO_SHOP_CREATE, params, new TypeToken<BaseResponse<Inquiry>>(){}.getType());
        } catch (ResponseInvokeException e) {
            Logger.error(this, e);
        }
        return response.getData();
    }
//===================================收货地址===============================================
    /**
     * 获取收货地址
     */
    public List<ReceiptAddress> getDeliveryAddressService(Long companyId){
        BaseResponse<List<ReceiptAddress>> data = new BaseResponse<List<ReceiptAddress>>();
        ReceiptAddress receiptAddress = new ReceiptAddress();
        receiptAddress.setCompanyId(companyId);
        Map<String,String> map = new HashMap<String, String>();
        map.put("queryCond",new Gson().toJson(receiptAddress));
        map.put("pageNo","");
        map.put("pageSize","");
        try{
            data = get(ConstUrl.GET_DELIVERY_ADDRESSS, map, new TypeToken<BaseResponse<List<ReceiptAddress>>>(){}.getType());
            System.out.println(data);
        }catch (Exception e){
            Logger.error("获取收货地址异常",e);
        }
        return data.getData();
    }

    /**
     * 设定默认地址
     */
    public BaseResponse setDefaultDeliveryAddressService(Long id,Long companyId){
        BaseResponse<List<ReceiptAddress>> data = new BaseResponse<List<ReceiptAddress>>();
        Map<String,String> map = new HashMap<String, String>();
        map.put("id",String.valueOf(id));
        map.put("companyId",String.valueOf(companyId));
        try{
            return post(ConstUrl.SET_DEFAULT_DELIVERY_ADDRESSS, map, new TypeToken<BaseResponse<List<ReceiptAddress>>>(){}.getType());
        }catch (Exception e){
            Logger.error("",e);
            data.setCode(ResultCode.FAIL);
            data.setMsg("设定默认地址异常!");
            return data;
        }
    }

    /**
     * 新增收货地址
     */
    public BaseResponse createDeliveryAddressService(ReceiptAddress receiptAddress){
        BaseResponse<List<ReceiptAddress>> data = new BaseResponse<List<ReceiptAddress>>();
        Map<String,String> map = new HashMap<String, String>();
        map.put("parameter",new Gson().toJson(receiptAddress));
        try{
            return post(ConstUrl.CREATE_DELIVERY_ADDRESSS, map, new TypeToken<BaseResponse<List<ReceiptAddress>>>(){}.getType());
        }catch (Exception e){
            Logger.error("",e);
            data.setCode(ResultCode.FAIL);
            data.setMsg("新增收货地址异常!");
            return data;
        }
    }

    /**
     * 修改收货地址
     */
    public BaseResponse updateDeliveryAddressService(ReceiptAddress receiptAddress){
        BaseResponse<List<ReceiptAddress>> data = new BaseResponse<List<ReceiptAddress>>();
        Map<String,String> map = new HashMap<String, String>();
        map.put("parameter",new Gson().toJson(receiptAddress));
        try{
            return post(ConstUrl.UPDATE_DELIVERY_ADDRESSS, map, new TypeToken<BaseResponse<List<ReceiptAddress>>>(){}.getType());
        }catch (Exception e){
            Logger.error("",e);
            data.setCode(ResultCode.FAIL);
            data.setMsg("修改收货地址!");
            return data;
        }
    }

    /**
     * 删除收货地址
     */
    public BaseResponse deleteDeliveryAddressService(Long id){
        BaseResponse<List<ReceiptAddress>> data = new BaseResponse<List<ReceiptAddress>>();
        Map<String,String> map = new HashMap<String, String>();
        map.put("id",String.valueOf(id));
        try{
            return post(ConstUrl.DELETE_DELIVERY_ADDRESSS, map, new TypeToken<BaseResponse<List<ReceiptAddress>>>(){}.getType());
        }catch (Exception e){
            Logger.error("",e);
            data.setCode(ResultCode.FAIL);
            data.setMsg("删除收货地址!");
            return data;
        }
    }
//===================================发票信息==================================
    /**
     * 获取发票信息
     */
    public List<InvoiceInfo> queryInvoiceService(InvoiceInfo invoiceInfo){
        BaseResponse<List<InvoiceInfo>> data = new BaseResponse<List<InvoiceInfo>>();
        Map<String,String> map = new HashMap<String, String>();
        map.put("queryCond",new Gson().toJson(invoiceInfo));
        map.put("pageNo","");
        map.put("pageSize","");
        try{
            data = get(ConstUrl.GET_INVOICE_INFO, map, new TypeToken<BaseResponse<List<InvoiceInfo>>>(){}.getType());
            for(int i = 0;i<data.getData().size();i++){
                if(data.getData().get(i).getType().equals(InvoiceType.VALUE_INVOICE.getCode())){
                    data.getData().get(i).setType(InvoiceType.VALUE_INVOICE.getDesc());
                }else if(data.getData().get(i).getType().equals(InvoiceType.NORMAL_INVOICE.getCode())){
                    data.getData().get(i).setType(InvoiceType.NORMAL_INVOICE.getDesc());
                }
            }
        }catch (Exception e){
            Logger.error("",e);
            data.setCode(ResultCode.FAIL);
            data.setMsg("获取发票信息异常!");
        }
        return data.getData();
    }

    /**
     * 新增发票信息
     */
    public BaseResponse createInvoiceService(InvoiceInfo invoiceInfo){
        BaseResponse data = new BaseResponse();
        Map<String,String> map = new HashMap<String, String>();
        map.put("parameter",new Gson().toJson(invoiceInfo));
        try{
            return post(ConstUrl.CREATE_INVOICE_INFO, map, new TypeToken<BaseResponse>(){}.getType());
        }catch (Exception e){
            Logger.error("",e);
            data.setCode(ResultCode.FAIL);
            data.setMsg("新增发票信息异常!");
            return data;
        }
    }

    /**
     * 更新发票信息
     */
    public BaseResponse updateInvoiceService(InvoiceInfo invoiceInfo){
        BaseResponse data = new BaseResponse();
        Map<String,String> map = new HashMap<String, String>();
        map.put("parameter",new Gson().toJson(invoiceInfo));
        try{
            return post(ConstUrl.UPDATE_INVOICE_INFO, map, new TypeToken<BaseResponse>(){}.getType());
        }catch (Exception e){
            Logger.error("",e);
            data.setCode(ResultCode.FAIL);
            data.setMsg("更新发票信息异常!");
            return data;
        }
    }

    /**
     * 设置默认发票信息
     */
    public BaseResponse setDefaultInvoiceService(Long id,Long companyId){
        BaseResponse data = new BaseResponse();
        Map<String,String> map = new HashMap<String, String>();
        map.put("id",String.valueOf(id));
        map.put("companyId",String.valueOf(companyId));
        try{
            return post(ConstUrl.SET_DEFAULT_INVOICE_INFO, map, new TypeToken<BaseResponse>(){}.getType());
        }catch (Exception e){
            Logger.error("",e);
            data.setCode(ResultCode.FAIL);
            data.setMsg("设置默认发票信息异常!");
            return data;
        }
    }
    /**
     * 删除发票信息
     */
    public BaseResponse deleteInvoiceService(Long id){
        BaseResponse data = new BaseResponse();
        Map<String,String> map = new HashMap<String, String>();
        map.put("id",String.valueOf(id));
        try{
            return post(ConstUrl.DELETE_INVOICE_INFO, map, new TypeToken<BaseResponse>(){}.getType());
        }catch (Exception e){
            Logger.error("",e);
            data.setCode(ResultCode.FAIL);
            data.setMsg("删除发票信息异常!");
            return data;
        }
    }
    //=============================提交订单======================================
    /**
     * 提交订单信息
     */
    public BaseResponse<String> commitOrder(List<OrderDetail> list ,Long companyId,Long receiptAddressId,Long invoiceInfoId){
        BaseResponse<String> data = new BaseResponse<String>();
        Map<String,String> map = new HashMap<String, String>();
        map.put("orderDetails",new Gson().toJson(list));
        map.put("companyId",String.valueOf(companyId));
        map.put("receiptAddressId",String.valueOf(receiptAddressId));
        map.put("invoiceInfoId",String.valueOf(invoiceInfoId));
        try{
            return post(ConstUrl.COMMIT_CARTS_ORDER, map, new TypeToken<BaseResponse<String>>(){}.getType());
        }catch (Exception e){
            Logger.error("",e);
            data.setCode(ResultCode.FAIL);
            data.setMsg("提交订单信息异常!");
            return data;
        }
    }
}
