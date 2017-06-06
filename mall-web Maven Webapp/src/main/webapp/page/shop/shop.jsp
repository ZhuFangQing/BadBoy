<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>七彩云</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<%@include file="/page/common/resource.jsp" %>
	<script src="${ctx}/js/product.js"></script>
</head>
<body>
<jsp:include page="/page/common/feedback.jsp"></jsp:include>
<%--top模块--%>
<%@ include file="/page/common/top.jsp" %>
<div class="container">
	<%--筛选条件--%>
	<div class="member-list" style="margin:10px 0 0 0;">
		<p>高级筛选</p>
		<ul class="open_two">
			<span>商品分类：</span>
			<li class="active"><a class="product_options product_type1" href="javascript:;" data-id="-1" data-type="all">不限</a></li>

			<c:forEach items="${menuTypeList}" var="menuType" varStatus="idx">
				<li><a class="product_options product_type1" href="javascript:;" data-child="${idx.count}" data-id="${menuType.eid}" data-prop="${menuType.propIdList}">${menuType.displayText}</a></li>
			</c:forEach>

			<c:forEach items="${menuTypeList}" var="menuType" varStatus="idx">
				<ul class="level_two product_type1_child" data-id="${idx.count}" style="display: none;">
					<span>选择：</span>
					<li class="active"><a class="product_options product_type2" href="javascript:;" data-id="-1" data-type="all">不限</a></li>

					<c:forEach items="${menuType.childClassList}" var="p">
						<li><a class="product_options product_type2" href="javascript:;" data-id="${p.eid}" data-prop="${p.propIdList}">${p.displayText}</a></li>
					</c:forEach>
				</ul>
			</c:forEach>
		</ul>

		<c:forEach items="${menuPropertyList}" var="menuProperty">
			<ul class="product_prop_ul">
				<span>${menuProperty.typeText}：</span>
				<li class="active"><a class="product_options product_prop" href="javascript:;" data-id="-1" data-type="all">不限</a></li>

				<c:forEach items="${menuProperty.propList}" var="p">

					<li><a class="product_options product_prop" href="javascript:;" data-id="${p.id}">${p.value}</a></li>
				</c:forEach>
			</ul>
		</c:forEach>
	</div>
	<%--<div class="open_more_chose mb20">
		<div class="open_more_chose_box" id="open_more">更多选项 (适用材料\颜色等)</div>
	</div>--%>
	<div class="shop_index">
		<jsp:include page="shop_index.jsp"></jsp:include>
	</div>
	<div class="shop_prod_list" style="display: none;">
		<jsp:include page="shop_prod_list.jsp"></jsp:include>
	</div>
</div>

<div class="business-pages container">
	<jsp:include page="/page/common/pagination.jsp"></jsp:include>
</div>
<%@ include file="/page/common/foot.jsp" %>
</body>
</html>
