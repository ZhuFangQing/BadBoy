<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@include file="/page/common/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>七彩云</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="/css/myOrder.css" rel="stylesheet" type="text/css"/>
    <%@include file="/page/common/resource.jsp" %>
    <link href="/css/authentication.css" rel="stylesheet" type="text/css" />
    <link href="/css/payway.css" rel="stylesheet" type="text/css" />
    <script>
        $(document).ready(function(){
            $(".submit-change-password").click(function(){
                console.log('change-password...');
                //mobile
                var password = $("input[name='password']").val();
                var newPassword =$("input[name='newPassword']").val();
                var reNewPassword =$("input[name='reNewPassword']").val();

                if(undefined == password || null == password || undefined == newPassword || null == newPassword || undefined == reNewPassword || null == reNewPassword){
                    alert('密码不能为空');
                    return false;
                }

                if(newPassword.length < 6 || newPassword.length > 14){
                    alert('密码长度应为6-14个字符');
                    return false;
                }

                if(newPassword==reNewPassword){
                    $.ajax({
                        url:'/user/changePassword',
                        type:'GET',
                        data:{
                            'password': password,
                            'newPassword':newPassword,
                            'reNewPassword':reNewPassword
                        },
                        dataType:'json',
                        success:function(resp){
                            console.log(resp);
                            if(resp.code == 'SUCCESS'){
                                openChangeSuccess();
                            }else{
                                alert(resp.msg);
                            }
                        }
                    });
                }else{
                    alert("两次密码不一致!");
                    return false;
                }
            });
            function openChangeSuccess() {
                var popHeight = $('#popbox').height();
                var InfoBoxTop = ($(window).height()-popHeight)/2 + window.scrollY-10;
                $('.pop_bg').height($(document).height());
                $('.pop_bg').fadeIn();
                $('#popbox').css('top',InfoBoxTop);
                $('#popbox').fadeIn();
                $('body').css('overflow','hidden');
            }

            $(".return").click(function(){
                location.href='/login';
            });
        });
    </script>
</head>
·
<body>
<%@ include file="/page/common/top.jsp" %>

<!--确认  弹出框-->
<div class="popbox_bg" id="popbox">
    <p class="popbox-title">订单完成<a href="javascript:;" id="close_popbox">X</a></p>
    <div class="popbox-content">
        <p>密码修改成功！</p>
        <p>密码修改后，您需要重新登录，请点击下方按钮跳转</p>
        <p>至登录页面！</p>
    </div>
    <a href="javascript:  " class="return">重新登录</a>
</div>

<div class="mian_content container">
    <%@ include file="/page/common/usercenter.jsp" %>
    <div class="mumber_right_content">
        <div class="shopping_car_tab">
            <span class="active">修改密码</span>
        </div>
        <div class="aut_main_box">
            <div class="aut_title"><span>修改密码</span></div>
            <div class="aut_cont_box">
                <dl>
                    <dt>原密码：</dt>
                    <dd>
                        <div class="input_box">
                            <input class="pass" type="password" name="password" placeholder="请输入密码" />
                            <input class="text" type="text" name="password" placeholder="请输入密码" />
                            <em class="pass"></em>
                        </div>
                        <img src="/images/must.jpg" />
                    </dd>
                </dl>
                <dl>
                    <dt>新密码：</dt>
                    <dd class="heiAuto">
                        <div class="input_box">
                            <input class="pass" type="password" name="newPassword" placeholder="请输入密码" />
                            <input class="text" type="text" name="newPassword" placeholder="请输入密码" />
                            <em class="pass"></em>
                        </div>
                        <img src="/images/must.jpg" />
                        <p>·长度为6-14个字符</p>
                        <%--<p>·支持数字、大小写字母和标点符号</p>--%>
                        <%--<p>·不允许有空格</p>--%>
                    </dd>
                </dl>
                <dl>
                    <dt>确认密码：</dt>
                    <dd>
                        <div class="input_box">
                            <input class="pass" type="password" name="reNewPassword" placeholder="请输入密码" />
                            <input class="text" type="text" name="reNewPassword" placeholder="请输入密码" />
                            <em class="pass"></em>
                        </div>
                        <img src="/images/must.jpg" />
                    </dd>
                </dl>
                <div class="submit_box"><input type="submit" class="submit-change-password" value="确认修改" /></div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>
<%@ include file="/page/common/foot.jsp" %>
</body>
</html>
