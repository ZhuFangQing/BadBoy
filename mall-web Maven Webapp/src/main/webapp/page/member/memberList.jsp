<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>七彩云</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%@include file="../common/resource.jsp" %>
    <link href="/css/member.css" rel="stylesheet" type="text/css" />
    <script>
        $(document).ready(function () {
            $("#Pagination").pagination("${memberList.perPageNo}", {
                callback: getOtherNews
            });

            function getOtherNews(pageNum) {
                pageNum =pageNum + 1;
                $.ajax({
                    url: '${ctx}/member/getMemberListAjax',
                    type: 'POST',
                    data: {
                        beginPage: pageNum,
                        city:$("#city").val()
                    },
                    dataType: 'json',
                    success: function (resp) {
                        $(".pages").show();
                        if(resp.perPageNo<2){
                            $(".pages").hide();
                        }
                        console.log(resp);
                        $("#memberList").html("");
                        var list2 ="<dl>\n" +
                            "                        <dt><a href=\"/member/{memberList.id}\"><img  src=\"{memberList.logo_url}\" width=\"200\" height=\"100\"/></a></dt>\n" +
                            "                        <dd><a href=\"/member/{memberList.id}\">{memberList.member_name}</a></dd>\n" +
                            "                        <dd>{memberList.summary}</dd>\n" +
//                            "                        <dd>{memberList.phone}</dd>" +
                            "                        <dd>{memberList.city}</dd>\n" +
                            "                    </dl>";
                        for (var i = 0; i < resp.data.length; i++) {
                            var list = list2;
                            list = list.replace("{memberList.id}",resp.data[i].id);
                            list = list.replace("{memberList.id}",resp.data[i].id);
                            list = list.replace("{memberList.logo_url}","${itx}"+resp.data[i].logo_url);
                            list = list.replace("{memberList.member_name}",resp.data[i].member_name);
                            list = list.replace("{memberList.summary}",resp.data[i].summary);
//                            list = list.replace("{memberList.phone}",resp.data[i].phone);
                            list = list.replace("{memberList.city}",resp.data[i].city);
                            $("#memberList").append(list);
                        }
                    }
                });
            }

            if(${memberList.perPageNo<2}){
                $(".pages").hide();
            }

            $(".member-list-type li").click(function(){
                debugger;
                $(".pages").show();
                $(".member-list-type li").removeClass("active");
                $(this).attr("class","active");
                $("#city").val($(this).attr("value"));
                getMemberListByCity();

            });

            function getMemberListByCity() {
                debugger;
                $.ajax({
                    url: '${ctx}/member/getMemberListAjax',
                    type: 'POST',
                    data: {
                        city:$("#city").val()
                    },
                    dataType: 'json',
                    success: function (resp) {
                        debugger;
                        if(resp.perPageNo<2){
                            $(".pages").hide();
                        }
                        $("#Pagination").pagination(resp.perPageNo, {
                            callback: getOtherNews
                        });
                        $("#memberList").html("");
                        var list2 ="<dl>\n" +
                            "                        <dt><a href=\"/member/{memberList.id}\"><img  src=\"{memberList.logo_url}\" width=\"200\" height=\"100\"/></dt></a>\n" +
                            "                        <dd><a href=\"/member/{memberList.id}\">{memberList.member_name}</a></dd>\n" +
                            "                        <dd>{memberList.summary}</dd>\n" +
//                            "                        <dd>{memberList.phone}</dd>" +
                            "                        <dd>{memberList.city}</dd>\n" +
                            "                    </dl>";
                        for (var i = 0; i < resp.data.length; i++) {
                            var list = list2;
                            list = list.replace("{memberList.id}",resp.data[i].id);
                            list = list.replace("{memberList.id}",resp.data[i].id);
                            list = list.replace("{memberList.logo_url}","${itx}"+resp.data[i].logo_url);
                            list = list.replace("{memberList.member_name}",resp.data[i].member_name);
                            list = list.replace("{memberList.summary}",resp.data[i].summary);
//                            list = list.replace("{memberList.phone}",resp.data[i].phone);
                            list = list.replace("{memberList.city}",resp.data[i].city);
                            $("#memberList").append(list);
                        }
                    }
                });
            }

        });



    </script>

</head>
<body>
<%--top模块--%>
<%@ include file="../common/top.jsp" %>
<!--行业资讯标题-->
<div class="container">
    <p class="business-title">
        <span>首页</span>
        &gt;
        <span>会员风采</span>

    </p>
</div>
<!--行业资讯标题-end-->

<div class="content container">
    <!--content-left-->
    <div class="content-left">
        <!--member-list-->
        <div class="member-list">
            <p>会员列表</p>
            <ul class="member-list-type">
                <span>所在地区：</span>
                <li class="active"><a href="javascript:;">不限</a></li>
                <c:forEach items="${memberClassList}" var="memberClassList">
                    <li value="${memberClassList.id}"><a href="javascript:;">${memberClassList.name}<%--<span>(${memberClassList.value})</span>--%></a></li>
                </c:forEach>
                <input type="hidden" id="city" value="0"/>
            </ul>
        </div>
        <!--member-list-end-->
        <!--member-content-->
        <div class="member-content">
            <div class="member-content-title">
                <span>企业LOGO</span>
                <span>企业名称</span>
                <%--<span>联系电话</span>--%>
                <span>所在地区</span>
            </div>

            <div class="member-content-dl" id="memberList">
                <c:forEach items="${memberList.data}" var="memberList">
                    <dl>
                        <dt><a href="/member/${memberList.id}"><img src="${itx}${memberList.logo_url}" width="200" height="100"/></a></dt>
                        <dd><a href="/member/${memberList.id}">${memberList.member_name}</a></dd>
                        <dd>${memberList.summary}</dd>
                        <%--<dd>${memberList.phone}</dd>--%>
                        <dd>${memberList.city}</dd>
                    </dl>
                </c:forEach>
            </div>
        </div>
    </div>
    <!--content-left-end-->
    <%@ include file="/page/shop/shop_right.jsp" %>
</div>

<div class="business-pages container">
    <jsp:include page="/page/common/pagination.jsp"></jsp:include>
</div>


<%--foot--%>
<%@ include file="../common/foot.jsp" %>
</body>
</html>