<%--
  Created by IntelliJ IDEA.
  User: Echos
  Date: 2016/12/6
  Time: 14:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/page/common/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>七彩云</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <%@include file="/page/common/resource.jsp" %>
    <link href="/css/payway.css" rel="stylesheet" type="text/css"/>
    <link href="/css/placeorder.css" rel="stylesheet" type="text/css"/>
    <script language="javascript" type="text/javascript" src="${ctx}/js/order-confirm.js"></script>
    <script>
        //=====================提交订单==================
        $(document).ready(function () {
            if(${! empty msg}){
                alert('${msg}');
                location.href="/carts"
            }

            $(document).on('click','.placeorder-submit.commit-order',function () {
              //  alert($('#deliveryAddress li.default').attr('data-id'));
                if ($('#deliveryAddress li.default').attr('data-id')==undefined){
                    alert("请选择收货地址");
                    return false;
                }
                if ($('#invoiceList li.default').attr('data-id')==undefined){
                    alert("请选择发票信息");
                    return false;
                }
               // debugger;
                console.log(JSON.parse('${inquiry}'));
                $.ajax({
                    url: '/carts/commitOrder',
                    type: 'POST',
                    data: {
                        'inquiry': JSON.parse('${inquiry}'),
                        'receiptAddressId': $('#deliveryAddress li.default').attr('data-id'),
                        'invoiceInfoId': $('#invoiceList li.default').attr('data-id')
                    },
                    dataType: 'json',
                    success: function (resp) {
                        if (resp.code == 'SUCCESS') {
//                            box_alert('提交订单成功！');
                            alert('提交订单成功！');
                            location.href="/orders/"+resp.data+"/payments";
                        } else {
                            alert('提交订单失败！')
                        }
                    }
                });
            });
        });

    </script>
</head>
<body>
<jsp:include page="/page/common/feedback.jsp"></jsp:include>
<%--top模块--%>
<!--确认  弹出框-->
<!--发票-->
<input type="hidden" id="addressId" name="addressId">
<input type="hidden" id="invoiceId" name="invoiceId">
<div class="popbox_bg invoice-box" id="popbox" style="height:auto; padding-bottom:20px;">

    <p class="popbox-title">发票信息编辑<a href="javascript:;" id="close_popbox">X</a></p>
    <div class="invoice">
        <p class="invoice-head">
            <span><em class="red">*</em>发票类型：</span>
            <label><input type="radio" name="bill_type" value="VALUE_INVOICE"
                          checked="checked"/><em>增值税普通发票</em></label>
            <label><input type="radio" name="bill_type" value="NORMAL_INVOICE"/><em>增值税专业发票</em></label>
        </p>
        <p class="invoice-content">
            <span><em class="red">*</em>企业名称：</span>
            <input type="text" class="duan" id="i-new-company-name"/>
        </p>
        <p class="invoice-content">
            <span><em class="red">*</em>纳税人识别号：</span>
            <input type="text" class="duan" id="i-new-tax-code"/>
        </p>
        <p class="invoice-content">
            <span><em class="red">*</em>公司地址：</span>
            <input type="text" id="i-new-company-address"/>
        </p>
        <p class="invoice-content">
            <span><em class="red">*</em>公司电话：</span>
            <input type="text" class="duan" id="i-new-company-phone"/>
        </p>
        <p class="invoice-content">
            <span><em class="red">*</em>开户行：</span>
            <input type="text" class="duan" id="i-new-bank"/>
            <span><em class="red">*</em>开户账号：</span>
            <input type="text" class="duan" id="i-new-bank-code"/>
        </p>
        <p class="invoice-content">
            <span><em class="red">*</em>发票快递地址：</span>
            <input type="text" id="i-new-mail-address"/>
        </p>
        <p class="invoice-content">
            <span><em class="red">*</em>收件人：</span>
            <input type="text" class="duan" id="i-new-mail-person"/>
            <span><em class="red">*</em>电话：</span>
            <input type="text" class="duan" id="i-new-mail-phone"/>
        </p>
        <p class="invoice-btn">
            <a class="save-new-invoice" href="javascript:;">保存</a>
            <a class="cancel-new-invoice" href="javascript:;">取消</a>
        </p>
    </div>
</div>

<%--编辑发票信息--%>
<div class="popbox_bg invoice-box" id="popbox4" style="height:auto; padding-bottom:20px;">
    <p class="popbox-title">发票信息编辑<a href="javascript:;" id="close_popbox4">X</a></p>
    <div class="invoice edit">
        <input type="hidden" class="duan" id="i-edit-id"/>
        <p class="invoice-head">
            <span><em class="red">*</em>发票类型：</span>
            <label><input type="radio" name="edit_bill_type" value="NORMAL_INVOICE" checked="checked"/><em>增值税普通发票</em></label>
            <label><input type="radio" name="edit_bill_type" value="VALUE_INVOICE"/><em>增值税专业发票</em></label>
        </p>
        <p class="invoice-content">
            <span><em class="red">*</em>企业名称：</span>
            <input type="text" class="duan" id="i-edit-company-name"/>
        </p>
        <p class="invoice-content">
            <span><em class="red">*</em>纳税人识别号：</span>
            <input type="text" class="duan" id="i-edit-tax-code"/>
        </p>
        <p class="invoice-content">
            <span><em class="red">*</em>公司地址：</span>
            <input type="text" id="i-edit-company-address"/>
        </p>
        <p class="invoice-content">
            <span><em class="red">*</em>公司电话：</span>
            <input type="text" class="duan" id="i-edit-company-phone"/>
        </p>
        <p class="invoice-content">
            <span><em class="red">*</em>开户行：</span>
            <input type="text" class="duan" id="i-edit-bank"/>
            <span><em class="red">*</em>开户账号：</span>
            <input type="text" class="duan" id="i-edit-bank-code"/>
        </p>
        <p class="invoice-content">
            <span><em class="red">*</em>发票快递地址：</span>
            <input type="text" id="i-edit-mail-address"/>
        </p>
        <p class="invoice-content">
            <span><em class="red">*</em>收件人：</span>
            <input type="text" class="duan" id="i-edit-mail-person"/>
            <span><em class="red">*</em>电话：</span>
            <input type="text" class="duan" id="i-edit-mail-phone"/>
        </p>
        <p class="invoice-btn">
            <a class="save-edit-invoice" href="javascript:;">保存</a>
            <a class="cancel-edit-invoice" href="javascript:;">取消</a>
        </p>
    </div>
</div>
<!--新增收货人信息-->
<div class="popbox_bg popbox_bg2" id="popbox2">
    <p class="popbox-title">新增收货人信息<a href="javascript:;" id="close_popbox2">X</a></p>
    <div class="consignee-box-content">
        <p>
            <span><i>收货人 :</i></span>
            <input type="text" id="new-recipients" placeholder="请输入收货人姓名"/>
        </p>
        <p>
            <span><i>所在地区 :</i></span>
            <select id="new-province">
                <option>--请选择--</option>
            </select>
            <select id="new-city">
                <option>--请选择--</option>
            </select>
            <select id="new-area">
                <option>--请选择--</option>
            </select>
        </p>
        <p>
            <span><i>详细地址 :</i></span>
            <input type="text" id="new-address" placeholder="请输入详细地址"/>
        </p>
        <p>
            <span><i>手机号码 :</i></span>
            <input type="text" id="new-phone" placeholder="请输入手机号"/>
        </p>
        <p>
            <a href="javascript:;" class="save-consignee-btn create-receipt-address">保存收货人信息</a>
        </p>
    </div>
</div>
<%--编辑收货地址--%>
<div class="popbox_bg popbox_bg2" id="popbox3">
    <p class="popbox-title">编辑收货地址信息<a href="javascript:;" id="close_popbox3">X</a></p>
    <div class="consignee-box-content">
        <p>
            <span><i>收货人 :</i></span>
            <input type="text" id="edit-recipients"/>
        </p>
        <p>
            <span><i>所在地区 :</i></span>
            <select id="edit-province">
                <option>--请选择--</option>
            </select>
            <select id="edit-city">
                <option>--请选择--</option>
            </select>
            <select id="edit-area">
                <option>--请选择--</option>
            </select>
        </p>
        <p>
            <span><i>详细地址 :</i></span>
            <input type="text" id="edit-address"/>
        </p>
        <p>
            <span><i>手机号码 :</i></span>
            <input type="text" id="edit-phone"/>
        </p>
        <input type="hidden" id="edit-id"/>
        <p>
            <a href="javascript:;" class="save-consignee-btn edit-receipt-address">确认修改</a>
        </p>
    </div>
</div>
<!--头部结束-->
<%@ include file="/page/common/top.jsp" %>

<p class="placeorder-title container">请填写并核对订单信息</p>

<div class="payway-content-middle container placeorder-content">
    <div class="payway-content-middle-t">
        <p class="payway-content-middle-title">收货人信息<a href="javascript:;" class="cosignee-btn">新增收货地址</a></p>
        <ul class="consignee" id="deliveryAddress">

        </ul>
    </div>

    <div class="payway-content-middle-t">
        <p class="payway-content-middle-title">发票信息<a href="javascript:;" id="submit">新增发票抬头</a></p>
        <ul class="consignee" id="invoiceList">
        </ul>
    </div>
    <div class="placeorder-content-middle-b">
        <p class="payway-content-middle-title">商品信息</p>
        <div class="placeorder-shop-info">
            <c:set var="price" value="0"></c:set>
            <c:forEach items="${inquiryConfirmList}" var="inquiryConfirmList">
                <c:set var="price" value="${price+inquiryConfirmList.price}"></c:set>
                <dl>
                    <dt><img src="${itx}${inquiryConfirmList.product.largeUrl}" width="80" height="80"/></dt>
                    <dd>
                        <p>${inquiryConfirmList.product.aliasName}</p>
                        <p>商品编号: <span>${inquiryConfirmList.product.code}</span></p>
                    </dd>
                    <dd>
                        <c:set var="packType" value="默认"></c:set>
                        <c:forEach items="${inquiryConfirmList.product.propTypeList}" var="prop">
                            <c:if test="${prop.type == 'pack'}">
                                <c:set var="packType" value="${prop.propList[0].value}"></c:set>
                            </c:if>
                        </c:forEach>
                            ${packType}
                    </dd>
                    <dd>${inquiryConfirmList.num}公斤</dd>
                    <dd>￥${inquiryConfirmList.price}</dd>
                </dl>
            </c:forEach>
        </div>
    </div>
</div>
<!--placeorder-content-->

<div class="placeorder-result container">
    <p>商品总金额:<span>￥<b>${price}</b></span></p>
    <p>
        送货至:
        <span id="address" class="address"></span>
        收货人:
        <span id="check-recipients"></span>
        <span id="check-phone"></span>
    </p>
</div>

<div class="container submit-box">
    <a href="javascript:;" class="placeorder-submit commit-order" id="">提交订单</a>
</div>


<%@ include file="/page/common/foot.jsp" %>
</body>
</html>