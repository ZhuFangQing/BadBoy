package com.i7colors.controller.member;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.DictBean;
import com.i7colors.bean.info.MemberStyle;
import com.i7colors.bean.info.Partner;
import com.i7colors.bean.product.Product;
import com.i7colors.commons.constant.ConstType;
import com.i7colors.controller.BaseController;
import com.i7colors.domain.PageResponse;
import com.i7colors.service.member.MemberService;
import com.i7colors.util.Logger;
import com.i7colors.util.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Echos on 2016/11/30.
 */
@Controller
@RequestMapping("/member")
public class MemberController extends BaseController {
    @Autowired
    private MemberService memberService;
    private static final String memberPageSize = PropertyUtils.getProperty("memberListNum");
    /**
     * 跳转到会员风采页面
     * @return
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public ModelAndView getMemberList(@RequestParam(defaultValue="1") Integer beginPage, @RequestParam(defaultValue="0") String city){
        ModelAndView mav = new ModelAndView("/member/memberList");
        Map<String,String> pageMap = new HashMap<String,String>();
        pageMap.put("beginPage",String.valueOf(beginPage));
        pageMap.put("pageSize",memberPageSize);
        pageMap.put("city",city);
        PageResponse<List<MemberStyle>> memberList = memberService.getMemberList(pageMap);
        List<DictBean> memberClassList = memberService.getMemberClass();
        mav.addObject("memberClassList",memberClassList);
        mav.addObject("newCreateList",getNewCreateList(10));
        mav.addObject("topSalesList",getTopSalesList(10));
        mav.addObject("memberList",memberList);
        //=============================广告====================================
        mav.addObject("adList", advertisementService.getAdInfoByCode(ConstType.MEMBER_AD));
        return mav;
    }


    /**
     * 获取会员风采列表 ajax
     * @return
     */
    @RequestMapping(value = "getMemberListAjax")
    public @ResponseBody Object getMemberListAjax(@RequestParam(defaultValue="1") Integer beginPage, @RequestParam(defaultValue="0") String city){
        Map<String,String> pageMap = new HashMap<String,String>();
        pageMap.put("beginPage",String.valueOf(beginPage));
        pageMap.put("pageSize",memberPageSize);
        pageMap.put("city",city);
        return memberService.getMemberList(pageMap);
    }



    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public ModelAndView getDetails(@PathVariable Long id){
        Logger.info("id==>" + id);

        ModelAndView mav = new ModelAndView("/member/member_details");

        Map<String, String> params = new HashMap<String, String>();
        params.put("id", String.valueOf(id));

        MemberStyle memberStyle = memberService.getMemberDetails(params);
        mav.addObject("member", memberStyle);
        params = new HashMap<String, String>();
        params.put("pageNo", String.valueOf(1));
        params.put("pageSize", String.valueOf(10));
        params.put("partnerCond", "");
        List<Partner> partnerList = partnerService.select(params);
        mav.addObject("partnerList", partnerList);
        mav.addObject("newCreateList",getNewCreateList(10));
        mav.addObject("topSalesList",getTopSalesList(10));
        //=============================广告====================================
        mav.addObject("adList", advertisementService.getAdInfoByCode(ConstType.MEMBER_AD));
        return mav;
    }

    /**
     * 获取销量最好产品排名
     * @return
     */
    private List<Product> getTopSalesList(Integer size){
        Map<String,String> params = new HashMap<String, String>();
        params.put("pageNo", String.valueOf(1));
        params.put("pageSize", String.valueOf(size));
        params.put("productCond", "");

        Map<String,String> orderCond = new LinkedHashMap<String, String>();
        orderCond.put("trade_volume", "desc");
        params.put("orderCond", new Gson().toJson(orderCond, new TypeToken<Map<String, String>>(){}.getType()));

        params.put("classCond", "");
        params.put("propCond", "");
        return productService.select(params).getData();
    }

    /**
     * 获取新上架产品
     * @return
     */
    private List<Product> getNewCreateList(Integer size){
        Map<String, String> params = new HashMap<String, String>();
        params.put("pageNo", String.valueOf(1));
        params.put("pageSize", String.valueOf(size));
        params.put("productCond", "");

        Map<String,String> orderCond = new LinkedHashMap<String, String>();
        orderCond.put("created_at", "desc");
        params.put("orderCond", new Gson().toJson(orderCond, new TypeToken<Map<String, String>>(){}.getType()));

        params.put("classCond", "");
        params.put("propCond", "");
        return productService.select(params).getData();
    }
}
