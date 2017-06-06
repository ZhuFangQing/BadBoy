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
    <script>
        $(function(){
//            var u = '1081';
            var u = '${userId}';
            if($.notNull(u)){
                userId = u;
            }
        })
    </script>
    <script language="javascript" type="text/javascript" src="/js/userPost.js"></script>
</head>
<body>
<%--top模块--%>
<%@ include file="/page/common/top.jsp" %>
<div class="mian_content container">
    <jsp:include page="/page/common/usercenter.jsp"></jsp:include>
    <div class="mumber_right_content">
        <%--<jsp:include page="/page/bbs/common/bbs_search_box.jsp"></jsp:include>
        <p class="business-title">
            <span>首页</span>
            &gt;
            <span>用户昵称</span>
            &gt;
            <span>帖子</span>
        </p>--%>

        <table class="bbs_table" cellpadding="0" cellspacing="0" width="100%">
            <thead>
            <tr>
                <th width="900">
                    <a href="javascript:bbsPostTab('all');" class="postTab"><span id="allSpan" class="onthis">最新</span></a>
                    <a href="javascript:bbsPostTab('hot');" class="postTab"><span id="hotSpan">热门</span></a>
                    <a href="javascript:bbsPostTab('essence');" class="postTab"><span id="essenceSpan">精华</span></a>
                    <a href="javascript:bbsPostTab('collection');" class="postTab"><span id="collectionSpan">我的收藏</span></a>
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
    <div class="clear"></div>
</div>
<%@ include file="/page/common/foot.jsp" %>
</body>
</html>