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
    <script language="javascript" type="text/javascript" src="${ctx}/js/company.js"></script>
    <script>
        $(document).ready(function () {
            if(${!empty companyInfo.province}){
                getProvince();
                $('#new-province').val(${companyInfo.province})
            }else{
                getProvince();
            }
            if(${!empty companyInfo.city}){
                getCity();
                $('#new-city').val(${companyInfo.city})
            }else{
                getCity();
            }
            if(${!empty companyInfo.area}){
                getArea();
                $('#new-area').val(${companyInfo.area})
            }else{
                getArea();
            }
            $("#customerClass").val('${companyInfo.customerClass}');
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
            <span class="active">企业资料</span>
        </div>
        <div class="aut_main_box">
            <div class="aut_title"><span>完善企业信息</span></div>
            <input type="hidden" id="companyId" value="${companyInfo.id}">
            <div class="aut_cont_box">
                <dl>
                    <dt>企业名称：</dt>
                    <dd>${companyInfo.companyName}</dd>
                </dl>
                <dl>
                    <dt>法人代表：</dt>
                    <dd>
                        <div class="input_box"><input id="legal" type="text" name="legal" placeholder="法人代表" value="${companyInfo.legal}" /></div>
                    </dd>
                </dl>
                <dl>
                    <dt>企业电话：</dt>
                    <dd>
                        <div class="input_box"><input id="tel" type="text" name="tel" placeholder="企业电话" value="${companyInfo.tel}" /></div>
                    </dd>
                </dl>
                <dl>
                    <dt>开户银行：</dt>
                    <dd>
                        <div class="input_box"><input id="bankName" type="text" name="tel" placeholder="企业开户银行" value="${companyInfo.bankName}" /></div>
                    </dd>
                </dl>
                <dl>
                    <dt>开户账号：</dt>
                    <dd>
                        <div class="input_box"><input id="bankCode" type="text" name="tel" placeholder="企业开户账号" value="${companyInfo.bankCode}"/></div>
                    </dd>
                </dl>
                <dl>
                    <dt>企业地址：</dt>
                    <dd style="color: #7e878e">
                        省份：<select id="new-province" style="height: 33px;color: #7e878e">
                            <option>--请选择--</option>
                        </select>
                        市：<select id="new-city" style="height: 33px;color: #7e878e">
                            <option>--请选择--</option>
                        </select>
                        区域：<select id="new-area" style="height: 33px;color: #7e878e">
                            <option>--请选择--</option>
                        </select>
                    </dd>
                </dl>
                <dl>
                    <dt></dt>
                    <dd>
                        <div class="input_box"><input id="address" type="text" name="address" placeholder="详细地址" value="${companyInfo.address}"/></div>
                    </dd>
                </dl>
                <dl>
                    <dt>企业类型：</dt>
                    <dd>
                            <select id="customerClass" placeholder="详细地址" style="height: 33px;color: #7e878e" >
                                <option selected disabled>--请选择--</option>
                                <option value="经销商">经销商</option>
                                <option value="染厂">染厂</option>
                                <option value="染料厂">染料厂</option>
                                <option value="助剂厂">助剂厂</option>
                                <option value="面料厂">面料厂</option>
                                <option value="其他">其他</option>
                            </select>
                    </dd>
                </dl>
                <dl>
                    <dt>企业邮箱：</dt>
                    <dd>
                        <div class="input_box"><input id="mail" type="text" placeholder="企业邮箱" value="${companyInfo.mail}"/></div>
                    </dd>
                </dl>
                <dl>
                    <dt>公司主页：</dt>
                    <dd>
                        <div class="input_box"><input id="companyIndex" type="text" placeholder="公司主页（如：http://www.i7color.com）" value="${companyInfo.companyIndex}"/></div>
                    </dd>
                </dl>
                <dl>
                    <dt>企业简介：</dt>
                    <dd class="txtarea">
                        <div class="input_box"><textarea id="description" placeholder="主要使用产品、订单情况" >${companyInfo.description}</textarea></div>
                    </dd>
                </dl>
                <dl class="aut_cont_tips">
                    <dt><img src="/images/tips_icon.png" /></dt>
                    <dd>说明：完善企业信息，有助于上下游企业更方便的了解您的企业，与您的企业合作！</dd>
                </dl>
            </div>
        </div>
        <div class="submit_box"><input type="button" id="completeSub" value="提交申请" /></div>
    </div>
    <div class="clear"></div>
    <div class="clear"></div>
</div>
<%@ include file="/page/common/foot.jsp" %>
</body>
</html>



