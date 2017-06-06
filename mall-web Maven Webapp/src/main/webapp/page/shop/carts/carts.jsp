<%--
  Created by IntelliJ IDEA.
  User: Echos
  Date: 2016/12/3
  Time: 12:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>七彩云</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%@include file="../../common/resource.jsp" %>

    <link href="/css/shoppingCar.css" rel="stylesheet" type="text/css" />
    <script src="/js/inquiry.js"></script>
    <script>
        function checkInquiry(){
            if($("input[name='inquiry']:checked").length == 0){
                alert('请选择要结算的商品');
                return false;
            }

            var result = true;
            $("input[name='inquiry']:checked").each(function () {
                if($(this).attr("data-status") == 'notoffer'){
                    alert('结算的商品中包含未报价的商品');
                    result = false;
                    return;
                }
            });

            return result;
        }
        
        function accDiv(arg1,arg2){
		    var t1=0,t2=0,r1,r2;
		    try{t1=arg1.toString().split(".")[1].length}catch(e){}
		    try{t2=arg2.toString().split(".")[1].length}catch(e){}
		    with(Math){
		        r1=Number(arg1.toString().replace(".",""))
		        r2=Number(arg2.toString().replace(".",""))
		        return (r1/r2)*pow(10,t2-t1);
		    }
		}
        

		var numreg = /.*\..*/;
		var intreg = /[0-9]+/;

        $(document).ready(function(){
            reCalcPrice();

            $("input[name='inquiry']").change(function(){
                reCalcPrice();
            });

            $(".pro_reduce").click(function () {
                var status = $(this).siblings('input').attr("data-status");
                if(status == "notoffer"){
                    alert("该商品暂未报价");
                    return false;
                }

                var num = $(this).siblings('input').val();
                var minNum = $(this).siblings('input').attr("data-min-num");
                var packType = parseFloat($(this).siblings('input').attr("data-pack-type"));
                if(num == packType || num == minNum) return;
                num -= packType;
                
                if(numreg.test(num)){
                	num=num.toFixed(3);
                }
                
                $(this).siblings('input').val(num);
                $(this).siblings('input').trigger("change");
            });

            $(".pro_plus").click(function () {
                var status = $(this).siblings('input').attr("data-status");
                if(status == "notoffer"){
                    alert("该商品暂未报价");
                    return false;
                }

                var packType = parseFloat($(this).siblings('input').attr("data-pack-type"));
                var num = parseFloat($(this).siblings('input').val());

                if(num == 10000000000) return;
                num += packType;
                
                if(numreg.test(num)){
                	num=num.toFixed(3);
                }
                
                $(this).siblings('input').val(num);
                $(this).siblings('input').trigger("change");
            });

            /*$(".inquiry_num").bind("propertychange",function(){

             });*/

            $(".inquiry_num").change(function(){
                debugger;
                var num = $(this).val();
                if(isNaN(num)){
                    alert("请填写正确的数量");
                    return false;
                }
                num = parseFloat(num);


                var packType = $(this).attr("data-pack-type");
                if (numreg.test(accDiv(num,packType))){
                    //alert("请输入打包方式的整倍数");
                    num -= num%packType;
                    if(numreg.test(num)){
	                	num=num.toFixed(3);
	                }
                    
                    $(this).val(num);
                    //return false;
                }
                var initNum = parseFloat($(this).attr("data-min-num"));
                if(num < initNum){
                    alert("不能低于询价时的数量["+$(this).attr("data-min-num")+"]");
                    $(this).val($(this).attr("data-min-num"));
                    return false;
                }


                //更新页面上的价格
                var num = parseFloat($(this).val());
                var unitPrice = parseFloat($(this).attr("data-unit-price"));

                calcInquiryPrice($(this).attr("data-id"), num * unitPrice);
                reCalcPrice();

                //更新到数据库
                changeInquiryNum($(this).attr("data-id"), num);
            });
        });
    </script>
</head>
<body>
<jsp:include page="/page/common/feedback.jsp"></jsp:include>
<%--top模块--%>
<%@ include file="../../common/top.jsp" %>
<div class="mian_content container">
    <jsp:include page="/page/common/usercenter.jsp"></jsp:include>
    <div class="mumber_right_content">
        <div class="shopping_car_tab" id="tab01">
            <span class="active">已询价商品</span>
            <span>我的收藏</span>
        </div>
        <div class="tab_main_box" id="already_price">
            <div class="product_chose_table_title">
                <table width="100%">
                    <tr>
                        <td width="70" class="tal"><label><input class="all" type="checkbox" /><span>全选</span></label></td>
                        <td width="400" class="tal" style="padding-left:90px;">商品</td>
                        <td width="151">包装形式</td>
                        <td width="50">单价(元)</td>
                        <td width="150">数量(公斤)</td>
                        <td width="80">价格(元)</td>
                        <td width="135">操作</td>
                    </tr>
                </table>
            </div>
            <form action="/carts/confirm" onsubmit="return checkInquiry()" method="POST">
                <div class="product_chose_table">
                    <table width="100%" class="inquiry_list_table">
                        <c:set var="totalPrice" value="0"></c:set>
                        <c:forEach items="${inquiryList}" var="inquiry">
                            <c:set var="totalPrice" value="${totalPrice + inquiry.price}"></c:set>
                            <c:set var="totalNum" value="${totalNum + inquiry.num}"></c:set>
                            <tr class="inquiry_line_${inquiry.id}">
                                <td width="70" class="tal"><input type="checkbox" name="inquiry" data-status="${inquiry.status}" data-eid="${inquiry.product.eid}" value="${inquiry.id}"/></td>
                                <td class="pro_box tal" width="400">
                                    <a href="/shop/product/${inquiry.product.eid}" target="_blank">
                                        <img src="${itx}${inquiry.product.largeUrl}" width="80" height="80" />
                                        <p><span>${inquiry.product.aliasName}</span></p>
                                    </a>
                                </td>
                                <td width="151">
                                    <c:set var="packTypeValue" value=""></c:set>
                                    <c:set var="packType" value="-"></c:set>
                                    <c:forEach items="${inquiry.product.propTypeList}" var="prop">
                                        <c:if test="${prop.type == 'pack'}">
                                            <c:set var="packType" value="${prop.propList[0].name}"></c:set>
                                            <c:set var="packTypeValue" value="${prop.propList[0].value}"></c:set>
                                        </c:if>
                                    </c:forEach>
                                        ${packType}
                                </td>
                                <td width="50">
                                        ${inquiry.status == 'notoffer' ? '-' : inquiry.unitPrice}
                                </td>
                                <td width="150">
                                    <div class="pro_number_box">
                                        <em class="pro_reduce"></em>
                                        <input class="pro_num inquiry_num" type="text" data-id="${inquiry.id}" data-status="${inquiry.status}" data-pack-type="${packTypeValue}" data-unit-price="${inquiry.unitPrice}" data-min-num="${inquiry.initNum}" value="${inquiry.num}" maxlength="11" ${inquiry.status == 'notoffer' ? 'readonly="readonly"' : ''} />
                                            <%--<span class="num inquiry_num" data-id="${inquiry.id}" data-unit-price="${inquiry.unitPrice}" data-min-num="${inquiry.initNum}"></span>--%>
                                        <em class="pro_plus"></em>
                                    </div>
                                </td>
                                <td width="80"><span class="price inquiry_price_${inquiry.id}">${inquiry.status == 'notoffer' ? '-' : inquiry.price}</span></td>
                                <td width="135">
                                    <a href="javascript:;" class="favorites_add_btn" data-id="${inquiry.product.eid}">加入收藏夹</a>
                                    <br/>
                                    <a href="javascript:;" class="inquiry_del_btn" data-id="${inquiry.id}">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <div class="shopping_car_bill">
                    <table width="100%">
                        <tr>
                            <td width="80"><label><input class="all" type="checkbox" /><span>全选</span></label></td>
                            <td width="50"><a href="javascript:;" class="inquiry_del_all_btn">删除</a></td>
                            <td width="450"><a href="javascript:;" class="favorite_add_all_btn">加入收藏夹</a></td>
                            <td width="160">
                                已选商品<span class="chose_num inquiry_total_num"><%--${totalNum}--%>0</span>件
                                <img style="margin-left:5px;" src="images/double_up_icon.jpg" />
                            </td>
                            <td width="250">合计：<span class="total_price"><em>¥</em> <span class="inquiry_total_price"><%--${totalPrice}--%>0.00</span></span></td>
                            <td width="120"><input type="submit" class="bill_btn" value="结算" /></td>
                        </tr>
                    </table>
                </div>
            </form>
        </div>
        <div class="tab_main_box" id="my_collection" style="display:none;">
            <div class="product_chose_table_title">
                <table width="100%">
                    <tr>
                        <td width="70" class="tal"><label><input class="all" type="checkbox" /><span>全选</span></label></td>
                        <td width="650" class="tal" style="padding-left:90px;">商品</td>
                        <td width="151">包装形式</td>
                        <td width="135">操作</td>
                    </tr>
                </table>
            </div>
            <div class="product_chose_table grey">
                <table width="100%" class="favorite_list_table">
                    <c:forEach items="${favoriteList}" var="favorite">
                        <tr class="favorite_line_${favorite.id}">
                            <td width="70" class="tal"><input type="checkbox" name="favorite" value="${favorite.id}" /></td>
                            <td class="pro_box tal" width="650">
                                <a href="/shop/product/${favorite.product.eid}" target="_blank">
                                    <img src="${itx}${favorite.product.largeUrl}" width="80" height="80" />
                                    <p><span>${favorite.product.aliasName}</span></p>
                                </a>
                            </td>
                            <td width="151">
                                <c:set var="packType" value="-"></c:set>
                                <c:set var="packTypeValue" value=""></c:set>
                                <c:forEach items="${favorite.product.propTypeList}" var="prop">
                                    <c:if test="${prop.type == 'pack'}">
                                        <c:set var="packType" value="${prop.propList[0].name}"></c:set>
                                        <c:set var="packTypeValue" value="${prop.propList[0].value}"></c:set>
                                    </c:if>
                                </c:forEach>
                                    ${packType}<%--/${favorite.product.isDisplayPrice=='1' ? favorite.product.price : "-"}--%>
                            </td>
                            <td width="135">
                                    <%--<a href="javascript:;" class=".ask_product_price">询价</a>--%>
                                    <%--<br/>--%>
                                <a href="javascript:;" class="favorite_del_btn" data-id="${favorite.id}">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <div class="shopping_car_bill">
                <table width="100%">
                    <tr>
                        <td width="80"><label><input class="all" type="checkbox" /><span>全选</span></label></td>
                        <td width="50"><a href="javascript:;" class="favorite_del_all_btn">删除</a></td>
                        <td width="1100"></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>
<%@ include file="../../common/foot.jsp" %>
<script language="javascript" type="text/javascript">
    var theTab1_box = new Array('already_price','my_collection');
    var theTab1 = new AlexTab2('tab01',theTab1_box);
    theTab1;
</script>
</body>
</html>