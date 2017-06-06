<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>七彩云</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <%@include file="../common/resource.jsp" %>
    <script src="/js/bbs.js?t=${now}"></script>
    <link href="/css/bbs.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%--top模块--%>
<%@ include file="../common/top.jsp" %>

<div class="container">
    <jsp:include page="/page/bbs/common/bbs_search_box.jsp"></jsp:include>
    <p class="business-title">
        <span>首页</span>
        &gt;
        <span>七彩云论坛（染者无疆）</span>
    </p>
    <div class="bbs_head_box">
        <div class="bbs_head_box_left">
            <div class="swiper-container" id="bbs_swp">
                <div class="swiper-wrapper">
                    <c:forEach items="${recommendCoverPost }" var="recommend">
                        <div class="swiper-slide">
                            <a href="/bbs/bbsPost?id=${recommend.bbsPost.id}">
                                <div class="bbs_head_box_left_imgbox">
                                    <img src="${itx}${recommend.coverUrl}" width="350"/>
                                    <p>${recommend.bbsPost.title}</p>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>

                <div class="pagination" id="bbs_swpp"></div>

                <div class="swiper-button-prev" id="bbs_swbp"></div>
                <div class="swiper-button-next" id="bbs_swbn"></div>
            </div>
            <ul class="bbs_img_down_list">
                <c:forEach items="${recommendHotPost }" var="recommend">
                    <li><a href="/bbs/bbsPost?id=${recommend.bbsPost.id}">${recommend.bbsPost.title}</a></li>
                </c:forEach>
            </ul>
        </div>
        <div class="bbs_head_box_right">
            <div class="bbs_head_rigth_tab" id="tab01">
                <a href="#" onclick="getSectionPost('',this)"><span class="active">全部精华</span></a>
                <c:forEach items="${bbsSection }" var="section" begin="0" end="6">
                    <a href="#" onclick="getSectionPost('${section.id}',this)"><span>${section.name }</span></a>
                </c:forEach>

            </div>
            <div class="bbs_head_right_list" id="all_essence" style="display:block;">
                <div class="list_left_box">
                    <ul>
                        <c:forEach items="${allSectionHotPost }" var="post" begin="0" end="8">
                            <li>
                                <a href="/bbs/bbsPost?id=${post.id}"><strong>${post.title}</strong><span>${post.poster.login_name} / <fmt:formatDate
                                        value="${post.createdAt}" pattern="yyyy-MM-dd"/></span></a></li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="list_left_box">
                    <ul>
                        <c:forEach items="${allSectionHotPost }" var="post" begin="9" end="18">
                            <li>
                                <a href="/bbs/bbsPost?id=${post.id}"><strong>${post.title}</strong><span>${post.poster.login_name} / <fmt:formatDate
                                        value="${post.createdAt}" pattern="yyyy-MM-dd"/></span></a></li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="bbs_all_info_bar">
        <img src="images/bbs_info_img.png"/>
        <div class="info_box">今日：<span>${bbsSectionGroupData.todayPostNum }</span></div>
        <div class="info_box">帖子：<span>${bbsSectionGroupData.topicPostNum }</span></div>
        <div class="info_box">会员：<span>${totalUser }</span></div>
    </div>


    <c:forEach items="${bbsSection}" var="section">
        <div class="bbs_section_box">
            <div class="bbs_section_box_title"><span>${section.name }</span></div>

            <c:forEach items="${section.sonSectionList }" var="sonSection" varStatus="i" step="1">
                <c:if test="${i.index%3==0 }">
                    <div class="bbs_search_box_con_bar">
                </c:if>
                <div class="bbs_search_box_conbox"
                        <c:if test="${not empty sonSection.iconUrl}">
                            style="background:url(${itx}${sonSection.iconUrl}) 0 5px no-repeat;background-size: 116px 100px;"
                        </c:if>
                >
                    <a href="/bbs/bbsSection?id=${sonSection.id}">
                        <h1>${sonSection.name }</h1>
                    </a>
                    <p style="margin-left: 70px;">
                        <span>主题:${sonSection.topicPostNum }</span><b>(${sonSection.todayPostNum })</b></p>
                    <p><a href="/bbs/bbsPost?id=${sonSection.lastBbsPost.id}">${sonSection.lastBbsPost.title }</a>
                        <span><fmt:formatDate
                                value="${sonSection.lastPostAt}"
                                pattern="HH:mm:ss"/>&nbsp;${sonSection.lastPostUser.login_name }</span></p>
                </div>
                <c:if test="${i.index%3==2 && i.index!=0 || i.index+1 == (fn:length(section.sonSectionList)) }">
                    </div>
                </c:if>
            </c:forEach>

        </div>
    </c:forEach>


</div>

<div class="clear"></div>
<%--foot--%>
<%@ include file="/page/common/foot.jsp" %>

</body>
</html>
