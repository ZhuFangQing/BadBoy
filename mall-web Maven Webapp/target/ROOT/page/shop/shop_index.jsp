<%--
  Created by IntelliJ IDEA.
  User: Echos
  Date: 2016/11/28
  Time: 15:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/taglib.jsp" %>
<%--热卖--%>
<div class="hot_box mb20">
    <div class="hot_title">
        <span>热卖商品</span>
        <div class="hot_type fr">
            <a href="#">全部产品></a>
        </div>
    </div>
    <div class="hot_mumber">
        <div class="hot_mumber_title"><span>金牌会员</span></div>
        <div class="hot_mumber_list_box">
            <div class="swiper-container" id="mumber1">
                <div class="swiper-wrapper">
                    <c:forEach items="${memberList}" var="memberList">
                        <div class="swiper-slide"><a href="/member/${memberList.id}"><img src="${itx}${memberList.logo_url}" height="50" /></a></div>
                    </c:forEach>
                </div>

                <div class="hot_mumber_list_arr">
                    <img id="up_arr1"  src="/images/up_arr.gif" />
                    <img class="down_arr" id="down_arr1" src="images/down_arr.gif" />
                </div>
            </div>
        </div>
    </div>
    <div class="hot_product">
        <div class="swiper-container" id="hot_product1">
            <div class="swiper-wrapper">
                <c:forEach items="${hotGoodsList}" var="hotList">
                    <div class="swiper-slide">
                        <div class="hot_product_box">
                            <a target="_blank" href="/shop/product/${hotList.eid}" >
                                <img src="${itx}${hotList.largeUrl}" />
                            </a>
                            <div class="hot_product_info">
                                <a target="_blank" href="/shop/product/${hotList.eid}" >
                                    <h1>${hotList.aliasName}</h1>
                                    <p>${hotList.code}</p>
                                </a>
                                <c:if test="${hotList.isDisplayPrice=='1'}">
                                    <c:choose>
                                        <c:when test="${hotList.isDisplayPrice=='0.00'}">
                                            价格：<span>----</span><br/>
                                        </c:when>
                                        <c:otherwise>
                                            价格：<span>${hotList.price}</span><br/>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                                <c:if test="${hotList.isDisplayPrice!='1'}">
                                    价格：<span>----</span><br/>
                                </c:if>

                                <c:set var="packType"></c:set>
                                <c:forEach items="${hotList.propTypeList}" var="prop">
                                    <c:if test="${prop.type == 'pack'}">
                                        <c:set var="packType" value="${prop.propList[0].name}"></c:set>
                                    </c:if>
                                </c:forEach>
                                包装形式：<span>${packType}</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="swiper-button-prev" id="hot_pro_prev1"></div>
        <div class="swiper-button-next" id="hot_pro_next1"></div>
    </div>
    <div class="clear"></div>
</div>

<%--热门--%>
<div class="hot_box mb20">
    <div class="hot_title">
        <span>热门推荐</span>
        <div class="hot_type fr">
            <a href="#">全部产品></a>
        </div>
    </div>
    <div class="hot_mumber">
        <div class="hot_mumber_title"><span>合作供应商</span></div>
        <div class="hot_mumber_list_box">
            <div class="swiper-container" id="mumber2">
                <div class="swiper-wrapper">
                    <c:forEach items="${suppliersList}" var="suppliersList">
                        <div class="swiper-slide"><img src="${itx}${suppliersList.logo_url}" height="50" /></div>
                    </c:forEach>
                </div>
                <div class="hot_mumber_list_arr">
                    <img id="up_arr2"  src="/images/up_arr.gif" />
                    <img class="down_arr" id="down_arr2" src="/images/down_arr.gif" />
                </div>
            </div>
        </div>
    </div>
    <div class="hot_product">
        <div class="swiper-container" id="hot_product2">
            <div class="swiper-wrapper">
                <c:forEach items="${recommendGoodsList}" var="recommendGoodsList">
                    <div class="swiper-slide">
                        <div class="hot_product_box">
                            <a target="_blank" href="/shop/product/${recommendGoodsList.eid}" >
                                <img src="${itx}${recommendGoodsList.largeUrl}" />
                            </a>
                            <div class="hot_product_info">
                                <a target="_blank" href="/shop/product/${recommendGoodsList.eid}" >
                                    <h1>${recommendGoodsList.aliasName}</h1>
                                    <p>${recommendGoodsList.code}</p>
                                </a>
                                <c:if test="${recommendGoodsList.isDisplayPrice=='1'}">
                                    <c:choose>
                                        <c:when test="${recommendGoodsList.isDisplayPrice=='0.00'}">
                                            价格：<span>----</span><br/>
                                        </c:when>
                                        <c:otherwise>
                                            价格：<span>${recommendGoodsList.price}</span><br/>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                                <c:if test="${recommendGoodsList.isDisplayPrice!='1'}">
                                    价格：<span>----</span><br/>
                                </c:if>

                                <c:set var="packType"></c:set>
                                <c:forEach items="${recommendGoodsList.propTypeList}" var="prop">
                                    <c:if test="${prop.type == 'pack'}">
                                        <c:set var="packType" value="${prop.propList[0].name}"></c:set>
                                    </c:if>
                                </c:forEach>
                                包装形式：<span>${packType}</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="swiper-button-prev" id="hot_pro_prev2"></div>
        <div class="swiper-button-next" id="hot_pro_next2"></div>
    </div>
    <div class="clear"></div>
</div>

<%--ad--%>
<c:forEach items="${adList}" var="adList">
    <c:if test="${adList.plate_code=='Mall_Streamer'}">
        <a href="${adList.ad_url}"><img class="middle_banner mb20" src="${itx}${adList.ad_image}" width="100%" /></a>
    </c:if>
</c:forEach>
<%--filter--%>
<div class="content-left">
    <div class="mall_product_bar">
        <div class="mall_hot_product">热门</div>
        <div class="mall_area">
            <span class="product_order_desc">按销量</span>
            <select class="product_filter_option" data-order-col="trade_volume">
                <option data-order="asc" selected="selected">从低到高</option>
                <option data-order="desc">从高到低</option>
            </select>
        </div>
    </div>
    <div class="mall_product_box">
        <ul class="mall_index_product_list_ul">
        </ul>
    </div>
</div>
<jsp:include page="/page/shop/shop_right.jsp"></jsp:include>