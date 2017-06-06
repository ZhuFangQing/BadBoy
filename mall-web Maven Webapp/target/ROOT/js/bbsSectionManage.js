var isEssence;
var isHot;
var topic;
var status = 2;
var bbsPostParameter = new Object();
//编辑器对象
var ue;

$(function () {
    $.fn.editable.defaults.mode = 'inline';
    $('.bbsEditable').editable({
        type: 'text',
        validate: function(value){
            if($.trim(value) == '') {
                return '不许为空';
            }
        },
        url: '/bbs/updateBbsTopic',
        params : function(params){
            var tmp = {
                id : params.pk,
                name : params.value
            }
            return tmp;
        },
        success : function(result){
            if(result){
                alert('修改成功');
            }else{
                alert('修改失败，请稍后重试');
            }
        }
    });

    getBbsPostList(1);

    $("#postBtn").click(function () {
        post();
    });
    if(isLogin()) {
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

function delBbsPostByTopic(id){
    if(confirm("是否确定删除？")){
        $.ajax({
            url: '/bbs/deleteBbsTopic',
            type: 'POST',
            dataType: 'json',
            data: {
                "id": id
            },
            async: false,
            cache: false,
            success: function (result) {
                if (result) {
                    alert("删除成功");
                    location.reload();
                } else {
                    alert("删除失败");
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

function addBbsTopic(){
    var name = prompt("请输入版块主题名");
    if(name){
        $.ajax({
            url: '/bbs/addBbsTopic',
            type: 'POST',
            dataType: 'json',
            data: {
                "sectionId" : $('#sectionId').val(),
                "name" : name
            },
            async: false,
            cache: false,
            success: function (result) {
                if (result) {
                    location.reload();
                } else {
                    alert("添加失败，请稍候重试");
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
    if (!codeValidate(ue.getContentTxt())) {
        alert('含非法字符');
        return;
    }
    if(!isLogin()) {
        alert('请先登录');
        return;
    }
    if(isSilence()){
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
function getBbsPostByTopic(topicId, obj) {
    topic = topicId;
    $("#typeUl li").attr("class", "");
    $(obj).attr("class", "onthis");
    getBbsPostList(1);
}

function bbsPostTab(tab) {
    var spanId;
    if (tab == 'all') {
        isHot = undefined;
        isEssence = undefined;
        status = 2;
        spanId = "allSpan";
    } else if (tab == 'hot') {
        isHot = 1;
        isEssence = undefined;
        status = 2;
        spanId = "hotSpan";
    } else if (tab == 'essence') {
        isHot = undefined;
        isEssence = 1;
        status = 2;
        spanId = "essenceSpan";
    } else if (tab == 'hasNoAuditing') {
        isHot = undefined;
        isEssence = undefined;
        status = 0;
        spanId = "hasNoAuditingSpan";
    } else if (tab == 'noAuditing') {
        isHot = undefined;
        isEssence = undefined;
        status = 1;
        spanId = "noAuditingSpan";
    }

    getBbsPostList(1);
    $('.postTab span').attr('class', '');
    $("#" + spanId).attr("class", "onthis");
}

function recommendPost(recType, postId, status,poster) {
    var operationText = '';
    // status = (status == 0 ? 1 : 0);
    if(status == 0){
        status = 1;
    }else{
        operationText += "取消";
        status = 0;
    }

    if (recType == 'top') {
        bbsPostParameter['isTop'] = status;
        operationText += '置顶';
    } else if (recType == 'hot') {
        bbsPostParameter['isHot'] = status;
        operationText += '推荐';
    } else if (recType == 'essence') {
        bbsPostParameter['isEssence'] = status;
        bbsPostParameter['createdBy'] = poster;
        bbsPostParameter['sectionId'] = $('#sectionId').val();
        operationText += '加精';
    } else {
        return;
    }


    if (confirm('确认' + operationText + '此贴吗?')) {
        bbsPostParameter['id'] = postId;
        setBbsPost();
        location.reload();
    }
    bbsPostParameter = new Object();
}

function setBbsSectionPointRule() {
    if (confirm('确认修改吗?')) {
        if(!$("#postPoint").val() || !$("#replyPoint").val() || !$("#essencePoint").val()){
            alert('不允许小于零');
            return;
        }
        if($("#postPoint").val() < 0 || $("#replyPoint").val() < 0 || $("#essencePoint").val() < 0 ){
            alert('不允许小于零');
            return;
        }
        $.ajax({
            url: '/bbs/updateBbsSection',
            type: 'POST',
            dataType: 'json',
            data: {
                "id": $("#sectionId").val(),
                "postPoint": $("#postPoint").val(),
                "replyPoint": $("#replyPoint").val(),
                "essencePoint": $("#essencePoint").val()
            },
            async: false,
            cache: false,
            success: function (result) {
                console.log(result);
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
function setBbsPost() {
    $.ajax({
        url: '/bbs/updateBbsPost',
        type: 'POST',
        dataType: 'json',
        data: bbsPostParameter,
        async: false,
        cache: false,
        success: function (result) {
            console.log(result);
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
function getBbsPostList(pageNo) {
    if (!pageNo)
        pageNo = 1;
    $.ajax({
        url: '/bbs/getBbsPostList',
        type: 'POST',
        dataType: 'json',
        data: {
            "sectionId": $("#sectionId").val(),
            "pageNo": pageNo,
            "pageSize": 10,
            "isEssence": isEssence,
            "isHot": isHot,
            "topicId": topic,
            "status": status
        },
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
                var node = '<tr><td><p class="admin"><a href="/bbs/bbsPost?id=' + ele.id + '">' + bbsTopicName
                    + ele.title + '</a>'
                    + (ele.isTop == 1 ? '<img class="zd" src="/images/zd.png" width="20" />' : '')
                    + (ele.isHot == 1 ? '<img class="hot_icon" src="/images/hot_icon.png" width="20" />' : '')
                    + (ele.isEssence == 1 ? '<img src="/images/crown_icon.png">' : '')
                    + '<input type="button" value="' + (ele.isTop == 0 ? '置顶' : '取消置顶') + '" onClick="recommendPost(\'top\',' + ele.id + ',' + ele.isTop + ')" />'
                    + '<input type="button" value="' + (ele.isHot == 0 ? '热门' : '取消热门') + '" onClick="recommendPost(\'hot\',' + ele.id + ',' + ele.isHot + ')" />'
                    + '<input type="button" value=" ' + (ele.isEssence == 0 ? '加精' : '取消加精') + '" onClick="recommendPost(\'essence\',' + ele.id + ',' + ele.isEssence + ','+ele.createdBy + ')" />'

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
//		 alert(pageNo);
    getBbsPostList(pageNo + 1);
}
