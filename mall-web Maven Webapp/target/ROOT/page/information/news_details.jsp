<%--
  Created by IntelliJ IDEA.
  User: Echos
  Date: 2016/11/29
  Time: 17:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>七彩云</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%@include file="../common/resource.jsp" %>
    <link href="/css/business.css" rel="stylesheet" type="text/css" />
    <link href="/css/businessDetail.css" rel="stylesheet" type="text/css" />
</head>
<body>

<%--top模块--%>
<%@ include file="../common/top.jsp" %>


<!--行业资讯标题-->
<div class="container">
    <p class="business-title">
        <a href="/"><span>首页</span></a>
        &gt;
        <a href="/information"><span>行业资讯</span></a>
        &gt;
        <span>${news.title}</span>
    </p>
</div>
<!--行业资讯标题-end-->


<!--主体-->
<div class="container">

    <!--主体左侧-->
    <div class="business-left">


        <div class="bs-detail-title">
            <h1>${news.title}</h1>
            <p>${empty news.news_date ? "" : fn:substring(news.news_date, 0, 10)}　<span>编辑：${news.author}</span></p>
        </div>

        <div class="bs-detail-content">
            <%--<p class="bs-detail-content-title">${news.title}</p>--%>

            ${news.content}

        </div>
        <div class="article-btn">
            <a href="/information/${prev.id}"><c:if test="${!empty prev}">上一篇：(<span>${fn:substring(prev.title, 0, 20)}...</span>)</c:if></a>
            <a href="/information/${next.id}"><c:if test="${!empty next}">下一篇：(<span>${fn:substring(next.title, 0, 20)}...</span>)</c:if></a>
        </div>

        <div class="bs-detail-content-bottom">
            <%--<p class="related-news">相关新闻</p>
            <ul>
                <li><a href="javscript:;">印染概念股浙江龙盛：染料价格回升</a></li>
                <li><a href="javscript:;">印染概念股浙江龙盛：染料价格回升</a></li>
                <li><a href="javscript:;">医院布料的印染制作要求</a></li>
                <li><a href="javscript:;">医院布料的印染制作要求</a></li>
                <li><a href="javscript:;">印染行业成植物重点 行业需加快绿色转型</a></li>
                <li><a href="javscript:;">印染行业成植物重点 行业需加快绿色转型</a></li>
            </ul>--%>
        </div>



    </div>


    <jsp:include page="rightSideInformation.jsp"></jsp:include>

</div>

<%@ include file="../common/foot.jsp" %>
</body>
</html>
