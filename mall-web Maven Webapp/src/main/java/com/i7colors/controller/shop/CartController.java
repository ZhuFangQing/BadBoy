package com.i7colors.controller.shop;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.trade.*;
import com.i7colors.controller.BaseController;
import com.i7colors.domain.BaseResponse;
import com.i7colors.enums.InquiryStatus;
import com.i7colors.enums.InvoiceType;
import com.i7colors.util.BigDecimalUtil;
import com.i7colors.util.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.math.BigDecimal;
import java.util.*;

/**
 * Created by Echos on 2016/11/21.
 */

@Controller
@RequestMapping("/carts")
public class CartController extends BaseController{

    /**
     * 获取购物车中所有商品
     * @return
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    @ResponseBody
    public ModelAndView list() {
        Map<String, String> params = new HashMap<String, String>();
        Inquiry inquiry = new Inquiry();
        inquiry.setCompanyId(getUserId());
        inquiry.setStatusList(Arrays.asList(InquiryStatus.OFFER.getCode(), InquiryStatus.NOTOFFER.getCode()));
        params.put("queryCond", new Gson().toJson(inquiry));
        params.put("pageNo", "");
        params.put("pageSize", "");
        List<Inquiry> inquiryList = cartService.list(params);
        BigDecimalUtil.formart(inquiryList);
        List<ProductFavorite> favoriteList = favoriteService.getAll(params);
        return new ModelAndView("/shop/carts/carts").addObject("inquiryList", inquiryList).addObject("favoriteList", favoriteList);
    }

    /**
     * 删除购物车中指定商品
     * @param ids
     * @return
     */
    @RequestMapping(value = "", method = RequestMethod.DELETE)
    @ResponseBody
    public Object delete(@RequestParam("ids[]") Long[] ids) {
        Map<String, String> params = new HashMap<String, String>();
        params.put("companyId", String.valueOf(getUserId()));
        params.put("idList", new Gson().toJson(Arrays.asList(ids), new TypeToken<List<Long>>(){}.getType()));

        return cartService.delete(params);
    }

    /**
     * 获取购物车中商品数量
     * @return
     */
    @RequestMapping(value = "/count", method = RequestMethod.GET)
    @ResponseBody
    public Object count(){
        BaseResponse response = new BaseResponse();
        response.setData(0);

        Long userId = getUserId();

        if(null != userId && userId > 0){

            Map<String, String> params = new HashMap<String, String>();
            Inquiry inquiry = new Inquiry();
            inquiry.setCompanyId(userId);
            inquiry.setStatusList(Arrays.asList(InquiryStatus.OFFER.getCode(), InquiryStatus.NOTOFFER.getCode()));
            params.put("queryCond", new Gson().toJson(inquiry));
            params.put("pageNo", "");
            params.put("pageSize", "");
            List<Inquiry> list = cartService.list(params);
            response.setData(null == list ? 0 : list.size());
        }

        return response;
    }

    /**
     * 添加到询价
     * @return
     */
    @RequestMapping(value = "/addInquiry", method = RequestMethod.POST)
    @ResponseBody
    public Object addInquiry(@RequestParam("productEid") Long productEid, @RequestParam("inquriyNum") Double inquriyNum) {
        Map<String, String> params = new HashMap<String, String>();
        params.put("companyId", String.valueOf(getUserId()));
//        params.put("companyId",String.valueOf(companyId));
        params.put("productEid",String.valueOf(productEid));
        params.put("inquriyNum",String.valueOf(inquriyNum));
        return cartService.addInquiry(params);
    }

    /**
     * 获取购物车中所有商品 客服界面
     * @return
     */
    @RequestMapping(value = "/ajax/{inquiryId}", method = RequestMethod.GET)
    @ResponseBody
    public List<Inquiry> list2(@PathVariable Long inquiryId) {
        Map<String, String> params = new HashMap<String, String>();
        Inquiry inquiry = new Inquiry();
        if(inquiryId>0){
            inquiry.setId(inquiryId);
        }
        inquiry.setCompanyId(getUserId());
        inquiry.setStatus(InquiryStatus.NOTOFFER.getCode());
        params.put("queryCond", new Gson().toJson(inquiry));
        params.put("pageNo", "");
        params.put("pageSize", "");
        return cartService.list(params);
    }

    /**
     * 商品详情询价
     * @return
     */
    @RequestMapping(value = "/addShopInquiry", method = RequestMethod.POST)
    @ResponseBody
    public Object addShopInquiry(@RequestParam("productEid") Long productEid,@RequestParam("inquiryNum") Double inquiryNum) {
        Map<String, String> params = new HashMap<String, String>();
        params.put("companyId",String.valueOf(getUserId()));
        params.put("productEid",String.valueOf(productEid));
        params.put("inquriyNum",String.valueOf(inquiryNum));
        return cartService.addInquiry(params);
    }

    /**
     * 添加到购物车
     */
    @RequestMapping(value = "/addToShopCar", method = RequestMethod.POST)
    @ResponseBody
    public Object addToShopCar(@RequestParam("productEid") Long productEid,@RequestParam("inquiryNum") Integer inquiryNum) {
        Map<String, String> params = new HashMap<String, String>();
        params.put("companyId",String.valueOf(getUserId()));
        params.put("productEid",String.valueOf(productEid));
        params.put("inquriyNum",String.valueOf(inquiryNum));
        return cartService.addToShopInquiry(params);
    }

    /**
     * 更新购物车中某件商品的数量
     * @param id
     * @param num
     * @return
     */
    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    @ResponseBody
    public Object addNum(@PathVariable("id") Long id, @RequestParam Double num) {
        Map<String, String> params = new HashMap<String, String>();
        Inquiry inquiry = new Inquiry();
        inquiry.setId(id);
        inquiry.setCompanyId(getUserId());
        inquiry.setNum(BigDecimal.valueOf(num));

        params.put("inquiry", new Gson().toJson(inquiry, new TypeToken<Inquiry>(){}.getType()));
        BaseResponse data = cartService.updateProductNum(params);
        return data;
    }



    /**
     * 进入确认订单页面
     * @return
     */
    @RequestMapping(value = "/confirm", method = RequestMethod.POST)
    public ModelAndView confirm(@RequestParam Long[] inquiry) {
        if(getUserId()==null || getUserId()==0){
            return new ModelAndView("redirect:/login");
        }
        Logger.info(this, "确认订单：" + inquiry);
        Map<String, String> params = new HashMap<String, String>();
        Inquiry inquiry2 = new Inquiry();
        inquiry2.setCompanyId(getUserId());
        params.put("queryCond", new Gson().toJson(inquiry2));
        params.put("pageNo", "");
        params.put("pageSize", "");
        List<Inquiry> inquiryList = cartService.list(params);
        List<Inquiry> inquiryConfirmList = new ArrayList<Inquiry>();
        String msg = null;
        for (int i = 0;i<inquiryList.size();i++){
            if(Arrays.asList(inquiry).contains(inquiryList.get(i).getId())){
                if(inquiryList.get(i).getPrice()==null){
                    msg = "不能提交含有价格为空的商品";
                }
                inquiryConfirmList.add(inquiryList.get(i));
            }
        }
        return new ModelAndView("/shop/trade/confirm").addObject("inquiryConfirmList",inquiryConfirmList)
                .addObject("inquiry",new Gson().toJson(inquiry,new TypeToken<Long[]>(){}.getType()))
                .addObject("msg",msg);
    }

    /**
     * 提交订单
     */
    @RequestMapping(value = "/commitOrder", method = RequestMethod.POST)
    public @ResponseBody Object deleteDeliveryAddress(@RequestParam("inquiry[]") Long[] inquiry,@RequestParam Long receiptAddressId,@RequestParam Long invoiceInfoId){
        Map<String, String> params = new HashMap<String, String>();
        params.put("queryCond", "{\"companyId\":"+getUserId()+"}");
        params.put("pageNo", "");
        params.put("pageSize", "");
        List<Inquiry> inquiryList = cartService.list(params);
        List<OrderDetail> inquiryConfirmList = new ArrayList<OrderDetail>();
        for (Inquiry anInquiryList : inquiryList) {
            if (Arrays.asList(inquiry).contains(anInquiryList.getId())) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setProductEid(anInquiryList.getProductEid());
                orderDetail.setInquiryId(anInquiryList.getId());
                orderDetail.setProductNum(anInquiryList.getNum());
                orderDetail.setRealTotalPrice(anInquiryList.getPrice());
                orderDetail.setRealPrice(anInquiryList.getUnitPrice());
                inquiryConfirmList.add(orderDetail);
            }
        }
        return cartService.commitOrder(inquiryConfirmList,getUserId(),receiptAddressId,invoiceInfoId);
    }




    /**
     * 获取收货地址
     */
    @RequestMapping(value = "/getDeliveryAddress", method = RequestMethod.POST)
    public @ResponseBody Object getDeliveryAddress(){
        Long companyId = getUserId();
        return cartService.getDeliveryAddressService(companyId);
    }

    /**
     * 设置默认地址
     */
    @RequestMapping(value = "/setDefaultDeliveryAddress", method = RequestMethod.POST)
    public @ResponseBody Object setDefaultDeliveryAddress(@RequestParam Long id){
        Long companyId = getUserId();
        return cartService.setDefaultDeliveryAddressService(id,companyId);
    }

    /**
     * 新增收货地址
     */
    @RequestMapping(value = "/createDeliveryAddress", method = RequestMethod.POST)
    public @ResponseBody Object createDeliveryAddress(ReceiptAddress receiptAddress){
        Long companyId = getUserId();
        receiptAddress.setCompanyId(companyId);
        receiptAddress.setIsDefault("0");
        return cartService.createDeliveryAddressService(receiptAddress);
    }

    /**
     * 修改收货地址
     */
    @RequestMapping(value = "/updateDeliveryAddress", method = RequestMethod.POST)
    public @ResponseBody Object updateDeliveryAddress(ReceiptAddress receiptAddress){
        return cartService.updateDeliveryAddressService(receiptAddress);
    }
    /**
     * 删除收货地址
     */
    @RequestMapping(value = "/deleteDeliveryAddress", method = RequestMethod.POST)
    public @ResponseBody Object deleteDeliveryAddress(@RequestParam Long id){
        return cartService.deleteDeliveryAddressService(id);
    }




//================================发票信息================================
    /**
     * 查询发票信息
     */
    @RequestMapping(value = "/getInvoice", method = RequestMethod.POST)
    public @ResponseBody Object getInvoice(InvoiceInfo invoiceInfo){
        Long companyId = getUserId();
        invoiceInfo.setCompanyId(companyId);
        return cartService.queryInvoiceService(invoiceInfo);
    }

    /**
     * 添加发票信息
     */
    @RequestMapping(value = "/createInvoice", method = RequestMethod.POST)
    public @ResponseBody Object createInvoice(InvoiceInfo invoiceInfo){
        Long companyId = getUserId();
        invoiceInfo.setCompanyId(companyId);
        invoiceInfo.setIsDefault("0");
        if(invoiceInfo.getType().equals("NORMAL_INVOICE")){
            invoiceInfo.setType(InvoiceType.NORMAL_INVOICE.getCode());
        }else if(invoiceInfo.getType().equals("VALUE_INVOICE")){
            invoiceInfo.setType(InvoiceType.VALUE_INVOICE.getCode());
        }
        return cartService.createInvoiceService(invoiceInfo);
    }

    /**
     * 更新发票信息
     */
    @RequestMapping(value = "/updateInvoice", method = RequestMethod.POST)
    public @ResponseBody Object updateInvoice(InvoiceInfo invoiceInfo){
        Long companyId = getUserId();
        invoiceInfo.setCompanyId(companyId);
        if(invoiceInfo.getType().equals("NORMAL_INVOICE")){
            invoiceInfo.setType(InvoiceType.NORMAL_INVOICE.getCode());
        }else if(invoiceInfo.getType().equals("VALUE_INVOICE")){
            invoiceInfo.setType(InvoiceType.VALUE_INVOICE.getCode());
        }
        return cartService.updateInvoiceService(invoiceInfo);
    }

    /**
     * 设置默认发票信息
     */
    @RequestMapping(value = "/setDefaultInvoice", method = RequestMethod.POST)
    public @ResponseBody Object setDefaultInvoice(@RequestParam Long id){
        Long companyId = getUserId();
        return cartService.setDefaultInvoiceService(id,companyId);
    }

    /**
     * 删除发票信息
     */
    @RequestMapping(value = "/deleteInvoice", method = RequestMethod.POST)
    public @ResponseBody Object deleteInvoice(@RequestParam Long id){
        return cartService.deleteInvoiceService(id);
    }

}
