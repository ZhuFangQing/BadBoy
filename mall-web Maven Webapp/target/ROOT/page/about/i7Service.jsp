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
    <link href="/css/mall_serve.css" rel="stylesheet" type="text/css" />
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
            if('${t}'=='1'){
                $("ul.about_menu_list li[data-type='i7_about']").click()
            }
            if('${t}'=='2'){
                $("ul.about_menu_list li[data-type='i7_partner']").click()
            }
            if('${t}'=='3'){
                $("ul.about_menu_list li[data-type='i7_future']").click()
            }
            <%--if('${t}'=='4'){--%>
                <%--$("ul.about_menu_list li[data-type='i7_guide']").click()--%>
            <%--}--%>
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
            <h1 class="about_title"><em></em>技术服务</h1>
            <ul class="about_menu_list">
                <a href="javascript:;"><li data-type="i7_about" class="onthis">技术检测</li></a>
                <a href="javascript:;"><li data-type="i7_partner">专家顾问</li></a>
                <a href="javascript:;"><li data-type="i7_future">知识库</li></a>
            </ul>
        </div>
        <img src="images/about_img.jpg" width="240" />
    </div>
    <div class="about_right i7_about">
        <div class="about_con_title">技术检测</div>
        <ul class="skill-list of">
            <li id="fenxijiance" style="width:960px; margin-bottom:50px;">
                <div class="skill-title"></div>
                <div class="skill-list-txt">
                    <p>色彩服务一站式解决方案是我们的服务目标。七彩云团队为会员提供包括原材料、成品等全方位的分析检测服务。支持会员提供更好地产业链系统服务。</p>
                    <p><br/></p>
                    <p>七彩云电子商务拥有一只稳定的技术工程师队伍，用户在产品使用过程中如出现疑问或问题，可以随时电话联系我们（服务热线：4009208599）；</p>
                    <p><br/></p>
                    <p>如有特殊需求，我们可提供上门服务。</p>
                    <p><br/></p>
                    <%--<p>上门服务申请，请点击<a href="javascript:void(0)">这里</a>交给我们，我们将第一时间联系您提供服务。</p>--%>
                </div>
                <a href="javascript:void(0)" class="skill-list-link"></a>
                <div class="skill-list-icon"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/img0011.png"></div>
            </li>
        </ul>
    </div>
    <div class="about_right i7_partner" style="display: none;">
        <div class="about_con_title">专家顾问</div>
        <ul class="skill-list of">
            <li id="zhuanjiaguwen" style="width:960px; margin-bottom:50px;">
                <div class="skill-title"></div>
                <div class="skill-list-txt">
                    <p>七彩云电子商务在快速成长的道路上需要启迪与指导。</p>
                    <p><br/></p>
                    <p>七彩云大学堂专家顾问团队，汇聚了来自大专院校、印染企业、染料公司等各领域的专家和精英。集权威性、专业性于一体的专家团队为用户提供信心，为发展注入动力。</p>
                </div>
                <%--<a href="school.html" class="skill-list-link">查看专家列表</a>--%>
                <div class="skill-list-icon"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/img0010.png"></div>
            </li>
        </ul>
    </div>
    <div class="about_right i7_future" style="display: none;">
        <div class="about_con_title">知识库</div>
        <ul class="skill-list of">
            <li id="zhishiku" style="width:960px; margin-bottom:50px;">
                <div class="skill-title"></div>
                <div class="skill-list-txt">
                    <p>七彩云有强烈意愿与用户在染整技术方面共同成长，我们将集合各方技术力量总和各种染整技术文献，建立从基础到中级到高阶的印染知识库。</p>
                    <p><br/></p>
                    <p>本知识库不只是技术资料的沉淀，还涉及对印染发展趋势和周边相关技术的收集介绍。我们将陆续增加内容，使其完善；</p>
                    <p><br/></p>
                    <%--<p>点击<a href="javascript:void(0)">这里</a>进入知识库</p>--%>
                    <p><br/></p>
                    <p>工作日欢迎拨打服务热线：4009208599</p>
                </div>
                <%--<a href="javascript:void(0)" class="skill-list-link">非工作日留言</a>--%>
                <div class="skill-list-icon"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/img0013.png"></div>
            </li>
        </ul>
    </div>
    <%--<div class="about_right i7_guide" style="display: none;">--%>
        <%--<div class="about_con_title">技术服务</div>--%>
        <%--<ul class="skill-list of">--%>
            <%--<li id="xianchangjifu" style="width:960px; margin-bottom:50px;">--%>
                <%--<div class="skill-title"></div>--%>
                <%--<div class="skill-list-txt">--%>
                    <%--<p>七彩云应用技术团队拥有丰富的印染现场实践经验，结合专业的染料知识培训，根据会员需求，七彩云技术团队可以提供包括现场培训、问题解决等现场技服，近距离高效解决客户现场问题。</p>--%>
                    <%--<p><br/></p>--%>
                    <%--<p>七彩云电子商务拥有一只稳定的技术工程师队伍，用户在产品使用过程中如出现疑问或问题，可以随时电话联系我们（服务热线：4009208599）；</p>--%>
                    <%--<p><br/></p>--%>
                    <%--<p>如有特殊需求，我们可提供上门服务。</p>--%>
                    <%--<p><br/></p>--%>
                    <%--<p>上门服务申请，请点击<a href="javascript:void(0)">这里</a>交给我们，我们将第一时间联系您提供服务。</p>--%>
                <%--</div>--%>
                <%--<a href="javascript:void(0)" class="skill-list-link"></a>--%>
                <%--<div class="skill-list-icon"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/img0012.png"></div>--%>
            <%--</li>--%>
        <%--</ul>--%>
    <%--</div>--%>
    <div class="clear"></div>
</div>


<%@ include file="/page/common/foot.jsp" %>
</body>
</html>