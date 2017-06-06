<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/page/common/taglib.jsp" %>
<%--
  Created by IntelliJ IDEA.
  User: Echos
  Date: 2016/11/30
  Time: 16:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="partner container">
    <p>合作伙伴</p>
    <ul>
        <c:forEach items="${partnerList}" var="partner">
            <li><a href="${partner.link_url}" target="_blank"><img src="${itx}${partner.img_url}" width="135px" height="40px"/></a></li>
        </c:forEach>
    </ul>
</div>