package com.i7colors.controller.shop;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.product.Product;
import com.i7colors.commons.constant.ConstType;
import com.i7colors.controller.BaseController;
import com.i7colors.domain.PageResponse;
import com.i7colors.enums.ProductStatus;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/shop/product")
public class ProductController extends BaseController{
	private static final Logger logger=Logger.getLogger(ProductController.class);

	/**
	 * 查看商品详情
	 * @return
	 */
	@RequestMapping(value = "/{productEid}", method = RequestMethod.GET)
	public ModelAndView get(@PathVariable String productEid) {
		logger.info("productEid:" + productEid);
		ModelAndView mav = new ModelAndView("/shop/product/productDetail");
		Product product = productService.getProductDetail(productEid);
		mav.addObject("productDetail",product);
		mav.addObject("newCreateList",getNewCreateList(10));
		mav.addObject("topSalesList",getTopSalesList(10));
		//=============================广告====================================
		mav.addObject("adList", advertisementService.getAdInfoByCode(ConstType.PRODUCT_DETAIL_AD));
		return mav;
	}

	/**
	 * 筛选商品
	 * @return
	 */
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	@ResponseBody
	public Object search(@RequestParam Integer pageNo, @RequestParam Integer pageSize,
						 @RequestParam("prodCondJson") String prodCondJson,
						 @RequestParam("orderCond") String orderCond,
						 @RequestParam("classCondJson[]") Integer[] classCondJson,
						 @RequestParam("propCondJson[]") Integer[] propCondJson) {
//		logger.info("propIds: " + StringUtils.join(propIds, ","));

		Map<String, String> params = new HashMap<String, String>();
		params.put("pageNo", String.valueOf(pageNo));
		params.put("pageSize", String.valueOf(pageSize));

		Product product = new Gson().fromJson(prodCondJson, new TypeToken<Product>(){}.getType());
		if(product==null){
			product = new Product();
		}
//		if (StringUtils.isNotEmpty(product.getFullName())) {
//			try {
//				product.setFullName(new String(product.getFullName().getBytes("iso-8859-1"), "UTF-8"));
//			} catch (UnsupportedEncodingException e) {
//				e.printStackTrace();
//			}
//		}
		product.setStatus(ProductStatus.SHELVES.getCode());
		params.put("productCond", new Gson().toJson(product, new TypeToken<Product>(){}.getType()));
		params.put("orderCond", orderCond);
		params.put("classCond", new Gson().toJson(classCondJson));
		params.put("propCond", new Gson().toJson(propCondJson));

		logger.info("params==>" + params);

		PageResponse<List<Product>> data = productService.select(params);

		logger.info("data:" + data);

		return data;
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

	/**
	 * 查看热门商品
	 * @return
	 */
	@RequestMapping("/hot")
	public ModelAndView hot() {
		ModelAndView mav = new ModelAndView("products/product");
		return mav;
	}
	
	/**
	 * 查看推荐商品
	 * @return
	 */
	@RequestMapping("/recommend")
	public @ResponseBody String recommend() {
		String str = productService.getRecommendProducts().toString();
		return str;
	}
	
}
