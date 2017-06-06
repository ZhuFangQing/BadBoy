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
        var MESSAGE_LI = "<div class=\"bbs_mysms_box\" style=\"padding-bottom: 20px;\">\n" +
            "                <div class=\"bbs_mysms_img\"><img src=\"{picUrl}\" width=\"82\" height=\"82\" /></div>\n" +
            "                <h1>{title}</a><span>{createdAt}</span></h1>\n" +
            "                <a href=\"/bbs/u/messages/{receiveId}\"><p>{content}</p></a>\n" +
            "                <p class=\"bbs_mysms_btns\" data-id=\"{targetId}\" data-user=\"{targetName}\" data-mid=\"{id}\">\n" +
            "                    <a href=\"javascript:;\" class=\"btn_reply\"><img src=\"/images/bbs_answer_btn.jpg\" /></a>\n" +
            "                    <a href=\"javascript:;\" class=\"btn_del\"><img src=\"/images/bbs_del_btn.jpg\" /></a>\n" +
            "                </p>\n" +
            "            </div>";

        $(function(){
            //加载消息
            messageList(1,5);

            //直接打开发送消息窗口
            var at = $.getUrlParam("at");
            if($.notNull(at)){
                $("#send_user_name").val(decodeURI(at));
                OpenPopbox('aiac');
            }


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
                    'pageSize' : pageSize
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

                            $("#messages_container .bbs_mysms_box ").remove();

                            for(var idx in resp['data']){
                                var message = resp['data'][idx];
                                message['createdAt'] = new Date(message['createdAt']).pattern();
                                //message['picUrl'] = $.isNull(message['picUrl']) ? itx+"/images/bbs_default_avatar.jpg" : message['picUrl'];
                                var title;//<a href=\"/bbs/users/{receiveId}\">{createdUsername}：
                                if(message['flag'] == '0'){
                                    message['picUrl'] = itx+message['picUrl'];
                                    title = "<a href=\"javascript:;\">您</a> 对 <a href=\"/bbs/users/"+message['receiveId']+"\">"+message['receiveUsername']+"</a> 说：";
                                    message['targetId'] = message['receiveId'];
                                    message['targetName'] = message['receiveUsername'];
                                }else{
                                    message['picUrl'] = itx+message['sendPicUrl'];
                                    title = "<a href=\"/bbs/users/"+message['createdBy']+"\">"+message['createdUsername']+"</a> 对 <a href=\"javascript:;\">您</a> 说：";
                                    message['targetId'] = message['createdBy'];
                                    message['targetName'] = message['createdUsername'];
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

            $("#btn_send_new_message").click(function(){
                $("#send_user_name").val('');
                $("#send_user_name").removeAttr("readonly");
                $("#send_content").val('');
                $("#sendUserId").val('');
                OpenPopbox('aiac');
                $("#send_user_name").focus();
            });

            $("#btn_send_message").click(function(){
                if(!$("#send_user_name").val() || !$("#send_content").val()){
                    alert('接收人或发送消息不许为空');
                    return;
                }
                debugger;
                var obj = {
                    'receiveUsername'  :$("#send_user_name").val(),
                    'content'          :$("#send_content").val()
                };

                var userId = $("#sendUserId").val();
                if($.notNull(userId)){
                    obj['receiveId'] = userId;
                }
                $.ajax({
                    url: '/bbs/u/messages',
                    type: 'POST',
                    data: obj,
                    dataType: 'json',
                    success: function (resp) {
                        console.log(resp);

                        if($.ajaxSuccess(resp)){
                            ClosePopbox('aiac');
                        }else{
                            alert(resp['msg']);
                        }
                    },
                    error: function(){
                        console.log('error');
                    }
                });

            });

            $(document).on("click", ".btn_reply", function(){
                var id = $(this).parent().attr("data-id");
                var user = $(this).parent().attr("data-user");
                $("#send_user_name").attr("readonly", "readonly");
                $("#send_user_name").val(user);
                $("#sendUserId").val(id);
                OpenPopbox('aiac');
                $("#send_content").focus();
            });

            $(document).on("click", ".btn_del", function(){
                var id = $(this).parent().attr("data-mid");
                if($.notNull(id)){

                    $.ajax({
                        url: '/bbs/u/messages',
                        type: 'POST',
                        data: {
                            "_method":"delete",
                            "id"    :id
                        },
                        dataType: 'json',
                        success: function (resp) {
                            console.log(resp);

                            if($.ajaxSuccess(resp)){
                                alert('删除成功');
                            }else{
                                alert(resp['msg']);
                            }
                        }
                    });
                }
            });

            $(".bbs_mysms_answer_openbtn").click(function(){
                $(this).siblings('.bbs_mysms_answer').css("display", $(this).siblings('.bbs_mysms_answer').is(":hidden") ? "" : "none");
            });
        })
    </script>
</head>
<body>
<%--top模块--%>
<%@ include file="/page/common/top.jsp" %>
<div class="popbox_bg" id="aiac">
    <p class="popbox-title">发送消息<a href="javascript:;" onclick="ClosePopbox('aiac')">X</a></p>
    <div class="invoice" style="padding-left:100px; padding-top:20px;">
        <p class="invoice-content">
            <input type="hidden" id="sendUserId" name="sendUserId" name="userId">
            <input style="border:#CCC 1px solid; width:200px; height:30px; line-height:30px; padding-left:15px; margin-bottom:10px;" type="text" placeholder="请输入用户名" id="send_user_name" />
            <textarea placeholder="请输入留言内容" id="send_content"></textarea>
        </p>
        <p class="invoice-btn" style="padding-left:35px;">
            <a href="javascript:;" id="btn_send_message">发送</a>
            <a href="javascript:;" onclick="ClosePopbox('aiac')">取消</a>
        </p>
    </div>
</div>

<div class="mian_content container">
    <jsp:include page="/page/common/usercenter.jsp"></jsp:include>
    <div class="mumber_right_content">
        <div class="bbs_mysms_title">我的短消息<a href="javascript:;" id="btn_send_new_message"><img src="/images/bbs_post_sms_icon.jpg" /></a></div>
        <div id="messages_container">
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