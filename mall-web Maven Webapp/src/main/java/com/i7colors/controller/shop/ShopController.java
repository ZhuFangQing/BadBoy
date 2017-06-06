package com.i7colors.controller.shop;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.product.Product;
import com.i7colors.bean.product.ProductClassification;
import com.i7colors.bean.product.ProductPropType;
import com.i7colors.commons.constant.ConstType;
import com.i7colors.enums.ProductStatus;
import com.i7colors.service.shop.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.i7colors.controller.BaseController;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ShopController extends BaseController{
	
	
	/**
	 * 跳转到商城产品页面
	 * @return
	 */
	@RequestMapping("shop")
	public ModelAndView shop() {
		ModelAndView mav = new ModelAndView("shop/shop");
		//获取热卖商品
		mav.addObject("hotGoodsList",productService.getProductsList(ConstType.RM,0));
		//获取推荐商品
		mav.addObject("recommendGoodsList",productService.getProductsList(ConstType.TJ,0));
		//获取菜单
		mav.addObject("menuTypeList",shopService.getShopType());
		mav.addObject("menuPropertyList",shopService.getShopProp());
		mav.addObject("newCreateList",getNewCreateList(10));
		mav.addObject("topSalesList",getTopSalesList(10));
		//==============================客户会员以及推荐供应商=================================
		//客户会员
		mav.addObject("memberList", memberService.getMembersAndSuppliers(ConstType.RM_MEMBERS));
		//推荐供应商
		mav.addObject("suppliersList", memberService.getMembersAndSuppliers(ConstType.TJ_SUPPLIERS));
		//=============================广告====================================
		mav.addObject("adList", advertisementService.getAdInfoByCode(ConstType.SHOP_AD));
		return mav;
	}

	/**
	 *跳转到商品详情页
	 * @return
	 */
	@RequestMapping("productDetail")
	public ModelAndView productDetail(@RequestParam int eid){
		ModelAndView mav = new ModelAndView("/shop/product/productDetail");
		Product product = productService.getProductDetail(String.valueOf(eid));
		mav.addObject("productDetail",product);
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
		Product product = new Product();
		product.setStatus(ProductStatus.SHELVES.getCode());
		params.put("productCond", new Gson().toJson(product, new TypeToken<Product>(){}.getType()));

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
		Product product = new Product();
		product.setStatus(ProductStatus.SHELVES.getCode());
		params.put("productCond", new Gson().toJson(product, new TypeToken<Product>(){}.getType()));

		Map<String,String> orderCond = new LinkedHashMap<String, String>();
		orderCond.put("created_at", "desc");
		params.put("orderCond", new Gson().toJson(orderCond, new TypeToken<Map<String, String>>(){}.getType()));

		params.put("classCond", "");
		params.put("propCond", "");
		return productService.select(params).getData();
	}

	public static void main(String[] args) {
		ProductService productService = new ProductService();
		Product product = productService.getProductDetail("1898");
		Gson gson = new Gson();
		System.out.println(gson.toJson(product));
	}
}
