<%--
  Created by IntelliJ IDEA.
  User: Echos
  Date: 2016/11/29
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>七彩云</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%@include file="/page/common/resource.jsp" %>
    <link rel="stylesheet" type="text/css" href="http://www.i7colors.com/ec/p/public/style/default2015_my/css/mall_serve.css" />
    <link href="/css/about.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/jscript" src="/js/alagzn.js"></script>
    <script>
        $(document).ready(function(){
            $("ul.about_menu_list li").click(function(){
                $("ul.about_menu_list li").removeClass("onthis");
                $("div.about_right").hide();
                $(this).addClass("onthis");
                $("div." + $(this).attr("data-type")).show();
            })
        })
    </script>
</head>
<body>
<%--top模块--%>
<%@ include file="/page/common/top.jsp" %>


<div class="container">
    <p class="business-title brb mb20">
        <span>首页</span>
        &gt;
        <span>技术服务</span>
        <%--&gt;
        <span>七彩云简介</span>--%>
    </p>
    <div class="about_left">
        <div class="about_menu">
            <h1 class="about_title"><em></em>七彩云服务</h1>
            <ul class="about_menu_list">
                <a href="javascript:;"><li data-type="i7_about" class="onthis">客户服务</li></a>
            </ul>
        </div>
        <img src="images/about_img.jpg" width="240" />
    </div>
    <div class="about_right i7_about">
        <div class="about_con_title">客户服务</div>
        <div>
            <div class="part part07 of">
                <div class="dw">&nbsp;
                    <a name="a1" id="a1"></a>
                </div>
                <ul class="part-con2 of" style="width:956px; margin:-50px auto 40px;overflow:hidden;">
                    <li class="one">
                        <h2>400客服热线</h2>
                        <div class="icon-img of"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/img0014.jpg" /></div>
                        <div class="txt01 txt">专业的电话服务热线，为您及时解决问题</div>
                        <div class="txt02 txt">强大的电话客服团队，让您感受一站式购物体验</div>
                    </li>
                    <li class="two">
                        <h2>在线咨询</h2>
                        <div class="icon-img of"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/img0015.jpg" /></div>
                        <div class="txt01 txt">为您提供各种在线咨询，无需等待</div>
                        <div class="txt02 txt">非工作时间可留言，工作日2H内及时响应</div>
                    </li>
                    <li class="one">
                        <h2>自助服务</h2>
                        <div class="icon-img of"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/img0016.jpg" /></div>
                        <div class="txt01 txt">快速解决常见问题，自助、高效</div>
                        <div class="txt02 txt">详细的购物指南，轻松了解操作方式</div>
                    </li>
                    <li class="two">
                        <h2>专属客服</h2>
                        <div class="icon-img of"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/img0017.jpg" /></div>
                        <div class="txt01 txt">七彩云为优质会员提供专人专属客服，专享贴心服务</div>
                        <div class="txt02 txt">非工作时间可留言，工作日0.5H内及时响应</div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>


<%@ include file="/page/common/foot.jsp" %>
</body>
</html>