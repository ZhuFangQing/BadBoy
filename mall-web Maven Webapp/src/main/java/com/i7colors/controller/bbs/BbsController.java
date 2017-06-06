package com.i7colors.controller.bbs;

import java.text.ParseException;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.baidu.ueditor.ActionEnter;
import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.bbs.*;
import com.i7colors.enums.BbsRecommendPostType;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.i7colors.bean.customer.CustomerMain;
import com.i7colors.controller.BaseController;
import com.i7colors.domain.PageResponse;
import com.i7colors.enums.ResultCode;
import com.i7colors.util.FTPFileUploadUtils;
import com.i7colors.util.PropertyUtils;

@Controller
@RequestMapping("/bbs")
public class BbsController extends BaseController {
    private static final Logger logger = Logger.getLogger(BbsController.class);

//    private static final Long RECOMMEND_COVER_POST = 89L;
//
//    private static final Long RECOMMEND_HOT_POST = 90L;

    @RequestMapping("")
    public ModelAndView toBbs() throws ParseException {
        ModelAndView mav = new ModelAndView("bbs/bbs");

        // ================================论坛头图推荐================================================
        mav.addObject("recommendCoverPost", bbsService
                .getBbsRecommendPostListByPlateId(1, 10, BbsRecommendPostType.RECOMMEND_COVER_POST.getCode()));
        // ================================论坛热门推荐================================================
        mav.addObject("recommendHotPost", bbsService
                .getBbsRecommendPostListByPlateId(1, 4, BbsRecommendPostType.RECOMMEND_HOT_POST.getCode()));
        // ================================论坛版块精华===============================================
        mav.addObject("allSectionHotPost",
                bbsService.getBbsSectionHotPost(1, 18, null, null));
        // ================================论坛总用户数================================================
        mav.addObject("totalUser", userService.getUserCount(new CustomerMain()));
        // ================================论坛版块================================================
        mav.addObject("bbsSection",
                bbsService.getLevelBbsSectionList(new BbsSection(), null, null));
        // ================================论坛版块聚合数据================================================
        mav.addObject("bbsSectionGroupData", bbsService.getSectionGroupData());
        return mav;
    }

    /**
     * 版块页面跳转
     * @param sectionId
     * @param pageNo
     * @return
     */
    @RequestMapping("/bbsSection")
    public ModelAndView bbsSection(
            @RequestParam(value = "id", required = true) Long sectionId,
            Integer pageNo) {
        ModelAndView mav = null;
        Long userId = getUserId();
        if (userId == null || !isModerator(userId, sectionId)) {
            mav = new ModelAndView("bbs/bbsSection");
        } else {
            mav = new ModelAndView("bbs/bbsSectionManage");

        }
        // ================================论坛版块对象================================================
        mav.addObject("bbsSection", bbsService.getBbsSectionById(sectionId));
        // ================================论坛版块推荐================================================
        mav.addObject("sectionHotPost",
                bbsService.getBbsSectionHotPost(1, 15, sectionId, null));
        // ================================论坛版块话题================================================
        mav.addObject("bbsTopic", bbsService.getBbsTopicListAndCount(sectionId));

        return mav;
    }

    /**
     * 获取版块热门贴
     * @param pageNo
     * @param pageSize
     * @param sectionId 版块id
     * @param topSectionId 父版块id
     * @return
     */
    @RequestMapping(value = "/getSectionHotPostList", produces = "application/json; charset=utf-8")
    @ResponseBody
    public Object getSectionHotPostList(Integer pageNo, Integer pageSize,
                                        Long sectionId, Long topSectionId) {
        List<BbsPost> bbsPostList = bbsService.getBbsSectionHotPost(pageNo,
                pageSize, sectionId, topSectionId);
        return new Gson().toJson(bbsPostList);
    }

    /**
     * 获取主贴列表
     * @param pageNo
     * @param pageSize
     * @param bbsPost
     * @return
     */
    @RequestMapping(value = "/getBbsPostList", produces = "application/json; charset=utf-8")
    @ResponseBody
    public Object getBbsPostList(Integer pageNo, Integer pageSize,
                                 BbsPost bbsPost) {
        Map<String, Object> map = new HashMap<String, Object>();
        PageResponse<List<BbsPost>> resp = bbsService.getBbsPost(pageNo,
                pageSize, bbsPost);
        map.put("totalCount", resp.getTotalPageSize());
        map.put("data", resp.getData());
        return new Gson().toJson(map);
    }

    @RequestMapping("/search")
    public ModelAndView goSearchUserList(String bbs_search_type) {
        if ("user".equals(bbs_search_type)) {

            return new ModelAndView("/bbs/search_user_list");
        }

        return new ModelAndView("/bbs/search_post_list");
    }

    /**
     * 主贴页面跳转
     * @param postId
     * @param pageNo
     * @return
     */
    @RequestMapping("/bbsPost")
    public ModelAndView bbsPost(
            @RequestParam(value = "id", required = true) Long postId,
            Integer pageNo) {
        BbsPost bbsPost = bbsService.getBbsPostById(postId);




        if (bbsPost != null) {
            //修改点击量
            BbsPost b = new BbsPost();
            b.setId(postId);
            b.setClickRate(1);
            b.setSectionId(bbsPost.getSectionId());
            bbsService.updateBbsPost(b);

            ModelAndView mav = null;
            Long userId = getUserId();
            if (userId == null || !isModerator(userId, bbsPost.getSectionId())) {
                mav = new ModelAndView("bbs/bbsPost");
            } else {
                mav = new ModelAndView("bbs/bbsPostManage");
            }
            // 论坛主贴
            mav.addObject("bbsPost", bbsPost);
            // 论坛版块
            mav.addObject("bbsSection", bbsService.getBbsSectionById(bbsPost.getSectionId()));

            return mav;
        }
        return new ModelAndView("bbs/bbs");
    }

    /**
     * 获取回帖列表
     * @param pageNo
     * @param pageSize
     * @param bbsReply
     * @return
     */
    @RequestMapping(value = "/getBbsReplyList", produces = "application/json; charset=utf-8")
    @ResponseBody
    public Object getBbsReplyList(Integer pageNo, Integer pageSize,
                                  BbsReply bbsReply) {
        Map<String, Object> map = new HashMap<String, Object>();
        PageResponse<List<BbsReply>> resp = bbsService.getBbsReply(pageNo,
                pageSize, bbsReply);
        map.put("totalCount", resp.getTotalPageSize());
        map.put("data", resp.getData());
        return new Gson().toJson(map);
    }

    /**
     * 获取等级列表
     * @return
     */
    @RequestMapping(value = "/getBbsLevelList", produces = "application/json; charset=utf-8")
    @ResponseBody
    public Object getBbsLevelList() {
        return new Gson().toJson(bbsService.getBbsLevel(null, null,
                new BbsLevel()));
    }

    /**
     * 发帖
     * @param title 标题
     * @param sectionId 版块ID
     * @param topicId 主题ID
     * @param content 正文ID
     * @return
     */
    @RequestMapping(value = "/post", produces = "application/json; charset=utf-8")
    @ResponseBody
    public boolean post(@RequestParam(required = true) String title,
                        @RequestParam(required = true) Long sectionId, Long topicId,
                        @RequestParam(required = true) String content) {
        Long userId = getUserId();
        if (userId != null) {
            BbsPost bbsPost = new BbsPost();
            bbsPost.setTitle(title);
            bbsPost.setSectionId(sectionId);
            bbsPost.setTopicId(topicId);
            bbsPost.setCreatedBy(userId);
            if(isModerator(userId,sectionId)){
                //若发帖用户为该版块管理员，发帖状态设置为“已通过审核”
                bbsPost.setStatus("2");
            }

            BbsReply bbsReply = new BbsReply();
            bbsReply.setTitle(title);
            bbsReply.setContent(content);
            bbsReply.setIsMain("1");
            bbsReply.setCreatedBy(userId);

            //用户发帖数
            CustomerMain user = new CustomerMain();
            user.setId(userId);
            user.setBbsPostCount(1);
            userService.updateUserInfo(user);

            return bbsService.post(bbsPost, bbsReply);
        }

        return false;
    }

    /**
     * 回帖
     * @param bbsReply
     * @return
     */
    @RequestMapping(value = "/reply", produces = "application/json; charset=utf-8")
    @ResponseBody
    public boolean reply(BbsReply bbsReply) {
        Long userId = getUserId();
        if (userId != null) {
            bbsReply.setCreatedBy(userId);
            return bbsService.reply(bbsReply);
        }

        return false;
    }

    /**
     * 上传帖子图片
     * @param file
     * @return
     */
    @RequestMapping(value = "/uploadContentImg", produces = "application/json; charset=utf-8")
    @ResponseBody
    public Object uploadContentImg(@RequestParam(value = "upfile", required = false)MultipartFile file) {
        // 正文图片路径
        String savePath = PropertyUtils.getProperty("bbsPath");

        Map<String, Object> map = new HashMap<String, Object>();
        String url = uploadImg(file, savePath);
        if (url == null) {
            map.put("state", "FAILD");
        } else {
            map.put("state", "SUCCESS");
            map.put("url", url);
        }
        return new Gson().toJson(map);
    }
//    @RequestMapping(value = "/uploadContentImg", produces = "application/json; charset=utf-8")
//    @ResponseBody
//    public Object uploadContentImg(MultipartFile file) {
//        // 正文图片路径
//        String savePath = PropertyUtils.getProperty("bbsPath");
//
//        Map<String, Object> map = new HashMap<String, Object>();
//        String url = uploadImg(file, savePath);
//        if (url == null) {
//            map.put("result", 0);
//        } else {
//            map.put("result", 1);
//            map.put("url", url);
//        }
//        return new Gson().toJson(map);
//    }

    @RequestMapping("/messages")
    public ModelAndView goMessageList() {
        return new ModelAndView("/bbs/user/message");
    }

    @RequestMapping("/avatar")
    public ModelAndView goAvatar() {
        String picUrl = getUserInfo().getCustomerMain().getBbsProfilePhoto();
        return new ModelAndView("/bbs/user/avatar").addObject("picUrl", picUrl);
    }

    @RequestMapping("/search_user")
    @ResponseBody
    public Object searchUserList(@RequestParam String search,
                                 @RequestParam Integer pageNo, @RequestParam Integer pageSize) {
        SearchUserDTO userDTO = new SearchUserDTO();
        userDTO.setUsername(search);

        return bbsService.getBbsUserList(userDTO, pageNo, pageSize);
    }

    @RequestMapping("/users/{id}")
    public ModelAndView goUser(@PathVariable Long id) {
        SearchUserDTO userDTO = new SearchUserDTO();
        userDTO.setUserId(id);
        SearchUserDTO result = null;
        PageResponse<List<SearchUserDTO>> response = bbsService.getBbsUserList(userDTO, 1, 1);
        if (response.getCode() == ResultCode.SUCCESS && response.getData().size() > 0) {
            result = response.getData().get(0);
            return new ModelAndView("/bbs/user/user").addObject("user", result);
        }

        return new ModelAndView("redirect:/bbs");
    }

    @RequestMapping(value = "/userReply", produces = "application/json; charset=utf-8")
    @ResponseBody
    public Object getBbsUserReplyList(BbsReply bbsReply, Integer pageNo, Integer pageSize) {

        Map<String, Object> map = new HashMap<String, Object>();
        PageResponse<List<BbsReply>> resp = bbsService.getBbsUserReply(pageNo,
                pageSize, bbsReply);
//		map.put("totalCount", resp.getTotalPageSize());
//		map.put("data", resp.getData());
        return new Gson().toJson(resp, new TypeToken<PageResponse<List<BbsReply>>>(){}.getType());
    }

    @RequestMapping(value = "/findPost")
    public ModelAndView goFindPost(BbsReply bbsReply) {

        Long pageNo = null;
        if (null != bbsReply.getParentId() && null != bbsReply.getId()) {
            pageNo = bbsService.findPost(bbsReply);
        }
        return new ModelAndView("redirect:" + String.format("/bbs/bbsPost?id=%d&rid=%d&position=%d", bbsReply.getParentId(), bbsReply.getId(), pageNo));
    }

    @RequestMapping("/search_message")
    @ResponseBody
    public Object searchMessageList(@RequestParam Integer pageNo,
                                    @RequestParam Integer pageSize) {
        BbsMessage message = new BbsMessage();
        message.setReceiveId(getUserId());

        return bbsService.getBbsUserMessageList(message, pageNo, pageSize);
    }

    @RequestMapping(value = "/messages", method = RequestMethod.DELETE)
    @ResponseBody
    public Object delMessage(@RequestParam Long id) {

        return bbsService.deleteBbsMessage(id);
    }

    @RequestMapping(value = "/messages", method = RequestMethod.POST)
    @ResponseBody
    public Object sendMessage(BbsMessage bbsMessage) {

        bbsMessage.setCreatedBy(getUserId());

        return bbsService.createBbsMessage(bbsMessage);
    }

    /**
     * 论坛用户头像上传
     *
     * @param file 图片文件
     * @return 成功 result:1 并返回 url,失败 result:0
     */
    @RequestMapping(value = "/uploadImage", method = RequestMethod.POST)
    @ResponseBody
    public String uploadAvatar(
            @RequestParam(value = "file_input", required = false) MultipartFile file) {
        return uploadSmallImg(file);
    }

    private String uploadSmallImg(MultipartFile file) {
        // 正文图片路径
        String savePath = PropertyUtils.getProperty("avatarPath");

        Map<String, Object> map = new HashMap<String, Object>();
        String url = uploadImg(file, savePath);
        if (url == null) {
            map.put("result", 0);
        } else {
            map.put("url", url);

            // 保存头像地址
            CustomerMain customerMain = new CustomerMain();
            customerMain.setId(getUserId());
            customerMain.setBbsProfilePhoto(url);
            map.put("result", userService.updateUserInfo(customerMain) ? "1"
                    : "0");
        }
        return new Gson().toJson(map);
    }

    /**
     * 图片上传公共方法
     *
     * @param file     上传文件
     * @param savePath 保存路径
     * @return 图片URL（失败返回NULL）
     */
    private String uploadImg(MultipartFile file, String savePath) {
        // 非空验证
        if (file == null) {
            logger.info("文件空");
            return null;
        }

        // 文件名
        String fileName = file.getOriginalFilename();
        // 定义允许上传的文件扩展名
        String[] fileTypes = {"gif", "jpg", "jpeg", "png", "bmp"};
        // 最大文件大小
        long maxSize = Long.parseLong(PropertyUtils.getProperty("maxImgSize"));

        // 文件大小验证
        if (file.getSize() > maxSize) {
            logger.info("文件过大");
            return null;
        }

        // 文件类型验证
        String prefix = fileName.substring(fileName.lastIndexOf(".") + 1);
        if (!Arrays.<String>asList(fileTypes).contains(prefix)) {
            logger.info("文件类型不符");
            return null;
        }

        return FTPFileUploadUtils.uploadFile(savePath, file);
    }

    /**
     * 修改帖子
     *
     * @param bbsPost
     * @return
     */
    @RequestMapping(value = "/updateBbsPost", produces = "application/json; charset=utf-8")
    @ResponseBody
    public boolean updateBbsPost(BbsPost bbsPost) {
        Long userId = getUserId();
        if (isModerator(userId, bbsPost.getSectionId())) {
            bbsPost.setUpdatedBy(userId);
            return bbsService.updateBbsPost(bbsPost);
        }
        return false;
    }

    /**
     * 修改版块
     *
     * @param bbsSection
     * @return
     */
    @RequestMapping(value = "/updateBbsSection", produces = "application/json; charset=utf-8")
    @ResponseBody
    public boolean updateBbsSection(BbsSection bbsSection) {
        Long userId = getUserId();
        if (isModerator(userId, bbsSection.getId())) {
            bbsSection.setUpdatedBy(userId);
            return bbsService.updateBbsSection(bbsSection);
        }
        return false;
    }
    //TODO 本控制层两处修改回帖,只是请求路径不同,方法一样,对应Service层也有两处一样
    /**
     * 修改回帖
     *
     * @param bbsReply
     * @return
     */
    @RequestMapping(value = "/updateBbsReply", produces = "application/json; charset=utf-8")
    @ResponseBody
    public boolean updateBbsReply(BbsReply bbsReply) {
        Long userId = getUserId();
        if (isModerator(userId, null)) {
            bbsReply.setUpdatedBy(userId);
            return bbsService.updateBbsReply(bbsReply);
        }
        return false;
    }

    /**
     * 修改bbs用户数据
     *
     * @param id
     * @param bbsStatus
     * @return
     */
    @RequestMapping(value = "/updateBbsUser", produces = "application/json; charset=utf-8")
    @ResponseBody
    public boolean updateBbsUser(@RequestParam(required = false) Long id,
                                 String bbsStatus) {
        Long userId = getUserId();
        if (isModerator(userId, null)) {
            CustomerMain user = new CustomerMain();
            user.setUpdated_by(userId);
            user.setId(id);
            user.setBbsStatus(bbsStatus);
            return userService.updateUserInfo(user);
        }
        return false;
    }

    private boolean isModerator(Long userId, Long sectionId) {
        return bbsService.isModerator(userId, sectionId);
    }

    /**
     * 审核帖子
     * @param bbsPost
     * @return
     */
    @RequestMapping(value = "/audtingBbsPost", produces = "application/json; charset=utf-8")
    @ResponseBody
    public boolean audtingBbsPost(BbsPost bbsPost) {
        Long userId = getUserId();
        if (isModerator(userId,bbsPost.getSectionId())) {
            bbsPost.setUpdatedBy(userId);
            return bbsService.audtingBbsPost(bbsPost);
        }
        return false;
    }

    /**
     * 删除帖子
     * @param bbsPost
     * @return
     */
    @RequestMapping(value = "/deleteBbsPost", produces = "application/json; charset=utf-8")
    @ResponseBody
    public boolean deleteBbsPost(BbsPost bbsPost) {
        Long userId = getUserId();
        if (isModerator(userId,bbsPost.getSectionId())) {
            bbsPost.setUpdatedBy(userId);
            return bbsService.deleteBbsPost(bbsPost);
        }
        return false;
    }

    /**
     * 是否禁言
     * @return
     */
    @RequestMapping(value = "/isSilence", produces = "application/json; charset=utf-8")
    @ResponseBody
    public boolean isSilence(){
        return userService.getUserInfo(getUserId()).getBbsStatus().equals("0");
    }

    /**
     * 收藏帖子
     * @param postId
     * @return
     */
    @RequestMapping(value = "/collectBbsPost", produces = "application/json; charset=utf-8")
    @ResponseBody
    public boolean collectBbsPost(@RequestParam(value = "postId", required = true) Long postId) {
        Long userId = getUserId();
        if (userId != null) {
            return bbsService.collectBbsPost(postId, userId);
        }
        return false;
    }

    /**
     * 修改回帖
     *
     * @param bbsReply
     * @return
     */
    @RequestMapping(value = "/splitBbsReply", produces = "application/json; charset=utf-8")
    @ResponseBody
    public boolean splitBbsReply(BbsReply bbsReply) {
        Long userId = getUserId();
        if (isModerator(userId, null)) {
            bbsReply.setUpdatedBy(userId);
            return bbsService.splitBbsReply(bbsReply);
        }
        return false;
    }

    @RequestMapping(value = "/deleteBbsTopic", produces = "application/json; charset=utf-8")
    @ResponseBody
    public boolean deleteBbsTopic(Long id) {
        if (id != null && getUserId() != null) {
            return bbsService.deleteBbsTopic(id);
        }
        return false;
    }

    @RequestMapping(value = "/updateBbsTopic", produces = "application/json; charset=utf-8")
    @ResponseBody
    public boolean updateBbsTopic(BbsTopic bbsTopic) {
        if (getUserId() != null) {
            bbsTopic.setUpdatedBy(getUserId());
            return bbsService.updateBbsTopic(bbsTopic);
        }
        return false;
    }

    @RequestMapping(value = "/addBbsTopic", produces = "application/json; charset=utf-8")
    @ResponseBody
    public boolean addBbsTopic(BbsTopic bbsTopic) {
        if (getUserId() != null) {
            bbsTopic.setCreatedBy(getUserId());

            return bbsService.addBbsTopic(bbsTopic);
        }
        return false;
    }
    //TODO 这个请求估计是测试用的
    @RequestMapping(value = "/getEditorConfigure")
    public void getEditorCofnigure(){
        try {
            request.setCharacterEncoding("utf-8");
            response.setHeader("Content-Type", "text/html");
            String roolPath = request.getSession().getServletContext().getRealPath("/js/lib/ueditor/jsp/");
            //记得把config.json放到/Test/WEB-INF/下
            System.out.println("daniel" + roolPath);
            String configStr = new ActionEnter(request, roolPath).exec();
            System.out.println("daniel" + roolPath + "," + configStr);
            response.getWriter().write(configStr);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}

