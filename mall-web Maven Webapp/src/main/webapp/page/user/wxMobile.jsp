<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@include file="../common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>绑定手机号</title>
    <jsp:include page="/page/common/resource.jsp"></jsp:include>
    <link href="/css/login.css" rel="stylesheet" type="text/css"/>
    <script src="/js/user.js"></script>
    <script src="/js/thirdlogin.js"></script>
</head>
<body>
<div class="pop_bg"></div>
<div class="header">
    <div class="container">
        <span>Hi，欢迎来到七彩云</span>
        <div class="fr"><img src="images/phone.png"/>400-920-8599&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a
                href="#">帮助中心</a></div>
    </div>
</div>
<div class="top hbg">
    <div class="container">
        <a href="#" class="fl"><img class="logo" src="images/logo.png"/></a>
        <div class="welcome">账户设置</div>
        <div class="now_reg"><a href="/login">登录</a>|<a href="/register">注册</a></div>
    </div>
</div>
<div class="mumber_main">
    <div class="container">
        <div class="mumber_box">
            <div class="mumber_box_title">绑定手机号</div>
            <div class="munber_box_content">
                <img src="images/little_banner.jpg"/>
                <div class="munber_box_input_box">
                    <div class="munber_box_input">
                        <dl>
                            <dt><span>*</span>手机号：</dt>
                            <dd>
                                <div class="input_box yzm"><input type="text" name="mobile" placeholder="请输入手机号"/></div>
                            </dd>
                        </dl>
                        <dl>
                            <dt><span>*</span>验证码：</dt>
                            <dd>
                                <div class="input_box yzm"><input type="text" name="bindMobileCode" placeholder="请输入验证码"/></div>
                                <input type="button" class="send-bind-mobile-code" value="发送验证码"/>
                            </dd>
                        </dl>
                        <dl>
                            <dt><span>*</span>　密码：</dt>
                            <dd>
                                <div class="input_box yzm"><input type="text" name="password" placeholder="请输入密码"/></div>
                            </dd>
                        </dl>
                        <dl>
                            <dt><span>*</span>　确认：</dt>
                            <dd>
                                <div class="input_box yzm"><input type="text" name="password2" placeholder="请再次输入密码"/></div>
                            </dd>
                        </dl>
                        <input class="submit bind" type="submit" value="确认绑定"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input type="hidden" name="openId" value="${openId}">
<input type="hidden" name="type" value="${type}">
<input type="hidden" name="nickname" value="${nickname}">
<div class="footer grey">
    <div class="container">
        <div class="bz">
            版权声明 | 法律法规 | 咨询建议 上海七彩云电子商务有限公司(沪ICP备15026231号-1) 沪公网安备 31010402000379<br/>
            Copyright © 2015 i7colors.com v1.50 All rights reserved.
        </div>
    </div>
</div>
</body>
</html>