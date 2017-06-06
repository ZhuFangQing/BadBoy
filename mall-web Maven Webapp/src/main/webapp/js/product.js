/**
 * Created by Echos on 2016/11/26.
 */
var PRODUCT_LIST_LI = "<li class='${liClass}'><a target='_blank' href=\"/shop/product/${product.eid}\"><img src=\"${product.largeUrl}\" width=\"100%\" /><h1>${product.aliasName}</h1></a><p><span>${product.code}</span></p><p>包装形式：<span>${product.packType}</span></p><p class=\"product_detil\"><a href=\"/shop/product/${product.eid}\"><img src=\"/images/product_detil.jpg\" width=\"172\" /></a></p></li>";


function productType(propIds){
    if(null != propIds && propIds != undefined && propIds != ''){
        //移除所有已激活属性
        $(".product_prop a").removeClass("active");
        $(".product_prop a").removeClass("active");

        var propIdArray = propIds.split(",");
        for(var idx in propIdArray){
            var propId = propIdArray[idx];
            $(".product_prop a[data-id='" + propId + "']").addClass("active");
        }

    }
}

$(document).ready(function(){
    // $("#Pagination").pagination(1);
    var LIST_MODE = false;

    //search
    if($.notNull(getSearchContent())){

        //切换到筛选结果页面
        $("div.shop_index").remove();
        $("div.shop_prod_list").show();
        LIST_MODE = true;
    }

    search();

    $(".product_filter_option").change(function(){
        $("span.product_order_desc").html($(this).val());
        search();
    })

    $(".product_options").click(function(){
        $(this).parent().siblings("li").removeClass("active");
        $(this).parent("li").addClass("active");

        if(!LIST_MODE){

            //切换到筛选结果页面
            $("div.shop_index").remove();
            $("div.shop_prod_list").show();
            LIST_MODE = true;
        }
    })

    $(".product_type1").click(function(){

        if($(this).html() == '不限'){
            $(".product_type1_child").hide();
            $("ul.product_prop_ul a.product_options").parent().show();
            $("ul.product_prop_ul a.product_options").parent().parent().show();
            $(".product_prop_ul a.product_options[data-type='all']").click();
        }else{

            //显示相应二级分类
            var childTypeId = $(this).attr("data-child");
            $(".product_type1_child").hide();
            if(null != childTypeId && childTypeId != ''){
                $(".product_type1_child[data-id='" + childTypeId + "']").show();
            }

            var propIds = $(this).attr("data-prop");
            showPropByIds(JSON.parse(propIds));
        }

        search()
    })

    $(".product_type2").click(function(){

        var propIds = null;

        //如果选中不限，显示父分类的所有属性
        if($(this).html() == '不限'){
            $(".product_prop_ul a.product_prop[data-id='-1']").click();

            var parentId = $(this).attr("data-id");
            if(null != parentId && parentId != ''){
                propIds = $(".product_type1[data-child='" + parentId + "']").attr("data-prop");
            }

        }else{

            propIds = $(this).attr("data-prop");
        }

        if(null != propIds){

            showPropByIds(JSON.parse(propIds));
        }

        search()
    })

    $("ul.product_prop_ul a.product_prop").click(function(){
        search();
    })

    function showPropByIds(childIds){

        $("ul.product_prop_ul a.product_options").parent().hide();
        $("ul.product_prop_ul a.product_options").parent().parent().hide();
        $("ul.product_prop_ul a.product_options[data-id='-1']").parent().show();

        if(undefined != childIds && null != childIds){
            for(var idx in childIds){
                var obj =  $("ul.product_prop_ul a.product_options[data-id='" + $.trim(childIds[idx]) + "']");
                $(obj).parent().show();
                $(obj).parent().parent().show();
            }
        }
    }

    function search(pageNo,pageSize){

        //筛选条件
        var obj = getSearchCond(pageNo, pageSize);

        //筛选
        $.ajax({
            url:'/shop/product/search',
            type:'GET',
            data:obj,
            dataType:'json',
            success:function(resp){

                if(undefined != resp && null != resp){
                    console.debug(resp);

                    //更新分页控件
                    $("#Pagination").pagination(resp['totalPageSize'], {
                        callback: page,
                        current_page: resp['pageNo'] - 1
                    });

                    var products = "";
                    var i =0;
                    for(var idx in resp['data']){
                        i++;
                        var product = resp['data'][idx];
                        if(undefined != product && null != product){
                            try{

                                var li = PRODUCT_LIST_LI.replace("${product.eid}", product['eid']);
                                li = li.replace("${product.largeUrl}", itx+product['largeUrl']);
                                li = li.replace("${product.aliasName}", product['aliasName']);
                                li = li.replace("${product.eid}", product['eid']);
                                li = li.replace("${product.code}", product['code']);

                                var packType = "";
                                product['propTypeList'].forEach(function(val,index,arr){
                                    if(val['type'] == 'pack'){
                                        packType = val['propList'][0]['name'];
                                    }
                                });
                                /*for(var propType in product['propTypeList']){
                                 if(propType['type'] == 'pack'){
                                 packType = propType['propList'][0]['name'];
                                 }
                                 }*/

                                li = li.replace("${product.packType}", packType);
                                if(i%5==0){
                                    li = li.replace("${liClass}", "nmr");
                                }else{
                                    li = li.replace("${liClass}", "");
                                }
                                products += li;
                            }catch(error) {
                                console.error(error);
                                continue;
                            }
                        }
                    }

                    var container;
                    if(LIST_MODE){
                        container = $("ul.mall_product_list_ul");
                    }else{
                        container = $("ul.mall_index_product_list_ul")
                    }

                    container.html(products);
                }else{
                    console.debug('resp is null...')
                }
            }
        });
    }

    function getSearchCond(pageNo,pageSize){
        //已选择类型
        var classCond = new Array();
        var type2 = $(".product_type1_child:visible li.active a.product_type2").attr("data-id");
        if(undefined != type2 && null != type2 && type2 != '' && parseInt(type2) > 0){
            classCond.push(parseInt(type2));
        }else{
            var type1 = $(".open_two li.active a.product_type1").attr("data-id");
            if(undefined != type1 && null != type1 && type1 != '' && parseInt(type1) > 0){
                classCond.push(parseInt(type1));
            }
        }

        //已选择属性
        var propCond = new Array();
        console.log(propCond);
        var propIds = $("ul.product_prop_ul li.active:visible a").map(function(){
            return $(this).attr("data-id");
        }).get();
        if(undefined != propIds && null != propIds && propIds.length > 0){
            for(var idx in propIds){
                if(!isNaN(propIds[idx]) && parseInt(propIds[idx]) > 0){
                    propCond.push(parseInt(propIds[idx]))
                }
            }
        }

        //PageNo
        if(undefined == pageNo){
            pageNo = 1;
        }

        //PageSize
        if(undefined == pageSize){
            pageSize = 15;
        }

        //order
        var orderObj = {};
        var col = $(".product_filter_option").attr("data-order-col");
        var order = $(".product_filter_option :selected").attr("data-order")
        if(undefined != col && null != col && col != '' && undefined != order && null != order && order != ''){
            orderObj[col] = order;
        }

        console.log('classCond:' + classCond + ", propCond:" + propCond + ", pageNo:" + pageNo + ", pageSize:" + pageSize + ", orderObj:" + orderObj)

        //search content
        var parentOrderObj = {
            'aliasName': getSearchContent()
        };

        var obj = {
            'pageNo'        : pageNo,
            'pageSize'      : pageSize,
            'prodCondJson'  : '',
            'orderCond'     : JSON.stringify(orderObj)
        };
        if(classCond.length == 0){
            obj['classCondJson[]'] = '';
        }else{
            obj['classCondJson'] = classCond;
        }
        if(propCond.length == 0){
            obj['propCondJson[]'] = '';
        }else{
            obj['propCondJson'] = propCond;
        }
        if(LIST_MODE){
            obj['prodCondJson'] = JSON.stringify(parentOrderObj);
        }

        return obj;
    }

    function page(pageNo){
        console.log('跳转页面');
        pageNo = pageNo + 1;
        search(pageNo);
    }
})