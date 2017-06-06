package com.i7colors.service.shop;

import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.product.Product;
import com.i7colors.bean.product.ProductClassification;
import com.i7colors.bean.product.ProductPropType;
import com.i7colors.commons.constant.ConstUrl;
import com.i7colors.domain.BaseResponse;
import com.i7colors.remoteService.AbstractRemoteService;
import com.i7colors.util.Logger;
import com.i7colors.util.PropertyUtils;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
@Service
public class ShopService extends AbstractRemoteService {
	/**
	 * 获取商城首页菜单
	 * @return
	 * type 1:分类  2:属性
	 */
	public List<ProductClassification> getShopType(){
		//商城分类
		List<ProductClassification> menuList = new ArrayList<ProductClassification>();

		try{
			BaseResponse<List<ProductClassification>> data = get(ConstUrl.MALL_MENU_PROPERTY_GET,null,new TypeToken<BaseResponse<List<ProductClassification>>>(){}.getType());
			menuList = data.getData();
		}catch (Exception e){
			Logger.error("",e);
		}
		return menuList;
	}

	/**
	 * 获取商城首页菜单
	 * @return
	 * type 1:分类  2:属性
	 */
	public List<ProductPropType> getShopProp(){
		//商城分类
		List<ProductPropType> menuList = new ArrayList<ProductPropType>();
		try{
			BaseResponse<List<ProductPropType>> data = get(ConstUrl.MALL_MENU_TYPE_GET,null,new TypeToken<BaseResponse<List<ProductPropType>>>(){}.getType());
			menuList = data.getData();
		}catch (Exception e){
			Logger.error("",e);
		}
		return menuList;
	}

	public String getAppHost() {
		return PropertyUtils.getProperty("productUrl");
	}

}
