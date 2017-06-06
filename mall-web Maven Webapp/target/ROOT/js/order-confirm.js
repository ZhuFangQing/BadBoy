/**
 * Created by Administrator on 2016/12/8.
 */
$(document).ready(function () {
    ready();
    ready2();
    getProvince();
//=============================获取省市区====================================

    $(document).on('change', '#edit-province', function () {
    	getEditCity();
    });
    
    $(document).on('change', '#new-province', function () {
        getCity();
    });

    $(document).on('change', '#new-city', function () {
        getArea();
    });


//========================================================================
    $(document).on('click', '#deliveryAddress li', function () {
        $('#deliveryAddress li').removeClass("default active");
        $(this).addClass("default active");
        var addressId = $(this).attr("data-id");
        $('#check-recipients').html($("span[data-id='" + addressId + "recipients']").html());
        $('#address').html($("span[data-id='" + addressId + "address']").html());
        $('#check-phone').html($("span[data-id='" + addressId + "phone']").html());
    });

    $(document).on('click', '.edit-delivery-address', function () {
        var InfoBoxTop = ($(window).height() - 430) / 2 + window.scrollY;
        $('.pop_bg').height($(document).height());
        $('.pop_bg').fadeIn();
        $('#popbox3').css('top', InfoBoxTop);
        $('#popbox3').fadeIn();
        $('body').css('overflow', 'hidden');
        $(".invoice-box").css("display", "none");
        //===================================设置信息====================================
        debugger;
        var addressId = $(this).attr("data-id");
        getEditProvince();
        $('#edit-province').val($("span[data-id='" + addressId + "province']").html());
        getEditCity();
        $('#edit-city').val($("span[data-id='" + addressId + "city']").html());
        getEditArea();
        $('#edit-area').val($("span[data-id='" + addressId + "area']").html());
        $('#edit-recipients').val($("span[data-id='" + addressId + "recipients']").html());
        $('#edit-address').val($("span[data-id='" + addressId + "address']").html());
        $('#edit-phone').val($("span[data-id='" + addressId + "phone']").html());
        $('#edit-id').val(addressId);

    });
    $(document).on('click', '#close_popbox3', function () {
        $('.pop_bg').fadeOut();
        $('#popbox3').fadeOut();
        $('body').css('overflow', 'auto');
    });

//新增收货地址
    $(document).on('click', '.save-consignee-btn.create-receipt-address', function () {

        var checkResult = true;
        $("#popbox2 input,#popbox2 select").each(function () {
            if($(this).val() == ''){
                checkResult = false;
                return;
            }
        });
        if(!checkResult){
            alert('信息不完整');
            return false;
        }

        $.ajax({
            url: '/carts/createDeliveryAddress',
            type: 'POST',
            data: {
                'recipients': $('#new-recipients').val(),
                'address': $('#new-address').val(),
                'phone': $('#new-phone').val(),
                'province': $("#new-province option:selected").attr("value"),
                'city': $("#new-city option:selected").attr("value"),
                'area': $("#new-area option:selected").attr("value"),
                'provinceName': $("#new-province option:selected").attr("valueName"),
                'cityName': $("#new-city option:selected").attr("valueName"),
                'areaName': $("#new-area option:selected").attr("valueName")
            },
            dataType: 'json',
            success: function (resp) {
                if (resp.code == 'SUCCESS') {
                    $('#close_popbox2').click();
                    alert('新增收货地址成功！');
                    ready();
                    $('.consignee-box-content select, .consignee-box-content input').val('');
                } else {
                    alert('新增收货地址失败！')
                }
            }
        });
    });
//设定默认收货地址
    $(document).on('click', '.set-default-delivery-address', function () {
        debugger;
        var addressId = $(this).attr("data-id");
        $.ajax({
            url: '/carts/setDefaultDeliveryAddress',
            type: 'POST',
            data: {
                'id': addressId
            },
            dataType: 'json',
            success: function (resp) {
                if (resp.code == 'SUCCESS') {
                    alert('设为默认地址成功！');
                    ready();
                } else {
                    alert('设为默认地址失败！')
                }
            }
        });
    });

//修改收货地址
    $(document).on('click', '.save-consignee-btn.edit-receipt-address', function () {

        var checkResult = true;
        $("#popbox3 input,#popbox3select").each(function () {
            if($(this).val() == ''){
                checkResult = false;
                return;
            }
        });
        if(!checkResult){
            alert('信息不完整');
            return false;
        }

        $.ajax({
            url: '/carts/updateDeliveryAddress',
            type: 'POST',
            data: {
                'recipients': $('#edit-recipients').val(),
                'address': $('#edit-address').val(),
                'phone': $('#edit-phone').val(),
                'id': $('#edit-id').val(),
                'province': $("#edit-province option:selected").attr("value"),
                'city': $("#edit-city option:selected").attr("value"),
                'area': $("#edit-area option:selected").attr("value"),
                'provinceName': $("#edit-province option:selected").attr("valueName"),
                'cityName': $("#edit-city option:selected").attr("valueName"),
                'areaName': $("#edit-area option:selected").attr("valueName")
            },
            dataType: 'json',
            success: function (resp) {
                if (resp.code == 'SUCCESS') {
                    $('#close_popbox3').click();
                    alert('修改收货地址成功！');
                    ready();
                } else {
                    alert('修改收货地址失败！')
                }
            }
        });
    });

//删除收货地址
    $(document).on('click', '.delete-delivery-address', function () {
        var addressId = $(this).attr("data-id");
        if (confirm("是否删除该收货地址？")) {
            $.ajax({
                url: '/carts/deleteDeliveryAddress',
                type: 'POST',
                data: {
                    'id': addressId
                },
                dataType: 'json',
                success: function (resp) {
                    if (resp.code == 'SUCCESS') {
                        alert('删除收货地址成功！');
                        ready();
                    } else {
                        alert('修改收货地址失败！')
                    }
                }
            });
        }
    });
//=========================================================
    $(document).on('click', '.cancel-new-invoice', function () {
        $('#close_popbox').click();
    });
    $(document).on('click', '.cancel-edit-invoice', function () {
        $('#close_popbox4').click();
    });
    $(document).on('click', '.edit-invoice-info', function () {
        debugger;
        var popHeight = $('#popbox4').height();
        var InfoBoxTop = ($(window).height() - popHeight) / 2 + window.scrollY - 10;
        $('.pop_bg').height($(document).height());
        $('.pop_bg').fadeIn();
        $('#popbox4').css('top', InfoBoxTop);
        $('#popbox4').fadeIn();
        $('body').css('overflow', 'hidden');
        //===================================设置信息====================================
        var invoiceId = $(this).attr("data-id");
        $('#edit_bill_type').val($("span[data-id='" + invoiceId + "i_type']").html());
        $('#i-edit-id').val(invoiceId);
        $('#i-edit-company-name').val($("span[data-id='" + invoiceId + "i_companyName']").html());
        $('#i-edit-tax-code').val($("span[data-id='" + invoiceId + "i_taxCode']").html());
        $('#i-edit-company-address').val($("span[data-id='" + invoiceId + "i_address']").html());
        $('#i-edit-company-phone').val($("span[data-id='" + invoiceId + "i_tel']").html());
        $('#i-edit-bank').val($("span[data-id='" + invoiceId + "i_back']").html());
        $('#i-edit-bank-code').val($("span[data-id='" + invoiceId + "i_backCode']").html());
        $('#i-edit-mail-address').val($("span[data-id='" + invoiceId + "i_mailAddress']").html());
        $('#i-edit-mail-person').val($("span[data-id='" + invoiceId + "i_mailPerson']").html());
        $('#i-edit-mail-phone').val($("span[data-id='" + invoiceId + "i_mailPhone']").html());
    });

    $(document).on('click', '#close_popbox4', function () {
        $('.pop_bg').fadeOut();
        $('#popbox4').fadeOut();
        $('body').css('overflow', 'auto');
    });

//新增发票信息
    $(document).on('click', '.save-new-invoice', function () {
        debugger;

        var checkResult = true;
        $("#popbox input,#popbox select").each(function () {
            if($(this).val() == ''){
                checkResult = false;
                return;
            }
        });
        if(!checkResult){
            alert('信息不完整');
            return false;
        }

        $.ajax({
            url: '/carts/createInvoice',
            type: 'POST',
            data: {
                'type': $('input[name="bill_type"]:checked').val(),//发票类型
                'companyName': $('#i-new-company-name').val(),//企业名称
                'taxCode': $('#i-new-tax-code').val(),//税收号
                'address': $('#i-new-company-address').val(),//企业地址
                'back': $('#i-new-bank').val(),//开户银行
                'backCode': $('#i-new-bank-code').val(),//开户银行账户
                'mailAddress': $('#i-new-mail-address').val(),//发票收取地址
                'mailPerson': $('#i-new-mail-person').val(),//发票收件人
                'mailPhone': $('#i-new-mail-phone').val(),//收件人电话
                'tel': $('#i-new-company-phone').val()//公司电话
            },
            dataType: 'json',
            success: function (resp) {
                if (resp.code == 'SUCCESS') {
                    $('#close_popbox').click();
                    alert('新增发票信息地址成功！');
                    ready2();
                    $('.invoice input[type="text"]').val('');
                } else {
                    alert('新增发票信息失败！')
                }
            }
        });
    });
//删除发票信息
    $(document).on('click', '.delete-invoice-info', function () {
        var addressId = $(this).attr("data-id");
        $.ajax({
            url: '/carts/deleteInvoice',
            type: 'POST',
            data: {
                'id': addressId
            },
            dataType: 'json',
            success: function (resp) {
                if (resp.code == 'SUCCESS') {
                    alert('删除发票信息地址成功！');
                    ready2();
                } else {
                    alert('删除发票信息失败！')
                }
            }
        });
    });

//更新发票信息
    $(document).on('click', '.save-edit-invoice', function () {

        var checkResult = true;
        $("#popbox4 input,#popbox4 select").each(function () {
            if($(this).val() == ''){
                checkResult = false;
                return;
            }
        });
        if(!checkResult){
            alert('信息不完整');
            return false;
        }

        $.ajax({
            url: '/carts/updateInvoice',
            type: 'POST',
            data: {
                'id': $('#i-edit-id').val(),
                'type': $('input[name="edit_bill_type"]:checked').val(),//发票类型
                'companyName': $('#i-edit-company-name').val(),//企业名称
                'taxCode': $('#i-edit-tax-code').val(),//税收号
                'address': $('#i-edit-company-address').val(),//企业地址
                'back': $('#i-edit-bank').val(),//开户银行
                'backCode': $('#i-edit-bank-code').val(),//开户银行账户
                'mailAddress': $('#i-edit-mail-address').val(),//发票收取地址
                'mailPerson': $('#i-edit-mail-person').val(),//发票收件人
                'mailPhone': $('#i-edit-mail-phone').val(),//收件人电话
                'tel': $('#i-edit-company-phone').val()//公司电话
            },
            dataType: 'json',
            success: function (resp) {
                if (resp.code == 'SUCCESS') {
                    $('#close_popbox4').click();
                    alert('更新发票信息地址成功！');
                    ready2();
                    $('.invoice.edit input[type="text"]').val('');
                } else {
                    alert('更新发票信息失败！')
                }
            }
        });
    });

//设置默认发票信息
    $(document).on('click', '.set-default-invoice-info', function () {
        var addressId = $(this).attr("data-id");
        $.ajax({
            url: '/carts/setDefaultInvoice',
            type: 'POST',
            data: {
                'id': addressId
            },
            dataType: 'json',
            success: function (resp) {
                if (resp.code == 'SUCCESS') {
                    alert('设置默认发票信息成功！');
                    ready2();
                } else {
                    alert('设置默认发票信息失败！')
                }
            }
        });
    });

})
;
function ready() {
    //================================获取收货地址======================================================
    $.ajax({
        url: '/carts/getDeliveryAddress',
        type: 'POST',
        data: {},
        dataType: 'json',
        success: function (resp) {
            console.log(resp);
            $("#deliveryAddress").html("");
            for (var i = 0; i < resp.length; i++) {
                if (resp[i].isDefault == '1') {
                    $("#deliveryAddress").append("<li data-id=" + resp[i].id + "  class=\"default active\">\n" +
                        "                <span style=\"cursor:pointer;\">" + resp[i].recipients + "&nbsp;&nbsp;&nbsp;" + resp[i].provinceName + "</span>\n" +
                        "                <span data-id=" + resp[i].id + "recipients" + ">" + resp[i].recipients + "</span>\n" +
                        "                <span data-id=" + resp[i].id + "address" + ">" + resp[i].address + "</span>\n" +
                        "                <span data-id=" + resp[i].id + "phone" + ">" + resp[i].phone + "</span>\n" +
                        "                <span style='display: none' data-id=" + resp[i].id + "province" + ">" + resp[i].province + "</span>\n" +
                        "                <span style='display: none' data-id=" + resp[i].id + "provinceName" + ">" + resp[i].provinceName + "</span>\n" +
                        "                <span style='display: none' data-id=" + resp[i].id + "city" + ">" + resp[i].city + "</span>\n" +
                        "                <span style='display: none' data-id=" + resp[i].id + "cityName" + ">" + resp[i].cityName + "</span>\n" +
                        "                <span style='display: none' data-id=" + resp[i].id + "area" + ">" + resp[i].area + "</span>\n" +
                        "                <span style='display: none' data-id=" + resp[i].id + "areaName" + ">" + resp[i].areaName + "</span>\n" +
                        "                <span>（默认地址）</span>\n" +
                        "                <p>\n" +
                        "                    <a class=\"edit-delivery-address\" data-id=" + resp[i].id + " href=\"javascript:;\">编辑</a>\n" +
                        "                    <a class=\"delete-delivery-address\" data-id=" + resp[i].id + " href=\"javascript:;\">删除</a>\n" +
                        "                </p>\n" +
                        "            </li>");
                    $('#check-recipients').html(resp[i].recipients);
                    $('#address').html(resp[i].address);
                    $('#check-phone').html(resp[i].phone);
                }
            }
            for (var i = 0; i < resp.length; i++) {
                if (resp[i].isDefault == '0') {
                    $("#deliveryAddress").append("<li data-id=" + resp[i].id + ">\n" +
                        "             <span style=\"cursor:pointer;\">" + resp[i].recipients + "&nbsp;&nbsp;&nbsp;" + resp[i].provinceName + "</span>\n" +
                        "                <span data-id=" + resp[i].id + "recipients" + ">" + resp[i].recipients + "</span>\n" +
                        "                <span data-id=" + resp[i].id + "address" + ">" + resp[i].address + "</span>\n" +
                        "                <span data-id=" + resp[i].id + "phone" + ">" + resp[i].phone + "</span>\n" +
                        "                <span style='display: none' data-id=" + resp[i].id + "province" + ">" + resp[i].province + "</span>\n" +
                        "                <span style='display: none' data-id=" + resp[i].id + "provinceName" + ">" + resp[i].provinceName + "</span>\n" +
                        "                <span style='display: none' data-id=" + resp[i].id + "city" + ">" + resp[i].city + "</span>\n" +
                        "                <span style='display: none' data-id=" + resp[i].id + "cityName" + ">" + resp[i].cityName + "</span>\n" +
                        "                <span style='display: none' data-id=" + resp[i].id + "area" + ">" + resp[i].area + "</span>\n" +
                        "                <span style='display: none' data-id=" + resp[i].id + "areaName" + ">" + resp[i].areaName + "</span>\n" +
                        "                <p>\n" +
                        "                    <a class=\"set-default-delivery-address\" data-id=" + resp[i].id + " href=\"javascript:;\">设为默认地址</a>\n" +
                        "                    <a class=\"edit-delivery-address\" data-id=" + resp[i].id + " href=\"javascript:;\">编辑</a>\n" +
                        "                    <a class=\"delete-delivery-address\" data-id=" + resp[i].id + " href=\"javascript:;\">删除</a>\n" +
                        "                </p>\n" +
                        "            </li>")
                }
            }
            $('.consignee li').hover(function () {
                $('.consignee li').removeClass('active');
                $(this).addClass('active');
                $(this).find('p').show();
            }, function () {
                $('.consignee li').removeClass('active');
                $(this).find('p').hide();
            });
        }
    });

}

function ready2() {
    //============================获取发票信息=================================
    $.ajax({
        url: '/carts/getInvoice',
        type: 'POST',
        data: {},
        dataType: 'json',
        success: function (resp) {
            console.log(resp);
            $("#invoiceList").html("");
            for (var i = 0; i < resp.length; i++) {
                if (resp[i].isDefault == '1') {
                    $("#invoiceList").append("<li data-id=" + resp[i].id + " class=\"default active\">\n" +
                        "                    <span data-id=" + resp[i].id + "i_type" + " style=\"cursor:pointer;\">" + resp[i].type + "</span>\n" +
                        "                    <span>" + resp[i].companyName + "（" + resp[i].backCode + "）</span>\n" +
                        "                    <span>收票人：" + resp[i].mailPerson + "</span>\n" +
                        "                    <span data-id=" + resp[i].id + "i_mailPhone" + ">" + resp[i].mailPhone + "</span>\n" +
                        "                    <span style='display: none' data-id=" + resp[i].id + "i_taxCode" + ">" + resp[i].taxCode + "</span>\n" +
                        "                    <span style='display: none' data-id=" + resp[i].id + "i_address" + ">" + resp[i].address + "</span>\n" +
                        "                    <span style='display: none' data-id=" + resp[i].id + "i_back" + ">" + resp[i].back + "</span>\n" +
                        "                    <span style='display: none' data-id=" + resp[i].id + "i_backCode" + ">" + resp[i].backCode + "</span>\n" +
                        "                    <span style='display: none' data-id=" + resp[i].id + "i_mailAddress" + ">" + resp[i].mailAddress + "</span>\n" +
                        "                    <span style='display: none' data-id=" + resp[i].id + "i_tel" + ">" + resp[i].tel + "</span>\n" +
                        "                    <span style='display: none' data-id=" + resp[i].id + "i_tel" + ">" + resp[i].tel + "</span>\n" +
                        "                    <span style='display: none' data-id=" + resp[i].id + "i_mailPerson" + ">" + resp[i].mailPerson + "</span>\n" +
                        "                    <span style='display: none' data-id=" + resp[i].id + "i_companyName" + ">" + resp[i].companyName + "</span>\n" +
                        "                    <span style='display: none' data-id=" + resp[i].id + "i_id" + ">" + resp[i].id + "</span>\n" +
                        "                   <span>（默认发票）</span>\n" +
                        "                    <p>\n" +
                        "                        <a class=\"edit-invoice-info\" data-id=" + resp[i].id + "  href=\"javascript:;\">编辑</a>\n" +
                        "                        <a class=\"delete-invoice-info\" data-id=" + resp[i].id + "  href=\"javascript:;\">删除</a>\n" +
                        "                    </p>\n" +
                        "                </li>")
                }
            }
            for (var i = 0; i < resp.length; i++) {
                if (resp[i].isDefault == '0') {
                    $("#invoiceList").append("<li data-id=" + resp[i].id + ">" +
                        "                    <span data-id=" + resp[i].id + "i_type" + " style=\"cursor:pointer;\">" + resp[i].type + "</span>\n" +
                        "                    <span>" + resp[i].companyName + "（" + resp[i].backCode + "）</span>\n" +
                        "                    <span>收票人：" + resp[i].mailPerson + "</span>\n" +
                        "                    <span data-id=" + resp[i].id + "i_mailPhone" + ">" + resp[i].mailPhone + "</span>\n" +
                        "                    <span style='display: none' data-id=" + resp[i].id + "i_taxCode" + ">" + resp[i].taxCode + "</span>\n" +
                        "                    <span style='display: none' data-id=" + resp[i].id + "i_address" + ">" + resp[i].address + "</span>\n" +
                        "                    <span style='display: none' data-id=" + resp[i].id + "i_back" + ">" + resp[i].back + "</span>\n" +
                        "                    <span style='display: none' data-id=" + resp[i].id + "i_backCode" + ">" + resp[i].backCode + "</span>\n" +
                        "                    <span style='display: none' data-id=" + resp[i].id + "i_mailAddress" + ">" + resp[i].mailAddress + "</span>\n" +
                        "                    <span style='display: none' data-id=" + resp[i].id + "i_tel" + ">" + resp[i].tel + "</span>\n" +
                        "                    <span style='display: none' data-id=" + resp[i].id + "i_mailPerson" + ">" + resp[i].mailPerson + "</span>\n" +
                        "                    <span style='display: none' data-id=" + resp[i].id + "i_companyName" + ">" + resp[i].companyName + "</span>\n" +
                        "                    <span style='display: none' data-id=" + resp[i].id + "i_id" + ">" + resp[i].id + "</span>\n" +
                        "                    <p>\n" +
                        "                        <a class=\"set-default-invoice-info\" data-id=" + resp[i].id + " href=\"javascript:;\">设为默认发票抬头</a>\n" +
                        "                        <a class=\"edit-invoice-info\" data-id=" + resp[i].id + " href=\"javascript:;\">编辑</a>\n" +
                        "                        <a class=\"delete-invoice-info\" data-id=" + resp[i].id + " href=\"javascript:;\">删除</a>\n" +
                        "                    </p>\n" +
                        "                </li>")
                }
            }
            $('.consignee li').hover(function () {
                $('.consignee li').removeClass('active');
                $(this).addClass('active');
                $(this).find('p').show();
            }, function () {
                $('.consignee li').removeClass('active');
                $(this).find('p').hide();
            });
            $('#invoiceList li').click(function () {
                $('#invoiceList li').removeClass("default active");
                $(this).addClass("default active");
            });
        }
    });
}

function getProvince() {
    $.ajax({
        url: '/company/getProvince',
        type: 'GET',
        data: {},
        dataType: 'json',
        success: function (resp) {
            $('#new-province').empty();
            for (var i = 0; i < resp.length; i++) {
                $('#new-province').append("" +
                    "<option  value="+resp[i].regionCode+" valueName="+resp[i].regionName+" >" + resp[i].regionName + "</option>")
            }
            getCity();
        }
    });
}

function getCity() {
    $.ajax({
        url: '/company/getCity',
        type: 'GET',
        data: {
            provinceCode:$('#new-province').val()
        },
        dataType: 'json',
        success: function (resp) {
            $('#new-city').empty();
            for (var i = 0; i < resp.length; i++) {
                $('#new-city').append("" +
                    "<option value=" + resp[i].regionCode + " valueName="+resp[i].regionName+">" + resp[i].regionName + "</option>")
            }
            getArea();
        }
    });
}

function getArea() {
    $.ajax({
        url: '/company/getArea',
        type: 'GET',
        data: {
            cityCode:$('#new-city').val()
        },
        dataType: 'json',
        success: function (resp) {
            $('#new-area').empty();
            for (var i = 0; i < resp.length; i++) {
                $('#new-area').append("" +
                    "<option value=" + resp[i].regionCode + " valueName="+resp[i].regionName+">" + resp[i].regionName + "</option>")
            }
        }
    });
}

function getEditProvince() {
    $.ajax({
        url: '/company/getProvince',
        type: 'GET',
        data: {},
        dataType: 'json',
        async: false,
        success: function (resp) {
            $('#edit-province').empty();
            for (var i = 0; i < resp.length; i++) {
                $('#edit-province').append("" +
                    "<option value=" + resp[i].regionCode + " valueName="+resp[i].regionName+">" + resp[i].regionName + "</option>")
            }
            getEditCity();
        }
    });
}

function getEditCity() {
    $.ajax({
        url: '/company/getCity',
        type: 'GET',
        data: {
            provinceCode:$('#edit-province').val()
        },
        async: false,
        dataType: 'json',
        success: function (resp) {
            $('#edit-city').empty();
            for (var i = 0; i < resp.length; i++) {
                $('#edit-city').append("" +
                    "<option value=" + resp[i].regionCode + " valueName="+resp[i].regionName+">" + resp[i].regionName + "</option>")
            }
            getEditArea();
        }
    });
}

function getEditArea() {
    $.ajax({
        url: '/company/getArea',
        type: 'GET',
        data: {
            cityCode:$('#edit-city').val()
        },
        async: false,
        dataType: 'json',
        success: function (resp) {
            $('#edit-area').empty();
            for (var i = 0; i < resp.length; i++) {
                $('#edit-area').append("" +
                    "<option value=" + resp[i].regionCode + " valueName="+resp[i].regionName+">" + resp[i].regionName + "</option>")
            }
        }
    });
}