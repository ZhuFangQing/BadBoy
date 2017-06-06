<%--
  Created by IntelliJ IDEA.
  User: Echos
  Date: 2016/11/29
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>七彩云</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%@include file="/page/common/resource.jsp" %>
    <link href="/css/chanlstyle.css" rel="stylesheet" type="text/css" />
    <link href="/css/mall_serve.css" rel="stylesheet" type="text/css" />
    <link href="/css/about.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/jscript" src="/js/alagzn.js"></script>
    <script>
        $(document).ready(function(){
            $("ul.about_menu_list li").click(function(){
                $("ul.about_menu_list li").removeClass("onthis");
                $("div.about_right").hide();
                $(this).addClass("onthis");
                $("div." + $(this).attr("data-type")).show();
            })
            if('${t}'=='1'){
                $("ul.about_menu_list li[data-type='i7_about']").click()
            }
            if('${t}'=='2'){
                $("ul.about_menu_list li[data-type='i7_partner']").click()
            }
            if('${t}'=='3'){
                $("ul.about_menu_list li[data-type='i7_future']").click()
            }
        })
    </script>
</head>
<body>
<%--top模块--%>
<%@ include file="/page/common/top.jsp" %>


<div class="container">
    <p class="business-title brb mb20">
        <span>首页</span>
        &gt;
        <span>技术服务</span>
        <%--&gt;
        <span>七彩云简介</span>--%>
    </p>
    <div class="about_left">
        <div class="about_menu">
            <h1 class="about_title"><em></em>物流配送</h1>
            <ul class="about_menu_list">
                <a href="javascript:;"><li data-type="i7_about" class="onthis">配送标准说明</li></a>
                <a href="javascript:;"><li data-type="i7_partner">配送中心</li></a>
                <a href="javascript:;"><li data-type="i7_future">网点查询</li></a>
            </ul>
        </div>
        <img src="images/about_img.jpg" width="240" />
    </div>
    <div class="about_right i7_about">
        <div class="about_con_title">配送标准说明</div>
        <div class="part09-txt">
            <p><strong>签收标准：</strong></p>
            <p>1、收货人请仔细核对七彩云电子商务有限公司的销售出库单的收货人信息，如果非收货人请勿签收。</p>
            <p>2、收货人应仔细核对单据与实际收货的品种、规格、数量是否相符，如果不相符，请与送货人沟通或及时通知客服，如果一旦签收，则货物所有权转移至收货人。</p>
            <p>3、收货人应仔细检查货物外观，发现货物破损可以拒收并通知客服处理。</p>
        </div>
    </div>
    <div class="about_right i7_partner" style="display: none;">
        <div class="about_con_title">配送中心</div>
        <div class="wrapper m0a">
            <%--<img src="http://static.i7colors.com/help/distribution01.jpg">
            <img src="http://static.i7colors.com/help/distribution02.jpg">
            <img src="http://static.i7colors.com/help/distribution03.jpg">
            <img src="http://static.i7colors.com/help/distribution04.jpg">
            <img src="http://static.i7colors.com/help/distribution05.jpg">
            <img src="http://static.i7colors.com/help/distribution06.jpg">--%>
            <img src="http://static.i7colors.com/help/distribution01.jpg" style="margin-bottom: 332px;">
        </div>
    </div>
    <div class="about_right i7_future" style="display: none;">
        <div class="about_con_title">网点查询</div>
        <div class="of part-table" style="margin-left:0px;">
            <table width="99.5%" cellspacing="0" cellpadding="0" class="table table-bordered">
                <thead>
                <tr>
                    <th>配送中心</th>
                    <th>地址</th>
                    <th>配送范围</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>嘉兴仓库</td>
                    <td>
                        <div>浙江省桐乡市屠甸镇鹏飞路137号</div>
                    </td>
                    <td>嘉兴、湖州、吴江、杭州地区</td>
                </tr>
                <tr>
                    <td>苏州仓库</td>
                    <td>
                        <div>江苏省苏州市相城区渭塘镇渭西村仙士工业园江苏大厦1号楼</div>
                    </td>
                    <td>江苏省全境</td>
                </tr>
                <tr>
                    <td>佛山仓库</td>
                    <td>
                        <div>广东省佛山市南海区罗村佛罗路南储仓库（永江化工对面）</div>
                    </td>
                    <td>广东省全境</td>
                </tr>
                <tr>
                    <td>石狮仓库</td>
                    <td>
                        <div>福建省石狮市锦尚镇石锦大道冠辉物流园</div>
                    </td>
                    <td>福建省全境</td>
                </tr>
                <tr>
                    <td>绍兴仓库</td>
                    <td>
                        <div>浙江省绍兴滨海开发区兴滨路986号6栋1楼</div>
                    </td>
                    <td>绍兴、杭州、宁波地区</td>
                </tr>

                <tr>
                    <td>淄博仓库</td>
                    <td>
                        <div>山东省淄博市高新区付山工业园保税区仓库</div>
                    </td>
                    <td>山东、河北、河南地区</td>
                </tr>
                <tr>
                    <td>东营仓库</td>
                    <td>
                        <div>山东省东营市河口经济开发区海宁路779号</div>
                    </td>
                    <td>全国范围配送</td>
                </tr>
                <tr>
                    <td>盐城仓库</td>
                    <td>
                        <div>江苏省盐城市响水县陈家港镇生态化工园区纬六路</div>
                    </td>
                    <td>全国范围配送</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="clear"></div>
</div>


<%@ include file="/page/common/foot.jsp" %>
</body>
</html>