<%--
  Created by IntelliJ IDEA.
  User: Echos
  Date: 2016/11/28
  Time: 15:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/taglib.jsp" %>
<div class="hot_box mb20"></div>

<%--filter--%>
<div class="content-left">
    <div class="mall_product_bar">
        <div class="mall_hot_product">产品</div>
        <div class="mall_area">
            <span class="product_order_desc">按销量</span>
            <select class="product_filter_option" data-order-col="trade_volume">
                <option data-order="asc" selected="selected">从低到高</option>
                <option data-order="desc">从高到低</option>
            </select>
        </div>
    </div>
    <div class="mall_product_box">
        <ul class="mall_product_list_ul">
            <%--<c:forEach items="${hotGoodsList}" var="hotList">
                <li>
                    <img src="images/mall_product.jpg" width="100%" />
                    <h1>${hotList.aliasName}</h1>
                    <p>EID：<span>${hotList.eid}</span></p>
                    <p>交易笔数：<span>111</span></p>
                    <p class="product_detil"><a href="${ctx}/productDetail?eid=${hotList.eid}" target="_blank"><img src="images/product_detil.jpg" width="172" /></a></p>
                </li>
            </c:forEach>--%>
        </ul>
    </div>
</div>
<jsp:include page="/page/shop/shop_right.jsp"></jsp:include>