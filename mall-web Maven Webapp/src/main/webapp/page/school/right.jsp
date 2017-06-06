<%@include file="../common/taglib.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: Echos
  Date: 2017/1/7
  Time: 16:37
  To change this template use File | Settings | File Templates.
--%>

<!--主体右侧-->
<div class="business-right">


    <div class="business-right-top">
        <p class="business-right-title" style="width: 100%">点击排行</p>


        <ul class="recent">
            <c:forEach items="${rankingList}" var="item">
                <li>
                    <a href="/school/articles/${item.id}">
                        <img src="${itx}${item.coverUrl}" width="144px;" height="90px;" />
                        <p>${fn:substring(item.title, 0, 9)}...</p>
                        <span>${fn:substring(item.contentSummary, 0, 31)}...</span>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>


    <div class="business-right-bottom">
        <p class="business-right-title" style="width: 100%">热点资讯</p>

        <ul class="right-info">
            <c:forEach items="${hotNewsList}" var="hotNewsList">

                <li style="width: 300px;">
                    <c:if test="${fn:length(hotNewsList.title) >23}">
                        <a href="/information/${hotNewsList.id}" target="_blank">${fn:substring(hotNewsList.title,0,23)}...</a>
                    </c:if>
                    <c:if test="${fn:length(hotNewsList.title) <=23}">
                        <a href="/information/${hotNewsList.id}" target="_blank">${hotNewsList.title}</a>
                    </c:if>
                </li>
            </c:forEach>
        </ul>
    </div>


    <div class="business-right-img">
        <img src="${itx}${adList[0].ad_image}"/></div>
</div>