package com.i7colors.service.member;

import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.info.Partner;
import com.i7colors.bean.product.Product;
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
 * Created by Echos on 2016/11/30.
 */
@Service
public class PartnerService extends AbstractRemoteService {


    /**
     * 获取合作伙伴
     * @return
     */
    public List<Partner> select(Map<String,String> productMap){
        String url =  ConstUrl.PARTNER_LIST;
        BaseResponse<List<Partner>> result = null;

        try{
            result = get(url,productMap,new TypeToken<BaseResponse<List<Partner>>>(){}.getType());
        }catch (Exception e){
            Logger.error("",e);
        }
        return result.getData();
    }



    public String getAppHost() {
        return PropertyUtils.getProperty("infoUrl");
    }
}
