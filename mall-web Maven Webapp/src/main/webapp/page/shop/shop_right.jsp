<%--
  Created by IntelliJ IDEA.
  User: Echos
  Date: 2016/12/2
  Time: 17:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/page/common/taglib.jsp" %>

<div class="content-right">
    <div class="content-right-product" style="<c:if test="${!empty param.marginTop}">margin-top:${param.marginTop}px;</c:if>">
        <p>新上架产品</p>
        <ul>
            <c:forEach items="${newCreateList}" var="p">
                <c:set var="aliasName" value="${p.aliasName}"></c:set>
                <c:if test="${fn:length(aliasName) > 15}">
                    <c:set var="aliasName" value="${fn:substring(aliasName, 0, 15)}..." />
                </c:if>

                <li><a href="/shop/product/${p.eid}">${aliasName}</a></li>
            </c:forEach>
        </ul>
    </div>

    <div class="content-right-product">
        <p>销量最好产品排名</p>
        <ul>
            <c:forEach items="${topSalesList}" var="p">
                <c:set var="aliasName" value="${p.aliasName}"></c:set>
                <c:if test="${fn:length(aliasName) > 15}">
                    <c:set var="aliasName" value="${fn:substring(aliasName, 0, 15)}..." />
                </c:if>

                <li><a href="/shop/product/${p.eid}">${aliasName}</a></li>
            </c:forEach>
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

<div class="clear"></div>