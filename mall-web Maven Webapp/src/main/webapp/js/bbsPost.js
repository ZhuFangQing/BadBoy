var bbsLevel;
var replyId;
var lastPage;
var posterId;
//编辑器对象
var ue;
$(function () {
    initBbsLevelList();
    getBbsReplyList(1);
    $('#replyBtn').click(function () {
        reply();
    });

    if (isLogin()) {
        ue = UE.getEditor('content', {
            autoHeight: false,
            toolbars: [
                ['undo', 'redo', 'simpleupload']
            ]
        });

        // 编辑器初始化
        // $("#content").summernote({
        //     lang: "zh-CN",
        //     height: 190,
        //     maxHeight: 190,
        //     minHeight: 190,
        //     placeholder : '请输入回帖内容',
        //     toolbar: [
        //         ['insert', ['picture']]
        //     ],
        //     callbacks: {
        //         onImageUpload: function (files) { // the onImageUpload API
        //             img = uploadImg(files[0]);
        //         }
        //     }
        // });
        $('.bbs_content_loginbox').hide();
    }
});

// //正文图片上传
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

function toReply(id, toReplierFloor, toReplierName) {
    if (!isLogin()) {
        alert('请先登录');
        return;
    }
    replyId = id;

    var text = '回复 #' + toReplierFloor + toReplierName + '的帖子'
    $("#replyTitle").val(text);

    location.href = "#replyDiv";
    ue.focus();
}

function reply() {
    if (!codeValidate(ue.getContentTxt())) {
        alert('含非法字符');
        return;
    }
    if (!isLogin()) {
        reutrn;
    }

    if (isSilence()) {
        alert("您已被禁言，请与管理员联系");
        return;
    }

    var title = $("#replyTitle").val();
    var content = ue.getContent();
    var parentId = $("#postId").val();
    var sectionId = $("#sectionId").val();
    if (!content) {
        alert("请输入回帖内容");
        return;
    }
    if (!parentId) {
        alert("非法请求");
        return;
    }

    $.ajax({
        url: '/bbs/reply',
        type: 'POST',
        dataType: 'json',
        data: {
            "title": title,
            "content": content,
            "parentId": parentId,
            "replyId": replyId,
            "sectionId": sectionId
        },
        async: false,
        cache: false,
        success: function (result) {
            if (result) {
                alert("发送成功");

                $("#replyTitle").val('');
                ue.setContent('');
                replyId = undefined;

                getBbsReplyList(lastPage);
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

function initBbsLevelList() {
    $.ajax({
        url: '/bbs/getBbsLevelList',
        type: 'POST',
        dataType: 'json',
        async: false,
        cache: false,
        success: function (result) {
            bbsLevel = result;
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert(XMLHttpRequest.status);
            alert(XMLHttpRequest.readyState);
            alert(textStatus);
        }
    });
}

function getLevel(point) {
    var level;
    for (l in bbsLevel) {
        if (point <= bbsLevel[l].lowerLimit) {
            level = bbsLevel[(l == 0 ? l : l - 1)].name;
            break;
        }
    }

    return level || bbsLevel[bbsLevel.length - 1].name;
}

function onlyPoster(id) {
    if (posterId) {
        posterId = undefined;
    } else {
        posterId = id;
    }
    getBbsReplyList(1);
}

function collect(postId) {
    if (isLogin()) {
        $.ajax({
            url: '/bbs/collectBbsPost',
            type: 'POST',
            dataType: 'json',
            data: {
                postId: postId
            },
            async: false,
            cache: false,
            success: function (result) {
                if (result) {
                    alert("收藏成功");
                } else {
                    alert("收藏失败，请稍候重试");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(XMLHttpRequest.status);
                alert(XMLHttpRequest.readyState);
                alert(textStatus);
            }
        });
    } else {
        alert('请先登录');
    }
}

function sendMsg(loginName) {
    if (isLogin()) {
        window.location.href = encodeURI(encodeURI('/bbs/u/messages?at=' + loginName));
    } else {
        alert('请先登录');
    }
}


function getBbsReplyList(pageNo) {
    if (!pageNo)
        pageNo = 1;
    $.ajax({
        url: '/bbs/getBbsReplyList',
        type: 'POST',
        dataType: 'json',
        data: {
            "parentId": $("#postId").val(),
            "pageNo": pageNo,
            "pageSize": 20,
            "createdBy": posterId
        },
        async: false,
        cache: false,
        success: function (result) {
            var floor = (pageNo - 1) * 20;

            $("html,body").scrollTop(0);
            var totalPage = result.totalCount;
            $(".bbs_post_detil").remove();
            $(result.data).each(function (index, ele) {
                var levelText = getLevel(Number(ele.replier.bbsPoint));
                var toReplierNode = "";
                var attachNode = "";
                if (ele.replyId && ele.toReply) {
                    toReplierNode = '<div class="bbs_respon_box">' +
                        '<em class="left_quotes"><img src="/images/quotes_left_icon.png" /></em>' +
                        '<em class="right_quotes"><img src="/images/quotes_right_icon.png" /></em>' +
                        '<h1><span>' + ele.toReply.replier.real_name + '</span> 发表于 <span>' + new Date(ele.toReply.createdAt).pattern() + '</span></h1>' +
                        ele.toReply.content +
                        '</div>';
                }
                for (var i in ele.bbsAttachList) {
                    var attach = ele.bbsAttachList[i];
                    if (i == 0) {
                        attachNode += '<b>附件：</b>';
                    }
                    attachNode += '<a href="' + itx + attach.url + '" target="_blank">' + attach.filename + '</a>&nbsp;&nbsp;';
                }

                var node = '<div class="bbs_post_detil" id="rid' + ele.id + '">' +
                    '<div class="bbs_post_leftbox">' +
                    '<div class="post_user_name"><a href="/bbs/users/' + ele.replier.id + '">' + ele.replier.real_name + '</a></div>' +
                    '<div class="post_user_img"><img src="' + (itx + ele.replier.bbsProfilePhoto) + '" width="120" height="120" /></div>' +
                    '<div class="post_user_info"><span>' + ele.replier.bbsPostCount + '</span>主题</div>' +
                    '<div class="post_user_info"><span>' + ele.replier.bbsPoint + '</span>积分</div>' +
                    '<p>' + levelText + '</p>' +
                    '<p><img src="/images/sms_icon.jpg" /><a href="javascript:sendMsg(\'' + ele.replier.login_name + '\')">发短消息</a></p>' +
                    '</div>' +
                    '<div class="bbs_post_rightbox">' +
                    '<div class="bbs_poster_box">' +
                    '<img src="/images/bbs_poster_icon.png" /><span>发表于 ' + new Date(ele.createdAt).pattern() + '</span>';
                if (ele.isMain == '1') {
                    node += '<a href="javascript:onlyPoster(' + ele.replier.id + ')" id="onlyPoster">' + (posterId ? '取消' : '') + '只看楼主</a>' +
                        '<em>' + ++floor + '#</em><em>楼主</em><em><a href="javascript:collect(' + ele.id + ')">收藏</a></em>';
                } else {
                    node += '<em>' + ++floor + '#</em>'
                }
                node += '</div>' +
                    '<div class="bbs_post_content">' +
                    toReplierNode +
                    '<p><b>' + (ele.title || '') + '</b></p>' +
                    '<p>' + regexpTag(toEmoticon(ele.content)) + '<p>' +
                    '<div>' +
                    attachNode +
                    '</div>' +
                    '</div>' +

                    '<div class="bbs_answer_box">' +
                    '<img src="/images/bbs_answer_icon.png" /><a href="javascript:toReply(' + ele.id + ',' + floor + ',\'' + ele.replier.real_name + '\')">回复</a>' +
                    '</div>' +
                    '</div>' +
                    '</div>';

                $('#bbsPostDetail').append(node);
            });

            lastPage = totalPage;
            // 更新分页控件
            $("#Pagination").pagination(totalPage, {
                callback: getBbsReplyListByPage,
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

function getBbsReplyListByPage(pageNo) {
    getBbsReplyList(pageNo + 1);
}