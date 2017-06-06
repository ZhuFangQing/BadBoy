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
    <script src="/js/user.js"></script>
    <script src="/js/company.js"></script>
</head>
<body>
<%--top模块--%>
<%@ include file="/page/common/top.jsp" %>
<div class="mian_content container">
    <%@ include file="/page/common/usercenter.jsp" %>

    <div class="mumber_right_content">
        <div class="shopping_car_tab">
            <span class="active">企业资料</span>
        </div>
        <div class="aut_main_box">
            <div class="aut_title"><span>基础信息</span></div>
            <div class="aut_cont_box wi50">
                <dl>
                    <dt>企业名称：</dt>
                    <dd>${companyInfo.companyName}</dd>
                </dl>
                <dl>
                    <dt>联系人：</dt>
                    <dd>${companyInfo.contact}</dd>
                </dl>
                <dl>
                    <dt>企业类型：</dt>
                    <dd>${companyInfo.customerClass}</dd>
                </dl>
                <dl>
                    <dt>企业简介：</dt>
                    <dd>${companyInfo.description}</dd>
                </dl>
            </div>
            <div class="aut_cont_box wi50">
                <dl>
                    <dt>公司主页：</dt>
                    <dd><a href="${companyInfo.companyIndex}" target="_blank">${companyInfo.companyIndex}</a></dd>
                    <%--<dd>${companyInfo.fax}</dd>--%>
                </dl>
                <dl>
                    <dt>邮件地址：</dt>
                    <dd>${companyInfo.mail}</dd>
                </dl>
                <dl>
                    <dt>法人代表：</dt>
                    <dd>${companyInfo.legal}</dd>
                </dl>
                <dl>
                    <dt>企业电话：</dt>
                    <dd>${companyInfo.tel}</dd>
                </dl>
                <dl>
                    <dt>企业地址：</dt>
                    <dd>${companyInfo.address}</dd>
                </dl>
            </div>
            <div class="aut_title"><span>企业电子凭证</span></div>
            <c:choose>
                <c:when test="${companyInfo.busLicenceCode=='inOneCode'}">
                    <div class="aut_cont_box">
                        <div class="aut_voucher"><img src="${itx}${companyInfo.busLicenceUrl}" width="285" height="205"/><h1>三证合一<%--：${companyInfo.institutionCode}--%></h1></div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="aut_cont_box">
                        <div class="aut_voucher"><img src="${itx}${companyInfo.institutionUrl}" width="285" height="205"/><h1>组织机构代码<%--：${companyInfo.institutionCode}--%></h1></div>
                        <div class="aut_voucher"><img src="${itx}${companyInfo.busLicenceUrl}" width="285" height="205"/><h1>营业执照<%--注册号：${companyInfo.busLicenceCode}--%></h1></div>
                        <div class="aut_voucher"><img src="${itx}${companyInfo.taxUrl}" width="285" height="205"/><h1>税务登记<%--账号：${companyInfo.taxCode}--%></h1></div>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
        <c:if test="${groupId==2}">
            <div class="submit_box"><a href="/company/completeCompanyInfo"><input type="submit" id="submit" value="完善企业资料" /></a></div>
        </c:if>
    </div>
    <div class="clear"></div>
</div>
<%@ include file="/page/common/foot.jsp" %>
</body>
</html>



