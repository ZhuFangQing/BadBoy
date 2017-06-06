package com.i7colors.service.school;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.info.MemberStyle;
import com.i7colors.bean.school.*;
import com.i7colors.bean.trade.ProductFavorite;
import com.i7colors.commons.constant.ConstUrl;
import com.i7colors.domain.BaseResponse;
import com.i7colors.domain.PageResponse;
import com.i7colors.enums.ResultCode;
import com.i7colors.remoteService.AbstractRemoteService;
import com.i7colors.remoteService.ResponseInvokeException;
import com.i7colors.util.Logger;
import com.i7colors.util.PropertyUtils;
import org.apache.commons.net.nntp.Article;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class SchoolService extends AbstractRemoteService {
	@Override
	public String getAppHost() {
		return PropertyUtils.getProperty("schoolAppServiceHost");
	}
	/**
	 * 获取大学堂菜单信息
	 * @return
	 */
	public List<Map<String,Object>> getSchoolMenuList(){
		Logger.info("获取大学堂菜单信息");
		Map<String,String> map = new HashMap<String,String>();
		map.put("parameter","0");
		BaseResponse<List<SchoolMenu>> data = new BaseResponse<List<SchoolMenu>>();
		try {
			data = get(ConstUrl.GET_SCHOOL_MENU, map, new TypeToken<BaseResponse<List<SchoolMenu>>>(){}.getType());
			return getMenu(data.getData());
		} catch (ResponseInvokeException e) {
			Logger.error(this, e);
		}
		return null ;
	}

	private List<Map<String,Object>> getMenu(List<SchoolMenu> list) {
		List<Map<String,Object>> menuList = new ArrayList<Map<String,Object>>();
		Map<String,Object> menuMap = new HashMap<String,Object>();
		Map<Long,Integer> idx = new HashMap<Long,Integer>();
		int id = 0;
		for (SchoolMenu menu : list){
			menuMap = new HashMap<String,Object>();
			if(null == menu.getParentId() || menu.getParentId()==0){
				menuMap.put("childMenu",new ArrayList<SchoolMenu>());
				menuMap.put("parentMenu",menu);
				menuList.add(menuMap);
				idx.put(menu.getId(),id);
			}else{
				((List<SchoolMenu>)(menuList.get(idx.get(menu.getParentId())).get("childMenu"))).add(menu);
			}
			id++;
		}
		return menuList;
	}

	/**
	 * 获取大学堂首页板块信息
	 */
	public List<SchoolArticle> getArticleBySchoolPlate(String pageSize,String beginPage,String plateCode){
		Map<String,String> map = new HashMap<String,String>();
		map.put("plateCode",plateCode);
		map.put("pageSize",pageSize);
		map.put("beginPage",beginPage);
		String url =  ConstUrl.GET_SCHOOL_INDEX_ARTICLE;
		PageResponse<List<SchoolArticle>> data = new PageResponse<List<SchoolArticle>>();
		try{
			 data = get(url,map,new TypeToken<PageResponse<List<SchoolArticle>>>(){}.getType());
			/*int totalCount = data.getTotalCount();
			int a = totalCount%Integer.parseInt(map.get("pageSize"));
			int perPageNo = totalCount/Integer.parseInt(map.get("pageSize"));
			if(a!=0){
				perPageNo = perPageNo+1;
			}
			data.setPerPageNo(perPageNo);*/
		}catch (Exception e){
			Logger.error("",e);
		}
		return data.getData();
	}

	/**
	 * 获取大学堂文章（按点击排行）
	 */
	public List<SchoolArticle> getArticleByRanking(String pageSize,String pageNo){
		Map<String,String> map = new HashMap<String,String>();
		map.put("pageNo",pageNo);
		map.put("pageSize",pageSize);
		String url =  ConstUrl.GET_SCHOOL_ARTICLE_RANKING;
		PageResponse<List<SchoolArticle>> data = new PageResponse<List<SchoolArticle>>();
		try{
			 data = get(url,map,new TypeToken<PageResponse<List<SchoolArticle>>>(){}.getType());
		}catch (Exception e){
			Logger.error("",e);
		}
		return data.getData();
	}

	/**
	 * 获取大学堂菜单对应文章
	 */
	public PageResponse<List<SchoolMenuArticle>> getArticleBySchoolMenu(Integer pageNo, Long pageSize, SchoolMenuArticle schoolMenuArticle){
		Map<String,String> map = new HashMap<String,String>();
		map.put("queryCond", new Gson().toJson(schoolMenuArticle, new TypeToken<SchoolMenuArticle>(){}.getType()));
		map.put("pageNo", String.valueOf(pageNo));
		map.put("pageSize", String.valueOf(pageSize));
		String url =  ConstUrl.GET_SCHOOL_MENU_ARTICLE;
		PageResponse<List<SchoolMenuArticle>> data = new PageResponse<List<SchoolMenuArticle>>();
		try{
			 data = get(url,map,new TypeToken<PageResponse<List<SchoolMenuArticle>>>(){}.getType());
		}catch (Exception e){
			Logger.error("",e);
		}
		return data;
	}

	/**
	 * 获取文章评论
	 */
	public PageResponse<List<SchoolComment>> getComments(Integer pageNo, Long pageSize, SchoolComment schoolComment){
		Map<String,String> map = new HashMap<String,String>();
		map.put("queryCond", new Gson().toJson(schoolComment, new TypeToken<SchoolComment>(){}.getType()));
		map.put("pageNo", String.valueOf(pageNo));
		map.put("pageSize", String.valueOf(pageSize));
		String url =  ConstUrl.GET_SCHOOL_ARTICLE_COMMENT;
		PageResponse<List<SchoolComment>> data = new PageResponse<List<SchoolComment>>();
		try{
			 data = get(url,map,new TypeToken<PageResponse<List<SchoolComment>>>(){}.getType());
		}catch (Exception e){
			Logger.error("",e);
		}
		return data;
	}
	
	/**获取大学堂用户评论信息
	 * @param schoolComment
	 * @return
	 */
	public  PageResponse<List<SchoolComment>> querySchoolCommentList(SchoolComment schoolComment) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("queryCond", new Gson().toJson(schoolComment, new TypeToken<SchoolComment>(){}.getType()));
		String url =  ConstUrl.GET_SCHOOL_ARTICLE_COMMENT;
		PageResponse<List<SchoolComment>> data = new PageResponse<List<SchoolComment>>();
		try{
			 data = get(url,map,new TypeToken<PageResponse<List<SchoolComment>>>(){}.getType());
		}catch (Exception e){
			Logger.error("",e);
		}
		return data;
		
	}

	/**
	 * 查看文章详情
	 * @param article
	 * @return
	 */
	public SchoolArticle getArticleDetail(SchoolArticle article){
		Map<String,String> map = new HashMap<String,String>();
		map.put("queryCond",new Gson().toJson(article, new TypeToken<SchoolArticle>(){}.getType()));
		String url =  ConstUrl.GET_SCHOOL_ARTICLE_DETAIL;

		SchoolArticle schoolArticle = new SchoolArticle();

		PageResponse<List<SchoolArticle>> response = new PageResponse<List<SchoolArticle>>();
		try{
			response = get(url,map,new TypeToken<PageResponse<List<SchoolArticle>>>(){}.getType());

			if(response.getCode() == ResultCode.SUCCESS && response.getData().size() > 0){
				schoolArticle = response.getData().get(0);
			}

		}catch (Exception e){
			Logger.error("",e);
		}
		return schoolArticle;
	}

	/**
	 * 创建评论
	 * @param comment
	 * @return
	 */
	public BaseResponse<Long> createArticleComment(SchoolComment comment){
		Map<String,String> map = new HashMap<String,String>();
		map.put("parameter",new Gson().toJson(comment, SchoolComment.class));
		String url =  ConstUrl.CREATE_ARTICLE_COMMENT;

		BaseResponse<Long> response = new BaseResponse<Long>();
		try{
			response = post(url,map,new TypeToken<BaseResponse<Long>>(){}.getType());
		}catch (Exception e){
			Logger.error("",e);
		}
		return response;
	}
	
	/**
	 * 根据用户ID查询收藏文章信息
	 */
	public PageResponse<List<SchoolArticle>> querySchoolArticleFavoriteList(SchoolArticleFavorite schoolArticleFavorite) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("queryCond", new Gson().toJson(schoolArticleFavorite, new TypeToken<SchoolArticleFavorite>(){}.getType()));
		String url =  ConstUrl.GET_SCHOOL_ARTICLE_FAVORITE;
		PageResponse<List<SchoolArticle>> data = new PageResponse<List<SchoolArticle>>();
		try{
			 data = get(url,map,new TypeToken<PageResponse<List<SchoolArticleFavorite>>>(){}.getType());
		}catch (Exception e){
			Logger.error("",e);
		}
		return data;
	}
	
	/**添加收藏文章
	 * @param schoolComment
	 * @return
	 */
	public BaseResponse<Long> createArticleFavorite(SchoolArticleFavorite schoolArticleFavorite){
		Map<String,String> map = new HashMap<String,String>();
		map.put("parameter",new Gson().toJson(schoolArticleFavorite, SchoolArticleFavorite.class));
		String url =  ConstUrl.CREATE_ARTICLE_FAVORITE;

		BaseResponse<Long> response = new BaseResponse<Long>();
		try{
			response = post(url,map,new TypeToken<BaseResponse<Long>>(){}.getType());
		}catch (Exception e){
			Logger.error("",e);
		}
		return response;
	}
	
	/**根据用户ID查询浏览历史详细信息
	 * @param schoolHistory
	 * @return
	 */
	public PageResponse<List<SchoolArticle>> querySchoolHistoryDetailList(SchoolHistory schoolHistory) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("queryCond", new Gson().toJson(schoolHistory, new TypeToken<SchoolHistory>(){}.getType()));
		String url =  ConstUrl.GET_SCHOOL_HISTORY;
		PageResponse<List<SchoolArticle>> data = new PageResponse<List<SchoolArticle>>();
		try{
			 data = get(url,map,new TypeToken<PageResponse<List<SchoolHistory>>>(){}.getType());
		}catch (Exception e){
			Logger.error("",e);
		}
		return data;
	}

	/**
	 * 点赞
	 * @param support
	 * @return
	 */
	public BaseResponse createCommentSupport(SchoolSupport support){
		Map<String,String> map = new HashMap<String,String>();
		map.put("parameter",new Gson().toJson(support, SchoolSupport.class));
		String url =  ConstUrl.CREATE_COMMENT_SUPPORT;

		BaseResponse response = new BaseResponse();
		try{
			response = post(url,map,new TypeToken<BaseResponse>(){}.getType());
		}catch (Exception e){
			Logger.error("",e);
		}
		return response;
	}

	public static void main(String[] args) {
		SchoolService schoolService = new SchoolService();
		SchoolMenuArticle schoolMenuArticle = new SchoolMenuArticle();
		schoolMenuArticle.setMenuId(6l);
		schoolService.getArticleBySchoolMenu(1, 10l, schoolMenuArticle);
	}
	
	
}