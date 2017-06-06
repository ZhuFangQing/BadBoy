<%--
  Created by IntelliJ IDEA.
  User: Echos
  Date: 2017/1/6
  Time: 13:05
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

    <link rel="stylesheet" href="http://g.alicdn.com/de/prismplayer/1.4.10/skins/default/index.css" />
    <script type="text/javascript" src="http://g.alicdn.com/de/prismplayer/1.4.10/prism.js"></script>

    <script type="text/javascript" src="/js/school_article.js"></script>
    <style>
        .face{
            width: 40px;
            height: 40px;
        }
        .reply_comments{
            margin-left: 25px;
        }
    </style>
</head>
<body>

<%--top模块--%>
<%@ include file="../common/top.jsp" %>


<!--行业资讯标题-->
<div class="container">
    <p class="business-title">
        <a href="/"><span>首页</span></a>
        &gt;
        <a href="/school/industry"><span>大学堂</span></a>
        &gt;
        <span>${schoolArticle.title}</span>
    </p>
</div>
<!--行业资讯标题-end-->


<!--主体-->
<div class="container">
    <input type="hidden" id="articleId" value="${articleId}">
    <input type="hidden" id="articleType" value="${schoolArticle.type}">
    <input type="hidden" id="videoUrl" value="${schoolArticle.schoolMedia.url}">
    <input type="hidden" id="outUrl" value="${schoolArticle.outUrl}">
    <input type="hidden" id="pdfUrl" value="${schoolArticle.pdfUrl}">

    <!--主体左侧-->
    <div class="business-left">


        <div class="bs-detail-title">
            <h1>${schoolArticle.title}</h1>
            <p><fmt:formatDate value="${schoolArticle.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" />　<span>编辑：${schoolArticle.author}</span></p>
        </div>

        <div class="bs-detail-content">
            <%--<p class="bs-detail-content-title">${news.title}</p>--%>

            <div class="prism-player" id="J_prismPlayer" style="margin-top: 13px;margin-bottom: 13px;"></div>

            ${schoolArticle.content}

        </div>
        <div class="article-btn">
            <a href="/information/${prev.id}"><c:if test="${!empty prev}">上一篇：(<span>${prev.title}</span>)</c:if></a>
            <a href="/information/${next.id}"><c:if test="${!empty next}">下一篇：(<span>${next.title}</span>)</c:if></a>
        </div>

        <div class="bs-detail-content-bottom">
            <p class="related-news">相关新闻</p>
            <ul>
                <c:forEach items="${rankingList}" var="item" end="6">

                    <c:set var="title" value="${item.title}"></c:set>
                    <c:if test="${fn:length(item.title) >23}">
                        <c:set var="title" value="${fn:substring(item.title,0,23)}..."></c:set>
                    </c:if>
                    <li><a href="/school/articles/${item.id}">${title}</a></li>
                </c:forEach>
            </ul>
        </div>

        <div class="review">
            <p class="review-title">评论</p>

            <div class="send-review" name="send-review">
                <img src="/images/person_img.jpg" class="face"/>
                <textarea id="replyContent" maxlength="300"></textarea>
                <span id="replyContentNum">0/300</span>
                <a href="javascript:;" id="btn_submit">发表评论</a>
            </div>

            <ul class="review-list">
            </ul>
        </div>
    </div>


    <!--主体右侧-->
    <jsp:include page="right.jsp"></jsp:include>

</div>

<div class="business-pages container">
    <jsp:include page="/page/common/pagination.jsp"></jsp:include>
</div>

<%@ include file="../common/foot.jsp" %>
</body>
</html>
