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
    <link href="/css/bbs.css" rel="stylesheet" type="text/css" />
    <script src="/js/bbs.js?t=${now}"></script>
    <script>
        var userId = '${user.userId}';
        var ITEM = "<tr><td><a href=\"/bbs/bbsPost?id={post.id}\">{post.title}<img src=\"/images/crown_icon.png\"></a>{replyList}</td><td>黑色蝙蝠<br>2006-03-02 07:44:40</td><td>25 / 7166</td><td><p>pengjian50<br>2007-03-13 09:25:56</p></td></tr>"

        $(function(){
            if($.notNull(userId)){


                getBbsPostList(1);
            }else{
                alert('用户不存在');
                location.href = "/bbs";
            }

            $("#btn_send_message").click(function () {
                var at = $(this).attr("data-username");
                at = encodeURI(encodeURI(at));
                location.href = "/bbs/u/messages?at=" + at;
            });

            $(".post_span").click(function(){
                $(".post_span").removeClass("onthis");
                $(this).addClass("onthis");
            });
        });

        function getBbsReplyList(pageNo){

            if(!pageNo)
                pageNo=1;
            $.ajax({
                url : '/bbs/userReply',
                type : 'GET',
                dataType : 'json',
                data : {
                    "pageNo" : pageNo,
                    "pageSize" : 10,
                    'createdBy': userId
                },
//                async : false,
                cache : false,
                success : function(resp) {
                    debugger;
                    console.log(resp);

                    if($.ajaxSuccess(resp)){
                        var postReply = {};
                        $(resp['data']).each(function(index,val){
                            if(!postReply[val['post']['id']]){
                                postReply[val['post']['id']] = new Array();
                            }

                            postReply[val['post']['id']].push(val);
                        });

                        console.log(postReply);

                        $("#bbsTable").empty();
                        var keys = {};
                        $(resp['data']).each(function(index,val){
                            var ele = val['post'];
                            if($.notNull(keys[ele['id']])){
                                return;
                            }
                            keys[ele['id']] = true;
                            var bbsTopicName = '';
                            if(ele.bbsTopic){
                                bbsTopicName = !ele.bbsTopic.name ? '' : ('[' + ele.bbsTopic.name + ']');
                            }
                            var replierName = "";
                            var postDate = new Date(ele.createdAt);
                            var lastReplyDate = new Date(ele.lastReplyAt);
                            if(ele.replier){
                                replierName = ele.replier.login_name
                            }
                            var node = '<tr><td><p><a href="/bbs/bbsPost?id='+ele.id+'">' + bbsTopicName
                                + ele.title + ' <img src="/images/crown_icon.png" /></a></p>{replyList}</td>'
                                + '<td>' + ele.poster.login_name + '<br/>'+ postDate.pattern() + '</td>'
                                + '<td>' + ele.replyRate + ' / ' + ele.clickRate + '</td>'
                                + '<td><p>' + replierName + '<br/>' + lastReplyDate.pattern() +
                                '</p></td>';
                            + '</tr>';

                            var replyList = "<ul class='que_list'>";
                            postReply[val['post']['id']].forEach(function(value, index, array){
                                var content = regexpTag(toEmoticon(value['content']));
                                if(content.length > 50){
                                    content = content.substring(0, 50) + "...";
                                }
//                                replyList = replyList + "<li>" + content + "</li>";
                                replyList = replyList + "<li><a href=\"/bbs/findPost?parentId="+ele['id']+"&id=" + val.id + "\" target='_blank'>" + content + "</a></li>";
                            });
                            replyList += "</ul>";
                            node = node.replace('{replyList}', replyList);

                            $("#bbsTable").append(node);
                        });

                        // 更新分页控件
                        $("#Pagination").pagination(resp['totalCount'], {
                            callback: function(pageNo){getBbsReplyList(++pageNo)},
                            current_page: pageNo-1
                        });
                    }

                }
                ,error : function(XMLHttpRequest, textStatus, errorThrown) {
                    alert(XMLHttpRequest.status);
                    alert(XMLHttpRequest.readyState);
                    alert(textStatus);
                }
            });
        }


        function getBbsPostList(pageNo){
            if(!pageNo)
                pageNo=1;
            $.ajax({
                url : '/bbs/getBbsPostList',
                type : 'POST',
                dataType : 'json',
                data : {
                    "pageNo" : pageNo,
                    "pageSize" : 10,
                    'createdBy': userId
                },
                async : false,
                cache : false,
                success : function(result) {
                    debugger;
                    var totalPage = result.totalCount;
                    $("#bbsTable").empty();
                    $(result.data).each(function(index,ele){
                        var bbsTopicName = '';
                        if(ele.bbsTopic){
                            bbsTopicName = !ele.bbsTopic.name ? '' : ('[' + ele.bbsTopic.name + ']');

                        }

                        var replierName = "";
                        var postDate = new Date(ele.createdAt);
                        var lastReplyDate = new Date(ele.lastReplyAt);
                        if(ele.replier){
                            replierName = ele.replier.login_name
                        }
                        var node = '<tr><td><a href="/bbs/bbsPost?id='+ele.id+'">' + bbsTopicName
                            + ele.title + ' <img src="/images/crown_icon.png" /></a></td>'
                            + '<td>' + ele.poster.login_name + '<br/>'+ postDate.pattern() + '</td>'
                            + '<td>' + ele.replyRate + ' / ' + ele.clickRate + '</td>'
                            + '<td><p>' + replierName + '<br/>' + lastReplyDate.pattern() +
                            '</p></td>';
                        + '</tr>';

                        $("#bbsTable").append(node);
                    });
                    // 更新分页控件
                    $("#Pagination").pagination(totalPage, {
                        callback: getBbsPostListByPage,
                        current_page: pageNo-1
                    });

                },
                error : function(XMLHttpRequest, textStatus, errorThrown) {
                    alert(XMLHttpRequest.status);
                    alert(XMLHttpRequest.readyState);
                    alert(textStatus);
                }
            });
        }


        function getBbsPostListByPage(pageNo){
//		 alert(pageNo);
            getBbsPostList(pageNo+1);
        }
    </script>
</head>
<body>
<%--top模块--%>
<%@ include file="/page/common/top.jsp" %>
<div class="container">
    <jsp:include page="/page/bbs/common/bbs_search_box.jsp"></jsp:include>
    <p class="business-title">
        <span><a href="/">首页</a></span> &gt; <span><a href="/bbs">七彩云论坛</a></span>
    </p>
    <div class="bbs_user_infobox">
        <div class="bbs_user_infotext">
            <div class="bbs_user_imgbox"><img src="${itx}${user.picUrl}" width="48" height="48" /></div>
            <h1>${user.username}<a href="javascript:;" id="btn_send_message" data-username="${user.username}"><img src="/images/sms_icon.jpg" />发短消息</a></h1>
            <p><span>${user.levelName}</span><span>发帖数：${user.postCount}</span><span>最后访问：${user.lastLoginDate}</span></p>
        </div>
        <%--<a class="user_index" href="#">http://www.cnbeta.com/articles/570179.htm</a>--%>
    </div>

    <table class="bbs_table" cellpadding="0" cellspacing="0" width="100%">
        <thead>
        <tr>
            <th width="900">
                <a href="javascript:getBbsPostList();"><span  class="post_span onthis">帖子</span></a>
                <a href="javascript:getBbsReplyList();"><span class="post_span">回复</span></a>
            </th>
            <th width="120"><img src="/images/author_icon.png" />作者</th>
            <th width="120"><img src="/images/check_icon.png" />回复/查看</th>
            <th width="120"><img src="/images/publish_icon.png" />最后发表</th>
        </tr>
        </thead>
        <tbody id="bbsTable">
        </tbody>
    </table>

    <div class="business-pages bbs">
        <jsp:include page="/page/common/pagination.jsp"></jsp:include>
    </div>
</div>
<%@ include file="/page/common/foot.jsp" %>

<script language="javascript" type="text/javascript">
    var theTab1_box = new Array('all_essence','bbs_info','bbs_product','bbs_dyeing','bbs_life','bss_other');
    var theTab1 = new AlexTab2('tab01',theTab1_box);
    theTab1;
</script>
</body>
</html>