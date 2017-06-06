<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@include file="/page/common/taglib.jsp" %>
<div class="header">
    <div class="container">
        <span class="i7colors_welcome">Hi，<span class="i7colors_username"></span>&nbsp;&nbsp;&nbsp;欢迎来到七彩云</span>&nbsp;&nbsp;&nbsp;<span
            class="i7colors_login_out" style="color: red"></span>
        <div class="fr"><img src="/images/phone.png"/>400-920-8599&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a
                href="#">帮助中心</a></div>
    </div>
</div>
<div class="top">
    <div class="menu_bar_container">
        <a href="/" class="fl"><img class="logo" src="/images/logo.png"/></a>
        <div class="search">
            <div class="search_tab">
                <span class="onthis" data-type="product" data-url="/shop" data-desc="请输入商品名称">商品</span>
                <span data-type="school" data-url="/school/industry" data-desc="请输入文章标题/内容">大学堂</span>
                <span data-type="bbs" data-url="/bbs/search" data-desc="请输入帖子标题">论坛</span>
            </div>
            <div class="search_box">
                <input type="text" name="search" placeholder="请输入商品名称"/>
                <input type="button" id="btn_search" style="cursor:pointer;"/>
            </div>
            <a href="/shop">高级搜索</a>
            <div class="hot_search">
                <c:forEach items="${selectGoodsList}" var="selectGoodsList">
                    <a href="/shop/product/${selectGoodsList.eid}">${selectGoodsList.name}</a>
                </c:forEach>
            </div>
        </div>

        <div class="shopping_car_box fr">
            <div class="qr_box">
                <img src="/images/qr_icon.gif"/>扫描二维码
                <div class="qr_show_box"><img src="/images/QR.jpg"/></div>
            </div>
            <%--<div class="shopping_car"><a href="/carts"><img src="/images/spcar_icon.jpg" />我的购物车<em>0</em></a></div>--%>
            <c:if test="${isLogin=='true'}">
                <div class="shopping_car"><a href="/carts"><img src="/images/spcar_icon.jpg"/>我的购物车<em class="cart_num">0</em></a></div>
            </c:if>


        </div>

    </div>
</div>
<div class="menu_bar">
    <div class="menu_bar_container">
        <ul class="menu nav_bar_ul">
            <a href="/">
                <li class="nav_index onthis">首页</li>
            </a>
            <a href="/shop">
                <li class="nav_shop">商城</li>
            </a>
            <a href="/school">
                <li class="nav_school">大学堂</li>
            </a>
            <a href="/bbs">
                <li class="nav_bbs">论坛</li>
            </a>
            <a href="/information">
                <li class="nav_information">产业资讯</li>
            </a>
            <a href="/member">
                <li class="nav_member">会员风采</li>
            </a>
            <a href="javascript:window.open('/kefu','kefu');">
            <%--<a href="${groupId == 2 ? "/kefu" : "javascript:alert('请使用企业账号联系客服');location.href='/u'"}" ${groupId == 2 ? "target='_blank'" : ""}>--%>
                <li class="nav_kefu">联系客服</li>
            </a>
            <a href="/about">
                <li class="nav_about">关于七彩云</li>
            </a>
        </ul>
        <a href="javascript:void(0)" onclick="login()" class="log_reg_box fr"><img src="/images/login_icon.png"/><span
                class="log_reg_box_desc">登录/注册</span></a>
    </div>
</div>
<div class="pop_bg"></div>
