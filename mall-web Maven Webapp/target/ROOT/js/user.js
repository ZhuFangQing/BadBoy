/**
 * Created by Echos on 2016/12/1.
 */

var MOBILE_REG = /^1[3|4|5|7|8][0-9]{9}$/; //验证规则
var EMAIL_REG = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
var SEND_SMS_CODE_INTERVAL = 180 ;

$(document).ready(function(){
    // if(isLogin()){
    //     var backUrl = $.getUrlParam("back_url");
    //     if(null != backUrl && backUrl != ''){
    //         location.href = backUrl;
    //     }else{
    //         location.href = '/index';
    //     }
    // }

    $("input[name='mobile']").focus();

    //send interval
    function sendSmsCodeTimeout(second){
        if(second == 0){
            $(".code-btn").html("发送验证码");
            $(".code-btn").attr("disabled", false);
        }else{
            $(".code-btn").html("(" +second + "s) 后重发");
            setTimeout(function(){sendSmsCodeTimeout(--second)}, 1000)
        }
    }

    //send sms-code
    $(".code-btn").click(function(){
        console.log('captcha...');
        //mobile
        var mobile = $("input[name='mobile']").val();
        if(undefined != mobile && null != mobile && MOBILE_REG.test(mobile)){
            console.log("手机号正确...准备获取验证码");

            $.ajax({
                url:'/register_code',
                type:'GET',
                data:{
                    'mobile': mobile,
                    'VERIFY_CODE_TYPE':"I7COLOR_VERIFY_CODE"
                },
                dataType:'json',
                success:function(resp){
                    console.log(resp);
                    if(resp.code == 'SUCCESS'){
                        $("input[name='captcha']").focus();
                        $(".code-btn").attr("disabled", true);
                        sendSmsCodeTimeout(SEND_SMS_CODE_INTERVAL)
                    }else{
                        alert(resp.msg);
                    }
                }
            });
        }else{
            alert("手机号码格式错误");
            return false;
        }
    });



    //register
    $(".register-btn").click(function(){
        String.prototype.endWith=function(endStr){
            var d=this.length-endStr.length;
            return (d>=0&&this.lastIndexOf(endStr)==d)
        };
        console.log('register...');
        var   mobile=$("input[name='mobile']").val();
        var   username = $("input[name='username']").val();
        var   captcha = $("input[name='captcha']").val();
        var   password = $("input[name='password']").val();
        // var   password_confirm = $("input[name='password_confirm']").val();
        var   isAgree = $("input[name='agree']").is(":checked");
        if(undefined == mobile || null == mobile || "" == mobile){
            alert("手机号不能为空");
            return false;
        }
        if(undefined == username || null == username || "" == username){
            alert("用户名不能为空");
            return false;
        }
        if(!isNaN(username)){
            alert("用户名不能为纯数字");
            return false;
        }
        if(username.endWith("公司")){
            alert("用户名不能以'公司'结尾");
            return false;
        }

        if(undefined == captcha || null == captcha || "" == captcha){
            alert("验证码不能为空");
            return false;
        }
        if(undefined == password || null == password || "" == password){
            alert("密码不能为空");
            return false;
        }
        // if(undefined == password_confirm || null == password_confirm || "" == password_confirm){
        //     alert("请再次输入密码");
        //     return false;
        // }
        if(!isAgree){
            alert("请阅读并接受《七彩云协议》");
            return false;
        }

        var obj = {
            mobile          : mobile,
            username        : username,
            captcha         : captcha,
            password        : password
        };


        //check mobile
        if(!MOBILE_REG.test(obj['mobile'])){

            return false;
        }
        //check password
        // if(obj['password'] != obj['password_confirm']){
        //     alert("两次输入的密码不相同");
        //     return false;
        // }

        $.ajax({
            url:'/register',
            type:'POST',
            data:obj,
            dataType:'json',
            success:function(resp){
                console.log(resp);
                if(resp.code != 'SUCCESS'){
                    alert(resp['msg']);
                }else{
                    // alert('注册成功');
                    reSuccess();
                    var backUrl = $.getUrlParam("back_url");
                    if(null != backUrl && backUrl != ''){
                        location.href = backUrl;
                    }else{
                        location.href = '/';
                    }

                }
            }
        });

    })


    //###########################################################################
    //设置验证码
    $(".captcha_btn").click(function(){
        debugger;
        var captchaUrl = "/captcha?" + Math.random();
        $("span.captcha_span").css("background-image","url(" + captchaUrl + ")");
    });

    //register
    $(".login-btn").click(function(){
        console.log('login...');
        var username=$("input[name='username']").val();
        var captcha =$("input[name='captcha']").val();
        var password =$("input[name='password']").val();

        if(undefined == username || null == username || "" == username){
            alert("用户名不能为空");
            return false;
        }
        if(undefined == captcha || null == captcha || "" == captcha){
            alert("验证码不能为空");
            return false;
        }
        if(undefined == password || null == password || "" == password){
            alert("密码不能为空");
            return false;
        }

        var obj = {
            username : username,
            captcha  : captcha,
            password : password
        };

        console.log(obj);
        $.ajax({
            url:'/toLogin',
            type:'POST',
            data:obj,
            dataType:'json',
            success:function(resp){
                console.log(resp);
                if(resp.code != 'SUCCESS'){
                    alert(resp['msg']);
                }else{
                    var backUrl = $.getUrlParam("back_url");
                    if(null != backUrl && backUrl != ''){
                        location.href = backUrl;
                    }else{
                        location.href = '/index';
                    }

                }
            }
        });

    });
//============================找回密码=========================
    $(".submit.findPassword").click(function(){
        console.log('login...');
        var str = $("input[name='findMobile']").val();
        if(MOBILE_REG.test(str) || EMAIL_REG.test(str)){

            var obj = {
                mobile : str,
                findPwdCaptcha : $("input[name='findPwdCaptcha']").val()
            };
            $.ajax({
                url:'/findPasswordVerify',
                type:'POST',
                data:obj,
                dataType:'json',
                success:function(resp){
                    console.log(resp);
                    if(resp.msg != 'SUCCESS'){
                        alert(resp['msg']);
                    }else{
                        location.href =resp['url'];
                    }
                }
            });
        }else{

            alert("请输入正确的手机号或者邮箱地址");
        }
    });

    $(".send-rePassword-code").click(function(){
        console.log('captcha...');
        //mobile
        var mobile = $("input[name='mobile']").val();
        if(undefined != mobile && null != mobile && (MOBILE_REG.test(mobile)||EMAIL_REG.test(mobile))){
            console.log("手机号正确...准备获取验证码");

            $.ajax({
                url:'/register_code',
                type:'GET',
                data:{
                    'mobile': mobile,
                    'VERIFY_CODE_TYPE':"I7COLOR_FIND_SMS_CODE"
                },
                dataType:'json',
                success:function(resp){
                    console.log(resp);
                    if(resp.code = 'SUCCESS'){
                        $("input[name='rePasswordCode']").focus();
                        $(".send-rePassword-code").attr("disabled", true);
                        sendRePasswordSmsCodeTimeout(SEND_SMS_CODE_INTERVAL)
                    }
                }
            });
        }else{
            alert("手机号码格式错误");
            return false;
        }
    });

    function sendRePasswordSmsCodeTimeout(second){
        if(second == 0){
            $(".send-rePassword-code").val("发送验证码");
            $(".send-rePassword-code").attr("disabled", false);
        }else{
            $(".send-rePassword-code").val("(" +second + "s) 后重发");
            setTimeout(function(){sendRePasswordSmsCodeTimeout(--second)}, 1000)
        }
    }

    function reSuccess() {
        var popHeight = $('#popbox').height();
        var InfoBoxTop = ($(window).height()-popHeight)/2 + window.scrollY-10;
        $('.pop_bg').height($(document).height());
        $('.pop_bg').fadeIn();
        $('#popbox').css('top',InfoBoxTop);
        $('#popbox').fadeIn();
        $('body').css('overflow','hidden');
    }
});