<%--
  Created by IntelliJ IDEA.
  User: Echos
  Date: 2016/11/30
  Time: 11:28
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
    <link href="/css/member.css" rel="stylesheet" type="text/css" />
    <link href="/css/memberDetail.css" rel="stylesheet" type="text/css" />
</head>
<body>
<%--top模块--%>
<%@ include file="../common/top.jsp" %>



<!--行业资讯标题-->
<div class="container">
    <p class="business-title">
        <span>首页</span>
        &gt;
        <span>会员风采</span>
        &gt;
        <span>${member.member_name}</span>
    </p>
</div>
<!--行业资讯标题-end-->

<div class="content container">
    <!--content-left-->
    <div class="content-left">
        <div class="mumber_name">
            ${member.member_name}
            <sup><img src="/images/vip1.png" />
                <span>VIP企业</span></sup>
        </div>
        <!--member-detail-content-->
        <div class="member-detail-content">

            <h2>公司介绍</h2>
            <div style="margin-left: 30px;margin-right: 30px;">
            ${member.description}
            </div>
        </div>
        <!--member-detail-content-end-->

        <!--member-detail-content-->
        <div class="member-detail-content">
            <h2>联系方式</h2>

            <ul class="member-detail-contact-left">
                <li>企业负责人：</li>
                <%--<li>联系电话：</li>--%>
                <%--<li>企业邮箱：</li>--%>
            </ul>
            <ul class="member-detail-contact-right">
                <li>${member.name}</li>
                <%--<li>${member.phone}</li>--%>
                <%--<li>${member.mail}</li>--%>
            </ul>

        </div>
        <!--member-detail-content-end-->

    </div>
    <!--member-detail-content-end-->

</div>
<!--content-left-end-->

<!--content-right-->
<%@ include file="/page/shop/shop_right.jsp" %>
<!--member-content-->




<!--pages-->
<div class="business-pages container" style="height: 30px;">
</div>
<!--pages-end-->

<jsp:include page="/page/common/foot_partner.jsp"></jsp:include>

<%--foot--%>
<%@ include file="/page/common/foot.jsp" %>
</body>
</html>