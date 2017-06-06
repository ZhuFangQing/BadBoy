package com.i7colors.controller.bbs;

import com.google.gson.Gson;
import com.i7colors.bean.bbs.BbsMessage;
import com.i7colors.bean.bbs.SearchUserDTO;
import com.i7colors.bean.customer.CustomerMain;
import com.i7colors.controller.BaseController;
import com.i7colors.util.FTPFileUploadUtils;
import com.i7colors.util.PropertyUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Echos on 2017/3/8.
 */
@Controller
@RequestMapping("/bbs/u")
public class BbsUserController extends BaseController {
    private static final Logger logger = Logger.getLogger(BaseController.class);

    @RequestMapping()
    public ModelAndView goUser() {
        return new ModelAndView("redirect:/bbs/u/posts");
    }

    @RequestMapping("posts")
    public ModelAndView goPosts() {
        return new ModelAndView("/bbs/user/post").addObject("userId", getUserId());
    }

    @RequestMapping("/messages")
    public ModelAndView goMessageList() {
        return new ModelAndView("/bbs/user/message");
    }

    @RequestMapping("/messages/{userId}")
    public ModelAndView goMessageList(@PathVariable Long userId) {
        return new ModelAndView("/bbs/user/message_detail").addObject("userId", userId);
    }

    @RequestMapping("/avatar")
    public ModelAndView goAvatar() {
        String picUrl = getUserInfo().getCustomerMain().getBbsProfilePhoto();
        return new ModelAndView("/bbs/user/avatar").addObject("picUrl", picUrl);
    }

    @RequestMapping("/search_message")
    @ResponseBody
    public Object searchMessageList(@RequestParam Integer pageNo,
                                    @RequestParam Integer pageSize, BbsMessage message) {
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
     * @param file
     *            图片文件
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
     * @param file
     *            上传文件
     * @param savePath
     *            保存路径
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
        String[] fileTypes = { "gif", "jpg", "jpeg", "png", "bmp" };
        // 最大文件大小
        long maxSize = Long.parseLong(PropertyUtils.getProperty("maxImgSize"));

        // 文件大小验证
        if (file.getSize() > maxSize) {
            logger.info("文件过大");
            return null;
        }

        // 文件类型验证
        String prefix = fileName.substring(fileName.lastIndexOf(".") + 1);
        if (!Arrays.<String> asList(fileTypes).contains(prefix)) {
            logger.info("文件类型不符");
            return null;
        }

        return FTPFileUploadUtils.uploadFile(savePath, file);
    }
}
