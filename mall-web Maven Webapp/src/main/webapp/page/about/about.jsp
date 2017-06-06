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
    <link rel="shortcut icon" href="${ctx}/images/favicon.ico" type="image/x-icon" />
    <link href="/css/bootstrap.min.css" rel="stylesheet" type="text/css" />


    <link href="/css/public.min.css" rel="stylesheet" type="text/css" />
    <link href="/css/idangerous.swiper2.7.6.css" rel="stylesheet" type="text/css" />
    <link href="/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/css/about.css" rel="stylesheet" type="text/css" />
    <link href="/css/chanlstyle.css" rel="stylesheet" type="text/css"  />
    <link href="/css/mall_buy_center.css" rel="stylesheet" type="text/css" />
    <link href="/css/mall_about.css" rel="stylesheet" type="text/css" />


    <script language="javascript" type="text/jscript" src="/js/jquery-1.11.1.min.js"></script>
    <script language="javascript" type="text/jscript" src="/js/bootstrap.min.js"></script>
    <script language="javascript" type="text/javascript" src="/js/public.min.js"></script>
    <script language="javascript" type="text/javascript" src="/js/idangerous.swiper2.7.6.min.js"></script>
    <script language="javascript" type="text/javascript" src="/js/common.js?t=1482987689021"></script>
    <script language="javascript" type="text/javascript" src="/js/commons.js?t=1482987689021"></script>
    <script language="javascript" type="text/javascript" src="/js/ajaxfileupload.js"></script>





    <script language="javascript" type="text/jscript" src="/js/alagzn.js"></script>
    <script>
        $(document).ready(function(){
            console.log('${t}'=='3');
            $("ul.about_menu_list li").click(function(){
                $("ul.about_menu_list li").removeClass("onthis");
                $("div.about_right").hide();
                $(this).addClass("onthis");
                /*$("div." + $(this).attr("data-type")).show();*/
                console.log($(this).attr("id"));
                $("div." + $(this).attr("id")).show();
            })
            if('${t}'=='1'){
                /*$("ul.about_menu_list li[data-type='i7_about']").click()*/
                $("ul.about_menu_list #i7_about").click();
            }
            if('${t}'=='2'){
                /*$("ul.about_menu_list li[data-type='i7_partner']").click()*/
                $("ul.about_menu_list #i7_partner").click();
            }
            if('${t}'=='3'){
                /*$("ul.about_menu_list li[data-type='i7_future']").click()*/
                $("ul.about_menu_list #i7_future").click();
            }
            if('${t}'=='4'){
                /*$("ul.about_menu_list li[data-type='i7_guide']").click()*/
                $("ul.about_menu_list #i7_guide").click();
            }

            //显示注册协议
            if($.getUrlParam("source") == 'reg'){
                $("#link_agree").click();
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
        <span>关于七彩云</span>
        <%--&gt;
        <span>七彩云简介</span>--%>
    </p>
    <div class="about_left">
        <div class="about_menu">
            <h1 class="about_title"><em></em>关于七彩云</h1>
            <ul class="about_menu_list">
                <a href="javascript:;"><li data-type="i7_about" class="onthis" id="i7_about">七彩云简介</li></a>
                <a href="javascript:;"><li data-type="i7_partner" id="i7_partner">企业文化</li></a>
                <a href="javascript:;"><li data-type="i7_future" id="i7_future">联系我们</li></a>
                <a href="javascript:;"><li data-type="i7_guide" id="i7_guide">采购指南</li></a>
            </ul>
        </div>
        <img src="${itx}/ad/about_img.png" width="240" />
    </div>
    <div class="about_right i7_about">
        <div class="about_con_title">七彩云简介</div>
        <%--<div class="about_text_title">品牌介绍<br/><span></span></div>--%>
        <div class="about_text_box">
            <p>　　上海七彩云电子商务有限公司成立于2015年5月，七彩云染化电商平台于2016年4月13日正式上线运行。公司由中国印染行业协会、中国染料工业协会发起成立，公司主要股东还包括上海安诺其集团股份有限公司、盛虹集团有限公司、宜兴乐祺纺织集团有限公司、绍兴柯桥新都印染有限公司、石狮市祥华集团有限公司、广东工信科技服务有限公司。</p>
            <p>　　七彩云染化电商平台将通过整合国内外纺织印染、染料化工等产业链的优势资源，网聚各路英才，培育平台优势，努力为客户创造价值。平台将努力发挥资源优势，借助互联网的力量和创新的思维模式，推动合作伙伴更有效率地进行商业活动，帮助合作伙伴探索传统行业与电商的融合之道，实现企业自身价值增长乃至跨越式发展，推动纺织印染和染料化工行业健康发展和产业升级。</p>
            <p>　　七彩云染化电商平台是为印染企业和染化企业提供服务的平台，平台将努力打造多方共赢生态圈，在两个协会的领导支持下，通过持续完善和创新，致力于打造全球染化电商第一品牌。</p>
            <p>    “七彩梦想，共创共享”，让我们携手共进，合作共赢，共创平台，共享成果。</p>
        </div>
        <ul class="about_adv_list">
            <li>
                <div class="about_adv_text">
                    <h1>专业服务</h1>
                    <p>七彩云拥有强大的专家顾问团及丰富实践经验的技术工程师，全力为会员提供一站式色彩解决方案。</p>
                </div>
            </li>
            <li>
                <div class="about_adv_text">
                    <h1>产品齐全</h1>
                    <p>七彩云拥有强大的专家顾问团及丰富实践经验的技术工程师，全力为会员提供一站式色彩解决方案。</p>
                </div>
            </li>
            <li>
                <div class="about_adv_text">
                    <h1>快速供应</h1>
                    <p>七彩云拥有强大的专家顾问团及丰富实践经验的技术工程师，全力为会员提供一站式色彩解决方案。</p>
                </div>
            </li>
        </ul>
        <div class="our_adv">
            <div class="our_adv_title">我们的优势<br/><span></span></div>
            <ul class="our_adv_con">
                <li>
                    <img src="images/jzcg_icon.png" width="194" />
                    <h1>集中采购</h1>
                    <span></span>
                    <p>七彩云平台的本质某种意义上讲就是在线的染料团购模式，减少营销成本、便于供应链管理，同时有利于染料和印染企业。</p>
                </li>
                <li>
                    <img src="images/zxms_icon.png" width="194" />
                    <h1>直销模式</h1>
                    <span></span>
                    <p>去中间化是电子商务的核心，为了更好地服务于客户并缩短供应链，七彩云全部采取直销模式，由七彩云直接面对终端印染客户开展交易并提供专业服务。</p>
                </li>
                <li>
                    <img src="images/bzty_icon.png" width="194" />
                    <h1>标准统一</h1>
                    <span></span>
                    <p>为了利于染料企业组织生产、印染企业减少不必要的库存，七彩云供应的品种中相同结构或成分一致的品种原则上只提供单一标准，少数产品根据市场需求提供两个不同力份的标准。</p>
                </li>
            </ul>
        </div>
    </div>
    <div class="about_right i7_partner" style="display: none;">
        <div class="about_con_title">企业文化</div>
        <%--<ul class="about-link of">
            <li>
                <div class="about-title of">七彩云助力印染企业提效降耗</div>
                <div class="about-con of">
                    <p>1.集中采购，减少中间环节，降低成本；</p>
                    <p>2.快速配送，降低客户库存，减少资金压力；</p>
                    <p>3.印染企业采购一站式服务，提高采购效率；</p>
                    <p>4.有效处理客户滞压库存；</p>
                    <p>5.全面纺织化学品及行业动态信息，有助经营决策；</p>
                    <p>6.优质的专业技术支持和培训。</p>
                </div>
                <div class="about-bg"></div>
            </li>
            <li>
                <div class="about-title of">七彩云助力染料企业发展增效</div>
                <div class="about-con of">
                    <p>1.减少中间环节依赖，竞争力更强；</p>
                    <p>2.全球优质终端客户群，更直接的销售渠道；</p>
                    <p>3.更专业的技术推广助力产品销售；</p>
                    <p>4.有效规避应收款风险；</p>
                    <p>5.集中采购，有计划安排生产运营；</p>
                    <p>6.提供更好的广告宣传平台;</p>
                    <p>7.延伸金融支持，解决融资难题。</p>
                </div>
                <div class="about-bg"></div>
            </li>
        </ul>--%>
        <div class="about_text_box">
            <p>　　使  命：打造全球染化电商第一品牌</p>
            <p>　　愿  景：引领色彩领域数字化革命</p>
            <p>　　核心价值观：七彩梦想、共创共享</p>
            <p>　　营销理念：网聚行业资源，助推客商发展</p>
            <p>　　服务理念：色彩服务一站式解决方案</p>
        </div>
    </div>
    <div class="about_right i7_future" style="display: none;">
        <%--<div class="about_con_title">七彩云未来</div>
        <div style="padding:15px 0 15px 15px;font-size:14px;">
            在互联网大力发展的时代，“七彩云”作为中国首个专业的染料第三方电商专业平台承载着太多的责任与期望。“携手共进，合作共赢！”
        </div>
        <div style="padding:15px 0 15px 15px;font-size:14px;">
            <img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/img0026.png" style="margin-left:15px" class="fr">
            <p>——这是一个七彩“中国梦”！</p>
            <p>目标打造国际染料及相关化工产品最大的专业交易平台</p>
            <p>愿景引领色彩领域数字化革命</p>
            <p>理念色彩服务一站式解决方案</p>
        </div>--%>

        <div class="about_con_title">联系我们</div>
        <div class="ad"><img src="http://static.i7colors.com/i7/about_0089.jpg" /></div>
        <div class="map" style="margin-bottom:50px;"><img src="http://static.i7colors.com/i7/about_0090.jpg" /></div>


    </div>
    <div class="about_right i7_guide" style="display: none;">
            <div class="about_con_title">采购指南</div>
            <div class="navlist">
                <input type="hidden" id="jumpNum" value="" />
                <ul class="menu-nav of m0a">
                    <li>
                        <a href="javascript:void(0)"><i><img src="images/img0002.png" /></i>
                            <p>
                                注册
                            </p></a>
                    </li>
                    <li>
                        <a href="javascript:void(0)"><i><img src="images/img0003.png" /></i>
                            <p>
                                询价
                            </p></a>
                    </li>
                    <li>
                        <a href="javascript:void(0)"><i><img src="images/img0004.png" /></i>
                            <p>
                                购物
                            </p></a>
                    </li>
                    <li>
                        <a href="javascript:void(0)"><i><img src="images/img0005.png" /></i>
                            <p>
                                代客下单
                            </p></a>
                    </li>
                    <li>
                        <a href="javascript:void(0)"><i><img src="images/img0006.png" /></i>
                            <p>
                                常见问题Q&A
                            </p></a>
                    </li>
                </ul>
            </div>
            <div class="b-c-main b-c-bg01" style="height:1920px;">
                <div class="part part01 of">
                    <div class="dw">
                        &nbsp; <a name="a1" id="a1"></a>
                    </div>
                    <div class="part-title">
                        注册
                    </div>
                    <div class="part-con">
                        <h4>操作指南</h4>
                        <ul class="of">
                            <li>
                                <i>1</i><a>注册按钮</a>
                                <span>点击页面的注册按钮</span>
                            </li>
                            <li>
                                <i>2</i><a>填写信息</a>
                                <span>在注册页面填写注册信息</span>
                            </li>
                            <li>
                                <i>3</i><a>提交注册</a>
                                <span>信息填写核对完成后 提交</span>
                            </li>
                            <li>
                                <i>4</i><a>邮箱激活</a>
                                <span>点击注册邮箱收到的验证 邮件链接激活</span>
                            </li>
                            <li class="last">
                                <i>5</i><a>注册完成</a>
                                <span>跳转到网站 完成注册 获得账号和密码</span>
                            </li>
                        </ul>
                        <h4>注意事项</h4>
                        <div class="text">
                            <p class="color">
                                为保证注册过程可以顺利完成，请保证以下信息的正确性
                            </p>
                            <p>
                                1.邮箱信息请注意核实，注册激活链接、分配给您的账号及密码以及后续相关文件将通过此邮箱发送给您，请保证所填写的邮箱为正确邮箱，建议填写企业用邮箱。
                            </p>
                            <p>
                                2.注册时填写的相关信息与图片内容一致。
                            </p>
                            <p>
                                3.获取帐号密码后请到买家中心修改密码，并完善收货地址及发票信息。
                            </p>
                        </div>
                    </div>
                </div>
                <!--end of part01-->
                <div class="part part02 of">
                    <div class="dw">
                        &nbsp; <a name="a2" id="a2"></a>
                    </div>
                    <div class="part-title">
                        询价
                    </div>
                    <div class="part-con">
                        <h4>操作指南</h4>
                        <ul class="of">
                            <li>
                                <i>1</i><a>登录</a>
                                <span>用注册成功的账号登录</span>
                            </li>
                            <li>
                                <i>2</i><a>选择商品</a>
                                <span>选择意向产品</span>
                            </li>
                            <li>
                                <i>3</i><a>发起询价</a>
                                <span>点击询价按钮询价</span>
                            </li>
                            <li class="last">
                                <i>4</i><a>确认报价</a>
                                <span>等待商家报价 完成询价</span>
                            </li>
                        </ul>
                        <h4>注意事项</h4>
                        <div class="text">
                            <p class="color">
                                为保证询价过程可以顺利完成，请保证以下信息的正确性
                            </p>
                            <p>
                                1.请先注册并登陆后再发起询价。
                            </p>
                            <p>
                                2.询价时请注意数量要大于商品起批数量并且是包装形式的整数倍。
                            </p>
                            <p>
                                3.所询商品价格具有12小时时效性，12小时过后价格将自动关闭。
                            </p>
                        </div>
                    </div>
                </div>
                <!--end of part02-->
                <div class="part part03 of">
                    <div class="dw">
                        &nbsp; <a name="a3" id="a3"></a>
                    </div>
                    <div class="part-title">
                        购物
                    </div>
                    <div class="part-con">
                        <h4>操作指南</h4>
                        <ul class="of">
                            <li>
                                <i>1</i><a>同意报价</a>
                                <span>同意商家的报价</span>
                            </li>
                            <li>
                                <i>2</i><a>加入清单</a>
                                <span>将所需产品和数量加入订单</span>
                            </li>
                            <li>
                                <i>3</i><a>提交订单</a>
                                <span>提交订单</span>
                            </li>
                            <li>
                                <i>4</i><a>完成支付</a>
                                <span>选择付款方案付款</span>
                            </li>
                            <li class="last">
                                <i>5</i><a>确认收货</a>
                                <span>收到货物后网上确认收货</span>
                            </li>
                        </ul>
                        <h4>注意事项</h4>
                        <div class="text">
                            <p class="color">
                                为保证下单过程可以顺利完成，请保证以下信息的正确性
                            </p>
                            <p>
                                1.请在提交订单前填写收货信息和账单信息，并确保相关内容的正确性。
                            </p>
                            <p>
                                2.需发票请在提交订单前填选相关发票信息，确认收货后我们将寄出您的发票。
                            </p>
                            <p>
                                3.款项到账后即可发货，请在收到产品后及时登录网站，并确认收货。
                            </p>
                        </div>
                    </div>
                </div>
                <!--end of part03-->
                <%--<div class="part part04 of">
                    <div class="dw">
                        &nbsp; <a name="a4" id="a4"></a>
                    </div>
                    <div class="part-title">
                        代客下单
                    </div>
                    <div class="part-con">
                        <h4>操作指南</h4>
                        <ul class="of">
                            <li>
                                <i>1</i><a>采购信息提供</a>
                                <span>向客服提供所需产品信息</span>
                            </li>
                            <li>
                                <i>2</i><a>客服代下单</a>
                                <span>客服完成询价下单操作</span>
                            </li>
                            <li class="last">
                                <i>3</i><a>确认订单</a>
                                <span>客户确认产品价格 数量</span>
                            </li>
                            <li class="last">
                                <i>4</i><a>完成支付</a>
                                <span>客户选择付款方案付款</span>
                            </li>
                        </ul>
                        <h4>注意事项</h4>
                        <div class="text">
                            <p class="color">
                                为保证代客下单过程可以顺利完成，请保证以下信息的正确性
                            </p>
                            <p>
                                1.已注册的会员可享受代客下单的专属服务。
                            </p>
                            <p>
                                2.客服将根据会员的具体要求协助完成下单，但请不要告知登陆密码。
                            </p>
                            <p>
                                3.客服下单后，由会员本人确认相关信息并自行完成付款。
                            </p>
                        </div>
                    </div>
                </div>--%>
                <!--end of part04-->
                <div class="part05 of">
                    <div class="dw">
                        &nbsp; <a name="a5" id="a5"></a>
                    </div>
                    <div class="part-title q-title of">
                        常见问题Q&A
                    </div>
                    <ul class="q-list">
                        <li>
                            <a>Q:如何注册？</a>
                            <p>
                                A:具体操作请查看注册流程说明：<a href="javascript:void(0)" style="display: inline-block;" onclick="$('body').animate({scrollTop:$('.part01').find('.part-title').offset().top});">链接</a>。
                            </p>
                        </li>
                        <li>
                            <a>Q:邮箱收不到邮件怎么办？</a>
                            <p>
                                A:请确认您的邮箱填写是否正确并拨打客服热线400-920-8599联系客服，我们将尽快为您解决。
                            </p>
                        </li>
                        <li>
                            <a>Q:邮箱链接打不开怎么办？</a>
                            <p>
                                A:请将此链接复制到浏览器自行打开，若还无法打开请拨打客服热线400-920-8599联系客服，我们将尽快为您解决。
                            </p>
                        </li>
                        <li>
                            <a>Q:用户名或密码忘记了怎么办？</a>
                            <p>
                                A:用户名是您注册时使用的邮箱，若您忘记密码请拨打客服热线400-920-8599联系您的专属客服，我们将为您提供重置密码的服务。
                            </p>
                        </li>
                        <li>
                            <a>Q:如何询价？</a>
                            <p>
                                A:具体操作请查看询价流程说明：<a href="javascript:void(0)" style="display: inline-block;" onclick="$('body').animate({scrollTop:$('.part02').find('.part-title').offset().top});">链接</a>。
                            </p>
                        </li>
                        <li>
                            <a>Q:如何购物？</a>
                            <p>
                                A:具体操作请查看购物流程说明：<a href="javascript:void(0)" style="display: inline-block;" onclick="$('body').animate({scrollTop:$('.part03').find('.part-title').offset().top});">链接</a>。
                            </p>
                        </li>
                        <li>
                            <a>Q:有哪些支付方式？</a>
                            <p>
                                A:我们有：现款支付、网银支付、电子汇票、纸质承兑汇票、转账、纸质银行汇票、支票等多种支付方式，您可以自行选择适用的支付方式进行支付。
                            </p>
                        </li>
                        <li>
                            <a>Q:提供什么类型的发票？</a>
                            <p>
                                A:我们提供：增值税专用发票、增值税普通发票、普通发票，您可在下单时根据您的需求自行选择。
                            </p>
                        </li>
                    </ul>
                </div>
                <!--end of part05-->
                <div class="part06 of">
                    <h3>七彩云电子商务网站用户注册协议和所需信息及材料</h3>
                    <a href="javascript:void(0)" data-toggle="modal" data-target="#readme1Dialog" id="link_agree">查看七彩云电子商务网站用户注册协议</a>
                    <a href="javascript:void(0)" data-toggle="modal" data-target="#readme2Dialog">查看七彩云商务网站用户注册所需信息及材料</a>
                </div>
                <a href="javascript:void(0)" class="top" onclick="$('body').animate({scrollTop:$('body').offset().top});"></a>
            </div>
        <div class="clear"></div>

        <!-- 七彩云电子商务网站用户注册协议start -->
        <div class="modal fade" id="readme1Dialog" aria-hidden="true">
            <div class="modal-dialog" style="width: 80%;">
                <div class="modal-content">
                    <div class="modal-body" id="readme1"><p class="MsoNormal" align="center" style="text-align: center; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><strong><span style="font-size:14.0pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:
Arial;mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">七彩云电子商务网站用户注册协议</span></strong><strong><span lang="EN-US" style="font-size:14.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt"><o:p></o:p></span></strong></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">本协议是用户（以下简称</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">“</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">”</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">）与七彩云电子商务网站（网址：包括但不限于</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">www.i7colors.com</span><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">等，简称</span><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt">“</span><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">本站</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;
font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt">”</span><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">）所有者（上海七彩云电子商务有限公司）及其关联公司之间就七彩云电子商务网站（以下简称为</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">“</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">七彩云电子商务</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">”</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">）服务等相关事宜所订立的契约，请您仔细阅读本注册协议，您点击</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">"</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">同意并继续</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">"</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">按钮后，即视为您接受并同意遵守本协议的约定。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 22.5pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">第</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt">1</span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">条</span></strong><strong><span style="mso-bidi-font-size:10.5pt;
font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"> </span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">本站服务条款的确认和接纳</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt"><o:p></o:p></span></strong></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">1.1</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">本站的各项电子服务的所有权和运作权归上海七彩云电子商务有限公司所有。您同意所有注册协议条款并完成注册程序，才能成为本站的正式用户。您确认：本协议条款是处理双方权利义务的依据，始终有效，法律另有强制性规定或双方另有特别约定的，依其规定或约定。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">1.2</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您点击同意本协议的，即视为您确认自己具有享受本站服务、下单购物等相应的权利能力和行为能力，能够独立承担法律责任。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">1.3</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">本站的各项服务仅供能够根据相关法律订立具有法律约束力的合约的个人或公司使用。因此，您的年龄必须在十八周岁或以上，才可使用本公司服务。如不符合本项条件，请勿使用“服务”。七彩云电子商务可随时自行全权决定拒绝向任何人士提供“服务”。“服务”不会提供给被暂时或永久中止资格的会员。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 13.5pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">1.4</span><strong><em><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">上海七彩云电子商务有限公司保留在中华人民共和国大陆地区施行之法律允许的范围内独自决定拒绝服务、关闭用户账户、清除或编辑内容或取消订单的权利。</span></em></strong><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">1.5</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您使用本站提供的服务时，应同时接受适用于本站特定服务、活动等的准则、条款和协议（以下统称为</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">“</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">其他条款</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">”</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">）；如果以下使用条件与</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">“</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">其他条款</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">”</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">有不一致之处，则以</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">“</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">其他条款</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">”</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">为准。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">1.6</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">为表述便利，商品和服务简称为</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">“</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">商品</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">”</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">或</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">“</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">货物</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">”</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 22.5pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">第</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt">2</span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">条</span></strong><strong><span style="mso-bidi-font-size:10.5pt;
font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"> </span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">本站服务</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></strong></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">2.1</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">七彩云电子商务网站通过互联网依法为您提供互联网信息及商品买卖等服务，您在完全同意本协议及本站相关规定的情况下，方有权使用本站的相关服务。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">2.2</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您必须自行准备如下设备和承担如下开支：（</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">1</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">）上网设备，包括并不限于电脑或者其他上网终端、调制解调器及其他必备的上网装置；（</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">2</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">）上网开支，包括并不限于网络接入费、上网设备租用费、手机流量费等。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">2.2.1</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">上网设备，包括并不限于电脑或者其他上网终端、调制解调器及其他必备的上网装置；</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">2.2.2</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">上网开支，包括并不限于网络接入费、上网设备租用费、手机流量费等。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 22.5pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">第</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt">3</span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">条</span></strong><strong><span style="mso-bidi-font-size:10.5pt;
font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"> </span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">用户信息收集及保护</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></strong></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">3.1</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您应自行诚信向本站提供注册资料，您保证提供的注册资料真实、准确、完整、合法有效，您的注册资料如有变动的，应及时更新其注册资料。如果您提供的注册资料不合法、不真实、不准确、不详尽的，您需承担因此引起的相应责任及后果，并且七彩云电子商务网站保留单方终止您使用七彩云电子商务各项服务的权利。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">3.2</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您在本站进行注册、浏览、下单购物、评价、参加活动等行为时，涉及您真实姓名</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">/</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">名称、通信地址、联系电话、电子邮箱、订单详情、评价或反馈、投诉内容、</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">cookies</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">等信息的，本站有权从完成交易、提供配送、售后及客户服务、开展活动、完成良好的客户体验等多种角度予以收集，并将对其中涉及个人隐私信息予以严格保密，除非得到您的授权、为履行强行性法律义务（如国家安全机关指令）或法律另有规定、本注册协议或其他条款另有约定外，本站不会向外界披露您的隐私信息。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">3.3</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">注册成功后，将产生用户名和密码等账户信息，您可以根据本站规定更改您的密码。您应谨慎合理的保存、使用您的账户信息。您若发现任何非法使用您的账户或其他存在安全漏洞的情况的，请立即通知本站并向公安机关报案。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">3.4</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您同意，七彩云电子商务网站拥有通过邮件、短信、电话、网站通知或声明等形式，向在本站注册、购物的用户、收货人发送订单信息、促销活动、售后服务、客户服务等告知信息的权利。如您不希望接收上述信息，可退订。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">3.5</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您同意：选择向本站的商品销售商或服务提供商（以下统称为</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">“</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">销售商</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">”</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">，含七彩云电子商务及第三方卖家）提交订单购买商品或服务的，视为您向销售商披露个人相关信息，接受销售商向您提供商品销售、配送、售后服务、客户服务、处理信用卡付款、数据分析、市场营销帮助或其他必要事宜；如前述全部或部分事宜之一涉及由销售商外的第三方履行的，销售商有权将您的信息以必要方式向第三方披露，第三方有权以履行上述事宜为目的联系您。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">3.6</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您不得将在本站注册获得的账号、密码等账户信息提供给他人使用，否则您应承担由此产生的全部责任，并与实际使用人承担连带责任。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">3.7</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您同意，七彩云电子商务有权使用您的注册信息、用户名、密码等信息，登陆进入您的注册账户，进行证据保全，包括但不限于公证、见证、协助司法机关进行调查取证等。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">3.8</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您同意接受七彩云电子商务发送的各类短信通知。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 22.5pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">第</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt">4</span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">条</span></strong><strong><span style="mso-bidi-font-size:10.5pt;
font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"> </span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">用户依法言行义务</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></strong></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">本协议依据国家相关法律法规规章制定，您同意严格遵守以下义务：</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.1</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">不得传输或发表：煽动抗拒、破坏宪法和法律、行政法规实施的言论，煽动颠覆国家政权，推翻社会主义制度的言论，煽动分裂国家、破坏国家统一的言论，煽动民族仇恨、民族歧视、破坏民族团结的言论；</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.2</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">从中国大陆向境外传输资料信息时必须符合中国有关法律法规；</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.3</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">不得利用本站从事洗钱、窃取商业秘密、窃取个人信息等违法犯罪活动；</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.4</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">不得干扰本站的正常运转，不得侵入本站及国家计算机信息系统；</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.5</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">不得传输或发表任何违法犯罪的、骚扰性的、中伤他人的、辱骂性的、恐吓性的、伤害性的、庸俗的，淫秽的、不文明的等信息资料；</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.6</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">不得传输或发表损害国家社会公共利益和涉及国家安全的信息资料或言论；</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.7</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">不得教唆他人从事本条所禁止的行为；</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.8</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">除本注册协议、其他条款或另有其他约定外，您不得利用在本站注册的账户进行经营活动、牟利行为及其他未经本站许可的行为，包括但不限于以下行为：</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.8.1</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您账户内任何七彩云电子商务网站优惠的信息（包括但不限于云币、云券、云豆及其他形式优惠或折扣等）由七彩云电子商务享有解释权和修改权，您仅享有在七彩云电子商务购物时的使用权，严禁转卖七彩云电子商务账户、云币、云券、云豆或其他类型的优惠券、七彩云电子商务卡、或利用七彩云电子商务账户进行其他经营性行为等；</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.8.2</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">恶意利用技术手段或其他方式，为获取优惠、折扣或其他利益而注册账户、下单等行为，影响其他用户正常消费行为或相关合法权益、影响七彩云电子商务正常销售秩序的行为；</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.8.3</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">发布广告、垃圾邮件；</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.8.4</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">以再销售或商业使用为目的对本站商品或服务进行购买的（与七彩云电子商务另有合同约定的除外）；</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.8.5</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">商品或服务的供应商、代理商对其所供商品进行回购的行为；</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.8.6</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">任何对商品目录、说明、价格、数量、其他用户信息或其他内容的下载、转载、收集、衍生利用、复制、出售、转售或其他形式的使用，无论是否通过</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">Robots</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">、</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">Spiders</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">、自动仪器或手工操作；</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.8.7</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">本站相关规则、政策、或网页活动规则中限制、禁止的行为；</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.8.8</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">其他影响七彩云电子商务对用户账户正常管理秩序的行为。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.9</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您不得利用任何非法手段获取其他用户个人信息，不得将其他用户信息用于任何营利或非营利目的，不得泄露其他用户或权利人的个人隐私，否则七彩云电子商务有权采取本协议规定的合理措施制止您的上述行为，情节严重的，将提交公安机关进行刑事立案。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.10</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您不得发布任何侵犯他人著作权、商标权等知识产权或其他合法权利的内容；如果有其他用户或权利人发现您发布的信息涉嫌知识产权、或其他合法权益争议的，这些用户或权利人有权要求七彩云电子商务删除您发布的信息，或者采取其他必要措施予以制止，七彩云电子商务将会依法采取这些措施。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.11</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您应不时关注并遵守本站不时公布或修改的各类规则规定。本站保有删除站内各类不符合法律政策或不真实的信息内容而无须通知您的权利。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">4.12</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">若您未遵守以上规定的，本站有权做出独立判断并采取暂停或关闭您的账号、冻结账号内余额及七彩云电子商务卡金额、关闭相应交易订单、停止发货等措施。您须对自己在网上的言论和行为承担法律责任。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 22.5pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">第</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt">5</span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">条</span></strong><strong><span style="mso-bidi-font-size:10.5pt;
font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"> </span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">商品信息</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></strong></p>

                        <p class="MsoNormal" align="left" style="line-height: 13.5pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><strong><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">5.1</span></strong><strong><em><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">本站上的商品价格、数量、是否有货等商品信息随时都有可能发生变动，本站不作特别通知。由于网站上商品信息的数量极其庞大，虽然本站会尽最大努力保证您所浏览商品信息的准确性，但由于众所周知的互联网技术因素等客观原因存在，本站网页显示的信息可能会有一定的滞后性或差错，对此情形您知悉并理解；七彩云电子商务网站欢迎纠错，并会视情况给予纠错者一定的奖励。</span></em></strong><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">5.1</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">本站售后服务政策为本协议的组成部分，七彩云电子商务有权以声明、通知或其他形式变更售后服务政策。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 22.5pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">第</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt">6</span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">条</span></strong><strong><span style="mso-bidi-font-size:10.5pt;
font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"> </span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">订单</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></strong></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">6.1</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">在您下订单时，请您仔细确认所购商品的名称、价格、数量、型号、规格、尺寸、联系地址、电话、收货人等信息。收货人与您本人不一致的，收货人的行为和意思表示视为您的行为和意思表示，您应对收货人的行为及意思表示的法律后果承担连带责任。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 13.5pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><strong><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">6.2</span></strong><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">除法律另有强制性规定外，双方约定如下：<strong><em>本站上销售方展示的商品和价格等信息仅仅是交易信息的发布，您下单时须填写您希望购买的商品数量、价款及支付方式、收货人、联系方式、收货地址等内容；系统生成的订单信息是计算机信息系统根据您填写的内容自动生成的数据，仅是您向销售方发出的交易诉求；销售方收到您的订单信息后，只有在销售方将您在订单中订购的商品从仓库实际直接向您发出时（</em></strong></span><strong><em><span style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt"> </span></em></strong><strong><em><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">以商品出库为标志），方视为您与销售方之间就实际直接向您发出的商品建立了交易关系；如果您在一份订单里订购了多种商品并且销售方只给您发出了部分商品时，您与销售方之间仅就实际直接向您发出的商品建立了交易关系；只有在销售方实际直接向您发出了订单中订购的其他商品时，您和销售方之间就订单中该其他已实际直接向您发出的商品才成立交易关系。您可以随时登录您在本站注册的账户，查询您的订单状态。</span></em></strong><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">6.3</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">尽管销售商做出最大的努力，但商品目录里的一小部分商品可能会有定价错误。如果发现错误定价，将采取下列之一措施，且不视为违约行为：</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">6.3.1</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">如果某一商品的正确定价低于销售商的错误定价，销售商将按照较低的定价向您销售交付该商品。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">6.3.2</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">如果某一商品的正确定价高于销售商的错误定价，销售商会通知您，并根据实际情况决定是否取消订单、停止发货、为已付款用户办理退款等。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">6.4</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">由于市场变化及各种以合理商业努力难以控制的因素的影响，本站无法保证您提交的订单信息中希望购买的商品都会有货；如您下单所购买的商品，发生缺货，您有权取消订单，销售商亦有权取消订单，并为已付款的用户办理退款。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 22.5pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">第</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt">7</span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">条</span></strong><strong><span style="mso-bidi-font-size:10.5pt;
font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"> </span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">配送</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></strong></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">7.1</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">销售商将会把商品（货物）送到您所指定的收货地址，所有在本站上列出的送货时间为参考时间，参考时间的计算是根据库存状况、正常的处理过程和送货时间、送货地点等相关信息估计得出的。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">7.2</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">因如下情况造成订单延迟或无法配送、交货等，销售商不承担延迟配送、交货的责任：</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">（</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">1</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">）您提供的信息错误、地址不详细等原因导致的；</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">（</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">2</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">）货物送达后无人签收，导致无法配送或延迟配送的；</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">（</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">3</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">）情势变更因素导致的；</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">（</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">4</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">）因节假日、大型促销活动、店庆、预购或抢购人数众多等原因导致的；</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">（</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">5</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">）不可抗力因素导致的，例如：自然灾害、交通戒严、突发战争等。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 22.5pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">第</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt">8</span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">条</span></strong><strong><span style="mso-bidi-font-size:10.5pt;
font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"> </span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">所有权及知识产权条款</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt"><o:p></o:p></span></strong></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">8.1</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您一旦接受本协议，即表明您主动将其在任何时间段在本站发表的任何形式的信息内容（包括但不限于客户评价、客户咨询、各类话题文章等信息内容）的财产性权利等任何可转让的权利，如著作权财产权（包括并不限于：复制权、发行权、出租权、展览权、表演权、放映权、广播权、信息网络传播权、摄制权、改编权、翻译权、汇编权以及应当由著作权人享有的其他可转让权利），全部独家且不可撤销地转让给七彩云电子商务所有，您同意七彩云电子商务有权就任何主体侵权而单独提起诉讼。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">8.2</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">本协议已经构成《中华人民共和国著作权法》第二十五条（条文序号依照</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">2011</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">年版著作权法确定）及相关法律规定的著作财产权等权利转让书面协议，其效力及于您在七彩云电子商务网站上发布的任何受著作权法保护的作品内容，无论该等内容形成于本协议订立前还是本协议订立后。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">8.3</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您同意并已充分了解本协议的条款，承诺不将已发表于本站的信息，以任何形式发布或授权其他主体以任何方式使用（包括但不限于在各类网站、媒体上使用）。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">8.4</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">上海七彩云电子商务有限有权不时地对本协议及本站的内容进行修改，并在本站张贴，无须另行通知您。在法律允许的最大限度范围内，上海七彩云电子商务有限公司对本协议及本站内容拥有解释权。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">8.5</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">除法律另有强制性规定外，未经七彩云电子商务网站明确的特别书面许可</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">,</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">任何单位或个人不得以任何方式非法地全部或部分复制、转载、引用、链接、抓取或以其他方式使用本站的信息内容，否则，上海七彩云电子商务有限公司有权追究其法律责任。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">8.6</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">本站所刊登的资料信息（包括但不限于文字、图表、商标、</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">logo</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">、标识、按钮图标、图像、声音文件片段、数字下载、数据编辑和软件等），均是七彩云电子商务网站或其内容提供者的财产，受中国和国际相关版权法规、公约等的保护，未经七彩云电子商务网站书面许可，任何第三方无权将上述资料信息复制、出版、发行、公开展示、编码、翻译、传输或散布至任何其他计算机、服务器、网站或其他媒介。本站上所有内容的汇编是上海七彩云电子商务有限公司的排他财产，受中国和国际版权法的保护。本站上所有软件都是七彩云电子商务或其关联公司或其软件供应商的财产，受中国和国际版权法的保护。您不得鼓励、协助或授权任何其他人复制、修改、反向工程、反向编译或反汇编、拆解或者试图篡改全部或部分软件，或利用软件创设衍生产品。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 22.5pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">第</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt">9</span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">条</span></strong><strong><span style="mso-bidi-font-size:10.5pt;
font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"> </span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">责任限制及不承诺担保</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt"><o:p></o:p></span></strong></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">9.1</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">除非另有明确的书面说明</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">,</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">本站及其所包含的或以其他方式通过本站提供给您的全部信息、内容、材料、产品（包括软件）和服务，均是在</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">“</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">按现状</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">”</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">和</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">“</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">按现有</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">”</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">的基础上提供的。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">9.2</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">除非另有明确的书面说明</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">,</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">七彩云电子商务不对本站的运营及其包含在本站上的信息、内容、材料、产品（包括软件）或服务作任何形式的、明示或默示的声明或担保（根据中华人民共和国法律另有规定的以外）。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">9.3</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">七彩云电子商务不担保本站所包含的或以其他方式通过本站提供给您的全部信息、内容、材料、产品（包括软件）和服务、其服务器或从本站发出的电子信件、信息没有病毒或其他有害成分。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">9.4</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">如因不可抗力或其他本站无法控制的原因使本站销售系统崩溃或无法正常使用导致网上交易无法完成或丢失有关的信息、记录等，七彩云电子商务会合理地尽力协助处理善后事宜。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">9.5</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您应对账户信息及密码承担保密责任，因您未能尽到信息安全和保密责任而致使您的账户发生任何问题的，您应承担全部责任。同时，因网络环境存在众多不可预知因素，因您自身终端网络原因（包括但不限于断网、黑客攻击、病毒等）造成您的七彩云电子商务账户或个人信息等被第三方窃取的，七彩云电子商务网站不承担赔偿责任。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">9.6</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您了解并同意，七彩云电子商务有权应国家有关机关的要求，向其提供您在七彩云电子商务网站的用户信息和交易记录等必要信息。如您涉嫌侵犯他人合法权益，则七彩云电子商务有权在初步判断涉嫌侵权行为可能存在的情况下，向权利人提供您必要的个人信息。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 22.5pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">第</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt">10</span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">条</span></strong><strong><span style="mso-bidi-font-size:10.5pt;
font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"> </span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">协议更新及用户关注义务</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt"><o:p></o:p></span></strong></p>

                        <p class="MsoNormal" align="left" style="line-height: 13.5pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">根据国家法律法规变化及网站运营需要，七彩云电子商务有权对本协议条款不时地进行修改，修改后的协议一旦被张贴在本站上即生效，并代替原来的协议。您可随时登陆查阅最新协议；<strong><em>您有义务不时关注并阅读最新版的协议、其他条款及网站公告。如您不同意更新后的协议，可以且应立即停止接受七彩云电子商务网站依据本协议提供的服务；如您继续使用本站提供的服务的，即视为同意更新后的协议。七彩云电子商务建议您在使用本站之前阅读本协议及本站的公告。</em></strong>如果本协议中任何一条被视为废止、无效或因任何理由不可执行，该条应视为可分的且并不影响任何其余条款的有效性和可执行性。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 22.5pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">第</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt">11</span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">条</span></strong><strong><span style="mso-bidi-font-size:10.5pt;
font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"> </span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">法律管辖和适用</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></strong></p>

                        <p class="MsoNormal" align="left" style="line-height: 13.5pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">本协议的订立、执行和解释及争议的解决均适用在中华人民共和国大陆地区适用之有效法律（但不包括其冲突法规则）。如发生本协议与适用之法律相抵触时，则这些条款将完全按法律规定重新解释，而其他条款继续有效。如缔约方就本协议内容或其执行发生任何争议，双方应尽力友好协商解决；协商不成时，任何一方均可向有管辖权的中华人民共和国大陆地区法院提起诉讼。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 22.5pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">第</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt">12</span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">条</span></strong><strong><span style="mso-bidi-font-size:10.5pt;
font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"> </span></strong><strong><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:Arial;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:#666666;
mso-font-kerning:0pt">其他</span></strong><strong><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></strong></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">12.1</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">七彩云电子商务网站所有者是指在政府部门依法许可或备案的七彩云电子商务网站经营主体。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">12.2</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">七彩云电子商务尊重您的合法权利，本协议及本站上发布的各类规则、声明、售后服务政策等其他内容，均是为了更好的、更加便利的为您提供服务。本站欢迎您和社会各界提出意见和建议，七彩云电子商务将虚心接受并适时修改本协议及本站上的各类规则。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">12.3</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">本协议内容中以黑体、加粗、下划线、斜体等方式显著标识的条款，请您着重阅读。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal" align="left" style="line-height: 15pt; background-image: initial; background-attachment: initial; background-size: initial; background-origin: initial; background-clip: initial; background-position: initial; background-repeat: initial;"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#666666;
mso-font-kerning:0pt">12.4</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">您点击本协议下方的</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">“</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">同意并继续</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt">”</span><span style="mso-bidi-font-size:
10.5pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;
mso-bidi-font-family:Arial;color:#666666;mso-font-kerning:0pt">按钮即视为您完全接受本协议，在点击之前请您再次确认已知悉并完全理解本协议的全部内容。</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
color:#666666;mso-font-kerning:0pt"><o:p></o:p></span></p>

                        <p class="MsoNormal"><span lang="EN-US">&nbsp;</span></p></div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                            关闭
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- 七彩云电子商务网站用户注册协议end -->

        <!-- 七彩云商务网站用户注册所需信息及材料start -->
        <div class="modal fade" id="readme2Dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body">
                        <table class="table table-bordered">
                            <tbody>
                            <tr>
                                <td colspan="4">七彩云会员注册所需信息和资料</td>
                            </tr>
                            <tr>
                                <td colspan="2">项目</td>
                                <td>检验方式</td>
                                <td>必填项</td>
                            </tr>
                            <tr>
                                <td rowspan="8">企业信息</td>
                                <td>组织机构代码</td>
                                <td>唯一性、合理性</td>
                                <td>是</td>
                            </tr>
                            <tr>
                                <td>企业名称</td>
                                <td>唯一性</td>
                                <td>是</td>
                            </tr>
                            <tr>
                                <td>税务登记证号</td>
                                <td>唯一性、合理性</td>
                                <td>是</td>
                            </tr>
                            <tr>
                                <td>营业执照注册号</td>
                                <td>唯一性、合理性</td>
                                <td>是</td>
                            </tr>
                            <tr>
                                <td>法人代表</td>
                                <td>不校验</td>
                                <td>是</td>
                            </tr>
                            <tr>
                                <td>企业开户行（增票信息）</td>
                                <td> 　</td>
                                <td>是</td>
                            </tr>
                            <tr>
                                <td>银行帐户（增票信息）</td>
                                <td> 　</td>
                                <td>是</td>
                            </tr>
                            <tr>
                                <td>企业描述</td>
                                <td>不校验</td>
                                <td>否</td>
                            </tr>
                            <tr>
                                <td rowspan="4">联系人信息</td>
                                <td>姓名</td>
                                <td>不校验</td>
                                <td>是</td>
                            </tr>
                            <tr>
                                <td>手机</td>
                                <td>唯一性</td>
                                <td>是</td>
                            </tr>
                            <tr>
                                <td>固定电话</td>
                                <td>不校验</td>
                                <td>否</td>
                            </tr>
                            <tr>
                                <td>电子邮箱</td>
                                <td>唯一性、合理性</td>
                                <td>是</td>
                            </tr>
                            <tr>
                                <td rowspan="3">地址信息</td>
                                <td>地区</td>
                                <td>不校验</td>
                                <td>是</td>
                            </tr>
                            <tr>
                                <td>详细地址</td>
                                <td>不校验</td>
                                <td>是</td>
                            </tr>
                            <tr>
                                <td>邮政编码</td>
                                <td>不校验</td>
                                <td>否</td>
                            </tr>
                            <tr>
                                <td rowspan="4">电子凭证（图片）</td>
                                <td>营业执照</td>
                                <td> 　</td>
                                <td>是</td>
                            </tr>
                            <tr>
                                <td>组织机构代码</td>
                                <td> 　</td>
                                <td>是</td>
                            </tr>
                            <tr>
                                <td>税务登记证</td>
                                <td> 　</td>
                                <td>是</td>
                            </tr>
                            <tr>
                                <td>电子签章</td>
                                <td> 　</td>
                                <td>否</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                            关闭
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <div class="clear"></div>
</div>


<%@ include file="/page/common/foot.jsp" %>
</body>
</html>