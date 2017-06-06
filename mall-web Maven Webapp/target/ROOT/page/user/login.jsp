<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>七彩云</title>

    <jsp:include page="/page/common/resource.jsp"></jsp:include>
    <link href="/css/login.css" rel="stylesheet" type="text/css" />
    <script src="/js/user.js"></script>
    <script>
        $(function(){
            document.onkeydown = function(e){
                var ev = document.all ? window.event : e;
                if(ev.keyCode==13) {
                    $(".login-btn").click();
                }
            }
        });
    </script>
</head>
<body>
<div class="header">
    <div class="container">
        <span>Hi，欢迎来到七彩云</span>
        <div class="fr"><img src="/images/phone.png" />400-920-8599&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="#">帮助中心</a></div>
    </div>
</div>
<div class="top hbg">
    <div class="container">
        <a href="/" class="fl"><img class="logo" src="/images/logo.png" /></a>
        <div class="welcome">欢迎登录</div>
        <div class="now_reg">没有账号，<a href="/register">立即注册</a></div>
    </div>
</div>

<div class="section">
    <div class="login-content">

        <div class="login-content-left">
            <h1>引领一场真正的色彩数字化革命</h1>
            <ul>
                <li><img src="/images/login-slogan1.png" /></li>
                <li><img src="/images/login-slogan2.png" /></li>
                <li><img src="/images/login-slogan3.png" /></li>
            </ul>
        </div>

        <div class="login-content-right">
            <p class="login-content-title">
                <span>登录</span>
                <span>没有账号，<a href="/register">立即注册</a></span>
            </p>
            <p class="username"><input name="username" type="text" placeholder="用户名" /></p>
            <p class="password"><input name="password" type="password" placeholder="密码" /></p>
            <p class="code">
                <input name="captcha" type="text" placeholder="验证码" />
                <a href="javascript:" class="captcha_btn">
                <span class="captcha_span" style="background: url('/captcha')"></span>
                换一张
                </a>
            </p>
            <p class="auto-login">
                <%--<input type="checkbox" checked="checked" />
                <span>下次自动登录</span>--%>
                <a href="/findPassword" style="margin-left: 260px;">找回密码</a>
            </p>
            <p><a href="javascript:;" class="login-btn">登录</a></p>
            <p class="other-way">可以使用以下方式登录</p>
            <p class="login-way">
                <a href="https://graph.qq.com/oauth/show?which=ConfirmPage&display=pc&client_id=101385314&response_type=code&state=i7colors&scope=&display=&redirect_uri=http%3A%2F%2Fi7colors.com/toQQLogin"><img id="qq-login" src="/images/qq.jpg" /></a>
                <a href="https://open.weixin.qq.com/connect/qrconnect?appid=wxd38031118f3b5d46&redirect_uri=http%3A%2F%2Fi7colors.com/toWxLogin&response_type=code&scope=snsapi_login&state=i7colors#wechat_redirect"><img style="margin-left: 0px;" id="linkbt" src="/images/wechat.jpg"/></a>
            </p>
        </div>
    </div>
</div>

<div class="footer grey">
    <div class="container">
        <div class="bz">
            版权声明  |  法律法规  |  咨询建议  上海七彩云电子商务有限公司(沪ICP备15026231号-1)   沪公网安备 31010402000379<br/>
            Copyright © 2015 i7colors.com v1.50 All rights reserved.
        </div>
    </div>
</div>
</body>
</html>
