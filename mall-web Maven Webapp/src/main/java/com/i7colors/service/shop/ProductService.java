package com.i7colors.service.shop;

import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.product.Product;
import com.i7colors.commons.constant.ConstUrl;
import com.i7colors.domain.BaseResponse;
import com.i7colors.domain.PageResponse;
import com.i7colors.remoteService.AbstractRemoteService;
import com.i7colors.util.Logger;
import com.i7colors.util.PropertyUtils;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProductService extends AbstractRemoteService{
	
	/**
	 * 获取商品
	 */
	public List<Product> getProductsList(String type,int num){
		String url =  ConstUrl.PRODUCT_INFO_GET;
		List<Product> productsList = new ArrayList<Product>();
		Map<String,String> productMap = new HashMap<String, String>();
		productMap.put("code", type);
		productMap.put("num", String.valueOf(num));
		try{
			BaseResponse<List<Product>> data = get(url,productMap,new TypeToken<BaseResponse<List<Product>>>(){}.getType());
			productsList = data.getData();
		}catch (Exception e){
			Logger.error("",e);
		}
		return productsList;
	}

	/**
	 * 获取商品列表
	 */
	public PageResponse<List<Product>> select(Map<String,String> productMap){
		String url =  ConstUrl.PRODUCT_LIST_GET;
		PageResponse<List<Product>> data = null;

		try{
			data = get(url,productMap,new TypeToken<PageResponse<List<Product>>>(){}.getType());
		}catch (Exception e){
			Logger.error("",e);
		}
		return data;
	}

	/**
	 * 获取推荐商品
	 */
	public List<Map<String,Object>> getRecommendProducts(){
		List<Map<String,Object>> productList = new ArrayList<Map<String,Object>>();
		Map<String,Object> product = new HashMap<String, Object>();
		for (int i = 0; i < 4; i++) {
			product = new HashMap<String, Object>();
			product.put("name", "推荐产品"+i);
			product.put("number", "推荐商品编号"+i);
			product.put("place", "推荐商品产地"+i);
			product.put("tradeNum", "推荐商品交易量100"+i);
			productList.add(product);
		}
		return productList;
	}

	/**
	 *获取单个商品详细信息
	 */
	public Product getProductDetail(String eid){
		Product product = new Product();
		String url = ConstUrl.PRODUCT_DETAIL_GET;
		Map<String,String> productMap = new HashMap<String, String>();
		productMap.put("parameter",eid);
		try{
			BaseResponse<Product> data = get(url,productMap,new TypeToken<BaseResponse<Product>>(){}.getType());
			product = data.getData();
		}catch (Exception e){
			Logger.error("",e);
		}
		return product;
	}

	public String getAppHost() {
		return PropertyUtils.getProperty("productUrl");
	}
}
