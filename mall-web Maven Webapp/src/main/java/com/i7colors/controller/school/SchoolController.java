package com.i7colors.controller.school;

import com.i7colors.bean.bbs.BbsPost;
import com.i7colors.bean.info.News;
import com.i7colors.bean.school.SchoolArticle;
import com.i7colors.bean.school.SchoolArticleFavorite;
import com.i7colors.bean.school.SchoolComment;
import com.i7colors.bean.school.SchoolHistory;
import com.i7colors.bean.school.SchoolMenuArticle;
import com.i7colors.bean.school.SchoolSupport;
import com.i7colors.commons.constant.ConstType;
import com.i7colors.controller.BaseController;
import com.i7colors.domain.BaseResponse;
import com.i7colors.domain.PageResponse;
import com.i7colors.enums.BbsRecommendPostType;
import com.i7colors.enums.ResultCode;
import com.i7colors.enums.SchoolPlateType;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/school")
public class SchoolController extends BaseController {
    private static final Logger logger = Logger.getLogger(SchoolController.class);
    private static final int dyeNewsType = 66;
    private static final int hotNewsType = 8;

    /**
     * 跳转到大学堂
     *
     * @return
     */
    @RequestMapping("")
    public ModelAndView toSchool() {
        ModelAndView mav = new ModelAndView("school/school");
        Map<String, String> params = new HashMap<String, String>();
        params.put("pageNo", String.valueOf(1));
        params.put("pageSize", String.valueOf(10));
        params.put("partnerCond", "");
        List<Map<String, Object>> list = schoolService.getSchoolMenuList();
        //================================大学堂广告================================================
        mav.addObject("adList", advertisementService.getAdInfoByCode(ConstType.SCHOOL_AD));
        //=================================大学堂菜单=============================================
        mav.addObject("partnerList", partnerService.select(params)).addObject("menuList", list);
        //=================================大学堂首页染料新闻======================================
        mav.addObject("dyeNewsList", getSchoolNews(1, 4, dyeNewsType));

        //热门推荐
        mav.addObject("recommendList", schoolService.getArticleBySchoolPlate("4", "1", SchoolPlateType.HOT_RECOMMEND.getCode()));
        //教育培训
        mav.addObject("educationList", schoolService.getArticleBySchoolPlate("7", "1", SchoolPlateType.EDUCATION.getCode()));
        //印染百科
        mav.addObject("encyclopediasList", schoolService.getArticleBySchoolPlate("7", "1", SchoolPlateType.ENCYCLOPEDIAS.getCode()));
        //专家团队
        mav.addObject("expertList", schoolService.getArticleBySchoolPlate("7", "1", SchoolPlateType.EXPERT.getCode()));
        //技术交流
        mav.addObject("technologyExchangeList", schoolService.getArticleBySchoolPlate("7", "1", SchoolPlateType.TECHNOLOGY_EXCHANGE.getCode()));
        //热门课程
        mav.addObject("popularCourseList", schoolService.getArticleBySchoolPlate("4", "1", SchoolPlateType.POPULAR_COURSE.getCode()));

        //热门话题
        mav.addObject("hotTopicList", bbsService.getBbsRecommendPostListByPlateId(1, 5, BbsRecommendPostType.RECOMMEND_SCHOOL_HOT_POST.getCode()));
        //专家论坛
        BbsPost bbsPost = new BbsPost();
        bbsPost.setStatus(ConstType.BBS_POST_STATUS_QUALIFIED);
        mav.addObject("expertForumList", bbsService.getBbsPost(1, 6, bbsPost,
                "order by last_reply_at desc").getData());
        //论坛精华
        bbsPost = new BbsPost();
        bbsPost.setStatus(ConstType.BBS_POST_STATUS_QUALIFIED);
        mav.addObject("forumEssenceList", bbsService.getBbsPost(1, 18,
                bbsPost, "order by is_top desc,click_rate / ((UNIX_TIMESTAMP(now()) - UNIX_TIMESTAMP(a.created_at)) / (60 * 60 * 24)) desc").getData());

        mav.addObject("rankingList", schoolService.getArticleByRanking("5", "1"));
        return mav;
    }

    /**
     * 跳转到大学堂资讯页面
     */
    @RequestMapping("/industry")
    public ModelAndView toSchoolIndustry() {
        ModelAndView mav = new ModelAndView("school/schoolIndustry");


        Map<String, String> params = new HashMap<String, String>();
        params.put("pageNo", String.valueOf(1));
        params.put("pageSize", String.valueOf(10));
        params.put("partnerCond", "");

        List<Map<String, Object>> list = schoolService.getSchoolMenuList();
        mav.addObject("menuList", list);
        //=================================大学堂首页染料新闻======================================
        mav.addObject("hotNewsList", getSchoolNews(1, 8, hotNewsType));
        mav.addObject("adList", advertisementService.getAdInfoByCode(ConstType.SCHOOL_INDUSTRY_AD));
        mav.addObject("partnerList", partnerService.select(params)).addObject("menuList", list);
        mav.addObject("rankingList", schoolService.getArticleByRanking("4", "1"));
        return mav;
    }


    @RequestMapping("/industry_search")
    @ResponseBody
    public Object industrySearch(@RequestParam Integer pageNo, @RequestParam Long pageSize, Long menuId, Long parentMenuId, String search) {

        SchoolMenuArticle schoolMenuArticle = new SchoolMenuArticle();
        schoolMenuArticle.setMenuId(menuId);
        schoolMenuArticle.setParentMenuId(parentMenuId);
        schoolMenuArticle.setTitle(search);
        schoolMenuArticle.setContentSummary(search);
        schoolMenuArticle.setContent(search);

        return schoolService.getArticleBySchoolMenu(pageNo, pageSize, schoolMenuArticle);
    }

    @RequestMapping("/comments_search")
    @ResponseBody
    public Object commentsSearch(SchoolComment comment, @RequestParam Integer pageNo, @RequestParam Long pageSize) {
        comment.setUserId(getUserId());

        return schoolService.getComments(pageNo, pageSize, comment);
    }

    //获取大学堂首页新闻侧边栏列表
    public List<News> getSchoolNews(int beginPage, int pageSize, int newsType) {
        Map<String, String> pageMap = new HashMap<String, String>();
        pageMap.put("beginPage", String.valueOf(beginPage));
        pageMap.put("pageSize", String.valueOf(pageSize));
        pageMap.put("newsType", String.valueOf(newsType));
        PageResponse<List<News>> pageResponse = informationService.getIndustryInformationService(pageMap);
        return pageResponse.getData();
    }

    /**
     * 文章详情
     *
     * @param articleId
     * @return
     */
    @RequestMapping("/articles/{articleId}")
    public ModelAndView articleDetail(@PathVariable("articleId") Long articleId) {
        ModelAndView mav = new ModelAndView("/school/article");

        SchoolArticle schoolArticle = new SchoolArticle();
        schoolArticle.setId(articleId);

        //=================================侧边栏======================================
        mav.addObject("hotNewsList", getSchoolNews(1, 8, hotNewsType));
        mav.addObject("adList", advertisementService.getAdInfoByCode(ConstType.SCHOOL_INDUSTRY_AD));

        mav.addObject("articleId", articleId);
        mav.addObject("rankingList", schoolService.getArticleByRanking("4", "1"));

        SchoolArticle data = schoolService.getArticleDetail(schoolArticle);
        mav.addObject("schoolArticle", data);


        return mav;
    }
    
    //发表文章评论
    @RequestMapping(value = "/comments", method = RequestMethod.POST)
    @ResponseBody
    public Object commentSubmit(SchoolComment schoolComment) {
        Long userId = getUserId();
        if (null == userId) {
            BaseResponse response = new BaseResponse();
            response.setCode(ResultCode.FAIL);
            response.setMsg("请登录后再发表评论");
            return response;
        }
        schoolComment.setUserId(userId);
        return schoolService.createArticleComment(schoolComment);
    }
    
    /**
	 * 获取用户评论信息
	 */
	@RequestMapping("/comments/{userId}")
	public ModelAndView getUserCommentList(@PathVariable("userId") Long userId){
		System.out.println(userId);
		ModelAndView mav = new ModelAndView("/school/school");
		SchoolComment schoolComment = new  SchoolComment();
		schoolComment.setUserId(userId);
		mav.addObject("commentList", schoolService.querySchoolCommentList(schoolComment));
		return mav;
	}
    
     
    //收藏文章
    @RequestMapping(value = "/favorite", method = RequestMethod.POST)
    @ResponseBody
    public Object createArticleFavorite(SchoolArticleFavorite schoolArticleFavorite) {
        Long userId = getUserId();
        if (null == userId) {
            BaseResponse response = new BaseResponse();
            response.setCode(ResultCode.FAIL);
            response.setMsg("请登录后再收藏");
            return response;
        }
        schoolArticleFavorite.setUserId(userId);
        return schoolService.createArticleFavorite(schoolArticleFavorite);
    }
    
    /**获取用户收藏文章
	 * @param userId
	 * @return
	 */
    @RequestMapping("/favorites/{userId}")
	public ModelAndView getUserArticleFavoriteList(@PathVariable("userId") Long userId){
		ModelAndView mav = new ModelAndView("/school/school");
		SchoolArticleFavorite schoolArticleFavorite = new SchoolArticleFavorite();
		schoolArticleFavorite.setUserId(userId);
		mav.addObject("favoriteArticleList", schoolService.querySchoolArticleFavoriteList(schoolArticleFavorite));
		return mav;
		
	}
	
	/**获取用户浏览历史信息
	 * @param userId
	 * @return
	 */
    @RequestMapping("/historys/{userId}")
	public ModelAndView getSchoolHistoryList(@PathVariable("userId") Long userId){
		ModelAndView mav = new ModelAndView("/school/school");
		SchoolHistory schoolHistory = new SchoolHistory();
		schoolHistory.setUserId(userId);
		mav.addObject("schoolHistoryList", schoolService.querySchoolHistoryDetailList(schoolHistory));
		return mav;
		
	}


    @RequestMapping(value = "/supports", method = RequestMethod.POST)
    @ResponseBody
    public Object supportSubmit(SchoolSupport schoolSupport) {
        schoolSupport.setUserId(getUserId());

        return schoolService.createCommentSupport(schoolSupport);
    }
}
