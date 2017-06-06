<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>七彩云</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<%@include file="../common/resource.jsp" %>
</head>
<body>
<div class="pop_bg"></div>
<div class="feedback_box" data-html2canvas-ignore="true" id="feedback">
	<div class="feedback_title">
		<a class="feedback_close" id="feedback_close">×</a>
		<h3>意见反馈</h3>
	</div>
	<div class="feedback_body">
		<div><span>反馈内容</span><span class="red">（*必填）</span></div>
		<textarea maxlength="400" class="feedback_content" name="issuedesc" data-exclude="true" placeholder="欢迎提出您在使用过程中遇到的问题或宝贵建议（400字以内），感谢您的支持。"></textarea>
		<div class="feedback_phone">联系方式</div>
		<input type="text" class="feedback_email" maxlength="100" placeholder="请留下您的联系方式，以便我们及时回复您。">
		<div class="feedback_footer"><div class="feedback_btn">提交反馈</div></div>
	</div>
</div>
<%--top模块--%>
<%@ include file="../common/top.jsp" %>
<div class="banner">
	<div class="swiper-container mb20" id="banner">
		<div class="swiper-wrapper">
			<c:forEach items="${adList}" var="adList">
				<c:if test="${adList.plate_code=='Index_Banner'}">
					<div class="swiper-slide"><a href="${adList.ad_url}"><img src="${itx}${adList.ad_image}" width="100%" /></a></div>
				</c:if>
			</c:forEach>
		</div>

		<div class="pagination" id="banner_swp"></div>
	</div>
</div>
<div class="container">
	<div class="hot_box mb20">
		<div class="hot_title">
			<span>热卖商品</span>
			<div class="hot_type fr">
				<%--<a href="#">染料</a>
				<a href="#">数码墨水</a>
				<a href="#">助剂</a>
				<a href="#">中间剂</a>
				<span>|</span>--%>
				<a href="/shop">全部产品></a>
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
		<%--热门商品--%>
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
	<div class="hot_box mb20">
		<div class="hot_title">
			<span>热门推荐</span>
			<div class="hot_type fr">
				<%--		<a href="#">染料</a>
                        <a href="#">数码墨水</a>
                        <a href="#">助剂</a>
                        <a href="#">中间剂</a>
                        <span>|</span>--%>
				<a href="/shop">全部产品></a>
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
	<c:forEach items="${adList}" var="adList">
		<c:if test="${adList.plate_code=='Index_Streamer'}">
			<a href="${adList.ad_url}"><img class="middle_banner mb20" src="${itx}${adList.ad_image}" width="100%" height="85" /></a>
		</c:if>
	</c:forEach>
	<div class="red_bar_title">
		<img src="/images/school_icon.jpg" /><span>大学堂</span>
		<a href="/school/industry">查看更多培训内容></a>
	</div>
	<div class="school_box">
		<c:forEach items="${schoolList}" var="item" end="0">
			<a href="/school/articles/${item.id}">
				<div class="school_text_box">
					<img src="${itx}${item.coverUrl}" width="528" height="364px;" />
					<div class="school_text">
						<h1>${fn:substring(item.title, 0, 13)}...</h1>
						<p>${fn:substring(item.contentSummary, 0, 65)}......</p>
					</div>
				</div>
			</a>
		</c:forEach>
		<c:forEach items="${schoolList}" var="item" begin="1" end="4">
			<a href="/school/articles/${item.id}">
				<div class="school_text_box">
					<img src="${itx}${item.coverUrl}" width="224" height="172px;" />
					<div class="school_text s">
						<h1>${fn:substring(item.title, 0, 13)}...</h1>
					</div>
				</div>
			</a>
		</c:forEach>
		<div class="school_long_box">
			<c:forEach items="${schoolList}" var="item" begin="5" end="5">
				<a href="/school/articles/${item.id}">
					<div class="school_text_box mr0">
						<img src="${itx}${item.coverUrl}" width="224" height="172px;"/>
						<div class="school_text s">
							<h1>${fn:substring(item.title, 0, 13)}...</h1>
						</div>
					</div>
				</a>
			</c:forEach>
			<ul class="school_text_list">
				<c:forEach items="${schoolList}" var="item" begin="6" end="11">
					<a href="/school/articles/${item.id}"><li>${fn:substring(item.title, 0, 10)}...</li></a>
				</c:forEach>
			</ul>
		</div>
		<div class="clear"></div>
	</div>
	<div class="red_bar_title">
		<img src="/images/info_icon.jpg" /><span>行业资讯</span>
		<a href="/information">查看更多资讯></a>
	</div>
	<div class="info_box mb20">
		<div class="info_left_box">
			<%--原来是广告板块，改成资讯--%>
			<%--<c:forEach items="${adList}" var="adList">
				<c:if test="${adList.plate_code=='Index_News'}">
					<a href="${adList.ad_url}"><img src="${itx}${adList.ad_image}" width="528" /></a>
				</c:if>
			</c:forEach>--%>
			<c:forEach items="${indexNews}" var="item">
				<a href="/information/${item.id}"><img src="${itx}${item.img_url}" width="528" height="243" /></a>
				<a href="/information/${item.id}"><div class="img_down_text">${fn:substring(item.title, 0, 23)}...</div></a>
			</c:forEach>
			<h1>人物访谈</h1>
			<ul class="per_info_list">
				<c:forEach items="${talentExchangeList}" var="talentExchangeList">
					<a href="/information/${talentExchangeList.id}"><li><span class="orange">[人物访谈]</span> ${fn:substring(talentExchangeList.title, 0, 15)}...</li></a>
				</c:forEach>
				<%--<a href="#"><li><span class="orange">[企业招聘]</span> 印花织物的源流</li></a>--%>
				<%--<a href="#"><li><span class="orange">[人才推荐]</span> 我国染颜料行业进入低位平稳发......</li></a>--%>
			</ul>
		</div>
		<div class="hot_info">
			<h1 class="first">热点资讯</h1>
			<ul>
				<c:forEach items="${hotNewsList}" var="hotNewsList">
					<li><a href="/information/${hotNewsList.id}">${fn:substring(hotNewsList.title, 0, 15)}...</a></li>
				</c:forEach>
			</ul>
		</div>
		<div class="order_info">
			<h1 class="first">供求信息</h1>
			<c:forEach items="${adList}" var="adList">
				<c:if test="${adList.plate_code=='Index_Order'}">
					<a href="${adList.ad_url}"><img src="${itx}${adList.ad_image}" width="350"  height="75"/></a>
				</c:if>
			</c:forEach>
			<c:forEach items="${textileOrderList}" var="textileOrderList">
				<a href="/information/${textileOrderList.id}"><dl><dt><span class="orange">[求购]</span>${fn:substring(textileOrderList.title, 0, 30)}</dt><%--<dd>${fn:substring(textileOrderList.news_date, 0, 10)}</dd>--%></dl></a>
			</c:forEach>
		</div>
		<div class="clear"></div>
	</div>
	<jsp:include page="/page/common/foot_partner.jsp"></jsp:include>
</div>
<%@ include file="../common/foot.jsp" %>
</body>
</html>
