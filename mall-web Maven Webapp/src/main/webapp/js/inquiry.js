/**
 * Created by Echos on 2016/12/3.
 */
var FAVORITE_TD = "<tr class=\"favorite_line_${favorite.id}\"><td width=\"70\" class=\"tal\"><input type=\"checkbox\" name=\"favorite\" value=\"${favorite.id}\" /></td><td class=\"pro_box tal\" width=\"650\"><a href=\"/shop/product/${favorite.product.eid}\" target=\"_blank\"><img src=\"${favorite.product.largeUrl}\" width=\"80\" height=\"80\" /><p><span>${favorite.product.aliasName}</span></p></a></td><td width=\"151\">${packType}</td><td width=\"135\"><a href=\"javascript:;\">询价</a><br/><a href=\"javascript:;\" class=\"favorite_del_btn\" data-id=\"${favorite.id}\">删除</a></td></tr>";

$(document).ready(function(){

    //单条添加收藏夹
    $(".favorites_add_btn").click(function(){
        var id = $(this).attr("data-id");
        if($.notNull(id)){
            var array = new Array();
            array.push(parseInt(id));

            addToFavorite(array);
        }
    });

    //删除单条询价
    $(".inquiry_del_btn").click(function(){
        var id = $(this).attr("data-id");
        if($.notNull(id)){
            var array = new Array();
            array.push(parseInt(id));

            deleteInquiry(array);
        }
    });
    //删除单条收藏
    $(".favorite_del_btn").click(function(){
        if(confirm("确认要删除吗？")){

            var id = $(this).attr("data-id");
            if($.notNull(id)){
                var array = new Array();
                array.push(parseInt(id));

                deleteFavorite(array);
            }
        }
    });

    //批量删除询价
    $(".inquiry_del_all_btn").click(function(){
        var ids = $("input[name='inquiry']:checked").map(function(){
            return $(this).val();
        }).get();
        console.log('delete inquiry...' + JSON.stringify(ids));

        if(ids.length > 0 && confirm("确认要删除吗？")){
            deleteInquiry(ids);
        }
    });

    //批量添加收藏
    $(".favorite_add_all_btn").click(function(){
        var ids = $("input[name='inquiry']:checked").map(function(){
            return $(this).attr("data-eid");
        }).get();
        console.log('add favorite...' + JSON.stringify(ids));
        addToFavorite(ids);
    });

    //批量删除收藏
    $(".favorite_del_all_btn").click(function(){

        var ids = $("input[name='favorite']:checked").map(function(){
            return $(this).val();
        }).get();
        console.log('delete favorite...' + JSON.stringify(ids));

        if(ids.length > 0 && confirm("确认要删除吗？")){
            deleteFavorite(ids);
        }
    });

    //修改数量
    /*$(".inquiry_num").bind("DOMNodeInserted", function(){
     //更新页面上的价格
     var num = parseInt($(this).html());
     var unitPrice = parseFloat($(this).attr("data-unit-price"));

     calcInquiryPrice($(this).attr("data-id"), num * unitPrice);
     reCalcPrice();

     //更新到数据库
     changeInquiryNum($(this).attr("data-id"), num);
     })*/
});

function changeNum(){

    //更新页面上的价格
    var num = parseInt($(this).val());
    var unitPrice = parseFloat($(this).attr("data-unit-price"));

    calcInquiryPrice($(this).attr("data-id"), num * unitPrice);
    reCalcPrice();

    //更新到数据库
    changeInquiryNum($(this).attr("data-id"), num);
}

function reCalcPrice(){
    calcInquiryTotalPrice();
    calcInquiryTotalNum();
}

function calcInquiryPrice(inquiryId, price){
    $(".inquiry_price_" + inquiryId).html(parseFloat(price).toFixed(3));
}

function calcInquiryTotalPrice(){
    var totalPrice = 0.00;

    var priceArray = $("input[name='inquiry']:checked").map(function(){
       return parseFloat($(".price.inquiry_price_" + $(this).val()).html());
    }).get();


    /*var priceArray = $(".inquiry_list_table span.price").map(function(){
        return parseFloat($(this).html());
    }).get();*/

    for(var idx in priceArray){
        var price = priceArray[idx];
        if(!isNaN(price)){

            totalPrice += price;
        }
    }
    console.log('total price:' + totalPrice);

    $(".inquiry_total_price").html(totalPrice.toFixed(2));
}

function calcInquiryTotalNum(){
    var totalNum = 0;

    var numArray = $("input[name='inquiry']:checked").map(function(){
        return parseFloat($(".pro_num.inquiry_num[data-id='"+$(this).val()+"']").val());
    }).get();
    /*var numArray = $(".inquiry_list_table input.inquiry_num").map(function(){
        return parseInt($(this).val());
    }).get();*/

    for(var idx in numArray){
        var num = numArray[idx];
        totalNum += num;
    }
    console.log('total num:' + totalNum);

    $(".inquiry_total_num").html(totalNum);
}

/**
 * 从购物车中删除指定产品
 * @param ids[Array]
 */
function deleteInquiry(ids){
    if($.notNull(ids) && ids.length > 0){
        $.ajax({
            url:'/carts',
            type:'POST',
            data:{
                _method: 'DELETE',
                'ids': ids
            },
            dataType:'json',
            success:function(resp){
                console.log(resp);
                if($.ajaxSuccess(resp)){

                    for(var idx in ids){
                        var id = ids[idx];
                        $(".inquiry_list_table tr.inquiry_line_" + id).remove();
                    }
                    reCalcPrice();
                }else{
                    alert(resp['msg']);
                }
            }
        });
    }
}

/**
 * 添加产品到收藏夹
 * @param productId
 */
function addToFavorite(ids){
    console.log('add favorite:' + ids);
    if($.notNull(ids) && ids.length > 0){

        $.ajax({
            url:'/favorites',
            type:'POST',
            data:{
                'ids' : ids
            },
            dataType:'json',
            success:function(resp){
                console.log(resp);
                if($.ajaxSuccess(resp)){
                    location.reload();
                }else{
                    alert(resp['msg']);
                }
            }
        });
    }
}

/**
 * 从收藏夹中删除指定产品
 * @param ids[Array]
 */
function deleteFavorite(ids){
    console.debug('delete favorite:' + ids)
    if($.notNull(ids) && ids.length > 0){
        $.ajax({
            url:'/favorites',
            type:'POST',
            data:{
                _method: 'DELETE',
                'ids': ids
            },
            dataType:'json',
            success:function(resp){
                debugger;
                console.log(resp);
                if($.ajaxSuccess(resp)){

                    for(var idx in ids){
                        var id = ids[idx];
                        $(".favorite_list_table tr.favorite_line_" + id).remove();
                    }
                }else{
                    alert(resp['msg']);
                }
            }
        });
    }
}

/**
 * 修改询价单商品数量
 * @param id
 * @param num
 */
function changeInquiryNum(id, num){
    console.log('change inquiry num:' + id + ',' + num);
    if($.notNull(id) && $.notNull(num)){
        $.ajax({
            url:'/carts/' + id,
            type:'POST',
            data:{
                _method: 'PUT',
                'id'    : id,
                'num'   : num
            },
            dataType:'json',
            success:function(resp){
                debugger;
                console.log(resp);
                if($.ajaxSuccess(resp)){
                }else{
                    alert(resp['msg']);
                }
            }
        });
    }
}