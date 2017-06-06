var bbsLevel;
var replyId;
var lastPage;
var posterId;
var currentlyPage;
var replyList;
//编辑器对象
var ue;
var updateReplyUe;

$(function () {
    initBbsLevelList();
    getBbsReplyList(1);
    $('#replyBtn').click(function () {
        reply();
    });
    if (isLogin()) {
        // 编辑器初始化
        ue = UE.getEditor('content',{
            autoHeight: false,
            toolbars: [
                [ 'undo', 'redo', 'simpleupload']
            ]
        });

        updateReplyUe = UE.getEditor('replyContent',{
            autoHeight: false,
            toolbars: [
                [ 'undo', 'redo', 'simpleupload']
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

function toReply(id, toReplierFloor, toReplierName) {
    replyId = id;

    var text = '回复 #' + toReplierFloor + toReplierName + '的帖子'
    $("#replyTitle").val(text);

    location.href = "#replyDiv";
    ue.focus();
}

function reply() {
    if(!codeValidate(ue.getContentTxt())){
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


function auditing(ret, poster) {

    $.ajax({
        url: '/bbs/audtingBbsPost',
        type: 'POST',
        dataType: 'json',
        data: {
            "id": $('#postId').val(),
            "sectionId": $('#sectionId').val(),
            "createdBy": poster,
            "status": ret
        },
        async: false,
        cache: false,
        success: function (result) {
            if (result) {
                var text = ret == 2 ? '操作成功，此贴通过审核' : '操作成功，此贴未通过审核';
                alert(text);
                location.href = '/bbs/bbsSection?id='+$('#sectionId').val();
            } else {
                alert("审核失败，请稍候重试");
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert(XMLHttpRequest.status);
            alert(XMLHttpRequest.readyState);
            alert(textStatus);
        }
    });

    $('#auditingModal').modal('hide');
}

function auditingAlert() {
    $('#auditingModal').modal('toggle');
}

function delPost(id, poster) {
    if (confirm('确认删除吗？')) {
        $.ajax({
            url: '/bbs/deleteBbsPost',
            type: 'POST',
            dataType: 'json',
            data: {
                "id": id,
                "sectionId": $('#sectionId').val(),
                "createdBy": poster,
                "isDeduct": confirm('是否扣除此用户积分')
            },
            async: false,
            cache: false,
            success: function (result) {
                if (result) {
                    alert("删除成功");
                    location.href = '/bbs/bbsSection?id='+$('#sectionId').val();
                } else {
                    alert("删除失败，请稍候重试");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(XMLHttpRequest.status);
                alert(XMLHttpRequest.readyState);
                alert(textStatus);
            }
        });
    }
}

function delReply(replyId) {
    if (confirm('确认删除吗？')) {
        var parameter = {
            "id": replyId,
            "isValid": 0
        };

        setBbsReply(parameter);
        getBbsReplyList(currentlyPage);
    }
}

function silenceUser(id, status, obj) {
    var alertText;
    if (status == 1) {
        status = 0;
        alertText = '确认禁言此用户吗?';
    } else {
        status = 1;
        alertText = '确认取消此用户禁言状态吗';
    }

    if (confirm(alertText)) {
        var parameter = {
            "id": id,
            "bbsStatus": status
        };

        $.ajax({
            url: '/bbs/updateBbsUser',
            type: 'POST',
            dataType: 'json',
            data: parameter,
            async: false,
            cache: false,
            success: function (result) {
                if (result) {
                    alert("操作成功");
                    location.reload();
                } else {
                    alert("操作失败，请稍候重试");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(XMLHttpRequest.status);
                alert(XMLHttpRequest.readyState);
                alert(textStatus);
            }
        });


    }
}

function setBbsReply(bbsReplyParameter) {
    $.ajax({
        url: '/bbs/updateBbsReply',
        type: 'POST',
        dataType: 'json',
        data: bbsReplyParameter,
        async: false,
        cache: false,
        success: function (result) {
            if (result) {
                alert("操作成功");
            } else {
                alert("操作失败，请稍候重试");
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert(XMLHttpRequest.status);
            alert(XMLHttpRequest.readyState);
            alert(textStatus);
        }
    });
}

function setBbsPost(bbsPostParameter) {
    $.ajax({
        url: '/bbs/updateBbsPost',
        type: 'POST',
        dataType: 'json',
        data: bbsPostParameter,
        async: false,
        cache: false,
        success: function (result) {
            if (result) {
                alert("操作成功");
            } else {
                alert("操作失败，请稍候重试");
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert(XMLHttpRequest.status);
            alert(XMLHttpRequest.readyState);
            alert(textStatus);
        }
    });
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

function splitReplyModal(replyId, title) {
    if (confirm("确定拆分此贴吗？")) {
        $('#splitReplyId').val(replyId || '');
        $('#splitReplyTitle').val(title || '');

        $('#splitReplyModal').modal('show');
    }
}

function splitReply() {
    if (!$('#splitReplyTitle').val()) {
        alert('请输入标题');
        return;
    }

    var reply = getReplyById($('#splitReplyId').val());
    reply['title'] = $('#splitReplyTitle').val();
    reply['sectionId'] = $('#sectionId').val();
    reply['replier'] = undefined;
    console.log(JSON.stringify(reply));
    $.ajax({
        url: '/bbs/splitBbsReply',
        type: 'POST',
        dataType: 'json',
        data: reply,
        async: false,
        cache: false,
        success: function (result) {
            if (result) {
                alert("拆贴成功");
                getBbsReplyList(lastPage);
                $('#splitReplyModal').modal('hide');
            } else {
                alert("拆贴失败，请稍候重试");
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert(XMLHttpRequest.status);
            alert(XMLHttpRequest.readyState);
            alert(textStatus);
        }
    });
}
function getReplyById(replyId) {
    for (var i in replyList) {
        if (replyList[i].id == replyId) {
            return replyList[i];
        }
    }
    return null;
}

function editReply(id) {
    var reply = getReplyById(id);
    $('#replyIdEdit').val(id);
    $('#replyTitleEdit').val(reply.title);
    updateReplyUe.setContent('');

    $('#replyEditModal').modal('toggle');
}

function saveReply() {
    if(!codeValidate(updateReplyUe.getContentTxt())){
        alert('含非法字符');
        return;
    }
    $.ajax({
        url: '/bbs/updateBbsReply',
        type: 'POST',
        dataType: 'json',
        data: {
            id: $('#replyIdEdit').val(),
            title: $('#replyTitleEdit').val(),
            content: updateReplyUe.getContent()
        },
        async: false,
        cache: false,
        success: function (result) {
            if (result) {
                alert("修改成功");
                location.reload();
            } else {
                alert("修改失败，请稍候重试");
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert(XMLHttpRequest.status);
            alert(XMLHttpRequest.readyState);
            alert(textStatus);
        }
    });
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
            currentlyPage = pageNo;

            var floor = (pageNo - 1) * 20;

            $("html,body").scrollTop(0);
            var totalPage = result.totalCount;
            $(".bbs_post_detil").remove();
            replyList = result.data;

            $(result.data).each(function (index, ele) {
                var levelText = getLevel(ele.replier.bbsPoint);
                var toReplierNode = "";
                var manageNode = "";
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

                var node = '<div class="bbs_post_detil" id="' + ele.id + '">' +
                    '<div class="bbs_post_leftbox">' +
                    '<div class="post_user_name"><a href="/bbs/users/' + ele.replier.id + '">' + ele.replier.real_name + '</a></div>' +
                    '<div class="post_user_img"><img src="' + (itx + ele.replier.bbsProfilePhoto) + '" width="120" height="120" /></div>' +
                    '<div class="post_user_info"><span>' + ele.replier.bbsPostCount + '</span>主题</div>' +
                    '<div class="post_user_info"><span>' + ele.replier.bbsPoint + '</span>积分</div>' +
                    '<p>' + levelText + '</p>' +
                    '<p><img src="/images/sms_icon.jpg" /><a href="' + encodeURI(encodeURI('/bbs/u/messages?at=' + ele.replier.login_name)) + '">发短消息</a></p>' +
                    '</div>' +
                    '<div class="bbs_post_rightbox">' +
                    '<div class="bbs_poster_box">' +
                    '<img src="/images/bbs_poster_icon.png" /><span>发表于 ' + new Date(ele.createdAt).pattern() + '</span>';
                if (ele.isMain == '1') {
                    $('#bbsPostTitle').text(ele.title);
                    node += '<a href="javascript:onlyPoster(' + ele.replier.id + ')" id="onlyPoster">' + (posterId ? '取消' : '') + '只看楼主</a>' +
                        '<em>' + ++floor + '#</em><em>楼主</em><em><a href="javascript:collect(' + ele.id + ')">收藏</a></em>';
                    manageNode = '<input type="button" value="审核" onClick="auditingAlert()"/>' +
                        '<input type="button" value="删除此贴" onClick="delPost(' + $('#postId').val() + ',' + ele.createdBy + ')"/>' +
                        '<input type="button" value="' + (ele.replier.bbsStatus == 1 ? '禁言' : '解禁') + '此贴用户" onClick="silenceUser(' + ele.replier.id + ',' + ele.replier.bbsStatus + ',this)"/>' +
                        '<input type="button" value="编辑" onClick="editReply(' + ele.id + ')"/>';

                } else {
                    node += '<em>' + ++floor + '#</em>';
                    manageNode = '<input type="button" value="删除此贴" onClick="delReply(' + ele.id + ')"/>' +
                        '<input type="button" value="' + (ele.replier.bbsStatus == 1 ? '禁言' : '解禁') + '此贴用户" onClick="silenceUser(' + ele.replier.id + ',' + ele.replier.bbsStatus + ')"/>' +
                        '<input type="button" value="拆分此贴" onclick="splitReplyModal(' + ele.id + ',\'' + (ele.title || '') + '\')"/>' +
                        '<input type="button" value="编辑" onClick="editReply(' + ele.id + ')"/>';
                }
                node += '</div>' +
                    '<div class="bbs_post_content">' +
                    toReplierNode +
                    (ele.isMain != '1' ? '<p><b>' + (ele.title || '') + '</b></p>' : '') +
                    '<p>' + regexpTag(toEmoticon(ele.content)) + '<p>' +
                    '</div>' +
                    '<div>' +
                    attachNode +
                    '</div>' +
                    '<div class="bbs_answer_box">' +
                    '<img src="/images/bbs_answer_icon.png" /><a href="javascript:toReply(' + ele.id + ',' + floor + ',\'' + ele.replier.real_name + '\')">回复</a>' +
                    manageNode +
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