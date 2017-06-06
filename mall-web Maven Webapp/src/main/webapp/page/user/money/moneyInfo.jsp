<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@include file="/page/common/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>七彩云</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="/css/myOrder.css" rel="stylesheet" type="text/css"/>
    <%@include file="/page/common/resource.jsp" %>
    <link href="/css/moneyManagement.css" rel="stylesheet" type="text/css" />
    <link href="/css/payway.css" rel="stylesheet" type="text/css" />
    <link href="/css/placeorder.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="/js/money.js"></script>
</head>
<body>
<!--头部-->
<%@ include file="/page/common/top.jsp" %>
<div class="popbox_bg" id="aiac">
    <p class="popbox-title">申请提高信用额<a href="javascript:;" onclick="ClosePopbox('aiac')">X</a></p>
    <div class="invoice" style="padding-left:100px; padding-top:20px;">
        <p class="invoice-content">
            <span><em class="red">*</em>申请理由：</span>
            <textarea style="height:150px;" id="credit_reason"></textarea>
        </p>
        <p class="invoice-btn" style="padding-left:35px;">
            <a href="javascript:;" class="apply-credit-money">保存</a>
            <a href="javascript:;" class="apply-credit-money-cancel" onclick="ClosePopbox('aiac')">取消</a>
        </p>
    </div>
</div>

<div class="popbox_bg" id="adr">
    <p class="popbox-title">申请延长账期<a href="javascript:;" onclick="ClosePopbox('adr')">X</a></p>
    <div class="invoice" style="padding-left:100px; padding-top:20px;">
        <p class="invoice-content">
            <span><em class="red">*</em>延期时间：</span>
            <select class="adr" id="payment_day">
                <option value="1">一个月</option>
                <option value="2">二个月</option>
                <option value="3">三个月</option>
                <option value="4">四个月</option>
                <option value="5">五个月</option>
                <option value="6">六个月</option>
                <option value="7">七个月</option>
            </select>
        </p>
        <p class="invoice-content">
            <span><em class="red">*</em>申请理由：</span>
            <textarea id="payment_reason"></textarea>
        </p>
        <p class="invoice-content">
            <span>&nbsp;</span>
            <img src="images/tips_icon.png" />
            <em>说明：最终通过审批的延期时间由客服人员根据情况进行审核后决定。</em>
        </p>
        <p class="invoice-btn" style="padding-left:35px;">
            <a href="javascript:;" class="apply-payment-day">提交申请</a>
            <a href="javascript:;" class="apply-payment-day-cancel" onclick="ClosePopbox('adr')">取消</a>
        </p>
    </div>
</div>

<div class="popbox_bg" id="rapc">
    <p class="popbox-title">申请理由<a href="javascript:;" onclick="ClosePopbox('rapc')">X</a></p>
    <div class="invoice" style="padding-left:100px; padding-top:20px;">
        <p class="invoice-content">
            <span>申请理由：</span>
            <span class="content" id="show_apply_reason"></span>
        </p>
        <p class="invoice-btn" style="padding-left:35px;">
            <a href="javascript:;"onclick="ClosePopbox('rapc')" >确定</a>
        </p>
    </div>
</div>


<div class="mian_content container">
    <jsp:include page="/page/common/usercenter.jsp"></jsp:include>
    <div class="mumber_right_content">
        <div class="shopping_car_tab" id="tab01">
            <span class="active">现金流水</span>
            <span>信用额使用明细</span>
            <span>信用额度提升申请记录</span>
            &nbsp;&nbsp;&nbsp;
            <a href="javascript:;" class="red_bold" onclick="OpenPopbox('adr')">申请账期</a>
            <a href="javascript:;" class="red_bold" id="btn_apply" onclick="OpenPopbox('aiac')">申请提高信用额</a>
        </div>
        <div class="tab_main_box" id="already_price">
            <div class="manage_title_bar">
                <span>现金余额：<strong>¥${moneyInfo.total_amount}</strong>  （ 可用：<strong>¥${moneyInfo.available_amount}</strong> ， 冻结：<strong>¥${moneyInfo.freeze_amount}</strong> ）</span>
                <span>可使用信用额度：<strong>¥${moneyInfo.credit_available_amount}</strong>  （信用额度：<strong>¥${moneyInfo.credit_total_amount}</strong> ， 已使用：<strong>¥${moneyInfo.credit_total_amount-moneyInfo.credit_available_amount}</strong>）</span>
            </div>
            <table class="manage_table" width="100%" cellpadding="0" cellspacing="0" id="cash_flow_table">

            </table>
            <div class="pages" id="Pagination_1">
                <div id="Pagination"></div>
                <div class="searchPage">
                    <span class="page-sum">共<strong class="allPage"></strong>页</span>
                </div>
            </div>
        </div>
        <div class="tab_main_box" id="my_collection" style="display:none;">
            <div class="manage_title_bar">
                <span>现金余额：<strong>¥${moneyInfo.total_amount}</strong>  （ 可用：<strong>¥${moneyInfo.available_amount}</strong> ， 冻结：<strong>¥${moneyInfo.freeze_amount}</strong> ）</span>
                <span>可使用信用额度：<strong>¥${moneyInfo.credit_available_amount}</strong>  （信用额度：<strong>¥${moneyInfo.credit_total_amount}</strong> ， 已使用：<strong>¥${moneyInfo.credit_total_amount-moneyInfo.credit_available_amount}</strong>）</span>
            </div>
            <table class="manage_table mx" width="100%" cellpadding="0" cellspacing="0" id="credit_flow_table">
            </table>
            <div class="pages" id="Pagination_2">
                <div id="Pagination2"></div>
                <div class="searchPage">
                    <span class="page-sum">共<strong class="allPage"></strong>页</span>
                </div>
            </div>
        </div>
        <div class="tab_main_box" id="cltetar" style="display:none;">
            <div class="manage_title_bar">
                <span>现金余额：<strong>¥${moneyInfo.total_amount}</strong>  （ 可用：<strong>¥${moneyInfo.available_amount}</strong> ， 冻结：<strong>¥${moneyInfo.freeze_amount}</strong> ）</span>
                <span>可使用信用额度：<strong>¥${moneyInfo.credit_available_amount}</strong>  （信用额度：<strong>¥${moneyInfo.credit_total_amount}</strong> ， 已使用：<strong>¥${moneyInfo.credit_total_amount-moneyInfo.credit_available_amount}</strong>）</span>
            </div>
            <table class="manage_table mx" width="100%" cellpadding="0" cellspacing="0" id="apply_list_table">
            </table>
            <div class="pages" id="Pagination_3">
                <div id="Pagination3"></div>
                <div class="searchPage">
                    <span class="page-sum">共<strong class="allPage"></strong>页</span>
                </div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>

<%@ include file="/page/common/foot.jsp" %>
<script language="javascript" type="text/javascript">
    var theTab1_box = new Array('already_price','my_collection','cltetar','ecp');
    var theTab1 = new AlexTab2('tab01',theTab1_box);
    theTab1;
</script>
</body>
</html>
