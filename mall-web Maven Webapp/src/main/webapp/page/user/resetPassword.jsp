<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@include file="../common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>重设密码</title>
    <jsp:include page="/page/common/resource.jsp"></jsp:include>
    <link href="/css/login.css" rel="stylesheet" type="text/css"/>
    <script src="/js/user.js"></script>

    <script>
        $(document).ready(function(){
            $(".submit.reset-password").click(function(){
                console.log('to-reset-password...');
                //mobile
                var password = $("input[name='password']").val();
                var rePassword =$("input[name='rePassword']").val();
                if(undefined == password || null == password || undefined == rePassword || null == rePassword){
                    alert('密码不能为空');
                    return false;
                }

                if(password.length < 6 || password.length > 14){
                    alert('密码长度应为6-14个字符');
                    return false;
                }

                if(password==rePassword){
                    $.ajax({
                        url:'/updatePassword',
                        type:'GET',
                        data:{
                            'password': password,
                            'rePassword':rePassword
                        },
                        dataType:'json',
                        success:function(resp){
                            console.log(resp);
                            openResetSuccess();
                        }
                    });
                }else{
                    alert("两次密码不一致!");
                    return false;
                }
            });

        });
        function openResetSuccess() {
            var InfoBoxTop = ($(window).height()-430)/2 + window.scrollY;
            $('.pop_bg').height($(document).height());
            $('.pop_bg').fadeIn();
            $('#popbox').css('top',InfoBoxTop);
            $('#popbox').fadeIn();
            $('body').css('overflow','hidden');
        }
    </script>

</head>
<body>
<div class="pop_bg"></div>
<div class="popbox_bg" id="popbox">
    <div class="popbox">
        <div class="popbox_title">恭喜<em id="close_popbox"></em></div>
        <div class="sucess_box">
            <img src="/images/sucess_icon.png" />
            <p>重置密码成功</p>
        </div>
        <a class="popbox_link" href="/login">登 录</a>
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
        <a href="#" class="fl"><img class="logo" src="/images/logo.png" /></a>
        <div class="welcome">账户设置</div>
        <div class="now_reg">登录&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">注册</a></div>
    </div>
</div>
<div class="mumber_main">
    <div class="container">
        <div class="mumber_box">
            <div class="mumber_box_title">找回密码</div>
            <div class="munber_box_content">
                <img class="step_bar" src="/images/repas_step3.jpg" />
                <img src="/images/little_banner.jpg" />
                <div class="munber_box_input_box">
                    <div class="munber_box_input">
                        <dl class="taright">
                            <dt><span>*</span>新密码：</dt>
                            <dd><div class="input_box">
                                <input class="pass" type="password" name="password" placeholder="请输入密码" />
                                <input class="text" type="text" name="password" placeholder="请输入密码" disabled="disabled"/><em></em>
                            </div></dd>
                        </dl>
                        <dl class="taright">
                            <dt><span>*</span>请确认密码：</dt>
                            <dd><div class="input_box">
                                <input class="pass" type="password" name="rePassword" placeholder="请再次输入密码" />
                                <input class="text" type="text" name="rePassword" placeholder="请输入密码"disabled="disabled" /><em></em>
                            </div></dd>
                        </dl>
                        <input class="submit reset-password" type="submit" value="确认重置密码"/>
                    </div>
                </div>
            </div>
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

