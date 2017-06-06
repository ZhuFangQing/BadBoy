<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>七彩云</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="/css/bootstrap.css" rel="stylesheet">
    <%@include file="../common/resource.jsp" %>

    <link href="/css/bbs.css" rel="stylesheet" type="text/css"/>
    <link href="/css/bbsPagination.css" rel="stylesheet" type="text/css"/>

    <script src="/js/lib/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <script type="text/javascript" src="/js/lib/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="/js/lib/ueditor/ueditor.all.js"></script>
    <script type="text/javascript" src="/js/lib/ueditor/lang/zh-cn/zh-cn.js"></script>

    <script src="/js/bbs.js?t=${now}"></script>
    <script language="javascript" type="text/javascript" src="/js/bbsSection.js"></script>

</head>
<body>
<%--top模块--%>
<%@ include file="../common/top.jsp" %>


</div>
<div class="container">
    <jsp:include page="/page/bbs/common/bbs_search_box.jsp"></jsp:include>
    <p class="business-title">
        <span><a href="/">首页</a></span> &gt; <span><a href="/bbs">七彩云论坛（染者无疆）</a></span>
        &gt; <span><a href="/bbs/bbsSection?id=${bbsSection.id}">${bbsSection.name}</a></span>
    </p>
    <div class="bbs_section_info">
        <h1><b>${bbsSection.name }</b>今日: <span>${bbsSection.todayPostNum }</span><em>|</em>主题:
            <span>${bbsSection.topicPostNum }</span></h1>
        <h1>版主:
            <c:forEach items="${bbsSection.moderatorList }" var="moderator">
                 <a href="/bbs/users/${moderator.id}">${moderator.login_name }</a>
            </c:forEach>
        </h1>
        <h1>
            发贴增加积分:<span>${bbsSection.postPoint}</span> <em>/</em>
            回帖增加积分:<span>${bbsSection.replyPoint}</span><em>/</em>
            加精增加积分:<span>${bbsSection.essencePoint}</span>
        </h1>
        <p>被删除贴将双倍扣除积分&nbsp;&nbsp;&nbsp;对于“顶”贴将被定期删除，“刷”贴将被惩罚性删除</p>
    </div>
    <p class="business-title recom"><span>推荐主题</span></p>
    <div class="bbs_section_hot_list">
        <ul>
            <c:forEach items="${sectionHotPost }" var="post">
                <li><em></em><a href="/bbs/bbsPost?id=${post.id}">${post.title }</a></li>
            </c:forEach>
        </ul>
    </div>

    <div class="bbs_type_box">
        <ul id="typeUl">
            <li class="onthis" onclick="getBbsPostByTopic('',this)">全部</li>
            <c:forEach items="${bbsTopic}" var="topic">
                <li><span
                        onclick="getBbsPostByTopic(${topic.id},this)">${topic.name }</span><em>${topic.postCount }</em>
                </li>
            </c:forEach>
        </ul>
    </div>

    <a href="#postbox">
    <input class="to_bbs_quick_postbox" type="button" value="快速发帖"/>
    </a>

    <table class="bbs_table" cellpadding="0" cellspacing="0" width="100%">
        <thead>
        <tr>
            <th width="900">
                <a href="javascript:bbsPostTab('all');" class="postTab"><span id="allSpan" class="onthis">最新</span></a>
                <a href="javascript:bbsPostTab('hot');" class="postTab"><span id="hotSpan">热门</span></a>
                <a href="javascript:bbsPostTab('essence');" class="postTab"><span id="essenceSpan">精华</span></a>
            </th>
            <th width="120" style="text-align: center;"><img src="/images/author_icon.png"/>作者</th>
            <th width="120" style="text-align: center;"><img src="/images/check_icon.png"/>回复/查看</th>
            <th width="120" style="text-align: center;"><img src="/images/publish_icon.png"/>最后发表</th>
        </tr>
        </thead>
        <tbody id="bbsTable">
        </tbody>
    </table>

    <div class="business-pages container">
        <jsp:include page="/page/common/pagination.jsp"></jsp:include>
    </div>

    <div class="bbs_quick_postbox" id="postbox">
        <h1><img src="/images/quickpost_icon.gif"/>快速发帖</h1>
        <div class="bbs_quick_titlebox">

            <div class="bbs_quick_typeselect">
                <input id="bbs_type_text" type="text" placeholder="选择主题分类" disabled="disabled" value=""
                       AUTOCOMPLETE="off"/>
                <img src="/images/open_icon.jpg" height="30"/>
                <select id="bbs_type_select" AUTOCOMPLETE="off">
                    <option selected="selected" value="">--选择主题分类--</option>
                    <c:forEach items="${bbsTopic }" var="topic">
                        <option value="${topic.id }">${topic.name }</option>
                    </c:forEach>
                </select>
            </div>
            <div class="bbs_quick_title"><input id="postTitle" type="text" maxlength="80" AUTOCOMPLETE="off" placeholder="请输入标题"/></div>
            <div class="bbs_quick_tips"><img src="/images/bbs_tips_icon.png"/>可输入<span>80</span>个字符</div>
        </div>
        <div class="bbs_content_inputbox">
            <div class="bbs_content_loginbox">
                <p>您需要登录后才可以发帖</p>
                <a href="/login?back_url=/bbs/bbsSection?id=${bbsSection.id}">登录 | 注册染者无疆账号</a>
            </div>
            <%--富文本编辑器 --%>
            <script id="content" type="text/plain" style="width:100%;height:180px;">

            </script>
        </div>
        <input class="bbs_submit_btn" id="postBtn" type="submit" value="发表帖子"/>
    </div>
    <input type="hidden" id="sectionId" value="${bbsSection.id }"/>
</div>
<%--foot--%>
<%@ include file="/page/common/foot.jsp" %>
<script language="javascript" type="text/javascript">
    var theTab1_box = new Array('all_essence', 'bbs_info', 'bbs_product', 'bbs_dyeing', 'bbs_life', 'bss_other');
    var theTab1 = new AlexTab2('tab01', theTab1_box);
    theTab1;
</script>
</body>
</html>
