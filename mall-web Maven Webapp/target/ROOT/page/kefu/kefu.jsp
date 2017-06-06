<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>七彩云客服</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="shortcut icon" href="${ctx}/images/favicon.ico" type="image/x-icon" />
	<link href="/css/common.css" rel="stylesheet" type="text/css" />
	<link href="/css/online.css" rel="stylesheet" type="text/css" />
	<%@include file="../common/taglib.jsp" %>
	<script language="javascript" type="text/javascript" src="/js/jquery.min.js"></script>
	<%--cookie utils--%>
	<script language="javascript" type="text/javascript" src="/js/jquery.cookie.js"></script>
	<script language="javascript" type="text/javascript" src="${ctx}/js/commons.js?t=${now}"></script>
	<script language="javascript" type="text/javascript" src="/js/online.js"></script>
	<script>

	</script>
</head>
<body>
<%@include file="/page/common/feedback.jsp" %>
<%--top模块--%>
<div class="online_bg">
<div class="container">
	<div style="height: 50px"></div>
	<div class="online_box">
		<div class="online_box_title">
			<img class="online_persong" src="/images/online_person.png" />
			<div class="online_text_box">
				<img src="/images/online_text.png" /><br/>
				工作时间：AM 8:00 ~ PM 5:30
			</div>
			<div class="online_phone"><img src="/images/phone_w.png" /></div>
			<a class="close_online" href="javascript:void(0)"></a>
		</div>
		<div class="online_left_box">
			<div class="online_show_talk">

			</div>
			<div class="online_textarea_box">
				<a href="javascript:void(0)"><img src="/images/upimg_icon.png" /></a>
				<a href="javascript:void(0)"><img src="/images/doc.png" /></a>
				<textarea class="textarea_style" id="msgInp"></textarea>
				<input type="button" class="send_btn" value="发送" />
			</div>
		</div>
		<div class="online_right_box">

			<div id="advice">
				<p class="alredy_coll" id="alredy_coll">正在询价</p>




				<div class="online_this_pro">
					<div class="online_pro_box" id="askNowBox">
						<img src="/images/product_img.jpg" id="askNowImg" width="100" />
						<div class="online_pro_info">
							<h1 id="askNowTitle">分散染料 杭州吉华 分散蓝E-4R 100%</h1>
							<p id="askNowCode">S.D.0059.0101.001</p>
							包装形式：<span id="askNowPack"></span><br/>
							<strong>询价数量：</strong>
							<span class="num-box">
									<a href="javascript:;" class="reduce-ask-num">-</a>
									<input type="text" value="25" id="askNumInp" class="askNumInp"/>
									<a href="javascript:;" class="add-ask-num">+</a>
									<%--&nbsp;公斤--%>
								</span>

							<span id="askNowNum" class="askNowNum">987公斤</span>
						</div>
					</div>
					<a class="coll_btn" id="add-collect">加入收藏夹</a>
					<a class="coll_btn" id="ask-btn">询价</a>

				</div>
				<!--<h1 class="already_coll">已收藏产品</h1>

                -->

				<div class="online_tab" id="tab01">
					<span class="active" id="myCollect">我的收藏</span>
					<span id="commonProblem">常见问题</span>
				</div>



				<div class="already_coll_box" id="collectBox">
					<!--<div class="online_pro_box brb">
                        <img src="images/product_img.jpg" width="100" />
                        <div class="online_pro_info">
                            <h1>分散染料 杭州吉华 分散蓝E-4R 100%</h1>
                            <p>S.D.0059.0101.001</p>
                            包装形式<br/>
                            询价数量：<span>987件</span>
                        </div>
                    </div>
                    <div class="online_pro_box brb">
                        <img src="images/product_img.jpg" width="100" />
                        <div class="online_pro_info">
                            <h1>分散染料 杭州吉华 分散蓝E-4R 100%</h1>
                            <p>S.D.0059.0101.001</p>
                            包装形式<br/>
                            询价数量：<span>987件</span>
                        </div>
                    </div>
                    <div class="online_pro_box brb">
                        <img src="images/product_img.jpg" width="100" />
                        <div class="online_pro_info">
                            <h1>分散染料 杭州吉华 分散蓝E-4R 100%</h1>
                            <p>S.D.0059.0101.001</p>
                            包装形式<br/>
                            询价数量：<span>987件</span>
                        </div>
                    </div>
                    <div class="online_pro_box brb">
                        <img src="images/product_img.jpg" width="100" />
                        <div class="online_pro_info">
                            <h1>分散染料 杭州吉华 分散蓝E-4R 100%</h1>
                            <p>S.D.0059.0101.001</p>
                            包装形式<br/>
                            询价数量：<span>987件</span>
                        </div>
                    </div>-->
				</div>
			</div>
			<div id="problem" style="display:none;">
				<ul class="problem_list">
					<li class="open">
						<h1>如何购物？</h1>
						<div class="problem_detil">若您是企业用户，确认询价后在您的购物车内点击结算即可；若还不是企业用户，请先认证为企业用户。</div>
					</li>
					<li class="open">
						<h1>如何询价？</h1>
						<div class="problem_detil">查询您所需的商品后点击询价按钮。</div>
					</li>
					<li class="open">
						<h1>有哪些支付方式？</h1>
						<div class="problem_detil">我们有：现款支付、网银支付、电子汇票、纸质承兑汇票、转账、纸质银行汇票、支票等多种支付方式，您可以自行选择适用的支付方式进行支付。</div>
					</li>
					<li class="open">
						<h1>提供什么类型的发票？</h1>
						<div class="problem_detil">我们提供：增值税专用发票、增值税普通发票，您可在下单时根据您的需求自行选择。</div>
					</li>
					<li class="open">
						<h1>邮箱收不到邮件怎么办？</h1>
						<div class="problem_detil">请确认您的邮箱填写是否正确并拨打客服热线400-920-8599联系客服，我们将尽快为您解决。</div>
					</li>
					<li class="open">
						<h1>邮箱链接打不开怎么办？</h1>
						<div class="problem_detil">请将此链接复制到浏览器自行打开，若还无法打开请拨打客服热线400-920-8599联系客服，我们将尽快为您解决。</div>
					</li>
				</ul>
			</div>
		</div>
		<div class="clear"></div>
	</div>
</div>
</div>
<%--<%@ include file="/page/common/foot.jsp" %>--%>
</body>
</html>
