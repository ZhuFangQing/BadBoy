package com.i7colors.service.user;

import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.info.MallInform;
import com.i7colors.bean.info.News;
import com.i7colors.commons.constant.ConstUrl;
import com.i7colors.domain.BaseResponse;
import com.i7colors.domain.PageResponse;
import com.i7colors.remoteService.AbstractRemoteService;
import com.i7colors.util.Logger;
import com.i7colors.util.PropertyUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by Max on 2016/12/9.
 */
@Service
public class MallInformService extends AbstractRemoteService {
    public PageResponse<List<MallInform>> getMallInformList(Map<String,String> pageMap){
        String url = ConstUrl.GET_MALL_INFORM_LIST;
        PageResponse<List<MallInform>> data = new PageResponse<List<MallInform>>();
        try {
            data= get(url,pageMap,new TypeToken<PageResponse<List<MallInform>>>(){}.getType());
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

    public BaseResponse<MallInform> getMallInformDetails(Map<String,String> pageMap){
        String url = ConstUrl.GET_MALL_INFORM_DETAILS;
        BaseResponse<MallInform> data = new BaseResponse<MallInform>();
        try {
            data= get(url,pageMap,new TypeToken<BaseResponse<MallInform>>(){}.getType());
        }catch (Exception e){
            Logger.error("",e);
        }
        return data;
    }

    /**
     * 删除商城通知
     */
    public BaseResponse deleteMallInformById(Map<String,String> pageMap){
        String url = ConstUrl.DELETE_MALL_INFORM_LIST;
        BaseResponse data = new BaseResponse();
        try {
            data= get(url,pageMap,new TypeToken<BaseResponse>(){}.getType());
        }catch (Exception e){
            Logger.error("",e);
        }
        return data;
    }

    /**
     * 批量删除商城通知
     */
    public BaseResponse deleteMallInform(Map<String,String> pageMap){
        String url = ConstUrl.DELETE_MALL_INFORM_LIST;
        BaseResponse data = new BaseResponse();
        try {
            data= get(url,pageMap,new TypeToken<BaseResponse>(){}.getType());
        }catch (Exception e){
            Logger.error("",e);
        }
        return data;
    }

    /**
     * 标记已读
     */
    public BaseResponse readMallInform(Map<String,String> pageMap){
        String url = ConstUrl.READED_MALL_INFORM_LIST;
        BaseResponse data = new BaseResponse();
        try {
            data= get(url,pageMap,new TypeToken<BaseResponse>(){}.getType());
        }catch (Exception e){
            Logger.error("",e);
        }
        return data;
    }

    public String getAppHost() {
        return PropertyUtils.getProperty("infoUrl");
    }
}
