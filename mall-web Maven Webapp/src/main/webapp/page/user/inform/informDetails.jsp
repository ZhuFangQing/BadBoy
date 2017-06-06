<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@include file="/page/common/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>七彩云</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="/css/myOrder.css" rel="stylesheet" type="text/css"/>
    <%@include file="/page/common/resource.jsp" %>
    <script type="text/javascript">
        $(document).ready(function () {
            $(document).on('click', '.delete-inform-details', function () {
                debugger;
                var id = $(this).attr("id");
                if (confirm("确定要删除该通知吗？")) {
                    $.ajax({
                        url: '${ctx}/deleteMallInformById',
                        type: 'POST',
                        data: {
                            id: id
                        },
                        dataType: 'json',
                        success: function (resp) {
                            if (resp.code == 'SUCCESS') {
                                alert("删除商城通知成功！");
                                location.href = "/mallInform";
                            } else {
                                alert(resp.msg);
                            }
                        }
                    });
                }
            });

            $("#go_list").click(function(){
               location.href = "/mallInform";
            });
        });
    </script>
</head>
<body>
<!--头部-->
<%@ include file="/page/common/top.jsp" %>
<div class="mian_content container">
    <jsp:include page="/page/common/usercenter.jsp"></jsp:include>
    <div class="mumber_right_content">
        <div class="shopping_car_tab">
            <span class="active">商城通知</span>
        </div>
        <div class="tab_main_box">
            <div class="mall_sms_detil_title">
                <h1>${inform.title}</h1>
                <p>发件人：${inform.sender}</p>
                <p>时间：${inform.created_at}</p>
                <input id="go_list" type="button" value="返回" style="right: 80px;"/>
                <input id="${inform.id}" class="delete-inform-details" type="button" value="删除"/>
            </div>
            <div class="mall_sms_detil_content">
                ${inform.content}
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>

<%@ include file="/page/common/foot.jsp" %>

</body>
</html>
