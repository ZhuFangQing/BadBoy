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
    <script>
        function toResetCompany() {
            location.href="/company/toReCertificationPage";
        }
    </script>
</head>
<body>
<%--top模块--%>
<%@ include file="/page/common/top.jsp" %>
<div class="mian_content container">
    <%@ include file="/page/common/usercenter.jsp" %>
    <div class="mumber_right_content">
        <div class="shopping_car_tab">
            <span class="active">申请企业认证账户</span>
        </div>
        <div class="aut_main_box">
            <div class="aut_title"><span>${type}</span></div>
            <div class="aut_cont_box">
                <div class="audit_text">${status}</div>
            </div>
        </div>
        <c:if test="${type=='审核失败'}">
            <div class="submit_box"><input type="submit" id="submit11" value="重新编辑企业申请信息" onclick="toResetCompany()" /></div>
        </c:if>

    </div>
    <div class="clear"></div>
</div>
<%@ include file="/page/common/foot.jsp" %>
</body>
</html>



