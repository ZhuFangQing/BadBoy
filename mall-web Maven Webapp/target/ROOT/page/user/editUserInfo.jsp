<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@include file="/page/common/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>七彩云</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <%@include file="/page/common/resource.jsp" %>
    <link href="${ctx}/css/authentication.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/css/payway.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/css/pro_detil.css" rel="stylesheet" type="text/css"/>
    <script src="/js/user.js"></script>
    <script>
        $(document).ready(function(){

            $("select[name='education'] option[value='${userInfo.education}']").attr("selected", true);

            $("#edit-area").change(function(){
               $("input[name='location']").val($("#edit-province option:selected").attr("valueName") + "-" + $("#edit-city option:selected").attr("valueName") + "-" + $("#edit-area option:selected").attr("valueName"));
            });

            $("#edit-province").change(function(){
                getCity(function(){
                    getArea(function(){
                        $("#edit-area").trigger("change");
                    });
                });
            });
            $("#edit-city").change(function(){
                getArea(function(){
                    $("#edit-area").trigger("change");
                });
            });

            getProvince(function(){
                getCity(function(){
                    getArea(function(){

                        var location = "${userInfo.location}";
                        if(location != ""){
                            debugger;
                            var address = location.split("-");

                            $("#edit-province option[valueName='"+address[0]+"']").attr("selected",true);
                            getCity(function(){
                                $("#edit-city option[valueName='"+address[1]+"']").attr("selected",true);
//                                $("#edit-city").val(address[1]);

                                getArea(function(){

                                    $("#edit-area option[valueName='"+address[2]+"']").attr("selected",true);
//                                    $("#edit-area").val(address[2]);
                                });
                            });
                        }

                    });
                });
            });

            $("#edit-area").change();
        });

        function getProvince(callback) {
            $.ajax({
                url: '/company/getProvince',
                type: 'GET',
                data: {},
                dataType: 'json',
                success: function (resp) {
                    $('#edit-province').empty();
                    for (var i = 0; i < resp.length; i++) {
                        $('#edit-province').append("" +
                            "<option  value="+resp[i].regionCode+" valueName="+resp[i].regionName+" >" + resp[i].regionName + "</option>")
                    }

                    callback();
                }
            });
        }

        function getCity(callback) {
            $.ajax({
                url: '/company/getCity',
                type: 'GET',
                data: {
                    provinceCode:$('#edit-province').val()
                },
                dataType: 'json',
                success: function (resp) {
                    $('#edit-city').empty();
                    for (var i = 0; i < resp.length; i++) {
                        $('#edit-city').append("" +
                            "<option value=" + resp[i].regionCode + " valueName="+resp[i].regionName+">" + resp[i].regionName + "</option>")
                    }

                    callback();
                }
            });
        }

        function getArea(callback) {
            $.ajax({
                url: '/company/getArea',
                type: 'GET',
                data: {
                    cityCode:$('#edit-city').val()
                },
                dataType: 'json',
                success: function (resp) {
                    $('#edit-area').empty();
                    for (var i = 0; i < resp.length; i++) {
                        $('#edit-area').append("" +
                            "<option value=" + resp[i].regionCode + " valueName="+resp[i].regionName+">" + resp[i].regionName + "</option>")
                    }

                    callback();
                }
            });
        }


        $(document).on('click', '#submit3', function () {
            //check
            if(!REG_EMAIL.test($("input[name='email']").val())){
                alert('请填写正确的邮箱地址');
                return false;
            }
            if(!REG_QQ.test($("input[name='qq']").val())){
                alert('请填写正确的QQ号码');
                return false;
            }

            $.ajax({
                url: '/user/updateUserInfo',
                type: 'POST',
                data: $('#userInfoForm').serialize(),
                dataType: 'json',
                success: function (resp) {
                    console.log(resp);
                    if (resp.code != 'SUCCESS') {
                        alert(resp['msg']);
                    } else {
                        alert('更新个人信息成功！');
                        location.href="/user/toShowUserInfoPage";
                    }
                }
            });
        });

        $(document).on('change', '#new-province', function () {
            getCity();
        });

        $(document).on('change', '#new-city', function () {
            getArea();
        });


    </script>
</head>
<body>
<%--top模块--%>
<%@ include file="/page/common/top.jsp" %>
<div class="mian_content container">
    <%@ include file="/page/common/usercenter.jsp" %>
    <div class="mumber_right_content">
        <div class="shopping_car_tab">
            <span class="active">修改个人资料</span>
        </div>
        <div class="aut_main_box">
            <div class="aut_title"><span>账户信息</span></div>
            <form id="userInfoForm">
                <div class="aut_cont_box">
                    <dl>
                        <dt>会员昵称：</dt>
                        <dd>
                            ${userInfo.login_name}
                        </dd>
                    </dl>
                    <dl>
                        <dt>联系电话：</dt>
                        <dd>
                            ${userInfo.phone}
                        </dd>
                    </dl>
                    <dl>
                        <dt>真实姓名：</dt>
                        <dd>
                            <div class="input_box"><input type="text" name="real_name" placeholder="请填写您的真实姓名" maxlength="4" value="${userInfo.real_name}"/></div>
                            <input type="hidden" id="">
                        </dd>
                    </dl>
                    <dl>
                        <dt>Email：</dt>
                        <dd>
                            <div class="input_box"><input type="text" name="email" placeholder="请填写您的Email地址" value="${userInfo.email}"/></div>
                        </dd>
                    </dl>
                    <dl>
                        <dt>QQ：</dt>
                        <dd>
                            <div class="input_box"><input type="text" name="qq" placeholder="请填写您的QQ" value="${userInfo.qq}"/></div>
                        </dd>
                    </dl>
                    <dl>
                        <dt>所在地区：</dt>
                        <dd>
                            <%--<div class="input_box"><input type="text" name="location" placeholder="请填写您所在地区" maxlength="10" value="${userInfo.location}"/></div>--%>
                            <input type="hidden" name="location">
                            <select id="edit-province">
                                <option>--请选择--</option>
                            </select>
                            <select id="edit-city">
                                <option>--请选择--</option>
                            </select>
                            <select id="edit-area">
                                <option>--请选择--</option>
                            </select>
                        </dd>
                    </dl>
                    <dl>
                        <dt>所在公司：</dt>
                        <dd>
                            <div class="input_box"><input type="text" name="company" placeholder="请填写您所在公司" maxlength="50" value="${userInfo.company}"/></div>
                        </dd>
                    </dl>
                    <dl>
                        <dt>学历：</dt>
                        <dd>
                            <%--<div class="input_box">--%>
                            <select name="education" value="${userInfo.education}" style="height: 30px;">
                                <option value="小学">小学</option>
                                <option value="初中">初中</option>
                                <option value="中专/高中">中专/高中</option>
                                <option value="专科">专科</option>
                                <option value="本科">本科</option>
                                <option value="硕士研究生">硕士研究生</option>
                                <option value="博士研究生">博士研究生</option>
                            </select>
                            <%--<input type="text" name="education" placeholder="请填写您的学历" maxlength="10" />--%>
                            <%--</div>--%>
                        </dd>
                    </dl>
                </div>
            </form>
        </div>

        <div class="submit_box"><input type="button" value="确认修改" id="submit3" /></div>
    </div>
    <div class="clear"></div>
</div>
<%@ include file="/page/common/foot.jsp" %>
</body>
</html>



