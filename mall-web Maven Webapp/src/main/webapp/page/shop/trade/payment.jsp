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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%@include file="/page/common/resource.jsp" %>
    <link href="/css/placeorder.css" rel="stylesheet" type="text/css" />
    <link href="/css/business.css" rel="stylesheet" type="text/css" />
    <link href="/css/payway.css" rel="stylesheet" type="text/css" />
    <script src="/js/order.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var errorMsg = "${msg}";
            if($.notNull(errorMsg)){
                alert(errorMsg);
                location.href="/orders";
            }

            //选中默认支付方式
            var payAmount = parseFloat($(".wait_pay_amount").attr("data-val"));
            var creditVal = parseFloat($(".credit_balance").attr("data-val"));
            if(creditVal >= payAmount){
                $(".pay-way span[data-payment='credit']").click();
            }
        })
    </script>
</head>
<body>
<jsp:include page="/page/common/feedback.jsp"></jsp:include>
<%--top模块--%>
<%@ include file="/page/common/top.jsp" %>

<!--确认  弹出框-->
<div class="popbox_bg" id="popbox">
    <p class="popbox-title">订单完成<a href="javascript:;" id="close_popbox">X</a></p>
    <div class="popbox-content">
        <p>尊敬的客户，恭喜您 !</p>
        <p>您已成功下单 !</p>
        <p>如有任何问题，可通过在线咨询工具或者</p>
        <p>免费服务热线: 400-920-85599联系我们 !</p>
    </div>
    <a href="/u" class="return">确认</a>
</div>


<div class="payway-content container">
    <div class="pay-content-head">
        <p class="goods-num">订单提交成功，请您尽快付款! 订单号:<span>${order.orderNum}</span><span class="order_no" style="display: none;">${order.id}</span></p>
        <P class="goods-time">
            请您在<span>72小时内</span>完成支付，否则订单会被自动取消 (商品价格会随市场浮动儿产生变化，超市后需要重新询价)
        </P>
        <p class="goods-price">订单金额:<span class="order_total_amount" data-val="${order.orderAmount}">￥<b>${order.orderAmount}</b></span></p>
    </div>

    <div class="payway-content-middle">
        <div class="payway-content-middle-t">
            <p class="payway-content-middle-title">账户信息</p>
            <p class="balance">现金余额:<span class="cash_balance" data-val="${balance.availableAmount}">￥${balance.availableAmount}</span></p>
            <p class="credit">可使用信用额度:<span class="credit_balance" data-val="${credit.availableAmount}">￥${credit.availableAmount}</span></p>
        </div>

        <div class="payway-content-middle-m">
            <p class="payway-content-middle-title">实际付款金额</p>
            <c:set var="amount" value="${order.orderAmount - balance.availableAmount}"></c:set>
            <p class="cal">已抵扣现金：<span class="order_balance_use" data-val="${amount <= 0 ? order.orderAmount : balance.availableAmount}" style="color:red;">-${amount <= 0 ? order.orderAmount : balance.availableAmount}</span></p>
            <p class="actual">实际需付款金额 :<span class="wait_pay_amount" data-val="${amount < 0 ? 0 : amount}">￥<b>${amount < 0 ? 0 : amount}</b></span></p>
            <p class="cal">注: 实际付款金额 = 订单金额 - 现金余额，付款后现金余额将自动扣除相应部分</p>
        </div>
        <%--<input name="wait_pay_amount" value="${amount}"/>--%>

        <c:if test="${amount != 0}">
            <div class="payway-content-middle-b">
                <p class="payway-content-middle-title">支付方式</p>
                    <%--<p class="pay-way"><span class="active"></span>企业银行转账</p>--%>
                <p class="pay-way"><span data-payment="credit"></span>余额/信用额支付</p>
                <p class="pay-way"><span class="active" data-payment="cash"></span>企业银行转账</p>
                <ul>
                    <li>
                        <label><input type="checkbox" /><span>银行本票支付</span></label>
                    </li>
                    <li>
                        <label><input type="checkbox" /><span>银行支票支付</span></label>
                    </li>
                    <li>
                        <label><input type="checkbox" /><span>现金支付</span></label>
                    </li>

                </ul>
                <ul>
                    <li>
                        <span class="credit_tips" style="display: none;">信用额不足，<a target="_blank" href="/money?source=apply" class="red_bold">申请提额</a></span>
                    </li>
                </ul>
                <%--<span class="credit_tips" >信用额不足，<a target="_blank" href="/money?source=apply">申请提额</a></span>--%>
                <i style="clear:both;"></i>
            </div>
        </c:if>
    </div>
    <a href="javascript:;" class="sure-btn">确认</a>
</div>
<!--payway-content-->



<%@ include file="/page/common/foot.jsp" %>
</body>
</html>