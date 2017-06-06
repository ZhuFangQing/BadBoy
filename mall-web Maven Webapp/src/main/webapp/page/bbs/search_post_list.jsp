<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>七彩云</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<%@include file="../common/resource.jsp" %>
	<link href="/css/bbs.css" rel="stylesheet" type="text/css" />
	<script src="/js/bbs.js?t=${now}"></script>
	<script>
		$(function(){
            title = getBbsSearchContent();
		});
	</script>
	<script language="javascript" type="text/javascript" src="/js/bbsSection.js"></script>
</head>
<body>
<%--top模块--%>
<%@ include file="../common/top.jsp" %>

<div class="bbs_banner"><img src="/images/bbs_banner.jpg" width="100%" /></div>
<div class="container">
    <jsp:include page="/page/bbs/common/bbs_search_box.jsp"></jsp:include>
	<p class="business-title">
		<span><a href="/">首页</a></span> &gt; <span><a href="/bbs">七彩云论坛（染者无疆）</a></span>
        &gt;
		<span>帖子搜索</span>
	</p>

	<div class="business-pages container">
		<jsp:include page="/page/common/pagination.jsp"></jsp:include>
	</div>
    
    <table class="bbs_table" cellpadding="0" cellspacing="0" width="100%">
    	<thead>
        	<tr>
            	<th width="900">
                	<a href="javascript:getAllBbsPost();"><span id="allSpan" class="onthis">最新</span></a>
                    <a href="javascript:getHotBbsPost();"><span id="hotSpan">热门</span></a>
                    <a href="javascript:getEssenceBbsPost();"><span id="essenceSpan">精华</span></a>
                </th>
                <th width="120"><img src="/images/author_icon.png" />作者</th>
                <th width="120"><img src="/images/check_icon.png" />回复/查看</th>
                <th width="120"><img src="/images/publish_icon.png" />最后发表</th>
            </tr>
        </thead>
		<tbody id="bbsTable">
        </tbody>
    </table>
</div>
<%--foot--%>
<%@ include file="/page/common/foot.jsp" %>
<script language="javascript" type="text/javascript">
	var theTab1_box = new Array('all_essence','bbs_info','bbs_product','bbs_dyeing','bbs_life','bss_other');
	var theTab1 = new AlexTab2('tab01',theTab1_box);
	theTab1;
</script>
</body>
</html>
