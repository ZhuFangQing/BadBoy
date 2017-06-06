package com.i7colors.service.information;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.info.News;
import com.i7colors.bean.info.Region;
import com.i7colors.commons.constant.ConstUrl;
import com.i7colors.domain.BaseResponse;
import com.i7colors.domain.PageResponse;
import com.i7colors.remoteService.AbstractRemoteService;
import com.i7colors.remoteService.ResponseInvokeException;
import com.i7colors.util.DateUtils;
import com.i7colors.util.Logger;
import com.i7colors.util.PropertyUtils;
import org.springframework.stereotype.Service;

@Service
public class InformationService extends AbstractRemoteService{

	/**
	 * 返回新闻详情
	 * @return
	 */
	public News getNewsDetails(Map<String,String> pageMap){
		BaseResponse<News> data = new BaseResponse<News>();
		try {

			data = get(ConstUrl.INFO_DETAILS, pageMap, new TypeToken<BaseResponse<News>>(){}.getType());
		}catch (Exception e){
			Logger.error("", e);
		}

		return data.getData();
	}

	/**
	 * 返回新闻上一条和下一条
	 * @return
	 */
	public List<News> getNewsPrevAndNext(Map<String,String> pageMap){
		BaseResponse<List<News>> data = new BaseResponse<List<News>>();
		try {

			data = get(ConstUrl.INFO_DETAILS_PREV_AND_NEXT, pageMap, new TypeToken<BaseResponse<List<News>>>(){}.getType());
		}catch (Exception e){
			Logger.error("", e);
		}

		return data.getData();
	}

	
	/**
	 * 获取行业资讯信息
	 * @return
	 */
	public PageResponse<List<News>> getIndustryInformationService(Map<String,String> pageMap){
		String url = ConstUrl.INDUSTRY_INFORMATION_GET;
		PageResponse<List<News>> data = new PageResponse<List<News>>();
		try {
			data= get(url,pageMap,new TypeToken<PageResponse<List<News>>>(){}.getType());
			int totalCount = data.getTotalCount();
			int a = totalCount%Integer.parseInt(pageMap.get("pageSize"));
			int perPageNo = totalCount/Integer.parseInt(pageMap.get("pageSize"));
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
	 * 获取侧边栏资讯
	 * @return
	 */
	public List<News> getSideInformation(Map<String,String> pageMap){
		String url = ConstUrl.SIDE_INFORMATION_GET;
		PageResponse<List<News>> data = new PageResponse<List<News>>();
		try {
			data= get(url,pageMap,new TypeToken<PageResponse<List<News>>>(){}.getType());
		}catch (Exception e){
			Logger.error("",e);
		}
		return data.getData();
	}

	/**
	 * 获取热点资讯信息
	 * @return
	 */
	public List<Map<String,Object>> getHotInformationService(){
		List<Map<String,Object>> hotInformationList = new ArrayList<Map<String,Object>>();
		String url = ConstUrl.HOT_INFORMATION_GET;
		try {
			BaseResponse<List<Map<String,Object>>> data = get(url,null,new TypeToken<BaseResponse<List<Map<String,Object>>>>(){}.getType());
		}catch (Exception e){
			Logger.error("",e);
		}
		return hotInformationList;
	}

	/**
	 * 根据板块获取资讯
	 * @return
	 */
	public List<News> getNewsByPlate(Integer type, Long pageSize){
		PageResponse<List<News>> response = new PageResponse<List<News>>();
		Map<String, String> params = new HashMap<String, String>();
		params.put("type", String.valueOf(type));
		params.put("pageSize", String.valueOf(pageSize));

		try {
			response = get(ConstUrl.NEWS_BY_PLATE, params, new TypeToken<PageResponse<List<News>>>(){}.getType());
		}catch (Exception e){
			Logger.error("",e);
		}
		return response.getData();
	}

	/**
	 * 根据类型获取资讯
	 */
	public List<News>  getInformationByTypeService(int type,int num){
		Map<String,String> map = new HashMap<String, String>();
		map.put("type",String.valueOf(type));
		map.put("num",String.valueOf(num));
		try {
			BaseResponse<List<News>> data = get(ConstUrl.GET_INFORMATION_BY_TYPE,map,new TypeToken<BaseResponse<List<News>>>(){}.getType());
			return data.getData();
		} catch (ResponseInvokeException e) {
			Logger.error("",e);
			return null;
		}
	}

	/**
	 * 获取省
	 * @return
	 */
	public List<Region> getProvinceService(){
		try {
			BaseResponse<List<Region>> data = get(ConstUrl.GET_PROVINCE,null,new TypeToken<BaseResponse<List<Region>>>(){}.getType());
			return data.getData();
		} catch (ResponseInvokeException e) {
			Logger.error("",e);
			return null;
		}
	}
	/**
	 * 获取市
	 * @return
	 */
	public List<Region> getCityService(String provinceCode){
		Map<String,String> map = new HashMap<String,String>();
		map.put("provinceCode",provinceCode);
		try {
			BaseResponse<List<Region>> data = get(ConstUrl.GET_CITY,map,new TypeToken<BaseResponse<List<Region>>>(){}.getType());
			return data.getData();
		} catch (ResponseInvokeException e) {
			Logger.error("",e);
			return null;
		}
	}
	/**
	 * 获取区
	 * @return
	 */
	public List<Region> getAreaService(String cityCode){
		Map<String,String> map = new HashMap<String,String>();
		map.put("cityCode",cityCode);
		try {
			BaseResponse<List<Region>> data = get(ConstUrl.GET_AREA,map,new TypeToken<BaseResponse<List<Region>>>(){}.getType());
			return data.getData();
		} catch (ResponseInvokeException e) {
			Logger.error("",e);
			return null;
		}
	}



	public String getAppHost() {
		return PropertyUtils.getProperty("infoUrl");
	}
}
