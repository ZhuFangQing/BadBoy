/**
 * Created by Echos on 2016/11/21.
 */
var ORDER_LIST_ITEM = "<div class=\"my_order_box\">\n" +
    "                <div class=\"my_order_box_title\">\n" +
    "                    <p><span>${createdAt}</span></p>\n" +
    "                    <p><span>订单号：</span>${orderNum}</p>\n" +
    "                </div>\n" +
    "                <table class=\"my_order_table\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\n" +
    "                    <tbody>\n" +
    "                    <tr>\n" +
    "                        <td width=\"650\">\n" +
    "                            ${splitPack}\n" +
    "                            <div class=\"order_pro_img\"><img src=\"${productLargeUrl}\" width=\"60\" height=\"60\" /></div>\n" +
    "                            <div class=\"order_pro_info\">\n" +
    "                                <h1>${productAliasName}</h1>\n" +
    "                                <p><span>商品编号：${productCode}</span></p>\n" +
    "                            </div>\n" +
    "                            <div class=\"order_pro_number\"><span>${productPackType}  X  ${productNum}</span></div>\n" +
    "                        </td>\n" +
    "                        <td rowspan=\"${rowspan}\" class=\"rtecenter\">\n" +
    "                            <div class=\"order_total_price\"><p>总额 <span>¥${orderAmount}</span></p>${orderPayType}</div>\n" +
    "                        </td>\n" +
    "                        <td rowspan=\"${rowspan}\" class=\"rtecenter\">\n" +
    "                            <p>${orderStatus}</p>\n" +
    "                            <a href=\"/orders/${orderNum}\">订单详情</a>\n" +
    "                        </td>\n" +
    "                        <td rowspan=\"${rowspan}\" class=\"rtecenter\">\n" +
    "                            <a href='/orders/${orderNum}'><input type=\"button\" value=\"订单详情\" /></a>\n" +
    "                            ${payspan}                                   " +
    "                        </td>\n" +
    "                    </tr>\n" +
    "                    ${moreOrders}\n" +
    "                    </tbody>\n" +
    "                </table>\n" +
    "            </div>";

var ORDER_LIST_ITEM_MORE = "<tr>\n" +
    "                        <td width=\"300\">\n" +
    "                            ${splitPack}\n" +
    "                            <div class=\"order_pro_img\"><img src=\"${productLargeUrl}\" width=\"60\" height=\"60\" /></div>\n" +
    "                            <div class=\"order_pro_info\">\n" +
    "                                <h1>${productAliasName}</h1>\n" +
    "                                <p><span>商品编号：${productCode}</span></p>\n" +
    "                            </div>\n" +
    "                            <div class=\"order_pro_number\"><span>${productPackType}  X  ${productNum}</span></div>\n" +
    "                        </td>\n" +
    "                    </tr>";

var ORDER_LIST_ITEM_SPLIT_PACK =     "                            <div class=\"package_info\">\n" +
    "                                <span>包裹${splitPackNum}</span>\n" +
    "                                ${splitPackDesc}\n" +
    "                            </div>\n";

$(document).ready(function(){

    //选择支付方式
    $(".pay-way span").click(function(){
        console.log('payment...');

        $(".credit_tips").hide();
        var payment = $(this).attr("data-payment");
        //选择信用支付
        if($.notNull(payment) &&  payment == 'credit'){
            var creditBalance = parseFloat($(".credit_balance").attr("data-val"));
            var waitPayAmount = parseFloat($(".wait_pay_amount").attr("data-val"));
            if(creditBalance < waitPayAmount){
                $(".credit_tips").show();
                // alert("信用额度不足，请选择其他支付方式");
                // return;
            }
        }

        $(".pay-way span").removeClass("active");
        $(this).addClass("active");
    })

    //确认支付
    $(".sure-btn").click(function(){
        debugger;
        var obj = {
            'parentOrderId' : $(".order_no").html(),
            'payType'       : $(".pay-way span.active").attr("data-payment"),
            'paymentAmount' : parseFloat($(".order_total_amount").attr("data-val")),
            'balancePaymentAmount' : parseFloat($(".order_balance_use").attr("data-val")),
            'creditPaymentAmount' : 0,
        }

        if(obj['payType'] == 'credit'){
            obj['creditPaymentAmount'] = parseFloat($(".wait_pay_amount").attr("data-val"));

            var creditBalance = parseFloat($(".credit_balance").attr("data-val"));
            if(creditBalance < obj['creditPaymentAmount']){
                alert('信用额度不足');
                return;
            }

            //纯余额支付
            var waitPayAmount = parseFloat($(".wait_pay_amount").attr("data-val"));
            if(waitPayAmount == 0){
                obj['payType'] = 'balance';
            }

            $.ajax({
                url:'/orders/' + obj['parentOrderId'] + '/pay',
                type:'POST',
                data:obj,
                dataType:'json',
                success:function(resp){
                    console.log(resp);

                    if($.ajaxSuccess(resp)){

                        successTips();
                    }else{
                        alert(resp['msg']);
                    }
                }
            });

        }else{
            //线下转账，直接提示成功
            successTips();
        }
    })

    //我的订单-订单状态
    $(".order_status_type").click(function(){
        $(".order_status_type").removeClass("active");
        $(this).addClass("active");
        orderList();
    })

    //search
    $(".order_search_btn").click(function(){
        orderList();
    })
})
/**
 * 创建订单
 * @param order
 */
function createOrder(order){
    /**
     * order:
     *  delivery_province;
     *  delivery_city;
     *  delivery_area;
     *  delivery_address;
     *  delivery_people_name;
     *  tel_1;
     *  title;
     *  content;
     *  company_name;
     *  tax_id;
     *  register_address;
     *  register_tel;
     *  register_bank;
     *  bank_account;
     *  receiver_address;
     *  receiver_name;
     *  receiver_tel;
     */
    $.ajax({
        url:'/orders/',
        type:'POST',
        data:{
            'order' : order
        },
        dataType:'json',
        success:function(resp){
        }
    });
}

//支付成功提示
function successTips(){
    var InfoBoxTop = ($(window).height()-430)/2 + window.scrollY;
    $('.pop_bg').height($(document).height());
    $('.pop_bg').fadeIn();
    $('#popbox').css('top',InfoBoxTop);
    $('#popbox').fadeIn();
    $('body').css('overflow','hidden');
}

//订单列表
function orderList(pageNo, pageSize){
    var payType = $(".order_status_type.active").attr("data-status");
    var filter = $(".order_search_filter").val();


    //PageNo
    if(undefined == pageNo){
        pageNo = 1;
    }

    //PageSize
    if(undefined == pageSize){
        pageSize = 5;
    }

    var obj = {
        'pageNo'   : pageNo,
        'pageSize' : pageSize,
        'payType'  : payType,
        'filter'   : filter,
    };

    $.ajax({
        url:'/orders/search',
        type:'GET',
        data: obj,
        dataType:'json',
        success:function(resp){
            if($.ajaxSuccess(resp)){
                $(".tab_main_box .my_order_box").remove();

                //更新分页控件
                $("#Pagination").pagination(resp['totalPageSize'], {
                    callback: orderListByPage,
                    current_page: resp['pageNo'] - 1
                });

                debugger;
                for(var idx in resp['data']){
                    var totalCount = 0;
                    var order = resp['data'][idx];
                    var firstOrderDetails = order['orderList'][0]['orderDetailList'];

                    totalCount += firstOrderDetails.length;

                    //###################第一笔订单####################
                    //是否拆分包裹
                    var split = order['orderList'].length >= 2;
                    var splitPackInfo = null;
                    if(split){
                        splitPackInfo = {
                            'num'       :1,
                            'desc'      :''
                        }
                    }
                    //set first-order info
                    var item = setOrder(ORDER_LIST_ITEM, splitPackInfo, firstOrderDetails[0], order);
                    var itemMores = "";
                    //set >1 order info
                    if(firstOrderDetails.length >= 2){
                        firstOrderDetails.splice(0, 1);
                        itemMores += setChildOrder(firstOrderDetails, order, null);
                    }
                    //################################################

                    if(split){
                        for(var i = 1; i < order['orderList'].length; i++){
                            splitPackInfo = {
                                'num'       :i+1,
                                'desc'      :''
                            }

                            var orderDetails = order['orderList'][i]['orderDetailList'];

                            totalCount += orderDetails.length;

                            itemMores += setChildOrder(orderDetails, order, splitPackInfo);
                        }
                    }

                    //set child-order info
                    item = item.replace("${moreOrders}", itemMores);
                    //set row span
                    item = item.replace("${rowspan}", totalCount);
                    item = item.replace("${rowspan}", totalCount);
                    item = item.replace("${rowspan}", totalCount);


                    $(".tab_main_box").append(item);
                }
            }
        }
    });

    function setOrder(itemSource, splitPackInfo, orderDetail, order){
        var product = orderDetail['product'];

        var item = itemSource;
        item = item.replace("${orderNum}", order['orderNum']);

        //需要拆分包裹，显示包裹信息
        if($.notNull(splitPackInfo)){
            var splitPackInfoSource = ORDER_LIST_ITEM_SPLIT_PACK;
            splitPackInfoSource = splitPackInfoSource.replace("${splitPackNum}", splitPackInfo['num']);
            splitPackInfoSource = splitPackInfoSource.replace("${splitPackDesc}", splitPackInfo['desc']);
            item = item.replace("${splitPack}", splitPackInfoSource);
        }else{
            item = item.replace("${splitPack}", "");
        }
        item = item.replace("${createdAt}", order['createdAt'].substring(0,10) );
        item = item.replace("${orderAmount}", order['orderAmount'].toFixed(2));
        item = item.replace("${orderPayType}", $.paymentType(order['paymentType']));
        item = item.replace("${orderStatus}", $.orderStatus(order['status']));
        item = item.replace("${productLargeUrl}", itx+product['largeUrl']);
        item = item.replace("${productAliasName}", product['aliasName']);
        item = item.replace("${productCode}", product['code']);
        item = item.replace("${productPackType}", orderDetail['realPrice'].toFixed(2) + "元");
        // item = item.replace("${productPackType}", getProductPackType(product));
        item = item.replace("${productNum}", orderDetail['productNum'] + "公斤");
        item = item.replace("${orderNum}", order['orderNum']);
        item = item.replace("${orderNum}", order['orderNum']);
        if(order['status']=='notPay'){
            item = item.replace("${payspan}", "<p style='margin-top: 5px;'><a href='/orders/"+order['orderNum']+"/payments'><input style='color: #ffffff;border:#f10215 1px solid;background:#f10215 ' type=\"button\" value=\"去支付\" /></a></p>");
        }else{
            item = item.replace("${payspan}", "");
        }
        return item;
    }

    function setChildOrder(orderDetails, order, splitPackInfo){

        var itemMores = "";
        for(var i = 0; i < orderDetails.length; i++){
            var orderDetail = orderDetails[i];
            itemMores += setOrder(ORDER_LIST_ITEM_MORE, splitPackInfo, orderDetail, order)
            splitPackInfo = null;
        }

        return itemMores;
    }

    function orderListByPage(pageNo){
        pageNo = pageNo + 1;
        orderList(pageNo);
    }

    function getProductPackType(product){
        if($.notNull(product)){
            var propTypeList = product['propTypeList'];
            for(var idx in propTypeList){
                var prop = propTypeList[idx];
                if(prop['type'] == 'pack'){
                    return prop['propList'][0]['name'];
                }
            }
        }
        return null;
    }
}