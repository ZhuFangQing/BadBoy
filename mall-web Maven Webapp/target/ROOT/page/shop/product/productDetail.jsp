<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/page/common/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>商品详情</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%@include file="/page/common/resource.jsp" %>
    <script>
        $(document).ready(function(){
            $('.buy_now.ask_product_price').click(function () {
                debugger;
                var id = -1;
                if('${groupId}' == '2'){
                    $.ajax({
                        url: '${ctx}/carts/addShopInquiry',
                        type: 'POST',
                        data: {
                            productEid: ${productDetail.eid},
                            inquiryNum: $("#product_num").val()
                        },
                        dataType: 'json',
                        async:false,
                        success: function (resp) {
                            debugger;
                            console.log(resp);
                            id = resp.id;
//                            window.open("/kefu?id="+resp.id,"kefu");
                        }
                    });
                }else{
                    alert("请使用企业账号询价！");
                    return false;
                }

                window.open("/kefu?id="+id,"kefu");
            });

            $(document).on('click', '.buy_now.add_to_shop_car', function () {
                debugger;
                if('${groupId}' == '2'){
                    $.ajax({
                        url: '${ctx}/carts/addToShopCar',
                        type: 'POST',
                        data: {
                            productEid: ${productDetail.eid},
                            inquiryNum: $("#product_num").val()
                        },
                        dataType: 'json',
                        success: function (resp) {
                            debugger;
                            if(resp.code = 'SUCCESS'){
                                alert("成功添加到购物车！")
                            }else{
                                alert("添加到购物车失败，请联系客服。")
                            }
                        }
                    });
                }else{
                    alert("请使用企业账号添加购物车！");
                }
            });

            $(document).on('click', '.add_to_favorite', function () {
                if('${groupId}' == '2'){
                    $.ajax({
                        url: '${ctx}/favorites/ajaxAddFavorite',
                        type: 'POST',
                        data: {
                            productEid: ${productDetail.eid},
                        },
                        dataType: 'json',
                        success: function (resp) {
                            if(resp.code = 'SUCCESS'){
                                alert("成功收藏该商品！")
                            }else{
                                alert("添加到收藏失败，请联系客服。")
                            }
                        }
                    });
                }else{
                    alert("请使用企业账号收藏！");
                }
            });


			var numreg = /.*\..*/;
            var packNum = parseFloat($("#packType").val());

            $(".plus").click(function(){
                var num = parseFloat($('#product_num').val());
                if(num>=packNum) $('.reduce').removeClass('noclick');
                num += packNum;
                if(numreg.test(num)){
                	num = num.toFixed(2);
                }
                
                $('.product_info_numbers').find('input').val(num);
            });

            $('.reduce').click(function(e) {
                var num = parseFloat($('#product_num').val());
                if($('.reduce').hasClass('noclick')) return;
                num-=packNum;
                
                if(numreg.test(num)){
                	num = num.toFixed(2);
                }
                
                if(num<=packNum){
                    $('.reduce').addClass('noclick');
                }
                $('.product_info_numbers').find('input').val(num);
            });

            $('#product_num').change(function(){
                var num = parseFloat($(this).val());
                if((num*100)%(packNum*100) > 0){
                	num-=num%packNum;
                	if(numreg.test(num)){
	                	num = num.toFixed(2);
	                }
                	
                    $('#product_num').val(num);
                }
            });

        });
    </script>
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
<%@ include file="/page/common/top.jsp" %>

<div class="container">
    <div class="content-left">
        <div class="product_info_box mb20">
            <img src="${itx}${productDetail.detailUrl}" width="349" />
            <div class="product_info_text">
                <h1>${productDetail.aliasName}</h1>
                <p>${productDetail.enName}</p>
                <c:if test="${productDetail.isDisplayPrice=='1'}">
                    <div class="product_info_price">
                        促销价：<div class="price">¥${productDetail.price}<span>/公斤</span></div>
                    </div>
                </c:if>

                <div class="product_info_detil">
                    <ul>
                        <li>商品编号：${productDetail.code}</li>
                        <li>物流信息：免运费</li>
                        <%--<li>包装形式：25.00公斤/件</li>--%>
                        <li>&nbsp;</li>
                        <%--包装形式--%>
                        <c:set var="packType"></c:set>
                        <c:forEach items="${productDetail.propTypeList}" var="pList">
                            <c:if test="${pList.type == 'pack'}">
                                <c:set var="packType" value="${pList.propList[0].value}"></c:set>
                            </c:if>
                        </c:forEach>
                        <input type="hidden" id="packType" value="${packType}">
                    </ul>
                    <div class="clear"></div>
                </div>
                <div class="product_info_btns">
                    <div class="product_info_numbers">
                        <span><input id="product_num" style="text-align: center;width: 50px;" type="text" width="40px;"  onkeyup="this.value=this.value.replace(/[^\d\.]|^0/g,'')" onafterpaste="this.value=this.value.replace(/[^\d\.]|^0/g,'')" maxlength="8" value="${packType}"></span>
                        <em class="plus">+</em>
                        <em class="reduce noclick">-</em>
                    </div>
                    公斤
                    <%--<a href="#"><img style="margin-left:10px;" src="/images/product_buy.jpg" width="180" /></a>--%>
                    <c:choose>
                        <c:when test="${productDetail.isDisplayPrice=='1'}">
                            <input class="buy_now add_to_shop_car" type="button" value="加入购物车" />
                        </c:when>
                        <c:otherwise>
                            <input class="buy_now ask_product_price" type="button" value="询价" />
                        </c:otherwise>
                    </c:choose>
                    <input class="add_to_favorite" type="button" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;收藏" style="padding: 10px;font-size: 16px;margin-left: 20px; height: 41px;width: 100px;background: #f10215 url(/images/add_favorite.png) 18px center no-repeat;color: white;border-radius:5px;" />
                </div>
            </div>
        </div>
        <div class="product_detil_info_box">
            <div class="product_detil_info_tab" id="tab01">
                <span class="active">商品介绍</span>
                <span>基本参数</span>
                <span>附件下载</span>
            </div>
            <div class="product_detil_info_content" id="product_intro" style="display:block;">
                <h1>基本参数：</h1>
                <table cellpadding="0" cellspacing="0">
                    <c:set var="packType"></c:set>
                    <c:forEach items="${productDetail.propTypeList}" var="pList">
                        <tr>
                            <td>${pList.typeText}</td>
                            <td>
                                <c:forEach items="${pList.propList}" var="ppList">
                                    ${ppList.name}&nbsp;&nbsp;
                                </c:forEach>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                <h1>详细说明：</h1>
                ${productDetail.detailHtml}
            </div>
            <div class="product_detil_info_content" id="product_spe">
                <h1>基本参数：</h1>
                <table cellpadding="0" cellspacing="0">
                    <c:forEach items="${productDetail.propTypeList}" var="pList">
                        <tr>
                            <td>${pList.typeText}</td>
                            <td>
                                <c:forEach items="${pList.propList}" var="ppList">
                                    ${ppList.name}&nbsp;&nbsp;
                                </c:forEach>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <div class="product_detil_info_content" id="product_download">
                <h1>附件下载：</h1>
                <table cellpadding="0" cellspacing="0">
                    <c:forEach items="${productDetail.attachList}" var="oList">
                        <tr>
                            <td>${oList.attachName}</td>
                            <td><a href="${oList.attachUrl}" target="_blank">下载</a></td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
    <jsp:include page="/page/shop/shop_right.jsp">
        <jsp:param name="marginTop" value="85"></jsp:param>
    </jsp:include>
</div>
<%@ include file="/page/common/foot.jsp" %>
<script language="javascript" type="text/javascript">
    var theTab1_box = new Array('product_intro','product_spe','product_download');
    var theTab1 = new AlexTab2('tab01',theTab1_box);
    theTab1;
</script>
</body>
</html>
