<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>七彩云</title>
    <jsp:include page="/page/common/resource.jsp"></jsp:include>
    <link href="/css/register.css" rel="stylesheet" type="text/css"/>
    <script src="/js/user.js"></script>
    <script>
        $(function(){
            document.onkeydown = function(e){
                var ev = document.all ? window.event : e;
                if(ev.keyCode==13) {
                    $(".register-btn").click();
                }
            }
        });

    </script>
</head>
<body>
<div class="pop_bg"></div>

<div class="popbox_bg" id="popbox">
    <div class="popbox">
        <div class="popbox_title">恭喜<em id="close_popbox"></em></div>
        <div class="sucess_box">
            <img src="images/sucess_icon.png" />
            <p>注册成功！</p>
        </div>
        <a class="popbox_link" href="/login">马上登录</a>
    </div>
</div>
<div class="header">
    <div class="container">
        <span>Hi，欢迎来到七彩云</span>
        <div class="fr"><img src="/images/phone.png" />400-920-8599&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="#">帮助中心</a></div>
    </div>
</div>
<div class="top hbg">
    <div class="container">
        <a href="/" class="fl"><img class="logo" src="/images/logo.png" /></a>
        <div class="welcome">欢迎注册</div>
        <div class="now_reg">我已注册，<a href="/login">现在就登录</a></div>
    </div>
</div>


<div class="register-content">

    <div class="container">
        <p class="register-title">欢迎注册</p>

        <div class="register-content-p">
            <p class="num-p">
                <span style="vertical-align: middle;"><i>手机号 :</i></span>
                <b>+86</b>
                <input name="mobile" type="text" placeholder="用于登录/找回密码" class="num"/>

            </p>

            <p>
                <span><i>用户名 :</i></span>
                <input name="username" type="text" placeholder="请设置用户名" />

            </p>

            <p>
                <span><i>验证码 :</i></span>
                <input name="captcha" type="text" placeholder="请输入验证码" />
                <button class="code-btn">发送验证码</button>
            </p>

            <p>
                <span><i>输入密码 :</i></span>
                <input name="password" type="password" placeholder="请输入密码" />


            </p>

            <%--<p>--%>
                <%--<span><i>请确认密码 :</i></span>--%>
                <%--<input name="password_confirm" type="password" placeholder="请再次输入密码" />--%>
                <%--<a href="javscript:;" class="clear-content"></a>--%>
            <%--</p>--%>



        </div>

        <p class="agree-p">
            <input type="checkbox" class="agree" checked="checked" name="agree" />
            <span>阅读并接受<a href="/about?t=4&source=reg" target="_blank">《七彩云协议》</a></span>
        </p>

        <p>
            <a href="javascript:;" class="register-btn" id="submit2">注册</a>
        </p>


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
