package com.i7colors.service.shop;

import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.trade.ProductFavorite;
import com.i7colors.commons.constant.ConstUrl;
import com.i7colors.domain.BaseResponse;
import com.i7colors.remoteService.AbstractRemoteService;
import com.i7colors.remoteService.ResponseInvokeException;
import com.i7colors.util.Logger;
import com.i7colors.util.PropertyUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by Echos on 2016/11/21.
 */
@Service
public class FavoriteService extends AbstractRemoteService{

    @Override
    public String getAppHost() {
        return PropertyUtils.getProperty("tradeAppServiceHost");
    }

    /**
     * 获取收藏夹所有产品
     * @return
     */
    public List<ProductFavorite> getAll(Map<String, String> params){
        Logger.info("获取收藏夹中全部商品");
        BaseResponse<List<ProductFavorite>> data = new BaseResponse<List<ProductFavorite>>();
        try {
            data = get(ConstUrl.PRODUCT_FAVORITE_LIST, params, new TypeToken<BaseResponse<List<ProductFavorite>>>(){}.getType());
        } catch (ResponseInvokeException e) {
            Logger.error(this, e);
        }
        return data.getData();
    }

    /**
     * 添加产品到收藏夹
     * @return
     */
    public BaseResponse add(Map<String, String> params){
        Logger.info(this, "添加到收藏夹：" + params);
        BaseResponse data = new BaseResponse();
        try {
            data = post(ConstUrl.PRODUCT_FAVORITE_MULTI_ADD, params, new TypeToken<BaseResponse>(){}.getType());
        } catch (ResponseInvokeException e) {
            Logger.error(this, e);
        }
        return data;
    }

    /**
     * 从收藏夹删除产品
     * @return
     */
    public BaseResponse delete(Map<String, String> params){
        Logger.info("从收藏夹删除：" + params);
        BaseResponse data = new BaseResponse();
        try {
            data = post(ConstUrl.PRODUCT_FAVORITE_MULTI_DELETE, params, new TypeToken<BaseResponse>(){}.getType());
        } catch (ResponseInvokeException e) {
            Logger.error(this, e);
        }
        return data;
    }
}
