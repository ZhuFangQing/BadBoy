$(document).ready(function () {
    $(".send-bind-mobile-code").click(function () {
        console.log('captcha...');
        //mobile
        var mobile = $("input[name='mobile']").val();
        if (undefined != mobile && null != mobile && (MOBILE_REG.test(mobile) || EMAIL_REG.test(mobile))) {
            console.log("手机号正确...准备获取验证码");

            $.ajax({
                url: '/register_code',
                type: 'GET',
                data: {
                    'mobile': mobile,
                    'VERIFY_CODE_TYPE': "I7COLOR_BIND_MOBILE_CODE"
                },
                dataType: 'json',
                success: function (resp) {
                    console.log(resp);
                    if (resp.code = 'SUCCESS') {
                        $("input[name='rePasswordCode']").focus();
                        $(".send-bind-mobile-code").attr("disabled", true);
                        sendRePasswordSmsCodeTimeout(SEND_SMS_CODE_INTERVAL)
                    }
                }
            });
        } else {
            alert("手机号码格式错误");
            return false;
        }
    });

    function sendRePasswordSmsCodeTimeout(second){
        if(second == 0){
            $(".send-bind-mobile-code").val("发送验证码");
            $(".send-bind-mobile-code").attr("disabled", false);
        }else{
            $(".send-bind-mobile-code").val("(" +second + "s) 后重发");
            setTimeout(function(){sendRePasswordSmsCodeTimeout(--second)}, 1000)
        }
    }

    $(".submit.bind").click(function(){
        console.log('start bind mobile..');
        debugger;
        //mobile
        var mobile = $("input[name='mobile']").val();
        var bindMobileCode =$("input[name='bindMobileCode']").val();
        var openId =$("input[name='openId']").val();
        var type =$("input[name='type']").val();
        var nickname =$("input[name='nickname']").val();
        var password =$("input[name='password']").val();
        var password2 =$("input[name='password2']").val();

        if(!$.notNull(password) || !$.notNull(password2)){
            alert("请填写登陆密码");
            return false;
        }

        if(password != password2){
            alert('两次输入的密码不一致');
            return false;
        }

        if(password.length < 4 || password.length > 16){
            alert('请输入4-16位字符的密码');
            return false;
        }

        if(undefined != mobile && null != mobile && (MOBILE_REG.test(mobile)||EMAIL_REG.test(mobile))){
            $.ajax({
                url:'/toBindingAccount',
                type:'GET',
                data:{
                    'mobile': mobile,
                    'smsCode':bindMobileCode,
                    'openId':openId,
                    'type':type,
                    'VERIFY_CODE_TYPE':"I7COLOR_BIND_MOBILE_CODE",
                    'nickname':nickname,
                    'password':password
                },
                dataType:'json',
                success:function(resp){
                    console.log(resp);
                    if(resp.code = 'SUCCESS'){
                        alert(resp['msg']);
                        location.href="/";
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