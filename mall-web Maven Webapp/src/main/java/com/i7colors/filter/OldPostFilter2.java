package com.i7colors.filter;

import com.i7colors.service.bbs.BbsService;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Daniel on 2017/5/3.
 */
public class OldPostFilter2 implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpServletRequest req = (HttpServletRequest) request;
        String url = req.getRequestURI();

        //旧论坛帖子拦截 如/bbs/forum.php?mod=viewthread&tid=52772

        Long postId = Long.parseLong(req.getParameter("tid"));
        BbsService bbsService = new BbsService();
        if (postId != null) {
            resp.sendRedirect(req.getContextPath() + "/bbs/bbsPost?id=" + postId);
        } else {
            resp.sendRedirect(req.getContextPath() + "/bbs");
        }
        return;
    }

    @Override
    public void destroy() {

    }
}
