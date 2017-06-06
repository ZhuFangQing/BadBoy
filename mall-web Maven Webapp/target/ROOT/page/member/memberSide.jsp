<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp" %>
<!--content-right-->
<div class="content-right">
    <div class="content-right-product">
        <p>新上架产品</p>
        <ul>
            <li><a href="javascript:;">安诺可隆 深红WP-S</a></li>
            <li><a href="javascript:;">安诺可隆 红玉WP-S</a></li>
            <li><a href="javascript:;">安诺可隆 酱红WP-S</a></li>
            <li><a href="javascript:;">安诺可隆 紫WP-S</a></li>
            <li><a href="javascript:;">安诺可隆 藏青WP-S</a></li>
            <li><a href="javascript:;">安诺可隆 深藏青WP-S</a></li>
            <li><a href="javascript:;">安诺可隆 黑WP-S</a></li>
            <li><a href="javascript:;">安诺可隆 深黑WP-S</a></li>
            <li><a href="javascript:;">安诺可隆 深黑WP-S</a></li>
            <li><a href="javascript:;">分散橙SE-GL 200%</a></li>
        </ul>
    </div>
    <div class="content-right-product">
        <p>销量最好产品排名</p>
        <ul>
            <li><a href="javascript:;">安诺可隆 深红WP-S</a></li>
            <li><a href="javascript:;">安诺可隆 红玉WP-S</a></li>
            <li><a href="javascript:;">安诺可隆 酱红WP-S</a></li>
            <li><a href="javascript:;">安诺可隆 紫WP-S</a></li>
            <li><a href="javascript:;">安诺可隆 藏青WP-S</a></li>
            <li><a href="javascript:;">安诺可隆 深藏青WP-S</a></li>
            <li><a href="javascript:;">安诺可隆 黑WP-S</a></li>
            <li><a href="javascript:;">安诺可隆 深黑WP-S</a></li>
            <li><a href="javascript:;">安诺可隆 深黑WP-S</a></li>
            <li><a href="javascript:;">分散橙SE-GL 200%</a></li>
        </ul>
    </div>

    <div>
        <c:forEach items="${adList}" var="adList">
            <c:if test="${adList.plate_code=='Mall_List'}">
                <a href="${adList.ad_url}"><img src="${itx}${adList.ad_image}" width="100%" /></a>
            </c:if>
        </c:forEach>
    </div>
</div>
