<%--
  Created by IntelliJ IDEA.
  User: Echos
  Date: 2017/2/27
  Time: 13:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>七彩云</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%@include file="../common/resource.jsp" %>
    <script src="/js/bbs.js?t=${now}"></script>
    <link href="/css/bbs.css" rel="stylesheet" type="text/css" />
    <script>
        var USER_LI = "<li class=\"{isFirst}\">\n" +
            "                    <div class=\"bbs_search_listbox_img\"><a href=\"/bbs/users/{userId}\"><img src=\"/images/bbs_poster_img2.jpg\" width=\"100\" height=\"100\" /></a></div>\n" +
            "                    <h1><a href=\"/bbs/users/{userId}\">{username}</a></h1>\n" +
            "                    <p>{levelName}  |  积分：<span>{point}</span></p>\n" +
            "                    <a href=\"javascript:;\"><img src=\"/images/bbs_list_sms_icon.png\" class=\"bbs_search_list_sms\" data-username=\"{username}\" /></a>\n" +
            "                </li>";

        $(function(){

            userList();

            function userList(pageNo, pageSize){

                //PageNo
                if(undefined == pageNo){
                    pageNo = 1;
                }

                //PageSize
                if(undefined == pageSize){
                    pageSize = 12;
                }

                var obj = {
                    'search':getBbsSearchContent(),
                    'pageNo':pageNo,
                    'pageSize':pageSize
                };

                if($.isNull(obj['search'])){
                  alert('搜索用户关键字不能为空');
                  return false;
                };

                $.ajax({
                    url: '/bbs/search_user',
                    type: 'GET',
                    data: obj,
                    dataType: 'json',
                    success: function (resp) {
                        console.log(resp);

                        if($.ajaxSuccess(resp)){

                            //更新分页控件
                            $("#Pagination").pagination(resp['totalPageSize'], {
                                callback: function(pageNo){userList(++pageNo)},
                                current_page: resp['pageNo'] - 1
                            });

                            $("#user_list_container li").remove();

                            for(var idx in resp['data']){
                                var user = resp['data'][idx];
                                user['isFirst'] = idx%4 == 0 ? "first" : "";
                                var li = i7Utils.mix(USER_LI, user);
                                $("#user_list_container").append(li);
                            }
                        }else{
                            alert(resp['msg']);
                            return false;
                        }
                    }
                });
            }
            function listByPage(pageNo){
                pageNo = pageNo + 1;
                userList(pageNo);
            }

            $(document).on("click", ".bbs_search_list_sms", function () {
                var at = $(this).attr("data-username");
                at = encodeURI(encodeURI(at));
                location.href = "/bbs/u/messages?at=" + at;
            });
        });
    </script>
</head>
<body>
<%--top模块--%>
<%@ include file="../common/top.jsp" %>

<div class="container">
    <%--bbs search box--%>
    <jsp:include page="/page/bbs/common/bbs_search_box.jsp"></jsp:include>
        <div class="bbs_search_text"><img src="/images/search_icon_grey.png" />以下是查找到的用户列表(最多显示 100 个)，您还可以换个搜索条件试试</div>
        <div class="bbs_search_listbox">
            <ul id="user_list_container">
            </ul>
        </div>

        <div class="business-pages fl">
            <jsp:include page="/page/common/pagination.jsp"></jsp:include>
        </div>

</div>

<div class="clear"></div>
<%--foot--%>
<%@ include file="/page/common/foot.jsp" %>
</body>
</html>
