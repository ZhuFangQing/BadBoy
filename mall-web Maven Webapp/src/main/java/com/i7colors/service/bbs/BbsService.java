package com.i7colors.service.bbs;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.i7colors.bean.bbs.*;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.i7colors.commons.constant.ConstType;
import com.i7colors.commons.constant.ConstUrl;
import com.i7colors.domain.BaseResponse;
import com.i7colors.domain.PageResponse;
import com.i7colors.enums.ResultCode;
import com.i7colors.remoteService.AbstractRemoteService;
import com.i7colors.remoteService.ResponseInvokeException;
import com.i7colors.util.Logger;
import com.i7colors.util.PropertyUtils;

@Service
public class BbsService extends AbstractRemoteService {
	@Override
	public String getAppHost() {
		return PropertyUtils.getProperty("bbsAppServiceHost");
	}

	/**
	 * 获取版块推荐贴
	 *
	 * @param pageNo
	 * @param pageSize
	 * @param plateId
	 *            推荐版块ID
	 * @return
	 */
	public List<BbsRecommendPostRelation> getBbsRecommendPostListByPlateId(
			Integer pageNo, Integer pageSize, Long plateId) {
		BbsRecommendPostRelation bbsRecommendPostRelation = new BbsRecommendPostRelation();
		bbsRecommendPostRelation.setPlateId(plateId);

		PageResponse<List<BbsRecommendPostRelation>> pageResponse = new PageResponse<List<BbsRecommendPostRelation>>();
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("queryCond", new Gson().toJson(bbsRecommendPostRelation));
			if (pageNo != null)
				map.put("pageNo", pageNo.toString());
			if (pageSize != null)
				map.put("pageSize", pageSize.toString());

			pageResponse = get(
					ConstUrl.GET_BBS_RECOMMEND_POST_RELATION,
					map,
					new TypeToken<PageResponse<List<BbsRecommendPostRelation>>>() {
					}.getType());
		} catch (Exception e) {
			Logger.error("", e);
		}
		return pageResponse.getData();
	}

	/**
	 * 获取论坛主贴
	 *
	 * @param pageNo
	 * @param pageSize
	 * @param bbsPost
	 * @return
	 */
	public PageResponse<List<BbsPost>> getBbsPost(Integer pageNo,
												  Integer pageSize, BbsPost bbsPost) {
		PageResponse<List<BbsPost>> pageResponse = new PageResponse<List<BbsPost>>();
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("queryCond", new Gson().toJson(bbsPost));
			if (pageNo != null)
				map.put("pageNo", pageNo.toString());
			if (pageSize != null)
				map.put("pageSize", pageSize.toString());

			pageResponse = get(ConstUrl.GET_BBS_POST, map,
					new TypeToken<PageResponse<List<BbsPost>>>() {
					}.getType());
		} catch (Exception e) {
			Logger.error("", e);
		}
		return pageResponse;
	}
	//TODO 这个方法控制层没有用到
	/**
	 * 获取论坛主贴
	 *
	 * @param pageNo
	 * @param pageSize
	 * @param bbsPost
	 * @return
	 */
	public PageResponse<List<BbsPost>> getBbsPost(Integer pageNo,
												  Integer pageSize, BbsPost bbsPost,String orderBy) {
		PageResponse<List<BbsPost>> pageResponse = new PageResponse<List<BbsPost>>();
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("queryCond", new Gson().toJson(bbsPost));
			if (pageNo != null)
				map.put("pageNo", pageNo.toString());
			if (pageSize != null)
				map.put("pageSize", pageSize.toString());
			if (orderBy != null)
				map.put("orderBy",orderBy);

			pageResponse = get(ConstUrl.GET_BBS_POST, map,
					new TypeToken<PageResponse<List<BbsPost>>>() {
					}.getType());
		} catch (Exception e) {
			Logger.error("", e);
		}
		return pageResponse;
	}

	/**
	 * 根据ID获取主贴
	 *
	 * @param id
	 * @return
	 */
	public BbsPost getBbsPostById(Long id) {
		BbsPost bbsPost = new BbsPost();
		bbsPost.setId(id);
		List<BbsPost> list = getBbsPost(null, null, bbsPost).getData();
		if (list.size() > 0)
			return list.get(0);

		return null;
	}


	/**
	 * 获取版块热门贴
	 *
	 * @param pageNo
	 * @param pageSize
	 * @param sectionId
	 * @return
	 */
	public List<BbsPost> getBbsSectionHotPost(Integer pageNo, Integer pageSize,
											  Long sectionId,Long topSectionId) {
		BbsPost bbsPost = new BbsPost();
		bbsPost.setSectionId(sectionId);
		bbsPost.setTopSectionId(topSectionId);
		bbsPost.setStatus(ConstType.BBS_POST_STATUS_QUALIFIED);

		return getBbsPost(pageNo, pageSize, bbsPost).getData();
	}

	/**
	 * 获取帖子数量
	 *
	 * @param bbsPost
	 * @return
	 */
	public Integer getBbsPostCount(BbsPost bbsPost) {
		BaseResponse<Integer> pageResponse = new BaseResponse<Integer>();
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("queryCond", new Gson().toJson(bbsPost));

			pageResponse = get(ConstUrl.GET_BBS_POST_COUNT, map,
					new TypeToken<BaseResponse<Integer>>() {
					}.getType());
		} catch (Exception e) {
			Logger.error("", e);
		}
		return pageResponse.getData();
	}

	/**
	 * 按照日期获取帖子数量
	 *
	 * @param date
	 * @return
	 */
	public Integer getBbsPostCountByDate(Date date) {
		BbsPost bbsPost = new BbsPost();
		bbsPost.setCreatedAt(date);

		return getBbsPostCount(bbsPost);
	}

	/**
	 * 获取层级版块列表
	 *
	 * @param bbsSection
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public List<BbsSection> getLevelBbsSectionList(BbsSection bbsSection,
												   Integer pageNo, Integer pageSize) {
		PageResponse<List<BbsSection>> pageResponse = new PageResponse<List<BbsSection>>();
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("queryCond", new Gson().toJson(bbsSection));
			if (pageNo != null)
				map.put("pageNo", pageNo.toString());
			if (pageSize != null)
				map.put("pageSize", pageSize.toString());

			pageResponse = get(ConstUrl.GET_LEVEL_BBS_SECTION_LIST, map,
					new TypeToken<PageResponse<List<BbsSection>>>() {
					}.getType());
		} catch (Exception e) {
			Logger.error("", e);
		}
		return pageResponse.getData();
	}

	/**
	 * 获取版块列表
	 *
	 * @param bbsSection
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public List<BbsSection> getSectionList(BbsSection bbsSection,
										   Integer pageNo, Integer pageSize) {
		PageResponse<List<BbsSection>> pageResponse = new PageResponse<List<BbsSection>>();
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("queryCond", new Gson().toJson(bbsSection));
			if (pageNo != null)
				map.put("pageNo", pageNo.toString());
			if (pageSize != null)
				map.put("pageSize", pageSize.toString());

			pageResponse = get(ConstUrl.QUERY_BBS_SECTION_LIST, map,
					new TypeToken<PageResponse<List<BbsSection>>>() {
					}.getType());
		} catch (Exception e) {
			Logger.error("", e);
		}
		return pageResponse.getData();
	}

	/**
	 * 按照ID获取版块
	 *
	 * @param id
	 * @return
	 */
	public BbsSection getBbsSectionById(Long id) {
		BbsSection bbsSection = new BbsSection();
		bbsSection.setId(id);
		List<BbsSection> list = getSectionList(bbsSection, null, null);
		if (list.size() > 0) {
			return list.get(0);
		} else {
			return null;
		}
	}

	/**
	 * 获取版块下话题列表
	 *
	 * @param sectionId
	 * @return
	 */
	public List<BbsTopic> getBbsTopicListAndCount(Long sectionId) {
		BbsTopic bbsTopic = new BbsTopic();
		bbsTopic.setSectionId(sectionId);
		PageResponse<List<BbsTopic>> pageResponse = new PageResponse<List<BbsTopic>>();
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("queryCond", new Gson().toJson(bbsTopic));

			pageResponse = get(ConstUrl.QUERY_BBS_TOPIC_LIST_AND_COUNT, map,
					new TypeToken<PageResponse<List<BbsTopic>>>() {
					}.getType());
		} catch (Exception e) {
			Logger.error("", e);
		}
		return pageResponse.getData();
	}

	/**
	 * 获取版块推荐贴
	 *
	 * @param pageNo
	 * @param pageSize
	 * @param bbsReply
	 *            推荐版块ID
	 * @return
	 */
	public PageResponse<List<BbsReply>> getBbsReply(Integer pageNo,
													Integer pageSize, BbsReply bbsReply) {
		PageResponse<List<BbsReply>> pageResponse = new PageResponse<List<BbsReply>>();
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("queryCond", new Gson().toJson(bbsReply));
			if (pageNo != null)
				map.put("pageNo", pageNo.toString());
			if (pageSize != null)
				map.put("pageSize", pageSize.toString());

			pageResponse = get(ConstUrl.GET_REPLY_LIST, map,
					new TypeToken<PageResponse<List<BbsReply>>>() {
					}.getType());
		} catch (Exception e) {
			Logger.error("", e);
		}
		return pageResponse;
	}

	/**
	 * 获取论坛等级
	 * @param pageNo
	 * @param pageSize
	 * @param bbsLevel
	 * @return
	 */
	public List<BbsLevel> getBbsLevel(Integer pageNo, Integer pageSize,
									  BbsLevel bbsLevel) {
		PageResponse<List<BbsLevel>> pageResponse = new PageResponse<List<BbsLevel>>();
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("queryCond", new Gson().toJson(bbsLevel));
			if (pageNo != null)
				map.put("pageNo", pageNo.toString());
			if (pageSize != null)
				map.put("pageSize", pageSize.toString());

			pageResponse = get(ConstUrl.GET_LEVEL_LIST, map,
					new TypeToken<PageResponse<List<BbsLevel>>>() {
					}.getType());
		} catch (Exception e) {
			Logger.error("", e);
		}
		return pageResponse.getData();
	}

	/**
	 * 发帖
	 *
	 * @param bbsPost
	 * @param bbsReply
	 * @return
	 */
	public boolean post(BbsPost bbsPost, BbsReply bbsReply) {
		BaseResponse response = new BaseResponse();
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("post", new Gson().toJson(bbsPost));
			map.put("reply", new Gson().toJson(bbsReply));
			response = post(ConstUrl.POST, map, new TypeToken<BaseResponse>() {
			}.getType());
		} catch (Exception e) {
			Logger.error(this, e);
		}

		return response.getCode() == ResultCode.SUCCESS;
	}

	/**
	 * 回帖
	 *
	 * @param bbsReply
	 * @return
	 */
	public boolean reply(BbsReply bbsReply) {
		BaseResponse response = new BaseResponse();
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("parameter", new Gson().toJson(bbsReply));
			response = post(ConstUrl.REPLY, map, new TypeToken<BaseResponse>() {
			}.getType());
		} catch (Exception e) {
			Logger.error(this, e);
		}

		return response.getCode() == ResultCode.SUCCESS;
	}

	/**
	 * 搜索论坛用户
	 * @param userDTO
	 * @return
	 */
	public PageResponse<List<SearchUserDTO>> getBbsUserList(SearchUserDTO userDTO, Integer pageNo, Integer pageSize){
		PageResponse<List<SearchUserDTO>> pageResponse = new PageResponse<List<SearchUserDTO>>();
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("queryCond", new Gson().toJson(userDTO));
			map.put("pageNo", String.valueOf(pageNo));
			map.put("pageSize", String.valueOf(pageSize));

			pageResponse = get(
					ConstUrl.QUERY_BBS_SEARACH_USER_LIST,
					map,
					new TypeToken<PageResponse<List<SearchUserDTO>>>() {}.getType()
			);
		} catch (Exception e) {
			Logger.error("", e);
		}
		return pageResponse;
	}

	/**
	 * 用户消息列表
	 * @param userDTO
	 * @return
	 */
	public PageResponse<List<BbsMessage>> getBbsUserMessageList(BbsMessage userDTO, Integer pageNo, Integer pageSize){
		PageResponse<List<BbsMessage>> pageResponse = new PageResponse<List<BbsMessage>>();
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("queryCond", new Gson().toJson(userDTO));
			map.put("pageNo", String.valueOf(pageNo));
			map.put("pageSize", String.valueOf(pageSize));

			pageResponse = get(
					ConstUrl.QUERY_BBS_MESSAGE,
					map,
					new TypeToken<PageResponse<List<BbsMessage>>>() {}.getType()
			);
		} catch (Exception e) {
			Logger.error("", e);
		}
		return pageResponse;
	}


	/**
	 * 删除消息
	 */
	public BaseResponse deleteBbsMessage(Long messageId){
		String url = ConstUrl.DELETE_BBS_MESSAGE;
		BaseResponse response = new BaseResponse();
		Map<String,String> map = new HashMap<String, String>();
		map.put("id",String.valueOf(messageId));

		try {
			response = post(url, map, BaseResponse.class);
		} catch (ResponseInvokeException e) {
			Logger.error("",e);
		}
		return response;
	}

	/**
	 * 发送消息
	 */
	public BaseResponse<BbsMobileMessage> createBbsMessage(BbsMessage bbsMessage){
		String url = ConstUrl.CREATE_BBS_MESSAGE;
		BaseResponse response = new BaseResponse();
		Map<String,String> map = new HashMap<String, String>();
		map.put("parameter", new Gson().toJson(bbsMessage));

		try {
			response = post(url, map, new TypeToken<BaseResponse<BbsMobileMessage>>(){}.getType());
		} catch (ResponseInvokeException e) {
			Logger.error("",e);
		}
		return response;
	}

	public PageResponse<List<BbsReply>> getBbsUserReply(
			Integer pageNo, Integer pageSize, BbsReply bbsReply) {
		PageResponse<List<BbsReply>> pageResponse = new PageResponse<List<BbsReply>>();
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("queryCond", new Gson().toJson(bbsReply));
			if (pageNo != null)
				map.put("pageNo", pageNo.toString());
			if (pageSize != null)
				map.put("pageSize", pageSize.toString());

			pageResponse = get(
					ConstUrl.GET_USER_REPLY_LIST,
					map,
					new TypeToken<PageResponse<List<BbsReply>>>() {
					}.getType());
		} catch (Exception e) {
			Logger.error("", e);
		}
		return pageResponse;
	}

	/**
	 * 查找帖子
	 */
	public Long findPost(BbsReply bbsReply){
		String url = ConstUrl.FIND_POST;
		BaseResponse<Long> response = new BaseResponse();
		Map<String,String> map = new HashMap();
		map.put("parameter", new Gson().toJson(bbsReply));

		try {
			response = get(url, map, new TypeToken<BaseResponse<Long>>(){}.getType());
		} catch (ResponseInvokeException e) {
			Logger.error("",e);
		}
		return response.getData();
	}

	/**
	 * 修改主贴
	 * @param bbsPost
	 * @return
	 */
	public boolean updateBbsPost(BbsPost bbsPost) {
		String url = ConstUrl.UPDATE_BBS_POST;
		BaseResponse response = new BaseResponse();
		Map<String, String> map = new HashMap<String, String>();
		map.put("parameter", new Gson().toJson(bbsPost));

		try {
			response = post(url, map, BaseResponse.class);
			return response.getCode() == ResultCode.SUCCESS;
		} catch (ResponseInvokeException e) {
			Logger.error("", e);
		}
		return false;
	}

	/**
	 * 修改版块
	 * @param bbsSection
	 * @return
	 */
	public boolean updateBbsSection(BbsSection bbsSection) {
		String url = ConstUrl.UPDATE_BBS_SECTION;
		BaseResponse response = new BaseResponse();
		Map<String, String> map = new HashMap<String, String>();
		map.put("parameter", new Gson().toJson(bbsSection));

		try {
			response = post(url, map, BaseResponse.class);
			return response.getCode() == ResultCode.SUCCESS;
		} catch (ResponseInvokeException e) {
			Logger.error("", e);
		}
		return false;
	}

	/**
	 * 修改回帖
	 * @param bbsReply
	 * @return
	 */
	public boolean updateBbsReply(BbsReply bbsReply) {
		String url = ConstUrl.UPDATE_BBS_REPLY;
		BaseResponse response = new BaseResponse();
		Map<String, String> map = new HashMap<String, String>();
		map.put("parameter", new Gson().toJson(bbsReply));

		try {
			response = post(url, map, BaseResponse.class);
			return response.getCode() == ResultCode.SUCCESS;
		} catch (ResponseInvokeException e) {
			Logger.error("", e);
		}
		return false;
	}

	/**
	 * 版主判断
	 * @param userId
	 * @param sectionId
	 * @return
	 */
	public boolean isModerator(Long userId,Long sectionId){
		BbsModerator bbsModerator = new BbsModerator();
		bbsModerator.setUserId(userId);
		bbsModerator.setJudgeSectionId(sectionId);
		PageResponse<List<BbsModerator>> pageResponse = new PageResponse<List<BbsModerator>>();
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("queryCond", new Gson().toJson(bbsModerator));

			pageResponse = get(ConstUrl.GET_MODERATOR, map,
					new TypeToken<PageResponse<List<BbsPost>>>() {
					}.getType());
		} catch (Exception e) {
			Logger.error("", e);
		}
		return pageResponse.getData().size() > 0;

	}

	/**
	 * 获取版块列表
	 *
	 * @return
	 */
	public BbsSection getSectionGroupData() {
		BaseResponse<BbsSection> resp = new BaseResponse<BbsSection>();
		try {
			resp = get(ConstUrl.QUERY_BBS_SECTION_GROUP_DATA,
					new TypeToken<BaseResponse<BbsSection>>() {
					}.getType());
		} catch (Exception e) {
			Logger.error("", e);
		}
		return resp.getData();
	}

	/**
	 * 审核帖子
	 * @param bbsPost
	 * @return
	 */
	public boolean audtingBbsPost(BbsPost bbsPost) {
		String url = ConstUrl.AUDTING_BBS_POST;
		BaseResponse response = new BaseResponse();
		Map<String, String> map = new HashMap<String, String>();
		map.put("parameter", new Gson().toJson(bbsPost));

		try {
			response = post(url, map, BaseResponse.class);
			return response.getCode() == ResultCode.SUCCESS;
		} catch (ResponseInvokeException e) {
			Logger.error("", e);
		}
		return false;
	}

	/**
	 * 删除主贴
	 * @param bbsPost
	 * @return
	 */
	public boolean deleteBbsPost(BbsPost bbsPost) {
		String url = ConstUrl.DELETE_BBS_POST;
		BaseResponse response = new BaseResponse();
		Map<String, String> map = new HashMap<String, String>();
		map.put("parameter", new Gson().toJson(bbsPost));

		try {
			response = post(url, map, BaseResponse.class);
			return response.getCode() == ResultCode.SUCCESS;
		} catch (ResponseInvokeException e) {
			Logger.error("", e);
		}
		return false;
	}

	/**
	 * 收藏主贴
	 * @param postId
	 * @param userId
	 * @return
	 */
	public boolean collectBbsPost(Long postId,Long userId) {
		BbsCollection bbsCollection = new BbsCollection();
		bbsCollection.setUserId(userId);
		bbsCollection.setPostId(postId);

		String url = ConstUrl.COLLECT_BBS_POST;
		BaseResponse response = new BaseResponse();
		Map<String, String> map = new HashMap<String, String>();
		map.put("parameter", new Gson().toJson(bbsCollection));

		try {
			response = post(url, map, BaseResponse.class);
			return response.getCode() == ResultCode.SUCCESS;
		} catch (ResponseInvokeException e) {
			Logger.error("", e);
		}
		return false;
	}

	/**
	 * 修改回帖
	 * @param bbsReply
	 * @return
	 */
	public boolean splitBbsReply(BbsReply bbsReply) {
		String url = ConstUrl.SPLIT_BBS_REPLY;
		BaseResponse response = new BaseResponse();
		Map<String, String> map = new HashMap<String, String>();
		map.put("parameter", new Gson().toJson(bbsReply));

		try {
			response = post(url, map, BaseResponse.class);
			return response.getCode() == ResultCode.SUCCESS;
		} catch (ResponseInvokeException e) {
			Logger.error("", e);
		}
		return false;
	}
	/*
	 * 修改板块主题
	 */
	public boolean updateBbsTopic(BbsTopic bbsTopic) {
		String url = ConstUrl.UPDATE_BBS_TOPIC;
		BaseResponse response = new BaseResponse();
		Map<String, String> map = new HashMap<String, String>();
		map.put("parameter", new Gson().toJson(bbsTopic));

		try {
			response = post(url, map, BaseResponse.class);
			return response.getCode() == ResultCode.SUCCESS;
		} catch (ResponseInvokeException e) {
			Logger.error("", e);
		}
		return false;
	}
	/*
	 * 删除板块主题
	 */
	public boolean deleteBbsTopic(Long id) {

		String url = ConstUrl.DELETE_BBS_TOPIC;
		BaseResponse response = new BaseResponse();
		Map<String, String> map = new HashMap<String, String>();
		try {
			map.put("id", id.toString());
			response = post(url, map, BaseResponse.class);
			return response.getCode() == ResultCode.SUCCESS;
		} catch (Exception e) {
			Logger.error("", e);
		}
		return false;
	}
	/*
	 * 新增板块主题
	 */
	public boolean addBbsTopic(BbsTopic bbsTopic) {
		String url = ConstUrl.CREATE_BBS_TOPIC;
		BaseResponse response = new BaseResponse();
		Map<String, String> map = new HashMap<String, String>();
		map.put("parameter", new Gson().toJson(bbsTopic));

		try {
			response = post(url, map, BaseResponse.class);
			return response.getCode() == ResultCode.SUCCESS;
		} catch (ResponseInvokeException e) {
			Logger.error("", e);
		}
		return false;
	}

}
