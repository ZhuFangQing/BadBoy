/**
 * Created by Echos on 2017/1/7.
 */
var COMMENT_LIST_ITEM = "\n" +
    "                <li>\n" +
    "                    <a href=\"javascript:;\"><img src=\"/images/person_img.jpg\" class=\"face\"/></a>\n" +
    "                    <p class=\"nick\" data-id=\"{id}\">{nick}</p>\n" +
    "                    <p>{content}</p>\n" +
    "                    <p>时间: {date} </p>\n" +
    "                    <a class=\"support\" data-id=\"{id}\" {is_support}><span>{support_count}</span></a>\n" +
    "                </li>";

var current_reply_id = null;
$(document).ready(function () {
    var type = $("#articleType").val();
    var mediaUrl = $("#videoUrl").val();
    var pdfUrl = $("#pdfUrl").val();
    var outUrl = $("#outUrl").val();

    //视频
    if(type == 'video' || type =='article-video'){
        var player = new prismplayer({
            id: "J_prismPlayer", // 容器id
            source: mediaUrl,  // 视频url 支持互联网可直接访问的视频地址
            autoplay: false,      // 自动播放
            width: "100%",       // 播放器宽度
            height: "400px"      // 播放器高度
        });
    }else if(type == 'pdf'){
        location.href = "/tools/pdfViewer?pdf=" + (itx+pdfUrl);
    }else if(type == 'url'){
        location.href = outUrl;
    }

    //加载评论
    search();

    //回复
    $(".reply").click(function () {
        current_reply_id = $(this).attr("data-reply-id");
        $("#replyContent").val("#回复：" + $(this).attr("data-reply") + "#");
        $("#replyContent").trigger('change');
        $("#replyContent").focus();
    });

    //点赞
    $(".review-list").on("click", "a.support", function () {

        var obj = {
            'commentId' :$(this).attr("data-id")
        };

        var current = $(this);

        $.ajax({
            url:'/school/supports',
            type:'POST',
            data: obj,
            dataType:'json',
            success:function(resp){
                console.log(resp);
                console.log($(this));
                debugger;
                if($.ajaxSuccess(resp)){

                    var count = parseInt(current.find("span").html());
                    current.find("span").html(++count);
                    current.css("background-image","url(/images/hand_on.jpg)");
                }else{
                    alert(resp['msg']);
                }
            }
        });
    });

    //输入框计数
    $("#replyContent").on("change keyup", function () {
        $("#replyContentNum").html($(this).val().length + "/300");
        if($(this).val().length > 300){
            $(this).val($(this).val().substring(0, 300));
        }
    });

    //发表评论
    $("#btn_submit").click(function () {
        debugger;
        var obj = {
            'articleId' :$("#articleId").val(),
            'content'   :$("#replyContent").val()
        };

        $.ajax({
            url:'/school/comments',
            type:'POST',
            data: obj,
            dataType:'json',
            success:function(resp){
                console.log(resp);
                if($.ajaxSuccess(resp)){
//                            alert('评论成功');

                    var data = {
                        'username'      :$.cookie('I7COLOR_USER_NAME'),
                        'content'       :obj['content'],
                        'createdAt'     :new Date().getTime(),
                        'supportCount'  :'0',
                        'support'       :false,
                        'id'            :resp['data'],
                    };
                    $(".review-list").prepend(setData(data));
                    $(".review-list li:first").fadeOut();
                    $(".review-list li:first").fadeIn();

                    $("#replyContent").val('');
                    $("#replyContent").trigger('change');
                }else{
                    alert(resp['msg']);
                }
            }
        });
    });
});

function search(pageNo, pageSize){

    //PageNo
    if(undefined == pageNo){
        pageNo = 1;
    }

    //PageSize
    if(undefined == pageSize){
        pageSize = 10;
    }

    var obj = {
        'pageNo'	:pageNo,
        'pageSize'	:pageSize,
        'articleId' :$("#articleId").val()
    };

    $.ajax({
        url:'/school/comments_search',
        type:'GET',
        data: obj,
        dataType:'json',
        success:function(resp){
            console.log(resp);
            if($.ajaxSuccess(resp)){
                $(".review-list").empty();

                for(var idx in resp['data']){
                    var data = resp['data'][idx];
                    var item = setData(data);
                    $(".review-list").append(item);
                }

                //更新分页控件
                $("#Pagination").pagination(resp['totalPageSize'], {
                    callback: pageTo,
                    current_page: resp['pageNo'] - 1
                });
            }
        }
    });
}

function pageTo(pageNo){
    pageNo = pageNo + 1;
    search(pageNo);
}

function setData(data){
    console.log(data);

    var item = COMMENT_LIST_ITEM.replace("{nick}", data['username']);

    var content = data['content'];
    if(data['parentUsername'] != null){
        debugger;
        content = "回复：" + data['parentUsername'] + "<br/><span class='reply_comments'>" + content + "</span>";
    }

    item = item.replace("{id}", data['id']);
    item = item.replace("{content}", content);
    item = item.replace("{date}", new Date(data['createdAt']).pattern('yyyy-MM-dd'));
    item = item.replace("{support_count}", data['supportCount']);
    item = item.replace("{id}", data['id']);
    item = item.replace("{is_support}", data['support'] ? "style='background-image:url(/images/hand_on.jpg)'" : "");

    return item;
}