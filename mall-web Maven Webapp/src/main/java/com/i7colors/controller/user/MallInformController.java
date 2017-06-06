package com.i7colors.controller.user;

import com.google.gson.Gson;
import com.i7colors.bean.info.MallInform;
import com.i7colors.bean.info.News;
import com.i7colors.controller.BaseController;
import com.i7colors.domain.BaseResponse;
import com.i7colors.domain.PageResponse;
import com.i7colors.util.PropertyUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

/**
 * Created by Max on 2016/12/9.
 */
@Controller
public class MallInformController extends BaseController{
    private static final String mallPageSize = PropertyUtils.getProperty("mallInformPageSize");

    //跳转到商城通知列表页
    @RequestMapping("/mallInform")
    public ModelAndView toMallInformPage(@RequestParam(defaultValue="1") Integer beginPage) {
        Map<String,String> pageMap = new HashMap<String, String>();
        pageMap.put("beginPage",String.valueOf(beginPage));
        pageMap.put("pageSize",mallPageSize);
        pageMap.put("userId",String.valueOf(getUserId()));
        PageResponse<List<MallInform>> pageResponse =  mallInformService.getMallInformList(pageMap);
        return new ModelAndView("user/inform/informList").addObject("informList",pageResponse);
    }

    //商城通知翻页 ajax
    @RequestMapping("/mallInformPage")
    @ResponseBody
    public Object getMallInformPage(@RequestParam(defaultValue="1") Integer beginPage) {
        Map<String,String> pageMap = new HashMap<String, String>();
        pageMap.put("beginPage",String.valueOf(beginPage));
        pageMap.put("pageSize",mallPageSize);
        pageMap.put("userId",String.valueOf(getUserId()));
        return mallInformService.getMallInformList(pageMap);
    }

    //跳转到商城通知列表页
    @RequestMapping("/mallInform/{id}")
    public ModelAndView toMallInformDetails(@PathVariable Long id) {
        Map<String,String> pageMap = new HashMap<String, String>();
        pageMap.put("id",String.valueOf(id));
        pageMap.put("userId",String.valueOf(getUserId()));
        BaseResponse<MallInform> baseResponse  =  mallInformService.getMallInformDetails(pageMap);
        return new ModelAndView("user/inform/informDetails").addObject("inform",baseResponse.getData());
    }

    //删除商城通知
    @RequestMapping("/deleteMallInformById")
    @ResponseBody
    public Object deleteMallInformById(@RequestParam Long id) {
        Map<String,String> pageMap = new HashMap<String, String>();
        List<Long> list = new ArrayList<Long>();
        list.add(id);
        pageMap.put("id",new Gson().toJson(list));
        pageMap.put("userId",String.valueOf(getUserId()));
        return mallInformService.deleteMallInformById(pageMap);
    }

    //删除商城通知--批量
    @RequestMapping("/deleteMallInform")
    @ResponseBody
    public Object deleteMallInform(String[] informCheck) {
        Map<String,String> pageMap = new HashMap<String, String>();
        List<Long> list =new ArrayList<Long>();
        for (int i =0;i< Arrays.asList(informCheck).size();i++){
            list.add(Long.parseLong(Arrays.asList(informCheck).get(i)));
        }
        pageMap.put("id",new Gson().toJson(list));
        pageMap.put("userId",String.valueOf(getUserId()));
        return mallInformService.deleteMallInform(pageMap);
    }

    //标记商城通知全部已读
    @RequestMapping("/readMallInform")
    @ResponseBody
    public Object readMallInform(String[] informCheck) {
        Map<String,String> pageMap = new HashMap<String, String>();
        List<Long> list =new ArrayList<Long>();
        for (int i =0;i< Arrays.asList(informCheck).size();i++){
            list.add(Long.parseLong(Arrays.asList(informCheck).get(i)));
        }
        pageMap.put("id",new Gson().toJson(list));
        pageMap.put("userId",String.valueOf(getUserId()));
        return mallInformService.readMallInform(pageMap);
    }
}
