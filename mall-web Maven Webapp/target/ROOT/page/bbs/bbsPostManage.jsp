<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>七彩云</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="/css/bootstrap.css" rel="stylesheet">
    <%@include file="../common/resource.jsp" %>


    <link href="/css/bbsPagination.css" rel="stylesheet" type="text/css"/>

    <script src="/js/bbs.js?t=${now}"></script>

    <script src="/js/lib/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <script type="text/javascript" src="/js/lib/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="/js/lib/ueditor/ueditor.all.js"></script>
    <script type="text/javascript" src="/js/lib/ueditor/lang/zh-cn/zh-cn.js"></script>

    <script language="javascript" type="text/javascript"
            src="/js/bbsPostManage.js"></script>
    <link href="/css/bbs.css" rel="stylesheet" type="text/css"/>
    <style>
        .bbs_post_detil table tr td {
            border: 1px #333 solid;
        }

        .bbs_post_detil td {
            height: 3px;
            padding: 2px;
        }
    </style>

</head>
<body>
<%--top模块--%>
<%@ include file="../common/top.jsp" %>

<div class="container">
    <jsp:include page="/page/bbs/common/bbs_search_box.jsp"></jsp:include>
    <p class="business-title">
        <span><a href="/">首页</a></span> &gt; <span><a href="/bbs">七彩云论坛（染者无疆）</a></span>
        &gt; <span><a href="/bbs/bbsSection?id=${bbsSection.id}">${bbsSection.name}</a></span>
    </p>
    <div class="bbs_post_title">
        <div class="bbs_post_leftbox">
            查看: <span>${bbsPost.clickRate}</span> | 回复: <span>${bbsPost.replyRate }</span>
        </div>
        <div class="bbs_post_rightbox">
            <h1 id="bbsPostTitle">${bbsPost.title }</h1>
        </div>
    </div>
    <div id="bbsPostDetail"></div>

    <div class="business-pages container">
        <jsp:include page="/page/common/pagination.jsp"></jsp:include>
    </div>
    <div class="bbs_quick_postbox" id="replyDiv">
        <h1>
            <img src="/images/quickpost_icon.gif"/>回帖
        </h1>
        <div class="bbs_quick_titlebox">

            <div class="bbs_quick_title">
                <input id="replyTitle" type="text" maxlength="80"
                       AUTOCOMPLETE="off" placeholder="请输入标题"/>
            </div>
            <div class="bbs_quick_tips">
                <img src="/images/bbs_tips_icon.png"/>可输入<span>80</span>个字符
            </div>
        </div>
        <div class="bbs_content_inputbox">
            <div class="bbs_content_loginbox">
                <p>您需要登录后才可以发帖</p>
                <a href="/login?back_url=/bbs/bbsPost?id=${bbsPost.id}">登录 | 注册染者无疆账号</a>
            </div>
            <%--富文本编辑器 --%>
            <script id="content" type="text/plain" style="width:100%;height:180px;">

            </script>
        </div>
        <input class="bbs_submit_btn" id="replyBtn" type="submit"
               value="发表帖子"/>
    </div>

    <div class="modal fade bs-example-modal-sm" tabindex="-1"
         role="dialog" aria-labelledby="mySmallModalLabel" id="auditingModal">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">确认</h4>
                </div>
                <div class="modal-body">
                    <p>此贴是否通过审核?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="auditing('2',${bbsPost.createdBy })">是
                    </button>
                    <button type="button" class="btn btn-primary" onclick="auditing('1',${bbsPost.createdBy })">否
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>

                </div>
            </div>
        </div>
    </div>

    <div class="modal fade bs-example-modal-sm" tabindex="-1"
         role="dialog" aria-labelledby="mySmallModalLabel" id="splitReplyModal">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">请输入标题</h4>
                </div>
                <div class="modal-body bbs_section_hot_list set">
                    <input type="hidden" id="splitReplyId"/>
                    <input type="text" id="splitReplyTitle" style="width:80%"/>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="splitReply()">是</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" tabindex="-1"
         role="dialog" aria-labelledby="mySmallModalLabel" id="replyEditModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">编辑帖子</h4>
                </div>

                <div class="modal-body">
                    <input id="replyIdEdit" type="hidden"/>
                    <div class="bbs_quick_postbox">
                    <div class="bbs_quick_titlebox">
                        <div class="bbs_quick_title" style="width:100%;margin-left:0;">

                        <input id="replyTitleEdit" type="text" maxlength="80"
                               AUTOCOMPLETE="off" placeholder="请输入标题" style="width:100%;"/>
                        </div>
                    <%--<div class="bbs_quick_tips">
                        <img src="/images/bbs_tips_icon.png"/>可输入<span>80</span>个字符
                    </div>--%>
                    </div>


                    <div class="bbs_content_inputbox" style="background:transparent;border:0;width:100%;">
                        <%--富文本编辑器 --%>
                        <script id="replyContent" type="text/plain" style="width:100%;height:160px;">

                        </script>
                    </div>
                    <input class="bbs_submit_btn" id="replyBtnEdit" type="button" onclick="saveReply()"
                           value="保存修改"/>
                    </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>

            </div>
        </div>
    </div>
</div>

<input type="hidden" id="postId" value="${bbsPost.id }"/>
<input type="hidden" id="sectionId" value="${bbsPost.sectionId}"/>
<div class="clear"></div>
<%--foot--%>
<%@ include file="/page/common/foot.jsp" %>
<script language="javascript" type="text/javascript">
    var theTab1_box = new Array('all_essence', 'bbs_info',
        'bbs_product', 'bbs_dyeing', 'bbs_life', 'bss_other');
    var theTab1 = new AlexTab2('tab01', theTab1_box);
    theTab1;
</script>
</body>
</html>
