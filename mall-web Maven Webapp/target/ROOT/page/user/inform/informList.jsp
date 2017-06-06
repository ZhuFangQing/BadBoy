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
            var i = ${informList.perPageNo};
            if (i < 2) {
                $('#pagination').hide();
            }
            $("#Pagination").pagination("${informList.perPageNo}", {
                callback: getOtherNews
            });
            function getOtherNews(pageNum) {
                pageNum = pageNum + 1;
                $.ajax({
                    url: '${ctx}/mallInformPage',
                    type: 'POST',
                    data: {
                        beginPage: pageNum,
                    },
                    dataType: 'json',
                    success: function (resp) {
                        console.log(resp);
                        $("#mall_inform_form").html("");
                        var list2 = "<tr><td>\n" +
                            "                        <label><input type=\"checkbox\" name=\"informCheck\" value=\"{mallInformList.id}\"/><em class=\"{mallInformList.class}\"></em></label>\n" +
                            "                        </td>\n" +
                            "                        <td>{mallInformList.sender}</td>\n" +
                            "                        <td class=\"check-inform-detail\" ><a href=\"/mallInform/{mallInformList.id2}\">{mallInformList.title}-<span>{mallInformList.summary}</span></a></td>\n" +
                            "                        <td>{mallInformList.created_at}</td>\n" +
                            "                        <td class=\"rtecenter\"><a data-id=\"{mallInformList.id3}\" href=\"javascript:;\" class=\"del_sms\"><img  src=\"/images/del_icon.png\"/></a>\n" +
                            "                        </td></tr>";
                        for (var i = 0; i < resp.data.length; i++) {
                            var list = list2;
                            list = list.replace("{mallInformList.id}", resp.data[i].id);
                            list = list.replace("{mallInformList.id2}", resp.data[i].id);
                            list = list.replace("{mallInformList.id3}", resp.data[i].id);
                            list = list.replace("{mallInformList.sender}", resp.data[i].sender);
                            list = list.replace("{mallInformList.title}", resp.data[i].title);
                            list = list.replace("{mallInformList.summary}", resp.data[i].summary);
                            list = list.replace("{mallInformList.created_at}", resp.data[i].created_at);
                            if (resp.data[i].is_read == '1') {
                                list = list.replace("{mallInformList.class}", "read");
                            } else {
                                list = list.replace("{mallInformList.class}", "");
                            }
                            $("#mall_inform_form").append(list);
                        }
                    }
                });
            }

            $(document).on('click', '.delete-inform-list', function () {
                debugger;
                var id = $("input[name='informCheck']:checked").val();
                if (confirm("确定要删除通知吗？")) {
                    $.ajax({
                        url: '${ctx}/deleteMallInform',
                        type: 'POST',
                        data: $('#mallInformForm').serialize(),
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

            $(document).on('click', '.read-mall-inform', function () {
                debugger;
                var id = $("input[name='informCheck']:checked").val();
                $.ajax({
                    url: '${ctx}/readMallInform',
                    type: 'POST',
                    data: $('#mallInformForm').serialize(),
                    dataType: 'json',
                    success: function (resp) {
                        if (resp.code == 'SUCCESS') {
                            alert("标记已读成功！");
                            location.href = "/mallInform";
                        } else {
                            alert(resp.msg);
                        }
                    }
                });
            });

            $(document).on('click','.del_sms', function () {
                debugger;
                var id = $(this).attr("data-id");
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
            <span class="active">商城通知<em>${informList.total}</em></span>
            <div class="order_seach_box" style="margin-top:5px;">
                <%--<div class="order_seach_text"><input type="text" placeholder="商品名称/商品编号/订单号"/></div>--%>
                <%--<em></em>--%>
            </div>
            <input class="read-mall-inform" id="all_read" type="button" value="全部标为已读"/>
            <input class="delete-inform-list" type="button" value="删除"/>
        </div>
        <div class="tab_main_box">
            <form action="deleteMallInform" method="post" id="mallInformForm">
                <table class="mall_sms_table" width="100%" cellpadding="0" cellspacing="0">
                    <thead>
                    <tr>
                        <td width="100">
                            <label><input class="all" type="checkbox"/><span>全选</span></label>
                        </td>
                        <td width="110">发件人</td>
                        <td>主题</td>
                        <td width="160">时间</td>
                        <td class="rtecenter" width="80">操作</td>
                    </tr>
                    </thead>
                    <tbody id="mall_inform_form">
                    <c:forEach items="${informList.data}" var="mallInformList">
                        <tr>
                            <td>
                                <c:if test="${mallInformList.is_read=='1'}">
                                    <label><input value="${mallInformList.id}" type="checkbox" name="informCheck"/><em
                                            class="read"></em></label>
                                </c:if>
                                <c:if test="${mallInformList.is_read=='0'}">
                                    <label><input value="${mallInformList.id}" type="checkbox"
                                                  name="informCheck"/><em></em></label>
                                </c:if>
                            </td>
                            <td>${mallInformList.sender}</td>
                            <td>
                                <a href="/mallInform/${mallInformList.id}">${mallInformList.title}-<span>${mallInformList.summary}</span></a>
                            </td>
                            <td>${mallInformList.created_at}</td>
                            <td class="rtecenter"><a data-id="${mallInformList.id}" href="javascript:;" class="del_sms"><img src="/images/del_icon.png"/></a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </form>
        </div>
        <div id="pagination" class="business-pages container">
            <jsp:include page="/page/common/pagination.jsp"></jsp:include>
        </div>
    </div>
    <div class="clear"></div>
</div>

<%@ include file="/page/common/foot.jsp" %>

</body>
</html>
