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
    <script src="/js/user.js"></script>
    <script src="/js/company.js"></script>

    <style>
        .abutton { padding: 1px 15px; font-size: 12px; text-align: center; text-shadow: #80AD10 0 1px 0; border:1px solid #80AD10; border-radius: 2px; background: #A5D62D; background-image: -webkit-linear-gradient(top, #A5D62D, #9AC827); color:#FFF; cursor: hand; display: inline-block; }
    </style>
    <script>
        $(document).ready(function () {

            $("input[type='file']").change(function () {
                uploadImage($(this).attr("id"));
            });

            $("a.a_file_sel").click(function () {
                $(this).child().click();
            });
        });

        function reSetCompany() {
            if (check()) {
                $.ajax({
                    url: '/company/resetCompanyInfo',
                    type: 'POST',
                    data: $('#reCompanyForm').serialize(),
                    dataType: 'json',
                    success: function (resp) {
                        console.log(resp);
                        if (resp.code != 'SUCCESS') {
                            alert(resp['msg']);
                        } else {
                            alert('提交成功');
                            location.href = "/u";
                        }
                    }
                });
            }
        }
    </script>
</head>
<body>
<%--top模块--%>
<%@ include file="/page/common/top.jsp" %>
<div class="mian_content container">
    <%@ include file="/page/common/usercenter.jsp" %>

    <div class="mumber_right_content">
        <div class="shopping_car_tab">
            <span class="active">更新企业认证账户信息</span>
        </div>
        <form id="reCompanyForm" method="post">
        <div class="aut_main_box">
            <div class="aut_title"><span>账户信息</span></div>
            <div class="aut_cont_box">
                <dl>
                    <dt>企业名称：</dt>
                    <dd>
                        <div class="input_box"><input type="text" id="companyName" name="companyName" value="${company.companyName}" placeholder="请输入完整企业名称"/></div>
                        <img src="/images/must.jpg"/>
                        <input type="hidden" value="${company.id}" name="id">
                    </dd>
                </dl>

                <dl>
                    <dt>登录密码：</dt>
                    <dd>
                        <div class="input_box"><input type="text" id="password" name="password" placeholder="用于企业号登录的密码"/></div>
                        <img src="/images/must.jpg"/>
                    </dd>
                </dl>
                <dl>
                    <dt>确认密码：</dt>
                    <dd>
                        <div class="input_box"><input type="text" id="rePassword" name="rePassword"/></div>
                        <img src="/images/must.jpg"/>
                    </dd>
                </dl>
                <dl class="aut_cont_tips">
                    <dt><img src="/images/tips_icon.png"/></dt>
                    <dd>说明：申请的企业账户将会自动生产一个<strong>全新的账户</strong>，此账户的登录名为企业名称，使用企业认证账户登录后，将可以使用商城的全部功能！</dd>
                </dl>
            </div>
            <div class="aut_title"><span>企业证明</span></div>
            <div class="aut_cont_box">
                <dl>
                    <dt>营业执照：</dt>
                    <dd>
                        <div class="input_box"><input type="text" id="busLicenceCode" name="busLicenceCode" value="${company.busLicenceCode}" placeholder="请输入完整营业执照代码"/></div>
                        <img src="/images/must.jpg"/>
                        <label class="abutton">
                            选择文件
                            <input type="file" id="busLicenceUrl"  name="fileImg"  style="display: none;" accept="image/jpeg,image/gif,image/png,image/bmp"/>
                        </label>
                        <span class="busLicenceUrl" style="margin-left: 10px; color: #4cae4c; display: none;">上传成功</span>
                        <img src="/images/must.jpg"/>
                        <input type="hidden" name="busLicenceUrl" id="busLicenceImg">
                    </dd>
                </dl>
                <dl>
                    <dt>组织机构代码：</dt>
                    <dd>
                        <div class="input_box"><input type="text" id="institutionCode" name="institutionCode" value="${company.institutionCode}" placeholder="请输入完整组织机构代码"/></div>
                        <img src="/images/must.jpg"/>
                        <label class="abutton">
                            选择文件
                            <input type="file" id="institutionUrl" name="fileImg"  style="display: none;" accept="image/jpeg,image/gif,image/png,image/bmp"/>
                        </label>
                        <span class="institutionUrl" style="margin-left: 10px; color: #4cae4c; display: none;">上传成功</span>
                        <img src="/images/must.jpg"/>
                        <input type="hidden" name="institutionUrl" id="institutionImg">
                    </dd>
                </dl>
                <dl>
                    <dt>税务登记证：</dt>
                    <dd>
                        <div class="input_box"><input type="text" id="taxCode" name="taxCode" value="${company.taxCode}" placeholder="请输入完整税务登记代码"/></div>
                        <img src="/images/must.jpg"/>
                        <label class="abutton">
                            选择文件
                            <input type="file" id="taxUrl" name="fileImg"  style="display: none;" accept="image/jpeg,image/gif,image/png,image/bmp"/>
                        </label>
                        <span class="taxUrl" style="margin-left: 10px; color: #4cae4c; display: none;">上传成功</span>
                        <img src="/images/must.jpg"/>
                        <input type="hidden" name="taxUrl" id="taxImg">
                    </dd>
                </dl>
                <dl class="aut_cont_tips">
                    <dt><img src="/images/tips_icon.png"/></dt>
                    <dd style="text-align:left; padding-top:5px;">说明：三证合一的用户仅需上传营业执照即可</dd>
                </dl>
            </div>

            <%--<div class="aut_cont_box">
                <dl>
                    <dt>营业执照：</dt>
                    <dd>
                        <div class="input_box"><input type="text" id="busLicenceCode" value="${company.busLicenceCode}" name="busLicenceCode" placeholder="请输入完整营业执照代码"/></div>
                        <img src="/images/must.jpg"/>
                        <input type="file" id="busLicenceUrl"  name="fileImg"
                               onchange="uploadImage(this.id)" accept="image/jpeg,image/gif,image/png,image/bmp"/><img
                            src="/images/must.jpg"/>
                        <input type="hidden" name="busLicenceUrl" id="busLicenceImg">
                    </dd>
                </dl>
                <dl>
                    <dt>组织机构代码：</dt>
                    <dd>
                        <div class="input_box"><input type="text" id="institutionCode" value="${company.institutionCode}" name="institutionCode" placeholder="请输入完整组织机构代码"/></div>
                        <img src="/images/must.jpg"/>
                        <input type="file" id="institutionUrl" name="fileImg"
                               onchange="uploadImage(this.id)" accept="image/jpeg,image/gif,image/png,image/bmp"/><img
                            src="/images/must.jpg"/>
                        <input type="hidden" name="institutionUrl" id="institutionImg">
                    </dd>
                </dl>
                <dl>
                    <dt>税务登记证：</dt>
                    <dd>
                        <div class="input_box"><input type="text" id="taxCode" name="taxCode" value="${company.taxCode}" placeholder="请输入完整税务登记代码"/></div>
                        <img src="/images/must.jpg"/>
                        <input type="file" id="taxUrl" name="fileImg"
                               onchange="uploadImage(this.id)" accept="image/jpeg,image/gif,image/png,image/bmp"/><img
                            src="/images/must.jpg"/>
                        <input type="hidden" name="taxUrl" id="taxImg">
                    </dd>
                </dl>
                <dl class="aut_cont_tips">
                    <dt><img src="/images/tips_icon.png"/></dt>
                    <dd style="text-align:left; padding-top:5px;">说明：三证合一的用户仅需上传营业执照即可</dd>
                </dl>
            </div>--%>
        </div>
        <div class="submit_box"><input type="button" value="确认修改" onclick="reSetCompany()"/></div>
        </form>
    </div>
    <div class="clear"></div>
</div>
<%@ include file="/page/common/foot.jsp" %>
</body>
</html>



