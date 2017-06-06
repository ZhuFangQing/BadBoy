<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@include file="/page/common/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>七彩云</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <%@include file="/page/common/resource.jsp" %>
    <link href="${ctx}/css/authentication.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/css/payway.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/css/pro_detil.css" rel="stylesheet" type="text/css"/>
    <script src="/js/user.js"></script>
    <script>
        $(document).on('click', '#submit2', function () {
            location.href="/user/toEditUserInfoPage"
        });
    </script>
</head>
<body>
<%--top模块--%>
<%@ include file="/page/common/top.jsp" %>
<div class="mian_content container">
    <%@ include file="/page/common/usercenter.jsp" %>
    <div class="mumber_right_content">
        <div class="shopping_car_tab">
            <span class="active">会员个人资料</span>
        </div>
        <div class="aut_main_box">
            <div class="aut_title"><span>基础信息</span></div>
            <div class="aut_cont_box wi50">
                <dl>
                    <dt>会员昵称：</dt>
                    <c:if test="${! empty userInfo.login_name}">
                        <dd>${userInfo.login_name}</dd>
                    </c:if>
                    <c:if test="${empty userInfo.login_name}">
                        <dd style="color: grey">未填写</dd>
                    </c:if>
                </dl>
                <dl>
                    <dt>真实姓名：</dt>
                    <c:if test="${! empty userInfo.real_name}">
                        <dd>${userInfo.real_name}</dd>
                    </c:if>
                    <c:if test="${empty userInfo.real_name}">
                        <dd style="color: grey">未填写</dd>
                    </c:if>
                </dl>
                <dl>
                    <dt>所在地区：</dt>
                    <c:if test="${! empty userInfo.location}">
                        <dd>${userInfo.location}</dd>
                    </c:if>
                    <c:if test="${empty userInfo.location}">
                        <dd style="color: grey">未填写</dd>
                    </c:if>
                </dl>
                <dl>
                    <dt>联系电话：</dt>
                    <c:if test="${! empty userInfo.phone}">
                        <dd>${userInfo.phone}</dd>
                    </c:if>
                    <c:if test="${empty userInfo.phone}">
                        <dd style="color: grey">未填写</dd>
                    </c:if>
                </dl>
                <dl>
                    <dt>账号类型：</dt>
                    <c:if test="${! empty userInfo.groupName}">
                        <dd>${userInfo.groupName}</dd>
                    </c:if>
                    <c:if test="${empty userInfo.groupName}">
                        <dd style="color: grey">未填写</dd>
                    </c:if>
                </dl>
            </div>
            <div class="aut_cont_box wi50">
                <dl>
                    <dt>Email：</dt>
                    <c:if test="${! empty userInfo.email}">
                        <dd>${userInfo.email}</dd>
                    </c:if>
                    <c:if test="${empty userInfo.email}">
                        <dd style="color: grey">未填写</dd>
                    </c:if>
                </dl>
                <dl>
                    <dt>QQ：</dt>
                    <c:if test="${! empty userInfo.qq}">
                        <dd>${userInfo.qq}</dd>
                    </c:if>
                    <c:if test="${empty userInfo.qq}">
                        <dd style="color: grey">未填写</dd>
                    </c:if>
                </dl>
                <dl>
                    <dt>所在公司：</dt>
                    <c:if test="${! empty userInfo.company}">
                        <dd>${userInfo.company}</dd>
                    </c:if>
                    <c:if test="${empty userInfo.company}">
                        <dd style="color: grey">未填写</dd>
                    </c:if>
                </dl>
                <dl>
                    <dt>学历：</dt>
                    <c:if test="${! empty userInfo.education}">
                        <dd>${userInfo.education}</dd>
                    </c:if>
                    <c:if test="${empty userInfo.education}">
                        <dd style="color: grey">未填写</dd>
                    </c:if>
                </dl>
            </div>
        </div>
        <div class="submit_box"><input type="submit" id="submit2" value="编辑个人资料" /></div>
    </div>
    <div class="clear"></div>
</div>
<%@ include file="/page/common/foot.jsp" %>
</body>
</html>



