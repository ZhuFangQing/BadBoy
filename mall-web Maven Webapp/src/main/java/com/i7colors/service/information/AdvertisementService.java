package com.i7colors.service.information;

import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.info.AdInfo;
import com.i7colors.bean.info.News;
import com.i7colors.commons.constant.ConstUrl;
import com.i7colors.domain.BaseResponse;
import com.i7colors.remoteService.AbstractRemoteService;
import com.i7colors.util.Logger;
import com.i7colors.util.PropertyUtils;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Max on 2016/12/2.
 */
@Service
public class AdvertisementService extends AbstractRemoteService {
    /**
     * 获取广告
     */
    public List<AdInfo> getAdInfoByCode(String code){
        BaseResponse<List<AdInfo>> data = new BaseResponse<List<AdInfo>>();
        Map<String,String> adMap = new HashMap<String, String>();
        adMap.put("plateCode",code);
        try {
            data = get(ConstUrl.AD_INFOLIST_GET, adMap, new TypeToken<BaseResponse<List<AdInfo>>>(){}.getType());
        }catch (Exception e){
            Logger.error("", e);
        }
        return data.getData();
    }
    public String getAppHost() {
        return PropertyUtils.getProperty("infoUrl");
    }

}
