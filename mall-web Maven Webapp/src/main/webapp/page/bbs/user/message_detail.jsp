<%--
  Created by IntelliJ IDEA.
  User: Echos
  Date: 2016/12/7
  Time: 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>七彩云</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%@include file="/page/common/resource.jsp" %>
    <link href="/css/placeorder.css" rel="stylesheet" type="text/css" />

    <link href="/css/bbs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var MESSAGE_LI = "<div class=\"item\">\n" +
            "                    <h1>{title}</h1>\n" +
            "                    <p>{content}</p>\n" +
            "                </div>";

        $(function(){
            var userId = "${userId}";
            //加载消息
            messageList(1,5);

            function messageList(pageNo, pageSize){
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
                    'createdBy': userId
                };


                $.ajax({
                    url: '/bbs/u/search_message',
                    type: 'GET',
                    data: obj,
                    dataType: 'json',
                    success: function (resp) {
                        console.log(resp);

                        if($.ajaxSuccess(resp)){

                            //更新分页控件
                            $("#Pagination").pagination(resp['totalPageSize'], {
                                callback: function(pageNo){messageList(++pageNo)},
                                current_page: resp['pageNo'] - 1
                            });

                            $("#messages_container .item").remove();

                            for(var idx in resp['data']){
                                var message = resp['data'][idx];
                                message['createdAt'] = new Date(message['createdAt']).pattern();
                                message['picUrl'] = $.isNull(message['picUrl']) ? "/images/person_img.jpg" : message['picUrl'];
                                var title;
                                if(message['flag'] == '0'){
                                    title = "<a href=\"javascript:;\">您</a><span>"+new Date(message['createdAt']).pattern()+"</span>";
                                }else{
                                    title = "<a href=\"/bbs/users/"+message['createdBy']+"\">"+message['createdUsername']+"</a><span>"+new Date(message['createdAt']).pattern()+"</span>";
                                }
                                message['title'] = title;
                                $("#messages_container").append(i7Utils.mix(MESSAGE_LI, message));
                            }
                        }else{
                            alert(resp['msg']);
                        }
                    }
                });
            }

            $("#btn_submit").click(function(){
                var obj = {
                    'receiveId'        :userId,
                    'content'          :$("#send_content").val()
                };

                $.ajax({
                    url: '/bbs/u/messages',
                    type: 'POST',
                    data: obj,
                    dataType: 'json',
                    success: function (resp) {
                        console.log(resp);

                        if($.ajaxSuccess(resp)){
                            location.reload();
                        }else{
                            alert(resp['msg']);
                        }
                    }
                });
            });
        })
    </script>
</head>
<body>
<%--top模块--%>
<%@ include file="/page/common/top.jsp" %>
<div class="mian_content container">
    <jsp:include page="/page/common/usercenter.jsp"></jsp:include>
    <div class="mumber_right_content">
        <div class="bbs_mysms_title">我的短消息<a href="/bbs/u/messages" id="btn_send_new_message">返回列表<%--<img src="/images/bbs_post_sms_icon.jpg" />--%></a></div>
        <div>
            <div class="bbs_mysms_box" style="padding-left:0px;">
                <%--<div class="bbs_mysms_img"><img src="/images/person_img.jpg" width="82" height="82" /></div>--%>
                <div id="messages_container">
                </div>

                <div class="bbs_mysms_answer">
                    <div class="bbs_mysms_textarea">
                        <textarea id="send_content"></textarea>
                        <input type="submit" id="btn_submit" value="发表" />
                    </div>
                </div>
            </div>
        </div>

        <div class="business-pages fl">
            <jsp:include page="/page/common/pagination.jsp"></jsp:include>
        </div>
    </div>
    <div class="clear"></div>
</div>
<%@ include file="/page/common/foot.jsp" %>
</body>
</html>