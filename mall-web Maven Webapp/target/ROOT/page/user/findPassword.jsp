<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@include file="../common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>找回密码</title>
    <jsp:include page="/page/common/resource.jsp"></jsp:include>
    <link href="/css/login.css" rel="stylesheet" type="text/css"/>
    <script src="/js/user.js"></script>
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
        <a href="/" class="fl"><img class="logo" src="/images/logo.png"/></a>
        <div class="welcome">账户设置</div>
        <div class="now_reg"><a href="/login">登录</a> | <a href="/register">注册</a></div>
    </div>
</div>
<div class="mumber_main">
    <div class="container">
        <div class="mumber_box">
            <div class="mumber_box_title">找回密码</div>
            <div class="munber_box_content">
                <img class="step_bar" src="images/repas_step1.jpg"/>
                <img src="images/little_banner.jpg"/>
                <div class="munber_box_input_box">
                    <div class="munber_box_input">
                        <dl class="long">
                            <dt><span>*</span>请填写您需要找回的账号：</dt>
                            <dd>
                                <div class="input_box"><input name="findMobile" type="text" placeholder="请输入您的手机号码/邮箱地址"/></div>
                            </dd>
                        </dl>
                        <dl class="long">
                            <dd>
                                <div class="input_box yzm" style="width: 200px"><input name="findPwdCaptcha" type="text" placeholder="验证码"/>
                                </div>
                                <a href="javascript:void(0)"
                                   onclick="$('#findCaptcha').attr('src','/findCaptcha?'+Math.random())"><img
                                        id="findCaptcha" src='/findCaptcha'/>&nbsp;&nbsp;换一张</a>
                            </dd>
                        </dl>
                        <input class="submit findPassword" type="submit" value="下一步"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
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
