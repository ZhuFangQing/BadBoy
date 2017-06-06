<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>七彩云</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <%@include file="../common/resource.jsp" %>
    <link href="/css/school.css" rel="stylesheet" type="text/css"/>
    <style>
        .ellipsis{
            text-overflow: ellipsis;
            width: 13em;
            overflow: hidden;
            white-space: nowrap;
            height:22px;
        }
    </style>
</head>
<body>
<%--top模块--%>
<%@ include file="../common/top.jsp" %>
<div class="container" style="padding-bottom:30px;">
    <div class="school_head mb20">
        <div class="school_menu">
            <ul>
                <c:forEach items="${menuList}" var="map">
                    <li>
                        <c:if test="${map.parentMenu.id==1}">
                            <img src="/images/zj_icon.png" width="15"/>
                        </c:if>
                        <c:if test="${map.parentMenu.id==2}">
                            <img src="/images/edu_icon.png" width="15"/>
                        </c:if>
                        <c:if test="${map.parentMenu.id==3}">
                            <img src="/images/baike_icon.png" width="15" style="top:11px;"/>
                        </c:if>
                        <c:if test="${map.parentMenu.id==4}">
                            <img src="/images/hz_icon.png" width="15" style="top:10px;"/>
                        </c:if>
                        <c:if test="${map.parentMenu.id==5}">
                            <img src="/images/rc_icon.png" width="15"/>
                        </c:if>
                        <c:if test="${map.parentMenu.id==6}">
                            <img src="/images/jl_icon.png" width="15"/>
                        </c:if>
                        <h1>${map.parentMenu.name}</h1>
                        <c:forEach items="${map.childMenu}" var="childList">
                            <a href="/school/industry?t=${childList.id}">${childList.name}</a>
                        </c:forEach>

                    </li>
                </c:forEach>

            </ul>
            <a class="forum_btn" href="/bbs" style="position: relative;top: 50px;"><img
                    src="/images/forum_btn.png"/></a>
        </div>
        <div class="school_banner_box">
            <div class="school_banner">
                <div class="swiper-container" id="school_banner">
                    <div class="swiper-wrapper">
                        <c:forEach items="${adList}" var="adList">
                            <div class="swiper-slide"><a href="${adList.ad_url}"><img src="${itx}${adList.ad_image}"
                                                                                      width="803" height="268"/></a>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="pagination" id="school_banner_swp"></div>
                </div>
            </div>
            <div class="new_class_list">
                <div class="new_class_title">热门推荐</div>
                <div class="new_class_list_box">
                    <div class="swiper-container" id="new_class">
                        <div class="swiper-wrapper">
                            <c:forEach items="${recommendList}" var="item">
                                <div class="swiper-slide">
                                    <div class="new_class">
                                        <a href="/school/articles/${item.id}">
                                            <img src="${itx}${item.coverUrl}" height="90px;" width="144px;"/>
                                                ${fn:substring(item.title, 0, 20)}...
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="swiper-button-prev" id="sb_prev"></div>
                    <div class="swiper-button-next" id="sb_next"></div>
                </div>
            </div>
        </div>
        <div class="school_hot">
            <div class="school_hot_title"><span>热门话题</span></div>
            <div class="school_hot_content">
                <%--<img src="/images/school_hot_img.jpg" width="100%" />--%>
                <c:forEach items="${hotTopicList}" var="hotTopic" end="3">
                    <div class="school_hot_list">
                        <h1 class="ellipsis">${hotTopic.bbsPost.title}</h1>
                        <div class="ellipsis">${hotTopic.bbsPost.content}</div>
                        <a href="bbs/bbsPost?id=${hotTopic.bbsPost.id}" class="school_hot_link">查看原文</a>
                    </div>
                </c:forEach>
                <a href="/bbs" class="school_hot_more">更多论坛热帖 》</a>
            </div>
        </div>
        <div class="clear"></div>
    </div>
    <table class="school_class_box mb20" width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <th><span>教育培训</span><em>最新教学课件，职场再添助力</em></th>
            <th><span>印染百科</span><em>印花染色整理，干货一网打尽</em></th>
            <th class="last"><span>印染新闻</span></th>
        </tr>
        <tr>
            <td>
                <div class="class_info_box">
                    <div class="class_info_title">
                        <c:if test="${not empty educationList}">
                            <c:set var="item" value="${educationList.get(0)}"></c:set>
                            <img src="${itx}${item.coverUrl}" width="200px;" height="125px;"/>
                            <div class="class_info_title_text">
                                <h1>${fn:substring(item.title, 0, 13)}...</h1>
                                <p>${fn:substring(item.contentSummary, 0, 35)}...</p>
                                <p>讲课老师：${item.author}</p>
                                <a class="class_info_link" href="/school/articles/${item.id}">立即查看</a>
                            </div>
                        </c:if>
                    </div>
                    <div class="class_info_more">
                        <h1>更多内容</h1>

                        <ul class="half">
                            <c:forEach items="${educationList}" var="item" begin="1" end="3">
                                <c:set var="title" value="${item.title}"></c:set>
                                <c:if test="${fn:length(item.title) > 15}">
                                    <c:set var="title" value="${fn:substring(item.title, 0, 15)}..."></c:set>
                                </c:if>

                                <a href="/school/articles/${item.id}">
                                    <li>${title}</li>
                                </a>
                            </c:forEach>
                        </ul>

                        <ul class="half">
                            <c:forEach items="${educationList}" var="item" begin="4" end="6">
                                <c:set var="title" value="${item.title}"></c:set>
                                <c:if test="${fn:length(item.title) > 15}">
                                    <c:set var="title" value="${fn:substring(item.title, 0, 15)}..."></c:set>
                                </c:if>

                                <a href="/school/articles/${item.id}">
                                    <li>${title}</li>
                                </a>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </td>
            <td>
                <div class="class_info_box brn">
                    <div class="class_info_title">
                        <c:if test="${not empty encyclopediasList}">
                            <c:set var="item" value="${encyclopediasList.get(0)}"></c:set>
                            <img src="${itx}${item.coverUrl}" width="200px;" height="125px;"/>
                            <div class="class_info_title_text">
                                <h1>${fn:substring(item.title, 0, 13)}...</h1>
                                <p>${fn:substring(item.contentSummary, 0, 35)}...</p>
                                <p>讲课老师：${item.author}</p>
                                <a class="class_info_link" href="/school/articles/${item.id}">立即查看</a>
                            </div>
                        </c:if>
                    </div>
                    <div class="class_info_more">
                        <h1>更多内容</h1>

                        <ul class="half">
                            <c:forEach items="${encyclopediasList}" var="item" begin="1" end="3">
                                <c:set var="title" value="${item.title}"></c:set>
                                <c:if test="${fn:length(item.title) > 15}">
                                    <c:set var="title" value="${fn:substring(item.title, 0, 15)}..."></c:set>
                                </c:if>

                                <a href="/school/articles/${item.id}">
                                    <li>${title}</li>
                                </a>
                            </c:forEach>
                        </ul>

                        <ul class="half">
                            <c:forEach items="${encyclopediasList}" var="item" begin="4" end="6">
                                <c:set var="title" value="${item.title}"></c:set>
                                <c:if test="${fn:length(item.title) > 15}">
                                    <c:set var="title" value="${fn:substring(item.title, 0, 15)}..."></c:set>
                                </c:if>

                                <a href="/school/articles/${item.id}">
                                    <li>${title}</li>
                                </a>
                            </c:forEach>
                        </ul>
                        <%--<ul>
                            <c:forEach items="${encyclopediasList}" var="item" begin="1">
                                <c:set var="title" value="${item.title}"></c:set>
                                <c:if test="${fn:length(item.title) > 23}">
                                    <c:set var="title" value="${fn:substring(item.title, 0, 23)}..."></c:set>
                                </c:if>
                                <a href="/school/articles/${item.id}"><li>${title}<span style="width: 115px;">时间：<fmt:formatDate value="${item.createdAt}" pattern="yyyy-MM-dd"/></span></li></a>
                            </c:forEach>
                        </ul>--%>
                    </div>
                </div>
            </td>
            <td class="last">
                <c:forEach items="${dyeNewsList}" var="dyeNewsList" begin="0" end="2">
                    <div class="school_hot_list">
                        <c:if test="${fn:length(dyeNewsList.title) >13}">
                            <h1>${fn:substring(dyeNewsList.title, 0, 13)}...</h1>
                        </c:if>
                        <c:if test="${fn:length(dyeNewsList.title) <=13}">
                            <h1>${dyeNewsList.title}</h1>
                        </c:if>

                        <c:if test="${fn:length(dyeNewsList.content_summary) >13}">
                            <p>${fn:substring(dyeNewsList.content_summary, 0, 13)}...</p>
                        </c:if>
                        <c:if test="${fn:length(dyeNewsList.content_summary) <=13}">
                            <p>${dyeNewsList.content_summary}</p>
                        </c:if>
                        <a href="/information/${dyeNewsList.id}" target="_blank" class="school_hot_link">查看原文</a>
                    </div>
                </c:forEach>
            </td>
        </tr>
    </table>
    <table class="school_class_box mb20" width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <th><span>专家团队</span><em>院所学校工厂，教授专家精英</em></th>
            <th><span>技术交流</span><em>分享难点疑点，紧抓技术前沿</em></th>
            <th class="last"><span>论坛新帖</span></th>
        </tr>
        <tr>
            <td>
                <div class="class_info_box brn">

                    <div class="class_info_title">
                        <c:if test="${not empty expertList}">
                            <c:set var="item" value="${expertList.get(0)}"></c:set>
                            <img src="${itx}${item.coverUrl}" width="200px;" height="125px;"/>
                            <div class="class_info_title_text">
                                <h1>${fn:substring(item.title, 0, 13)}...</h1>
                                <p>${fn:substring(item.contentSummary, 0, 45)}...</p>
                                    <%--<p>讲课老师：${item.author}</p>--%>
                                <a class="class_info_link" href="/school/articles/${item.id}">立即查看</a>
                            </div>
                        </c:if>
                    </div>
                    <div class="class_info_more">
                        <h1>更多专家</h1>

                        <ul class="half">
                            <c:forEach items="${expertList}" var="item" begin="1" end="3">
                                <c:set var="title" value="${item.title}"></c:set>
                                <c:if test="${fn:length(item.title) > 15}">
                                    <c:set var="title" value="${fn:substring(item.title, 0, 15)}..."></c:set>
                                </c:if>

                                <a href="/school/articles/${item.id}">
                                    <li>${title}</li>
                                </a>
                            </c:forEach>
                        </ul>

                        <ul class="half">
                            <c:forEach items="${expertList}" var="item" begin="4" end="6">
                                <c:set var="title" value="${item.title}"></c:set>
                                <c:if test="${fn:length(item.title) > 15}">
                                    <c:set var="title" value="${fn:substring(item.title, 0, 15)}..."></c:set>
                                </c:if>

                                <a href="/school/articles/${item.id}">
                                    <li>${title}</li>
                                </a>
                            </c:forEach>
                        </ul>

                        <%--<ul>
                            <c:forEach items="${expertList}" var="item" begin="1">
                                <c:set var="title" value="${item.title}"></c:set>
                                <c:if test="${fn:length(item.title) > 23}">
                                    <c:set var="title" value="${fn:substring(item.title, 0, 23)}..."></c:set>
                                </c:if>
                                <a href="/school/articles/${item.id}"><li>${title}<span style="width: 115px;">时间：<fmt:formatDate value="${item.createdAt}" pattern="yyyy-MM-dd"/></span></li></a>
                            </c:forEach>
                        </ul>--%>
                    </div>
                </div>
            </td>
            <td>
                <div class="class_info_box brn">
                    <div class="class_info_title">
                        <c:if test="${not empty technologyExchangeList}">
                            <c:set var="item" value="${technologyExchangeList.get(0)}"></c:set>
                            <img src="${itx}${item.coverUrl}" width="200px;" height="125px;"/>
                            <div class="class_info_title_text">
                                <h1>${fn:substring(item.title, 0, 13)}...</h1>
                                <p>${fn:substring(item.contentSummary, 0, 45)}...</p>
                                    <%--<p>讲课老师：${item.author}</p>--%>
                                <a class="class_info_link" href="/school/articles/${item.id}">立即查看</a>
                            </div>
                        </c:if>
                    </div>
                    <div class="class_info_more">
                        <h1>更多内容</h1>

                        <ul class="half">
                            <c:forEach items="${technologyExchangeList}" var="item" begin="1" end="3">
                                <c:set var="title" value="${item.title}"></c:set>
                                <c:if test="${fn:length(item.title) > 15}">
                                    <c:set var="title" value="${fn:substring(item.title, 0, 15)}..."></c:set>
                                </c:if>

                                <a href="/school/articles/${item.id}">
                                    <li>${title}</li>
                                </a>
                            </c:forEach>
                        </ul>

                        <ul class="half">
                            <c:forEach items="${technologyExchangeList}" var="item" begin="4" end="6">
                                <c:set var="title" value="${item.title}"></c:set>
                                <c:if test="${fn:length(item.title) > 15}">
                                    <c:set var="title" value="${fn:substring(item.title, 0, 15)}..."></c:set>
                                </c:if>

                                <a href="/school/articles/${item.id}">
                                    <li>${title}</li>
                                </a>
                            </c:forEach>
                        </ul>
                        <%--<ul>
                            <c:forEach items="${technologyExchangeList}" var="item" begin="1">
                                <c:set var="title" value="${item.title}"></c:set>
                                <c:if test="${fn:length(item.title) > 23}">
                                    <c:set var="title" value="${fn:substring(item.title, 0, 23)}..."></c:set>
                                </c:if>
                                <a href="/school/articles/${item.id}"><li>${title}<span style="width: 115px;">时间：<fmt:formatDate value="${item.createdAt}" pattern="yyyy-MM-dd"/></span></li></a>
                            </c:forEach>
                        </ul>--%>
                    </div>
                </div>
            </td>
            <td class="last np">
                <c:forEach items="${expertForumList}" var="post" end="6" varStatus="i">
                    <c:choose>
                        <c:when test="${i.index==0}">
                            <div class="school_hot_list zj open">
                                <h1 class="ellipsis">${post.title}</h1>
                                <div class="school_zj_detil" style="display:block;">
                                    <div class="ellipsis" style="height:44px">${post.content}</div>
                                    <a href="/bbs/bbsPost?id=${post.id}" class="school_hot_link">查看原文</a>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="school_hot_list zj">
                                <h1 class="ellipsis">${post.title}</h1>
                                <div class="school_zj_detil">
                                    <div class="ellipsis" style="height:44px">${post.content}</div>
                                    <a href="/bbs/bbsPost?id=${post.id}" class="school_hot_link">查看原文</a>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <%--<div class="school_hot_list zj open">--%>
                    <%--<h1>纺织品常用染料及...</h1>--%>
                    <%--<div class="school_zj_detil" style="display:block;">--%>
                        <%--<p>这些纺织设备主要来自德国、意大利、日本和台湾等国家和地区</p>--%>
                        <%--<a href="#" class="school_hot_link">查看原文</a>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="school_hot_list zj">--%>
                    <%--<h1>纺织品常用染料及...</h1>--%>
                    <%--<div class="school_zj_detil">--%>
                        <%--<p>这些纺织设备主要来自德国、意大利、日本和台湾等国家和地区</p>--%>
                        <%--<a href="#" class="school_hot_link">查看原文</a>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="school_hot_list zj">--%>
                    <%--<h1>纺织品常用染料及...</h1>--%>
                    <%--<div class="school_zj_detil">--%>
                        <%--<p>这些纺织设备主要来自德国、意大利、日本和台湾等国家和地区</p>--%>
                        <%--<a href="#" class="school_hot_link">查看原文</a>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="school_hot_list zj">--%>
                    <%--<h1>纺织品常用染料及...</h1>--%>
                    <%--<div class="school_zj_detil">--%>
                        <%--<p>这些纺织设备主要来自德国、意大利、日本和台湾等国家和地区</p>--%>
                        <%--<a href="#" class="school_hot_link">查看原文</a>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="school_hot_list zj">--%>
                    <%--<h1>纺织品常用染料及...</h1>--%>
                    <%--<div class="school_zj_detil">--%>
                        <%--<p>这些纺织设备主要来自德国、意大利、日本和台湾等国家和地区</p>--%>
                        <%--<a href="#" class="school_hot_link">查看原文</a>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="school_hot_list zj">--%>
                    <%--<h1>纺织品常用染料及...</h1>--%>
                    <%--<div class="school_zj_detil">--%>
                        <%--<p>这些纺织设备主要来自德国、意大利、日本和台湾等国家和地区</p>--%>
                        <%--<a href="#" class="school_hot_link">查看原文</a>--%>
                    <%--</div>--%>
                <%--</div>--%>
            </td>
        </tr>
    </table>
    <table class="school_class_box mb20" width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <th colspan="2"><span>热门课程</span><em>技术管理技巧，各类课程课件</em></th>
            <th class="last"><span>点击排行</span></th>
        </tr>
        <tr>
            <td colspan="2" class="pjp">
                <ul class="hot_class_list">
                    <c:forEach items="${popularCourseList}" var="item">
                        <li>
                            <a href="/school/articles/${item.id}">
                                <img src="${itx}${item.coverUrl}" width="200px;" height="125px;"/>
                                <c:set var="title" value="${item.title}"></c:set>
                                <c:if test="${fn:length(item.title) > 14}">
                                    <c:set var="title" value="${fn:substring(item.title, 0, 14)}..."></c:set>
                                </c:if>
                                <div class="hot_class_title">${title}</div>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </td>
            <td class="last np">
                <ul class="db_list">
                    <c:forEach items="${rankingList}" var="item" varStatus="idx">
                        <li ${idx.index < 3 ? "class=\"top_three\"" : ""} ><em>${idx.index+1}</em><a
                                href="/school/articles/${item.id}">${fn:substring(item.title, 0, 14)}...</a></li>
                    </c:forEach>
                </ul>
            </td>
        </tr>
    </table>
    <table class="school_class_box mb20" width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <th colspan="3"><span>论坛精华</span><em>提炼精华内容，了解行业关注</em></th>
        </tr>
        <tr>
            <td colspan="3" class="pjp">
                <div class="bbs_essence">
                    <img src="${itx}${hotTopicList[0].coverUrl}" width="200" height="290px;"/>
                    <div class="bbs_essence_info">
                        <a target="_blank" href="/bbs/bbsPost?id=${hotTopicList[0].bbsPost.id}">
                            <h1 class="ellipsis">${hotTopicList[0].bbsPost.title}</h1></a>
                        <p class="ellipsis">${hotTopicList[0].bbsPost.content}</p>
                        <c:forEach items="${forumEssenceList}" var="post" varStatus="i" end="8">
                            <a target="_blank" href="/bbs/bbsPost?id=${post.id}">
                                <dl>
                                    <dt>${post.title}</dt>
                                    <dd></dd>
                                </dl>
                            </a>
                        </c:forEach>
                    </div>
                </div>
                <div class="bbs_essence">
                    <img src="${itx}${hotTopicList[1].coverUrl}" width="200" height="290px;"/>
                    <div class="bbs_essence_info">
                        <a target="_blank" href="/bbs/bbsPost?id=${hotTopicList[1].bbsPost.id}">
                            <h1 class="ellipsis">${hotTopicList[1].bbsPost.title}</h1></a>
                        <p class="ellipsis">${hotTopicList[1].bbsPost.content}</p>
                        <c:forEach items="${forumEssenceList}" var="post" varStatus="i" begin="9" end="17">
                            <a target="_blank" href="/bbs/bbsPost?id=${post.id}">
                                <dl>
                                    <dt>${post.title}</dt>
                                    <dd></dd>
                                </dl>
                            </a>
                        </c:forEach>
                    </div>
                </div>

            </td>
        </tr>
    </table>
</div>

<!--pages-->
<div class="business-pages container" style="height: 30px;">
</div>
<!--pages-end-->

<jsp:include page="/page/common/foot_partner.jsp"></jsp:include>

<%--foot--%>
<%@ include file="/page/common/foot.jsp" %>
</body>
</html>
