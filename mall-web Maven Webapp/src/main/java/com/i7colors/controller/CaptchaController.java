package com.i7colors.controller;

import com.i7colors.commons.constant.ConstCookieFlag;
import com.i7colors.util.CaptchaUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Echos on 2016/12/1.
 */
@Controller
@RequestMapping
public class CaptchaController {
    @RequestMapping(value="/captcha" ,method = RequestMethod.GET)
    @ResponseBody
    public void captcha(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        CaptchaUtils.outputCaptcha(request, response, ConstCookieFlag.I7COLOR_IMG_CODE);
    }

    @RequestMapping(value="/findCaptcha" ,method = RequestMethod.GET)
    @ResponseBody
    public void findCaptcha(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        CaptchaUtils.outputCaptcha(request, response, ConstCookieFlag.I7COLOR_FIND_IMG_CODE);
    }
}
