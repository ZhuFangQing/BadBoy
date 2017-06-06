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

    <link href="/css/myOrder.css" rel="stylesheet" type="text/css" />
    <script src="/js/order.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            orderList();
        })
    </script>
</head>
<body>
<jsp:include page="/page/common/feedback.jsp"></jsp:include>
<%--top模块--%>
<%@ include file="/page/common/top.jsp" %>
<div class="mian_content container">
    <jsp:include page="/page/common/usercenter.jsp"></jsp:include>
    <div class="mumber_right_content">
        <div class="shopping_car_tab">
            <span class="active">我的订单</span>
        </div>
        <div class="tab_main_box">
            <div class="my_order_title">
                <a href="javascript:;" class="order_status_type active" data-status="">全部订单</a>
                <a href="javascript:;" class="order_status_type" data-status="waitCheck">待审核</a>
                <a href="javascript:;" class="order_status_type" data-status="notPay">未付款</a>
                <a href="javascript:;" class="order_status_type" data-status="alreadyDelivery">已发货</a>
                <a href="javascript:;" class="order_status_type" data-status="finish">已完成</a>
                <div class="order_seach_box">
                    <div class="order_seach_text"><input type="text" class="order_search_filter" placeholder="商品名称/商品编号/订单号" /></div>
                    <em class="order_search_btn"></em>
                </div>
            </div>
            <%--<div class="my_order_box">
                <div class="my_order_box_title">
                    <p><span>2016-11-30 15:47:56</span></p>
                    <p><span>订单号：</span>45954313679</p>
                </div>
                <table class="my_order_table" width="100%" cellpadding="0" cellspacing="0">
                    <tbody>
                    <tr>
                        <td width="650">
                            <div class="order_pro_img"><img src="images/product_detil_img.jpg" width="60" height="60" /></div>
                            <div class="order_pro_info">
                                <h1>阳离子染料 苏州东吴 阳离子兰X阳离子兰 X阳离子兰X-GRRL 250%</h1>
                                <p><span>商品编号：S.D.0059.0101.001</span></p>
                            </div>
                            <div class="order_pro_number"><span>25公斤/件  X  10</span></div>
                        </td>
                        <td rowspan="3" class="rtecenter">
                            <div class="order_total_price"><p>总额 <span>¥250000.00</span></p>银行转账</div>
                        </td>
                        <td rowspan="3" class="rtecenter">
                            <p>订单审核中</p>
                            <a href="">订单详情</a>
                        </td>
                        <td rowspan="3" class="rtecenter">
                            <input type="button" value="取消订单" />
                        </td>
                    </tr>
                    <tr>
                        <td width="300">
                            <div class="order_pro_img"><img src="images/product_detil_img.jpg" width="60" height="60" /></div>
                            <div class="order_pro_info">
                                <h1>阳离子染料 苏州东吴 阳离子兰X阳离子兰 X阳离子兰X-GRRL 250%</h1>
                                <p><span>商品编号：S.D.0059.0101.001</span></p>
                            </div>
                            <div class="order_pro_number"><span>25公斤/件  X  10</span></div>
                        </td>
                    </tr>
                    <tr>
                        <td width="300">
                            <div class="order_pro_img"><img src="images/product_detil_img.jpg" width="60" height="60" /></div>
                            <div class="order_pro_info">
                                <h1>阳离子染料 苏州东吴 阳离子兰X阳离子兰 X阳离子兰X-GRRL 250%</h1>
                                <p><span>商品编号：S.D.0059.0101.001</span></p>
                            </div>
                            <div class="order_pro_number"><span>25公斤/件  X  10</span></div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="my_order_box">
                <div class="my_order_box_title">
                    <p><span>2016-11-30 15:47:56</span></p>
                    <p><span>订单号：</span>45954313679</p>
                </div>
                <table class="my_order_table" width="100%" cellpadding="0" cellspacing="0">
                    <tbody>
                    <tr>
                        <td width="650">
                            <div class="package_info">
                                <span>包裹1</span>
                                包裹编号：156464564564 ( 上海仓已发货，发货日期：2016-12-05 )
                            </div>
                            <div class="order_pro_img"><img src="images/product_detil_img.jpg" width="60" height="60" /></div>
                            <div class="order_pro_info">
                                <h1>阳离子染料 苏州东吴 阳离子兰X阳离子兰 X阳离子兰X-GRRL 250%</h1>
                                <p><span>商品编号：S.D.0059.0101.001</span></p>
                            </div>
                            <div class="order_pro_number"><span>25公斤/件  X  10</span></div>
                        </td>
                        <td rowspan="3" class="rtecenter">
                            <div class="order_total_price"><p>总额 <span>¥250000.00</span></p>银行转账</div>
                        </td>
                        <td rowspan="3" class="rtecenter">
                            <p>部分已发货</p>
                            <a href="">订单详情</a>
                        </td>
                        <td rowspan="3" class="rtecenter">
                            <input type="button" value="订单详情" />
                        </td>
                    </tr>
                    <tr>
                        <td width="300">
                            <div class="package_info">
                                <span>包裹2</span>
                                包裹编号：156464564564 ( 待发货 )
                            </div>
                            <div class="order_pro_img"><img src="images/product_detil_img.jpg" width="60" height="60" /></div>
                            <div class="order_pro_info">
                                <h1>阳离子染料 苏州东吴 阳离子兰X阳离子兰 X阳离子兰X-GRRL 250%</h1>
                                <p><span>商品编号：S.D.0059.0101.001</span></p>
                            </div>
                            <div class="order_pro_number"><span>25公斤/件  X  10</span></div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="my_order_box">
                <div class="my_order_box_title">
                    <p><span>2016-11-30 15:47:56</span></p>
                    <p><span>订单号：</span>45954313679</p>
                </div>
                <table class="my_order_table" width="100%" cellpadding="0" cellspacing="0">
                    <tbody>
                    <tr>
                        <td width="650">
                            &lt;%&ndash;<div class="package_info">
                                <span>包裹1</span>
                                包裹编号：156464564564 ( 2016-12-02 已确认收货 )
                            </div>&ndash;%&gt;
                            <div class="order_pro_img"><img src="images/product_detil_img.jpg" width="60" height="60" /></div>
                            <div class="order_pro_info">
                                <h1>阳离子染料 苏州东吴 阳离子兰X阳离子兰 X阳离子兰X-GRRL 250%</h1>
                                <p><span>商品编号：S.D.0059.0101.001</span></p>
                            </div>
                            <div class="order_pro_number"><span>25公斤/件  X  10</span></div>
                        </td>
                        <td rowspan="3" class="rtecenter">
                            <div class="order_total_price"><p>总额 <span>¥250000.00</span></p>银行转账</div>
                        </td>
                        <td rowspan="3" class="rtecenter">
                            <p>已确认收货</p>
                            <a href="">订单详情</a>
                        </td>
                        <td rowspan="3" class="rtecenter">
                            <input type="button" value="联系客服" />
                        </td>
                    </tr>
                    <tr>
                        <td width="300">
                            &lt;%&ndash;<div class="package_info">
                                <span>包裹2</span>
                                包裹编号：156464564564 ( 2016-12-02 已确认收货 )
                            </div>&ndash;%&gt;
                            <div class="order_pro_img"><img src="images/product_detil_img.jpg" width="60" height="60" /></div>
                            <div class="order_pro_info">
                                <h1>阳离子染料 苏州东吴 阳离子兰X阳离子兰 X阳离子兰X-GRRL 250%</h1>
                                <p><span>商品编号：S.D.0059.0101.001</span></p>
                            </div>
                            <div class="order_pro_number"><span>25公斤/件  X  10</span></div>
                        </td>
                    </tr>
                    <tr>
                        <td width="300">
                            <div class="order_pro_img"><img src="images/product_detil_img.jpg" width="60" height="60" /></div>
                            <div class="order_pro_info">
                                <h1>阳离子染料 苏州东吴 阳离子兰X阳离子兰 X阳离子兰X-GRRL 250%</h1>
                                <p><span>商品编号：S.D.0059.0101.001</span></p>
                            </div>
                            <div class="order_pro_number"><span>25公斤/件  X  10</span></div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="my_order_box">
                <div class="my_order_box_title">
                    <p><span>2016-11-30 15:47:56</span></p>
                    <p><span>订单号：</span>45954313679</p>
                </div>
                <table class="my_order_table" width="100%" cellpadding="0" cellspacing="0">
                    <tbody>
                    <tr>
                        <td width="650">
                            <div class="package_info">
                                <span>包裹1</span>
                                包裹编号：156464564564 ( 2016-12-02 已确认收货 )
                            </div>
                            <div class="order_pro_img"><img src="images/product_detil_img.jpg" width="60" height="60" /></div>
                            <div class="order_pro_info">
                                <h1>阳离子染料 苏州东吴 阳离子兰X阳离子兰 X阳离子兰X-GRRL 250%</h1>
                                <p><span>商品编号：S.D.0059.0101.001</span></p>
                            </div>
                            <div class="order_pro_number"><span>25公斤/件  X  10</span></div>
                        </td>
                        <td rowspan="3" class="rtecenter">
                            <div class="order_total_price"><p>总额 <span>¥250000.00</span></p>银行转账</div>
                        </td>
                        <td rowspan="3" class="rtecenter">
                            <p>已确认收货</p>
                            <a href="">订单详情</a>
                        </td>
                        <td rowspan="3" class="rtecenter">
                            <input type="button" value="联系客服" />
                        </td>
                    </tr>
                    <tr>
                        <td width="300">
                            <div class="package_info">
                                <span>包裹2</span>
                                包裹编号：156464564564 ( 2016-12-02 已确认收货 )
                            </div>
                            <div class="order_pro_img"><img src="images/product_detil_img.jpg" width="60" height="60" /></div>
                            <div class="order_pro_info">
                                <h1>阳离子染料 苏州东吴 阳离子兰X阳离子兰 X阳离子兰X-GRRL 250%</h1>
                                <p><span>商品编号：S.D.0059.0101.001</span></p>
                            </div>
                            <div class="order_pro_number"><span>25公斤/件  X  10</span></div>
                        </td>
                    </tr>
                    <tr>
                        <td width="300">
                            <div class="order_pro_img"><img src="images/product_detil_img.jpg" width="60" height="60" /></div>
                            <div class="order_pro_info">
                                <h1>阳离子染料 苏州东吴 阳离子兰X阳离子兰 X阳离子兰X-GRRL 250%</h1>
                                <p><span>商品编号：S.D.0059.0101.001</span></p>
                            </div>
                            <div class="order_pro_number"><span>25公斤/件  X  10</span></div>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div class="order_pro_return">
                    <em>退货单</em>
                    <div class="order_pro_return_list">
                        <span>退货清单：</span>
                        <p>阳离子染料 苏州东吴 阳离子兰X阳离子兰X阳离子兰X-GRRL 250%<span>39公斤</span><span>退款额：<i>¥ 500.00</i></span></p>
                        <p>阳离子染料 苏州东吴 阳离子兰X阳离子兰X阳离子兰X-GRRL 250%<span>19公斤</span><span>退款额：<i>¥ 5200.00</i></span></p>
                        <h1><span>退款总额：</span><i>¥ 5700.00</i></h1>
                    </div>
                    <input type="submit" value="确认退货" />
                </div>
            </div>--%>
        </div>

        <div class="business-pages fl">
            <jsp:include page="/page/common/pagination.jsp"></jsp:include>
        </div>
    </div>
    <div class="clear"></div>
</div>
<%@ include file="/page/common/foot.jsp" %>
<script language="javascript" type="text/javascript">
    var theTab1_box = new Array('already_price','my_collection');
    var theTab1 = new AlexTab2('tab01',theTab1_box);
    theTab1;
</script>
</body>
</html>