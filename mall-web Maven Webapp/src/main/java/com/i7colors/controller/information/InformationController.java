package com.i7colors.controller.information;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import javax.servlet.http.HttpServletRequest;

import com.google.gson.Gson;
import com.i7colors.bean.info.News;
import com.i7colors.commons.constant.ConstType;
import com.i7colors.domain.PageResponse;
import com.i7colors.util.PropertyUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import com.i7colors.controller.BaseController;
import com.i7colors.service.information.InformationService;

@Controller
@RequestMapping("/information")
public class InformationController extends BaseController{
	private static final Logger logger=Logger.getLogger(InformationController.class);
	private static final String pageSize = PropertyUtils.getProperty("pageSize");
	private static final String rightPageSize = PropertyUtils.getProperty("rightPageSize");


    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public ModelAndView get(@PathVariable Long id){
        ModelAndView mav = new ModelAndView("information/news_details");

        
        Map<String, String> params = new HashMap<String, String>();
        params.put("id", String.valueOf(id));

        News news = informationService.getNewsDetails(params);
        mav.addObject("news", news);
        //===========================获取侧边栏资讯====================================
		Map<String,String> pageMap = new HashMap<String, String>();
		pageMap.put("pageSize",rightPageSize);
		pageMap.put("newsPage",PropertyUtils.getProperty("sideNewsNum"));
		mav.addObject("sideInfoList", informationService.getSideInformation(pageMap));
		//=============================广告====================================
		mav.addObject("adList", advertisementService.getAdInfoByCode(ConstType.INFORMATION_DETAIL_AD));
		//============================================================================
        List<News> prevAndNext = informationService.getNewsPrevAndNext(params);
        if(prevAndNext.size() == 2){
        	mav.addObject("prev", prevAndNext.get(0));
        	mav.addObject("next", prevAndNext.get(1));
		}else{
			News tmp = prevAndNext.get(0);
			mav.addObject(tmp.getId() > news.getId() ? "next" : "prev", tmp);
		}

        return mav;
    }

	/**
	 * 跳转到行业资讯页面
	 * @return
	 */
	@RequestMapping("")
	public ModelAndView getIndustryInformation(@RequestParam(defaultValue="1") Integer beginPage,@RequestParam(defaultValue="0") Integer newsType){
		InformationService informationService = new InformationService();
		Map<String,String> pageMap = new HashMap<String, String>();
		pageMap.put("beginPage",String.valueOf(beginPage));
		pageMap.put("pageSize",pageSize);
		pageMap.put("newsType",String.valueOf(newsType));
		//获取资讯列表
		ModelAndView mav = new ModelAndView("information/industryInformation");
		PageResponse<List<News>> pageResponse =  informationService.getIndustryInformationService(pageMap);
//		获取侧边栏信息
		pageMap = new HashMap<String, String>();
		pageMap.put("pageSize",rightPageSize);
		pageMap.put("newsPage",PropertyUtils.getProperty("sideNewsNum"));
		mav.addObject("pageResponse", pageResponse);
		//侧边栏资讯
		mav.addObject("sideInfoList", informationService.getSideInformation(pageMap));
		//=============================广告====================================
		mav.addObject("adList", advertisementService.getAdInfoByCode(ConstType.INFORMATION_AD));
		return mav;
	}

	/**
	 * 跳转到行业资讯页面  ajax
	 * @return
	 */
	@RequestMapping("getIndustryInformation")
	public @ResponseBody Object getIndustryInformationByPage(@RequestParam(defaultValue="1") Integer beginPage,@RequestParam(defaultValue="0") Integer newsType){
		InformationService informationService = new InformationService();
		Map<String,String> pageMap = new HashMap<String, String>();
		pageMap.put("beginPage",String.valueOf(beginPage));
		pageMap.put("pageSize",pageSize);
		pageMap.put("newsType",String.valueOf(newsType));
		return informationService.getIndustryInformationService(pageMap);
	}



}
