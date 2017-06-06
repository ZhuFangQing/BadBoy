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
    <script>
        $(document).ready(function(){
            if('${mobile}'==""){
                location.href="/index";
            }
            $(".submit.update-password").click(function(){
                console.log('to-update-password...');
                debugger;
                //mobile
                var mobile = $("input[name='mobile']").val();
                var repwdCode =$("input[name='rePasswordCode']").val();
                if(undefined != mobile && null != mobile && (MOBILE_REG.test(mobile)||EMAIL_REG.test(mobile))){
                    $.ajax({
                        url:'/checkResetCode',
                        type:'GET',
                        data:{
                            'mobile': mobile,
                            'smsCode':repwdCode,
                            'VERIFY_CODE_TYPE':"I7COLOR_FIND_SMS_CODE"
                        },
                        dataType:'json',
                        success:function(resp){
                            console.log(resp);
                            debugger;
                            if(resp.code = 'SUCCESS'){
                                location.href='/toResetPasswordPage';
                            }else{
                                alert(resp['msg']);
                                return false;
                            }
                        }
                    });
                }else{
                    alert("");
                    return false;
                }
            });

        });
    </script>
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
            <div class="mumber_box_title">找回密码</div>
            <div class="munber_box_content">
                <img class="step_bar" src="images/repas_step2.jpg"/>
                <img src="images/little_banner.jpg"/>
                <div class="munber_box_input_box">
                    <div class="munber_box_input">
                        <p class="munber_box_text">
                            <em>*</em>为了您的账号安全，请完成身份验证<br/>
                            账号验证：<span>${showMobile}</span>
                        </p>
                        <dl>
                            <dt><span>*</span>验证码：</dt>
                            <dd>
                                <div class="input_box yzm"><input type="text" name="rePasswordCode" placeholder="请输入验证码"/></div>
                                <input type="button" class="send-rePassword-code" value="发送验证码"/>
                            </dd>
                        </dl>
                        <input class="submit update-password" type="submit" value="下一步"/>
                    </div>
                </div>
            </div>
        </div>
        <input type="hidden" value="${mobile}" name="mobile" id="mobile">
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