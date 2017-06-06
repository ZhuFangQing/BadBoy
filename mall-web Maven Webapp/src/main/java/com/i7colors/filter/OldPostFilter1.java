package com.i7colors.filter;

import com.i7colors.service.bbs.BbsService;
import com.i7colors.util.StringUtil;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Daniel on 2017/5/3.
 */
public class OldPostFilter1  implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpServletRequest req = (HttpServletRequest) request;
        String url = req.getRequestURI();

        //旧论坛帖子拦截 如/bbs/thread-52772-1-1.html
        String postIdStr = "";
        Long postId;
        Pattern p = Pattern.compile("/bbs/thread-(\\d+).*\\.html");
        Matcher m = p.matcher(url);
        if(m.matches()){
            postIdStr = m.group(1);
            if (!StringUtil.isBlank(postIdStr)) {
                postId = Long.parseLong(postIdStr);
                if(postId != null) {
                    resp.sendRedirect(req.getContextPath() + "/bbs/bbsPost?id=" + postId);
                }else{
                    resp.sendRedirect(req.getContextPath() + "/bbs");
                }
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {

    }
}
