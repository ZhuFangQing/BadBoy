<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@include file="../common/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>七彩云</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="/css/business.css" rel="stylesheet" type="text/css"/>
    <%@include file="../common/resource.jsp" %>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#Pagination").pagination("${pageResponse.perPageNo}", {
                callback: getOtherNews
            });
            function getOtherNews(pageNum) {
                            pageNum =pageNum + 1;
                            $.ajax({
                                url: '${ctx}/information/getIndustryInformation',
                                type: 'POST',
                                data: {
                                    beginPage: pageNum,
                                    newsType: $("#newsType").val()
                                },
                                dataType: 'json',
                                success: function (resp) {
                                    console.log(resp);
                                    $("#newsContent").html("");
                                    var list2 ="<dl>\n" +
                                        "                        <dt><a href=\"/information/{newsList.id}\"><img src=\"{newsList.img_url}\" width=\"250\" height=\"165\"/></a></dt>\n" +
                                        "                            <dd class=\"news-title\"><a href=\"/information/{newsList.id}\">{newsList.title}</a></dd>\n" +
                                        "                            <dd class=\"news-content\">{newsList.content_summary}</dd>\n" +
                                        "                            <dd class=\"news-detail\"><a href=\"/information/{newsList.id}\">查看详情&gt;&gt;</a></dd>\n" +
                                        "                            <dd class=\"news-time\">新闻日期：{newsList.news_date}</dd>\n" +
                                        "                        </dl>";
                                    for (var i = 0; i < resp.data.length; i++) {
                                        var list = list2;
                                        list = list.replace("{newsList.img_url}",'${itx}'+resp.data[i].img_url);
                                        list = list.replace("{newsList.title}",resp.data[i].title);
                                        list = list.replace("{newsList.content_summary}",resp.data[i].content_summary);
                                        list = list.replace("{newsList.news_date}",resp.data[i].news_date.substring(0,10));
                                        list = list.replace("{newsList.id}",resp.data[i].id);
                                        list = list.replace("{newsList.id}",resp.data[i].id);
                                        list = list.replace("{newsList.id}",resp.data[i].id);
                                        $("#newsContent").append(list);
                                    }
                    }
                });
            }

            $(".business-nav li").click(function(){
                $("#pagination").show();
                $("#newsType").val($(this).attr("value"));
                $("ul li").removeClass("active");
                $(this).attr("class","active");
                $.ajax({
                    url: '${ctx}/information/getIndustryInformation',
                    type: 'POST',
                    data: {
                        beginPage: 1,
                        newsType: $("#newsType").val()
                    },
                    dataType: 'json',
                    success: function (resp) {
                        if(resp.perPageNo<1){
                            $("#pagination").hide();
                        }
                        $("#Pagination").pagination(resp.perPageNo, {
                            callback: getOtherNews
                        });
                        console.log(resp);
                        $("#newsContent").html("");
                        /* var newsSub="{newsList.content_summary}";
                            if(newsSub.length>=90){
                            alert("lll");
                                newsSub=newsSub.substring(0,90)+ "...";
                            }  */
                        var list2 ="<dl>\n" +
                            "                        <dt><a href=\"/information/{newsList.id}\"><img src=\"{newsList.img_url}\" width=\"250\" height=\"165\"/></a></dt>\n" +
                            "                            <dd class=\"news-title\"><a href=\"/information/{newsList.id}\">{newsList.title}</a></dd>\n" +
                            "                            <dd class=\"news-content\">{newsList.content_summary}</dd>\n" +
                            "                            <dd class=\"news-detail\"><a href=\"/information/{newsList.id}\">查看详情&gt;&gt;</a></dd>\n" +
                            "                            <dd class=\"news-time\">新闻日期：{newsList.news_date}</dd>\n" +
                            "                        </dl>";
                        for (var i = 0; i < resp.data.length; i++) {
                            var list = list2;
                            list = list.replace("{newsList.img_url}",'${itx}'+resp.data[i].img_url);
                            list = list.replace("{newsList.title}",resp.data[i].title);
                            var content_summary = resp.data[i].content_summary;
                            if($.notNull(content_summary) && content_summary.length > 150){
                                content_summary = content_summary.substring(0, 150) + "...";
                            }
                            list = list.replace("{newsList.content_summary}",content_summary);
                            
                            list = list.replace("{newsList.news_date}",resp.data[i].news_date.substring(0,10));
                            list = list.replace("{newsList.id}",resp.data[i].id);
                            list = list.replace("{newsList.id}",resp.data[i].id);
                            list = list.replace("{newsList.id}",resp.data[i].id);
                            $("#newsContent").append(list);
                        }
                    }
                })})

            $(".business-nav li").eq(location.search.substring(1)).click();

        });


    </script>
</head>
<body>
<!--头部-->
<%@ include file="../common/top.jsp" %>
<!--头部结束-->
<!--行业资讯标题-->
<div class="container">
    <p class="business-title">
        <a href="/"><span>首页</span></a>
        &gt;
        <a href="/information"><span>行业资讯</span></a>
    </p>
</div>
<!--行业资讯标题-end-->
<!--主体-->
<div class="container">
    <!--主体左侧-->
    <div class="business-left">
        <!--business-nav-->
        <input type="hidden" id="newsType" value="0">
        <ul class="business-nav">
            <li value="0" class="active"><a href="javascript:;">全部</a></li>
            <li value="8"><a href="javascript:;">纺织印染</a></li>
            <li value="66"><a href="javascript:;">染料助剂</a></li>
            <li value="89"><a href="javascript:;">人物访谈</a></li>
            <li value="90"><a href="javascript:;">政策法规</a></li>
            <li value="91"><a href="javascript:;">展会/会议</a></li>
            <!-- <li value="11"><a href="javascript:;">人才交流</a></li> -->
            <li value="10"><a href="javascript:;">供求信息</a></li>
        </ul>
        <div id="newsContent">
            <c:forEach items="${pageResponse.data}" var="newsList">
                <dl>
                    <dt><a href="/information/${newsList.id}"><img src="${itx}${newsList.img_url}" width="250" height="165"/></a></dt>
                    <dd class="news-title"><a href="/information/${newsList.id}">${newsList.title}</a></dd>
                    <dd class="news-content">
                        <c:set var="content" value="${newsList.content_summary}"></c:set>

                        <c:if test="${fn:length(newsList.content_summary) > 150}">
                            <c:set var="content" value="${fn:substring(newsList.content_summary, 0, 150)}..."></c:set>
                        </c:if>
                        ${content}
                    </dd>
                    <dd class="news-detail"><a href="/information/${newsList.id}">查看详情&gt;&gt;</a></dd>
                    <dd class="news-time">新闻日期：${empty newsList.news_date ? "" : fn:substring(newsList.news_date, 0, 10)}</dd>
                </dl>
            </c:forEach>
        </div>
    </div>
    <%--侧边新闻--%>
    <jsp:include page="/page/information/rightSideInformation.jsp"></jsp:include>
</div>
<div id="pagination" class="business-pages container">
    <jsp:include page="/page/common/pagination.jsp"></jsp:include>
</div>

<!--底部-->
<jsp:include page="../common/foot.jsp"></jsp:include>
<!--底部结束-->


</body>
</html>