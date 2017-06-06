$(document).ready(function () {
    //申请提额
    var source = $.getUrlParam("source");
    if($.notNull(source) && source == 'apply'){
        $("#btn_apply").click();
    }

    getCashFlowReady();
    getCreditFlowReady();
    getApplyReady();
    //============================现金流水========================================
    function getCashFlowReady() {
        $.ajax({
            url: '/money/getCashFlow',
            type: 'POST',
            data: {},
            dataType: 'json',
            success: function (resp) {
                $("#Pagination").pagination(resp.perPageNo, {
                    callback: getCashFlow
                });
                if (resp.perPageNo < 2) {
                    $("#Pagination_1").hide();
                }
                console.log(resp);
                $("#cash_flow_table").html("");
                $("#cash_flow_table").append("<tr>\n" +
                    "                    <td><a href=\"javascript:;\"><em>日期</em><img src=\"/images/list_icon.png\" /></a></td>\n" +
                    "                    <td>类型</td>\n" +
                    "                    <td>现金流水</td>\n" +
                    "                    <td>操作事项</td>\n" +
                    "                </tr>");
                for (var i = 0; i < resp.data.length; i++) {
                    var classType="";
                    if(i%2!=0){
                        classType="grey"
                    }
                    if (resp.data[i].type == '1') {
                        $("#cash_flow_table").append("<tr class='"+classType+"'>\n" +
                            "                    <td>" + resp.data[i].date + "</td>\n" +
                            "                    <td>" + resp.data[i].type_desc + "</td>\n" +
                            "                    <td><span class=\"negative\">-¥" + resp.data[i].amount + "</span></td>\n" +
                            "                    <td class=\"rteleft\">" + resp.data[i].note + "</td>\n" +
                            "                </tr>");
                    } else {
                        $("#cash_flow_table").append("<tr class='"+classType+"'>\n" +
                            "                    <td>" + resp.data[i].date + "</td>\n" +
                            "                    <td>" + resp.data[i].type_desc + "</td>\n" +
                            "                    <td><span>+¥" + resp.data[i].amount + "</span></td>\n" +
                            "                    <td class=\"rteleft\">" + resp.data[i].note + "</td>\n" +
                            "                </tr>");
                    }

                }
            }
        });
    }

    function getCashFlow(pageNum) {
        pageNum = pageNum + 1;
        $.ajax({
            url: '/money/getCashFlow',
            type: 'POST',
            data: {
                beginPage: pageNum
            },
            dataType: 'json',
            success: function (resp) {
                console.log(resp);
                $("#cash_flow_table").html("");
                $("#cash_flow_table").append("<tr>\n" +
                    "                    <td><a href=\"javascript:;\"><em>日期</em><img src=\"/images/list_icon.png\" /></a></td>\n" +
                    "                    <td>类型</td>\n" +
                    "                    <td>现金流水</td>\n" +
                    "                    <td>操作事项</td>\n" +
                    "                </tr>");
                for (var i = 0; i < resp.data.length; i++) {
                    var classType="";
                    if(i%2!=0){
                        classType="grey"
                    }
                    if (resp.data[i].type == '1') {
                        $("#cash_flow_table").append("<tr class='"+classType+"'>\n" +
                            "                    <td>" + resp.data[i].date + "</td>\n" +
                            "                    <td>" + resp.data[i].type_desc + "</td>\n" +
                            "                    <td><span class=\"negative\">-¥" + resp.data[i].amount + "</span></td>\n" +
                            "                    <td class=\"rteleft\">" + resp.data[i].note + "</td>\n" +
                            "                </tr>");
                    } else {
                        $("#cash_flow_table").append("<tr class='"+classType+"'>\n" +
                            "                    <td>" + resp.data[i].date + "</td>\n" +
                            "                    <td>" + resp.data[i].type_desc + "</td>\n" +
                            "                    <td><span>+¥" + resp.data[i].amount + "</span></td>\n" +
                            "                    <td class=\"rteleft\">" + resp.data[i].note + "</td>\n" +
                            "                </tr>");
                    }

                }
            }
        });
    }

    //====================================信用额度==============================================
    function getCreditFlowReady() {
        $.ajax({
            url: '/money/getCreditFlow',
            type: 'POST',
            data: {},
            dataType: 'json',
            success: function (resp) {
                $("#Pagination2").pagination(resp.perPageNo, {
                    callback: getCashFlow2
                });
                if (resp.perPageNo < 2) {
                    $("#Pagination_2").hide();
                }
                console.log(resp);
                $("#credit_flow_table").html("");
                $("#credit_flow_table").append("<tr >\n" +
                    "                    <td><a href=\"javascript:;\"><em>日期</em><img src=\"/images/list_icon.png\" /></a></td>\n" +
                    "                    <td>交易金额</td>\n" +
                    "                    <td>交易类型</td>\n" +
                    "                    <td>到期还款日</td>\n" +
                    "                    <td>已还款金额</td>\n" +
                    "                    <td>交易描述</td>\n" +
                    "                    <td>状态</td>\n" +
                    "                </tr>");
                for (var i = 0; i < resp.data.length; i++) {
                    var classType="";
                    if(i%2!=0){
                        classType="grey"
                    }
                    $("#credit_flow_table").append("<tr class='"+classType+"'>\n" +
                        "                    <td>" + resp.data[i].tran_date + "</td>\n" +
                        "                    <td><span>¥" + resp.data[i].amount + "</span></td>\n" +
                        "                    <td>" + resp.data[i].tran_type_desc + "</td>\n" +
                        "                    <td>" + resp.data[i].last_repayment_date + "</td>\n" +
                        "                    <td><span>¥" + resp.data[i].repayment_amount + "</span></td>\n" +
                        "                    <td>" + resp.data[i].description + "</td>\n" +
                        "                    <td>" + resp.data[i].status_desc + "</td>\n" +
                        "                </tr>");

                }
            }
        });
    }

    function getCashFlow2(pageNum) {
        pageNum = pageNum + 1;
        $.ajax({
            url: '/money/getCreditFlow',
            type: 'POST',
            data: {
                beginPage: pageNum
            },
            dataType: 'json',
            success: function (resp) {
                console.log(resp);
                $("#credit_flow_table").html("");
                $("#credit_flow_table").append("<tr>\n" +
                    "                    <td><a href=\"javascript:;\"><em>日期</em><img src=\"/images/list_icon.png\" /></a></td>\n" +
                    "                    <td>交易金额</td>\n" +
                    "                    <td>交易类型</td>\n" +
                    "                    <td>到期还款日</td>\n" +
                    "                    <td>已还款金额</td>\n" +
                    "                    <td>交易描述</td>\n" +
                    "                    <td>状态</td>\n" +
                    "                </tr>");
                for (var i = 0; i < resp.data.length; i++) {
                    var classType="";
                    if(i%2!=0){
                        classType="grey"
                    }
                    $("#credit_flow_table").append("<tr class='"+classType+"'>\n" +
                        "                    <td>" + resp.data[i].tran_date + "</td>\n" +
                        "                    <td><span>¥" + resp.data[i].amount + "</span></td>\n" +
                        "                    <td>" + resp.data[i].tran_type_desc + "</td>\n" +
                        "                    <td>" + resp.data[i].last_repayment_date + "</td>\n" +
                        "                    <td><span>¥" + resp.data[i].repayment_amount + "</span></td>\n" +
                        "                    <td>" + resp.data[i].description + "</td>\n" +
                        "                    <td>" + resp.data[i].status_desc + "</td>\n" +
                        "                </tr>");

                }
            }
        });
    }
    //====================================获取申请列表==============================================
    function getApplyReady() {
        $.ajax({
            url: '/money/getApply',
            type: 'POST',
            data: {},
            dataType: 'json',
            success: function (resp) {
                $("#Pagination3").pagination(resp.perPageNo, {
                    callback: getCashFlow3
                });
                if (resp.perPageNo < 2) {
                    $("#Pagination_3").hide();
                }
                console.log(resp);
                $("#apply_list_table").html("");
                $("#apply_list_table").append("<tr >\n" +
                    "                    <td><a href=\"javascript:;\"><em>申请日期</em><img src=\"/images/list_icon.png\" /></a></td>\n" +
                    "                    <td>申请类型</td>\n" +
                    "                    <td>审核情况</td>\n" +
                    "                    <td>审批日期</td>\n" +
                    "                    <td>申请理由</td>\n" +
                    "                </tr>");
                for (var i = 0; i < resp.data.length; i++) {
                    var classType="";
                    if(i%2!=0){
                        classType="grey"
                    }
                    var date = resp.data[i].updated_at
                    if(undefined == date && null == date ){
                        date ="暂时未审核";
                    }
                    $("#apply_list_table").append("<tr class='"+classType+"' >\n" +
                        "                    <td>" + resp.data[i].created_at + "</td>\n" +
                        "                    <td>" + resp.data[i].type + "</td>\n" +
                        "                    <td>" + resp.data[i].status + "</td>\n" +
                        "                    <td>"+date+"</td>\n" +
                        "                    <td><a href=\"javascript:;\" class=\"reason\" onclick=\"OpenPopbox('rapc')\">" + resp.data[i].reason + "</a></td>\n" +
                        "                </tr>");

                }
            }
        });
    }

    function getCashFlow3(pageNum) {
        pageNum = pageNum + 1;
        $.ajax({
            url: '/money/getApply',
            type: 'POST',
            data: {
                beginPage: pageNum
            },
            dataType: 'json',
            success: function (resp) {
                console.log(resp);
                $("#apply_list_table").html("");
                $("#apply_list_table").append("<tr >\n" +
                    "                    <td><a href=\"javascript:;\"><em>申请日期</em><img src=\"/images/list_icon.png\" /></a></td>\n" +
                    "                    <td>申请类型</td>\n" +
                    "                    <td>审核情况</td>\n" +
                    "                    <td>审批日期</td>\n" +
                    "                    <td>申请理由</td>\n" +
                    "                </tr>");
                for (var i = 0; i < resp.data.length; i++) {
                    var classType="";
                    if(i%2!=0){
                        classType="grey"
                    }
                    var date = resp.data[i].updated_at
                    if(undefined == date && null == date ){
                        date ="暂时未审核";
                    }
                    $("#apply_list_table").append("<tr class='"+classType+"' >\n" +
                        "                    <td>" + resp.data[i].created_at + "</td>\n" +
                        "                    <td>" + resp.data[i].type + "</td>\n" +
                        "                    <td>" + resp.data[i].status + "</td>\n" +
                        "                    <td>"+date+"</td>\n" +
                        "                    <td><a href=\"javascript:;\" class=\"reason\" onclick=\"OpenPopbox('rapc')\">" + resp.data[i].reason + "</a></td>\n" +
                        "                </tr>");

                }
            }
        });
    }




    //===================================申请============================================
    //账期申请
    $(document).on('click', '.apply-payment-day', function () {
        if($('#payment_reason').val() == ""){
            alert("请填写申请理由");
            return false;
        }

        $.ajax({
            url: '/money/apply',
            type: 'POST',
            data: {
                type: 'CREDIT_TYPE',
                reason: $('#payment_reason').val(),
                payment_day: $('#payment_day').val()
            },
            dataType: 'json',
            success: function (resp) {
                console.log(resp);
                if(resp.code == 'SUCCESS'){
                    alert("提交申请延长账期成功！请耐心等待审核。");
                    $('.apply-payment-day-cancel').click();
                    $('#payment_reason').val("");
                }else{
                    alert("申请延长账期失败！");
                }
            }
        });
    });

    //提额申请
    $(document).on('click', '.apply-credit-money', function () {
        if($('#credit_reason').val() == ""){
            alert("请填写申请理由");
            return false;
        }

        $.ajax({
            url: '/money/apply',
            type: 'POST',
            data: {
                type: 'MONEY_TYPE',
                reason: $('#credit_reason').val()
            },
            dataType: 'json',
            success: function (resp) {
                console.log(resp);
                if(resp.code == 'SUCCESS'){
                    alert("提交申请提额成功！请耐心等待审核。");
                    $('.apply-credit-money-cancel').click();
                    $('#credit_reason').val("");
                }else{
                    alert("申请延长账期失败！");
                }
            }
        });
    });

    //显示申请理由
    $(document).on('click', '.reason', function () {
        $('#show_apply_reason').html($(this).html());
    });

});



