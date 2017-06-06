package com.i7colors.service.member;

import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.DictBean;
import com.i7colors.bean.info.MemberStyle;
import com.i7colors.bean.info.News;
import com.i7colors.commons.constant.ConstUrl;
import com.i7colors.domain.BaseResponse;
import com.i7colors.domain.PageResponse;
import com.i7colors.remoteService.AbstractRemoteService;
import com.i7colors.service.information.InformationService;
import com.i7colors.util.Logger;
import com.i7colors.util.PropertyUtils;
import org.bouncycastle.jcajce.provider.symmetric.ARC4;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MemberService extends AbstractRemoteService{

	/**
	 * 获取会员风采详情
	 * @return
	 */
	public MemberStyle getMemberDetails(Map<String,String> productMap){
		String url =  ConstUrl.MEMBER_MEMBER_DETAILS;
		MemberStyle member = new MemberStyle();
		try{
			BaseResponse<MemberStyle> data = get(url,productMap,new TypeToken<BaseResponse<MemberStyle>>(){}.getType());
			member = data.getData();
		}catch (Exception e){
			Logger.error("",e);
		}
		return member;
	}

	/**
	 * 获取会员风采分类
	 * @return
	 */
	public List<DictBean> getMemberClass(){
		BaseResponse<List<DictBean>> data = new BaseResponse<List<DictBean>>();
		try {
			data= get(ConstUrl.MEMBER_CLASSIFICATION_GET,null,new TypeToken<BaseResponse<List<DictBean>>>(){}.getType());
		}catch (Exception e){
			Logger.error("",e);
		}
		return data.getData();
	}

	/**
	 * 获取会员风采列表
	 * @return
	 */
	public PageResponse<List<MemberStyle>> getMemberList(Map<String,String> pageMap){
		PageResponse<List<MemberStyle>> data = new PageResponse<List<MemberStyle>>();
		try {
			data= get(ConstUrl.MEMBER_LIST_GET,pageMap,new TypeToken<PageResponse<List<MemberStyle>>>(){}.getType());
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
	 * 获取客户会员以及推荐供应商
	 */
	public List<MemberStyle> getMembersAndSuppliers(int code){
		BaseResponse<List<MemberStyle>> data = new BaseResponse<List<MemberStyle>>();
		Map<String,String> pageMap = new HashMap<String, String>();
		pageMap.put("code",String.valueOf(code));
		try {
			data= get(ConstUrl.GET_MEMBERS_AND_SUPPLIERS,pageMap,new TypeToken<BaseResponse<List<MemberStyle>>>(){}.getType());
		}catch (Exception e){
			Logger.error("",e);
		}
		return data.getData();
	}

	public String getAppHost() {
		return PropertyUtils.getProperty("infoUrl");
	}
}
