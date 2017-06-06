<%--
  Created by IntelliJ IDEA.
  User: Echos
  Date: 2016/12/3
  Time: 12:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="mumber_left_bar">
    <div class="mumber_person_box">
        <div class="mumber_left_title">会员中心首页</div>
        <div class="mumber_person_img"><img src="/images/person_img.jpg" width="76" height="76" /></div>
        <p class="mumber_person_name"><span class="i7colors_username"></span></p>
    </div>

    <div class="mumber_title_bar mall">我的商城</div>
    <c:if test="${groupId==2}">
        <ul class="mumber_menu_list" style="display:block">
            <li data-menu="/orders" class="menu_orders"><a href="/orders">我的订单</a></li>
            <li data-menu="/money" class="menu_money"><em></em><a href="/money">资金管理</a></li>
            <%--<li data-menu="/credit" class="menu_credit"><a href="#">信用额度</a></li>--%>
            <li data-menu="/carts" class="menu_carts"><a href="/carts">我的购物车</a></li>
        </ul>
    </c:if>
    <div class="mumber_title_bar">会员资料</div>
    <ul class="mumber_menu_list">
        <c:if test="${groupId==1}">
        <li data-menu="/company/toCertificationPage /company/completeCompanyInfo" class="menu_carts"><a href="/company/toCertificationPage">企业认证信息</a></li>
        <li data-menu="/user/toShowUserInfoPage"><a href="/user/toShowUserInfoPage">会员资料</a></li>
        <li data-menu="/user/toEditUserInfoPage"><a href="/user/toEditUserInfoPage">编辑会员资料</a></li>
        </c:if>
        <c:if test="${groupId==2}">
            <li data-menu="/company/toCompanyInfoPage" class="menu_carts"><a href="/company/toCompanyInfoPage">企业认证信息</a></li>
            <li data-menu="/company/completeCompanyInfo"><a href="/company/completeCompanyInfo">完善企业信息</a></li>
        </c:if>

        <li data-menu="/user/toChangePasswordPage"><a href="/user/toChangePasswordPage">修改密码</a></li>
    </ul>
    <div class="mumber_title_bar sms"><a href="/mallInform">商城通知</a></div>
    <div class="mumber_title_bar school">我的大学堂</div>
    <div class="mumber_title_bar bbs">我的论坛</div>
    <ul class="mumber_menu_list">
        <li data-menu="/bbs/u/posts" class="menu_carts"><a href="/bbs/u">我的帖子</a></li>
        <li data-menu="/bbs/u/messages"><a href="/bbs/u/messages">短消息</a></li>
        <li data-menu="/bbs/u/avatar"><a href="/bbs/u/avatar">头像设置</a></li>
    </ul>
</div>