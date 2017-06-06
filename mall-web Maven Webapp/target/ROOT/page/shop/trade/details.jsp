<%--
  Created by IntelliJ IDEA.
  User: Echos
  Date: 2016/12/6
  Time: 14:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>七彩云</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%@include file="/page/common/resource.jsp" %>

    <link href="/css/shoppingCar.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
           $(".payment_type_val").html($.paymentType($(".payment_type_val").html()));
        });
    </script>
</head>
<body>
<jsp:include page="/page/common/feedback.jsp"></jsp:include>
<%--top模块--%>
<%@ include file="/page/common/top.jsp" %>
<div class="mian_content container">
    <jsp:include page="/page/common/usercenter.jsp"></jsp:include>
    <div class="mumber_right_content">
        <div class="shopping_car_tab">
            <span class="active">订单详情</span>
        </div>
        <div class="tab_main_box">
            <div class="order_progress">
                <c:set var="none" value="none"></c:set>
                <c:set var="onthis" value=""></c:set>
                <div class="order_progress_box submit">
                    <p>提交订单</p>
                    <%--<p>2016-06-18</p>--%>
                </div>
                <div class="order_progress_bar"></div>

                <c:if test="${order.status != 'notPay' && order.status != 'paying'}">
                    <c:set var="none" value=""></c:set>
                </c:if>
                <c:if test="${order.status == 'waitCheck' || order.status == 'waitDelivery'}">
                    <c:set var="onthis" value=""></c:set>
                </c:if>
                <div class="order_progress_box pay ${none} ${onthis}">
                    <p>付款成功</p>
                    <%--<p>2016-06-18</p>--%>
                </div>
                <div class="order_progress_bar"></div>

                <c:set var="none" value="none"></c:set>
                <c:set var="onthis" value=""></c:set>
                <c:if test="${order.status == 'alreadyDelivery' || order.status == 'finish'}">
                    <c:set var="none" value=""></c:set>
                    <c:if test="${order.status != 'finish'}">
                        <c:set var="onthis" value="onthis"></c:set>
                    </c:if>
                </c:if>
                <div class="order_progress_box out ${none} ${onthis}">
                    <p>商品出库</p>
                    <%--<p>2016-06-19</p>--%>
                </div>
                <div class="order_progress_bar"></div>

                <c:set var="none" value="none"></c:set>
                <c:set var="onthis" value=""></c:set>
                <c:if test="${order.status == 'finish'}">
                    <c:set var="none" value=""></c:set>
                    <c:set var="onthis" value="onthis"></c:set>
                </c:if>
                <div class="order_progress_box complete ${none} ${onthis}">
                    <p>完成</p>
                </div>
            </div>
            <div class="order_detil_info">
                <table width="100%">
                    <tr>
                        <td width="33%">
                            <div class="order_detil_info_box">
                                <h1>订单信息</h1>
                                <p>订单编号：${order.orderNum}</p>
                                <p>支付方式：<span class="payment_type_val">${order.paymentType}</span></p>
                                <p>下单时间：${order.createdAt}</p>
                            </div>
                        </td>
                        <td width="33%">
                            <div class="order_detil_info_box">
                                <h1>收货人信息</h1>
                                <p>收货人姓名： ${order.orderList[0].deliveryPeopleName}</p>
                                <p>地址： ${order.orderList[0].deliveryProvince}&nbsp;${order.orderList[0].deliveryCity}&nbsp;${order.orderList[0].deliveryArea}&nbsp;${order.orderList[0].deliveryAddress}</p>
                                <p>固定电话： ${order.orderList[0].tel2}</p>
                                <p>手机号： ${order.orderList[0].tel1}</p>
                            </div>
                        </td>
                        <td width="33%">
                            <div class="order_detil_info_box">
                                <h1>发票信息</h1>
                                <%--<p>开票状态: 发票已开</p>--%>
                                <%--<p>发票类型：${order.type}</p>--%>
                                <p>发票抬头：${order.companyName}</p>
                                <p>纳税人识别号：${order.taxCode}</p>
                                <p>开户行：${order.back}</p>
                                <p>开户账号：${order.backCode}</p>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <h1 class="order_detil_title">商品信息</h1>
            <div class="product_chose_table grey">
                <table width="100%">
                    <tr>
                    <td>商品名称</td>
                    <td>包装形式</td>
                    <td>数量</td>
                    <td>单价</td>
                    <td>总价</td>
                    </tr>
                    <c:forEach var="chidlOrder" items="${order.orderList}">
                        <c:forEach var="o" items="${chidlOrder.orderDetailList}">
                            <tr>
                                <td class="pro_box tal" width="650">
                                    <a href="/shop/product/${o.product.eid}" target="_blank">
                                        <img src="${itx}${o.product.largeUrl}" width="80" height="80" />
                                        <p><span>${o.product.aliasName}</span></p>
                                    </a>
                                </td>

                                <c:set var="packType" value="默认"></c:set>
                                <c:forEach items="${o.product.propTypeList}" var="prop">
                                    <c:if test="${prop.type == 'pack'}">
                                        <c:set var="packType" value="${prop.propList[0].value}"></c:set>
                                    </c:if>
                                </c:forEach>
                                <td width="151">${packType}</td>
                                <td width="151">${o.productNum}公斤</td>
                                <td width="135"><span class="red">¥ ${o.realPrice}</span></td>
                                <td width="135"><span class="red">¥ ${o.realTotalPrice}</span></td>
                            </tr>
                        </c:forEach>
                    </c:forEach>
                    <%--<tr>
                        <td class="pro_box tal" width="650">
                            <img src="images/product_detil_img.jpg" width="80" height="80" />
                            <p><span>阳离子染料 苏州东吴 阳离子兰X阳离子兰X阳离子兰X-GRRL 250%</span></p>
                        </td>
                        <td width="151">25.00公斤/件</td>
                        <td width="151">20件</td>
                        <td width="135"><span class="red">¥ 500.00</span></td>
                    </tr>
                    <tr>
                        <td class="pro_box tal" width="650">
                            <img src="images/product_detil_img.jpg" width="80" height="80" />
                            <p><span>阳离子染料 苏州东吴 阳离子兰X阳离子兰X阳离子兰X-GRRL 250%</span></p>
                        </td>
                        <td width="151">25.00公斤/件</td>
                        <td width="151">20件</td>
                        <td width="135"><span class="red">¥ 500.00</span></td>
                    </tr>
                    <tr>
                        <td class="pro_box tal" width="650">
                            <img src="images/product_detil_img.jpg" width="80" height="80" />
                            <p><span>阳离子染料 苏州东吴 阳离子兰X阳离子兰X阳离子兰X-GRRL 250%</span></p>
                        </td>
                        <td width="151">25.00公斤/件</td>
                        <td width="151">20件</td>
                        <td width="135"><span class="red">¥ 500.00</span></td>
                    </tr>--%>
                </table>
            </div>
            <div class="order_detil_price">
                <h1>商品总金额：<span>¥ <strong>${order.orderAmount}</strong></span></h1>
                <p>送货至：${order.orderList[0].deliveryProvince}&nbsp;${order.orderList[0].deliveryCity}&nbsp;${order.orderList[0].deliveryArea}&nbsp;${order.orderList[0].deliveryAddress}   收货人：${order.orderList[0].deliveryPeopleName} ${order.orderList[0].tel2}</p>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>
<%@ include file="/page/common/foot.jsp" %>
<script language="javascript" type="text/javascript">
    var theTab1_box = new Array('already_price','my_collection');
    var theTab1 = new AlexTab2('tab01',theTab1_box);
    theTab1;
</script>
</body>
</html>