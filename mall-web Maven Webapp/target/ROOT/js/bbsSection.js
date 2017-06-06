var isEssence;
var isHot;
var collectionUserId;
var topic;
var userId;
var title;
//编辑器对象
var ue;

$(function () {
    getBbsPostList(1);

    $("#postBtn").click(function () {
        post();
    });
    if (isLogin()) {
            // 编辑器初始化
            ue = UE.getEditor('content', {
                autoHeight: false,
                toolbars: [
                    ['undo', 'redo', 'simpleupload']
                ]
            });
        $('.bbs_content_loginbox').hide();
    }

});

//正文图片上传
// function uploadImg(file) {
//     data = new FormData();
//     data.append("file", file);
//     $.ajax({
//         data: data,
//         type: "POST",
//         url: '/bbs/uploadContentImg',
//         cache: false,
//         contentType: false,
//         processData: false,
//         success: function (data) {
//             console.log(JSON.stringify(data));
//             $("#content").summernote('insertImage', itx + data.url, 'image name');
//         },
//         error: function (XMLHttpRequest, textStatus, errorThrown) {
//             alert(XMLHttpRequest.status);
//             alert(XMLHttpRequest.readyState);
//             alert(textStatus);
//         }
//     });
// }

function post() {
    if(!codeValidate(ue.getContentTxt())){
        alert('含非法字符');
        return;
    }
    if(!isLogin()) {
        alert('请先登录');
        return;
    }
    if (isSilence()) {
        alert("您已被禁言，请与管理员联系");
        return;
    }
    var topicId = $("#bbs_type_select").val();
    var title = $("#postTitle").val();
    var content = ue.getContent();
    var sectionId = $("#sectionId").val();

    if (!title) {
        alert("请输入标题");
        return;
    }
    if (!content) {
        alert("请输入正文");
        return;
    }
    if (!sectionId) {
        alert("非法请求");
        return;
    }
    console.log(sectionId, topicId, title, content);

    $.ajax({
        url: '/bbs/post',
        type: 'POST',
        dataType: 'json',
        data: {
            "topicId": topicId,
            "title": title,
            "content": content,
            "sectionId": sectionId
        },
        async: false,
        cache: false,
        success: function (result) {
            console.log(result);
            if (result) {
                alert("发送成功，请等待审核");
                location.reload();
            } else {
                alert("发送失败，请稍候重试");
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert(XMLHttpRequest.status);
            alert(XMLHttpRequest.readyState);
            alert(textStatus);
        }
    });


}
function bbsPostTab(tab) {
    if (tab == 'all') {
        isHot = undefined;
        isEssence = undefined;
        getBbsPostList(1);
        $('.postTab span').attr('class', '');
        $("#allSpan").attr("class", "onthis");
    } else if (tab == 'hot') {
        isHot = 1;
        isEssence = undefined;
        getBbsPostList(1);
        $('.postTab span').attr('class', '');
        $("#hotSpan").attr("class", "onthis");
    }
    if (tab == 'essence') {
        isHot = undefined;
        collectionUserId = undefined;
        isEssence = 1;
        getBbsPostList(1);
        $('.postTab span').attr('class', '');
        $("#essenceSpan").attr("class", "onthis");
    }
    if (tab == 'collection') {
        isHot = undefined;
        isEssence = undefined;
        collectionUserId = userId;
        getBbsPostList(1);
        $('.postTab span').attr('class', '');
        $("#collectionSpan").attr("class", "onthis");
    }
}

function getEssenceBbsPost() {
    isHot = undefined;
    isEssence = 1;
    getBbsPostList(1);
    $("#hotSpan").attr("class", "");
    $("#allSpan").attr("class", "");
    $("#essenceSpan").attr("class", "onthis");
}

function getBbsPostByTopic(topicId, obj) {
    topic = topicId;
    $("#typeUl li").attr("class", "");
    $(obj).attr("class", "onthis");
    getBbsPostList(1);
}

function getBbsPostList(pageNo) {
    if (!pageNo) {
        pageNo = 1;
    }
    var parameter = {
        "sectionId": $.notNull($("#sectionId").val()) ? $("#sectionId").val() : "",
        "pageNo": pageNo,
        "pageSize": 10,
        "isEssence": isEssence,
        "isHot": isHot,
        "collectionUserId": collectionUserId,
        "topicId": topic,
        "status": 2
    };

    if ($.notNull(userId) && $.isNull(collectionUserId)) {
        parameter['createdBy'] = userId;
    }
    if ($.notNull(title)) {
        parameter['title'] = title;
    }
    $.ajax({
        url: '/bbs/getBbsPostList',
        type: 'POST',
        dataType: 'json',
        data: parameter,
        async: false,
        cache: false,
        success: function (result) {
            var totalPage = result.totalCount;
            $("#bbsTable").empty();
            $(result.data).each(function (index, ele) {
                var bbsTopicName = '';
                if (ele.bbsTopic) {
                    bbsTopicName = !ele.bbsTopic.name ? '' : ('[' + ele.bbsTopic.name + ']');

                }

                var replierName = "";
                var postDate = new Date(ele.createdAt);
                var lastReplyDate = new Date(ele.lastReplyAt);
                if (ele.replier) {
                    replierName = ele.replier.login_name
                }
                var node = '<tr><td><p><a href="/bbs/bbsPost?id=' + ele.id + '">' + bbsTopicName
                    + ele.title + '</a>'
                    + (ele.isTop == 1 ? '<img class="zd" src="/images/zd.png" width="20" />' : '')
                    + (ele.isHot == 1 ? '<img class="hot_icon" src="/images/hot_icon.png" width="20" />' : '')
                    + (ele.isEssence == 1 ? '<img src="/images/crown_icon.png">' : '')
                    + '</p></td>'
                    + '<td>' + ele.poster.login_name + '<br/>' + new Date(postDate).pattern('yyyy-MM-dd') + '</td>'
                    + '<td>' + ele.replyRate + ' / ' + ele.clickRate + '</td>'
                    + '<td><p>' + replierName + '<br/>' + new Date(lastReplyDate).pattern('yyyy-MM-dd') +
                    '</p></td>';
                +'</tr>';

                $("#bbsTable").append(node);

            });
            // 更新分页控件
            $("#Pagination").pagination(totalPage, {
                callback: getBbsPostListByPage,
                current_page: pageNo - 1
            });

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert(XMLHttpRequest.status);
            alert(XMLHttpRequest.readyState);
            alert(textStatus);
        }
    });
}


function getBbsPostListByPage(pageNo) {
    getBbsPostList(pageNo + 1);
}
