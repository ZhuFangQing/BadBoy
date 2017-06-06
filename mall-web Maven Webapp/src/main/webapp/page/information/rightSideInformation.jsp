<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@include file="../common/taglib.jsp" %>
<!--主体右侧-->
<script>
    $(document).ready(function () {
        $(".right-nav a").click(function () {
            var str = "#" + $(this).attr("name");
            $(".right-nav a").addClass("active");
            $(this).attr("class", "");
            $(".right-info-bus").hide();
            $(str).show();
        })
    })

</script>

<div class="business-right">
    <p class="business-right-title-b">资讯</p>
    <div class="right-nav">
        <a name="RM" href="javascript:;">热门推荐</a>
        <a name="TJ" href="javascript:;" class="active">最新资讯</a>
    </div>
    <ul id="RM" class="right-info-bus">
        <c:forEach items="${sideInfoList}" var="sideInfoList">
            <c:if test="${sideInfoList.type==18}">
                <li><a href="/information/${sideInfoList.id}">
                    <c:if test="${fn:length(sideInfoList.title) >23}">
                        ${fn:substring(sideInfoList.title, 0, 23)}...
                    </c:if>
                    <c:if test="${fn:length(sideInfoList.title) <=23}">
                        ${sideInfoList.title}
                    </c:if>
                </a></li>
            </c:if>
        </c:forEach>
    </ul>

    <ul id="TJ" class="right-info-bus" style="display: none">
        <c:forEach items="${sideInfoList}" var="sideInfoList">
            <c:if test="${sideInfoList.type==19}">
                <li><a href="/information/${sideInfoList.id}">
                    <c:if test="${fn:length(sideInfoList.title) >23}">
                        ${fn:substring(sideInfoList.title, 0, 23)}...
                    </c:if>
                    <c:if test="${fn:length(sideInfoList.title) <=23}">
                        ${sideInfoList.title}
                    </c:if>
                </a></li>
            </c:if>
        </c:forEach>
    </ul>
    <c:forEach items="${adList}" var="adList">
        <c:if test="${adList.plate_code=='Information_List01'}">
            <div class="business-right-img"><a href="${adList.ad_url}"><img src="${itx}${adList.ad_image}"
                                                                            width="100%"/></a></div>
        </c:if>
    </c:forEach>

    <p class="business-right-title-b">近期焦点</p>

    <ul class="recent_bus">
        <c:forEach items="${sideInfoList}" var="sideInfoList">
            <c:if test="${sideInfoList.type==20}">
                <li>
                    <a href="/information/${sideInfoList.id}">
                        <img src="${itx}${sideInfoList.img_url}"/>
                        <c:if test="${fn:length(sideInfoList.title) >15}">
                            <p> ${fn:substring(sideInfoList.title, 0, 15)}...</p>
                        </c:if>
                        <c:if test="${fn:length(sideInfoList.title) <=15}">
                            <p>${sideInfoList.title}</p>
                        </c:if>
                    </a>
                    <span>${empty sideInfoList.news_date ? "" : fn:substring(sideInfoList.news_date, 0, 10)}</span>
                </li>
            </c:if>
        </c:forEach>

    </ul>
    <c:forEach items="${adList}" var="adList">
        <c:if test="${adList.plate_code=='Information_List02'}">
            <div class="business-right-img"><a href="${adList.ad_url}"><img src="${itx}${adList.ad_image}"
                                                                            width="100%"/></a></div>
        </c:if>
    </c:forEach>
</div>