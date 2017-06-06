<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>七彩云</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<%@include file="../common/resource.jsp" %>
	<link href="/css/business.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		.business-nav li{
			width: 125px;
		}
		.business-nav-twice{
			width: 125px;
		}
		.business-nav-twice li a{
			width: 125px;
		}
	</style>
	<script>
        var ITEM = "<dl>\n" +
            "\t\t\t<dt><a href=\"{url}\"><img src=\"{coverImg}\" width=\"250\" height=\"165\"/></a></dt>\n" +
            "\t\t\t<dd class=\"news-title\"><a href=\"{url}\">{title}</a></dd>\n" +
            "\t\t\t<dd class=\"news-content\">\n" +
            "\t\t\t\t<a href=\"{url}\">{contentSummary}...</a>\n" +
            "\t\t\t</dd>\n" +
            "\t\t\t<dd class=\"news-detail\"><a href=\"{url}\">查看详情&gt;&gt;</a></dd>\n" +
            "\t\t\t<dd class=\"news-time\">新闻日期：{date}</dd>\n" +
            "\t\t</dl>";

        var currentMenuId = '${param.t}';
        var currentMenuType = 'parent';
        console.log(currentMenuId);

        $(document).ready(function () {
            $("li.item_menu").click(function () {
                $(".nav_name").html($(this).attr("data-name"));
				currentMenuId = $(this).attr("data-id");
				$(".business-nav li").removeClass("active");
                currentMenuType = $(this).attr("data-type");
				if(currentMenuId == '-1' || currentMenuType == 'parent'){
                    $(".business-nav li[data-id='" + $(this).attr('data-id') + "']").addClass("active");
				}else{
                    $(".business-nav li[data-id='" + $(this).attr('data-parent') + "']").addClass("active");
				}
				search();
            });

            /*//全部
            $(".btn_search_all").click(function () {
                $(".nav_name").html($(this).attr("data-name"));
                $(".business-nav li").removeClass("active");
                $(this).parent().addClass("active");
                currentMenuId = '';
                search();
            });*/

            if('${param.t}' == ''){
                search();
            }else{
                $("li.item_menu[data-id='${param.t}']").click();
			}
        });

        function search(pageNo, pageSize){

            //PageNo
            if(undefined == pageNo){
                pageNo = 1;
            }

            //PageSize
            if(undefined == pageSize){
                pageSize = 5;
            }

            var obj = {
                'pageNo'	:pageNo,
                'pageSize'	:pageSize,
				'search'	:getSearchContent()
            };
            if(currentMenuId != '' && currentMenuId != '-1'){
                obj[currentMenuType == 'parent' ? 'parentMenuId' : 'menuId'] = currentMenuId;
			}

            $.ajax({
                url:'/school/industry_search',
                type:'GET',
                data: obj,
                dataType:'json',
                success:function(resp){
                    console.log(resp);
                    if($.ajaxSuccess(resp)){

                        $(".item_container").empty();
                        for(var idx in resp['data']){
							var data = resp['data'][idx];

							var mixData = {
							    'coverImg'			:itx + data['coverUrl'],
							    'title'				:data['title'],
							    'contentSummary'	:data['contentSummary'],
							    'url'				:'/school/articles/' + data['id'],
							    'date'				:new Date(data['createdAt']).pattern(),
							};

							var item = i7Utils.mix(ITEM, mixData);

                            /*var item = ITEM.replace("{coverImg}", itx + data['coverUrl']);
                            item = item.replace("{title}", data['title']);
                            item = item.replace("{contentSummary}", data['contentSummary']);
                            item = item.replace("{url}", '/school/articles/' + data['id']);
                            var date = new Date(data['createdAt']);
                            item = item.replace("{date}", date.pattern());*/
                            $(".item_container").append(item);
						}

                        //更新分页控件
                        $("#Pagination").pagination(resp['totalPageSize'], {
                            callback: articleListByPage,
                            current_page: resp['pageNo'] - 1
                        });
                    }
                }
            });
        }

        function articleListByPage(pageNo){
            console.log('跳转页面:' + pageNo);
            pageNo = pageNo + 1;
            search(pageNo);
        }
	</script>
</head>
<body>
<%--top模块--%>
<%@ include file="../common/top.jsp" %>
<!--头部结束-->
<div class="container">
	<p class="business-title">
		<span><a href="/">首页</a></span>
		&gt;
		<span><a href="/school/industry">大学堂</a></span>
		&gt;
		<span class="nav_name">全部</span>
	</p>
</div>
<!--主体-->
<div class="container">
	<!--主体左侧-->
	<div class="business-left">
		<div class="business-nav-div">
			<!--business-nav-->
			<ul class="business-nav">
				<li class="item_menu active" data-id="-1" data-name="全部"><a href="javascript:;" class="btn_search_all">全部</a></li>
				<c:forEach items="${menuList}" var="menuList">
					<li data-id="${menuList.parentMenu.id}" data-name="${menuList.parentMenu.name}" data-type="parent" class="item_menu"><a href="javascript:;">${menuList.parentMenu.name}</a></li>
				</c:forEach>
			</ul>

			<c:forEach items="${menuList}" var="menuList">
				<ul class="business-nav-twice ${menuList.parentMenu.id}">
					<c:forEach items="${menuList.childMenu}" var="childList">
						<li data-id="${childList.id}" data-parent="${menuList.parentMenu.id}" data-name="${childList.name}" class="item_menu"><a href="javascript:;">${childList.name}</a></li>
					</c:forEach>
				</ul>
			</c:forEach>
		</div>

		<div class="item_container">
		</div>


	</div>
	<!--主体右侧-->
	<jsp:include page="right.jsp"></jsp:include>
	<!--content-right-end-->
</div>


<div class="business-pages container">
	<jsp:include page="/page/common/pagination.jsp"></jsp:include>
</div>
<!--pages-end-->

<jsp:include page="/page/common/foot_partner.jsp"></jsp:include>

<%--foot--%>
<%@ include file="/page/common/foot.jsp" %>
</body>
</html>
