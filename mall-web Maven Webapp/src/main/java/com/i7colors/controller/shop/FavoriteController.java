package com.i7colors.controller.shop;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.trade.ProductFavorite;
import com.i7colors.commons.dto.JSONResult;
import com.i7colors.controller.BaseController;
import com.i7colors.domain.BaseResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * Created by Echos on 2016/11/21.
 */
@Controller
@RequestMapping("/favorites")
public class FavoriteController extends BaseController{

    @RequestMapping(value = "/", method = RequestMethod.GET)
    @ResponseBody
    public List<ProductFavorite> getAll() {
        Map<String, String> params = new HashMap<String, String>();
        ProductFavorite productFavorite = new ProductFavorite();
        productFavorite.setCompanyId(getUserId());
        params.put("queryCond",new Gson().toJson(productFavorite));
        return favoriteService.getAll(params);
    }
    /**
     * 添加产品到收藏夹（可批量，id用逗号分隔）
     * @param ids
     * @return
     */
    @RequestMapping(value = "", method = RequestMethod.POST)
    @ResponseBody
    public Object addFavorite(@RequestParam("ids[]") Long[] ids) {
        Map<String, String> params = new HashMap<String, String>();
        if(null != ids){
            params.put("companyId", String.valueOf(getUserId()));
            params.put("productEidList", new Gson().toJson(Arrays.asList(ids), new TypeToken<List<Long>>(){}.getType()));
        }
        return favoriteService.add(params);
    }

    /**
     * 添加产品到收藏夹
     * @param ids
     * @return
     */
    @RequestMapping(value = "/ajaxAddFavorite", method = RequestMethod.POST)
    @ResponseBody
    public Object addFavorite(@RequestParam("productEid") Long ids) {
        Map<String, String> params = new HashMap<String, String>();
        List<Long> list = new ArrayList<Long>();
        list.add(ids);
        if(null != ids){
            params.put("companyId", String.valueOf(getUserId()));
            params.put("productEidList", new Gson().toJson(list, new TypeToken<List<Long>>(){}.getType()));
        }
        return favoriteService.add(params);
    }


    /**
     * 从收藏夹删除产品（可批量，id用逗号分隔）
     * @return
     */
    @RequestMapping(value = "", method = RequestMethod.DELETE)
    @ResponseBody
    public Object delete(@RequestParam("ids[]") Long[] ids) {
        Map<String, String> params = new HashMap<String, String>();
        params.put("companyId", String.valueOf(getUserId()));
        params.put("idList", new Gson().toJson(Arrays.asList(ids), new TypeToken<List<Long>>(){}.getType()));

        return favoriteService.delete(params);
    }
}
