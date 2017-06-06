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
    <link href="/css/chanlstyle.css" type="text/css" rel="stylesheet" />
    <link href="/css/mall_partner.css" type="text/css" rel="stylesheet" />
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

            $(".partner_list a").attr("href", "javascript:;");
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
            <h1 class="about_title"><em></em>供应商服务</h1>
            <ul class="about_menu_list">
                <a href="javascript:;"><li data-type="i7_about" class="onthis">供应商</li></a>
                <a href="javascript:;"><li data-type="i7_partner">联系我们</li></a>
            </ul>
        </div>
        <img src="images/about_img.jpg" width="240" />
    </div>
    <div class="about_right i7_about">
        <div class="partner-chann-title of mt50"><span>Association</span>行业协会</div>
        <ul class="partner-chann-list of">
            <li>
                <a href="http://www.cdpa.org.cn/" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/hzhb001.jpg"></a>
                <div class="partner-txt">
                    <h4>中国印染行业协会</h4>
                    <p>协会的宗旨是遵守宪法、法律、法规和国家政策，维护行业的整体利益和会员的合法权益。</p>
                </div>
                <a href="http://www.cdpa.org.cn/" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.dyechina.com/" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/hzhb002.jpg"></a>
                <div class="partner-txt">
                    <h4>中国染料工业协会</h4>
                    <p>从事染料、有机颜料、印染助剂、中间体和色母粒的生产、科研及相关企事业单位。</p>
                </div>
                <a href="http://www.dyechina.com/" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
        </ul>
        <div class="partner-chann-title of mt50"><span>Partners</span>合作伙伴</div>
        <ul class="partner-chann-list of partner_list">
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/JJMVNA8X01SP.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_sup_jihua.jpg"></a>
                <div class="partner-txt">
                    <h4>浙江吉华集团股份有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/JJMVNA8X01SP.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/MHB4J48S01IF.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/img0055.jpg"></a>
                <div class="partner-txt">
                    <h4>徐州开达精细化工有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/MHB4J48S01IY.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/MHB4J48S01JL.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/img0051.jpg"></a>
                <div class="partner-txt">
                    <h4>苏州市东吴染料有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/MHB4J48S01JL.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/JJMVNA8X01AP.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/img0053.jpg"></a>
                <div class="partner-txt">
                    <h4>天津德凯化工股份有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/JJMVNA8X01AP.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/MHB4J48S01IY.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/img0054.jpg"></a>
                <div class="partner-txt">
                    <h4>吴江梅堰三友染料化工有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/MHB4J48S01IY.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/D664MY8X01BH.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_sup_cf.jpg"></a>
                <div class="partner-txt">
                    <h4>沧州富杰乐材料科技有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/D664MY8X01BH.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/D664MY8X01UE.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_sup_dalianlvfeng.jpg"></a>
                <div class="partner-txt">
                    <h4>大连绿峰化学股份有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/D664MY8X01UE.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/RN4BN88X01Z5.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_sup_hd.jpg"></a>
                <div class="partner-txt">
                    <h4>浙江花蝶化学股份有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/RN4BN88X01Z5.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/RN4BN88X01NN.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_sup_krt.jpg"></a>
                <div class="partner-txt">
                    <h4>河北永泰柯瑞特化工有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/RN4BN88X01NN.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/channel_xbr.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_sup_reba.jpg"></a>
                <div class="partner-txt">
                    <h4>江苏新瑞贝科技股份有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/channel_xbr.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/Q6DEJ68S018F.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/img0050.jpg"></a>
                <div class="partner-txt">
                    <h4>上海安诺其集团股份有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/Q6DEJ68S018F.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <!-- 增加2016-01-08 -->
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/SCRDBX94011R.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_xiangshuihanglong.jpg"></a>
                <div class="partner-txt">
                    <h4>响水航龙化工有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/SCRDBX94011R.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/SCRDBX94015A.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_ouyahuagong.jpg"></a>
                <div class="partner-txt">
                    <h4>浙江欧亚化工有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/SCRDBX94015A.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/NFFWE294012N.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_jiangxiyiwang.jpg"></a>
                <div class="partner-txt">
                    <h4>江西煜旺化学工业有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/NFFWE294012N.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/SCRDBX94013L.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_yifangfushi.jpg"></a>
                <div class="partner-txt">
                    <h4>晋州市亿方服饰材料有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/SCRDBX94013L.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/DJGNBT94018A.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_jiaxinranliao.jpg"></a>
                <div class="partner-txt">
                    <h4>蓬莱嘉信染料化工有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/DJGNBT94018A.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/0WK96V9401UQ.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_rihuahuaxue.jpg"></a>
                <div class="partner-txt">
                    <h4>浙江日华化学有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/0WK96V9401UQ.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/DJGNBT9401OG.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_wandehuagong.jpg"></a>
                <div class="partner-txt">
                    <h4>上海万得化工有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/DJGNBT9401OG.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/DJGNBT9401MD.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_taifuhuagong.jpg"></a>
                <div class="partner-txt">
                    <h4>泰氟化工技术（上海）有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/DJGNBT9401MD.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/07AMC29401XT.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_taojiahuagong.jpg"></a>
                <div class="partner-txt">
                    <h4>上海桃佳化工染料有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/07AMC29401XT.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/DJGNBT94014J.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_liwanghuagong.jpg"></a>
                <div class="partner-txt">
                    <h4>丽王化工（南通）有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/DJGNBT94014J.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/DJGNBT9401RL.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_shaoxinglianfa.jpg"></a>
                <div class="partner-txt">
                    <h4>绍兴联发化工有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/DJGNBT9401RL.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/9DRQFC9501SM.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_zhejianghongda.jpg"></a>
                <div class="partner-txt">
                    <h4>浙江宏达化学制品有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/9DRQFC9501SM.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/9DRQFC9501RH.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_taixingzhenqing.jpg"></a>
                <div class="partner-txt">
                    <h4>泰兴市臻庆化工有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/9DRQFC9501RH.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/9DRQFC9501PL.html" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/logo_liaoninghengxing.jpg"></a>
                <div class="partner-txt">
                    <h4>辽宁恒星精细化工有限公司</h4>
                    <p></p>
                </div>
                <a href="http://www.i7colors.com/ec/p/~i7c/mall/gys/9DRQFC9501PL.html" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
        </ul>
        <div class="partner-chann-title of mt50"><span>Banks</span>合作银行</div>
        <ul class="partner-chann-list of">
            <li>
                <a href="http://www.cmbchina.com/" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/hzhb003.jpg"></a>
                <div class="partner-txt">
                    <h4>招商银行</h4>
                    <p></p>
                </div>
                <a href="http://www.cmbchina.com/" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.bankcomm.com/BankCommSite/default.shtml" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/hzhb004.jpg"></a>
                <div class="partner-txt">
                    <h4>交通银行</h4>
                    <p></p>
                </div>
                <a href="http://www.bankcomm.com/BankCommSite/default.shtml" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://bank.ecitic.com/" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/hzhb005.jpg"></a>
                <div class="partner-txt">
                    <h4>中信银行</h4>
                    <p></p>
                </div>
                <a href="http://bank.ecitic.com/" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
        </ul>
        <div class="partner-chann-title of mt50"><span>Mechanism</span>合作机构</div>
        <ul class="partner-chann-list of">
            <li>
                <a href="http://www.xrite.cn" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/hzhb006.jpg"></a>
                <div class="partner-txt">
                    <h4>xrite</h4>
                    <p></p>
                </div>
                <a href="http://www.xrite.cn" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.pantone.hk/" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/hzhb007.jpg"></a>
                <div class="partner-txt">
                    <h4>PANTONE</h4>
                    <p></p>
                </div>
                <a href="http://www.pantone.hk/" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.bureauveritas.cn/" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/hzhb016.jpg"></a>
                <div class="partner-txt">
                    <h4>BUREAU VERITAS</h4>
                    <p></p>
                </div>
                <a href="http://www.bureauveritas.cn/" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.sgsgroup.com.cn/zh-CN/Service-by-Type-Path/Inspection.aspx" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/hzhb015.jpg"></a>
                <div class="partner-txt">
                    <h4>SGS</h4>
                    <p></p>
                </div>
                <a href="http://www.sgsgroup.com.cn/zh-CN/Service-by-Type-Path/Inspection.aspx" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
        </ul>
        <div class="partner-chann-title of mt50"><span>Media</span>合作媒体</div>
        <ul class="partner-chann-list of">
            <li>
                <a href="http://www.knittingpub.com/ch/index.aspx" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/hzhb011.jpg"></a>
                <div class="partner-txt">
                    <h4>《针织工业》</h4>
                    <p></p>
                </div>
                <a href="http://www.knittingpub.com/ch/index.aspx" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://c.wanfangdata.com.cn/Periodical-rzjs.aspx" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/hzhb012.jpg"></a>
                <div class="partner-txt">
                    <h4>《染整技术》</h4>
                    <p></p>
                </div>
                <a href="http://c.wanfangdata.com.cn/Periodical-rzjs.aspx" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://yinran.cdfn.com.cn/ch/index.aspx" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/hzhb013.jpg"></a>
                <div class="partner-txt">
                    <h4>《印染》 </h4>
                    <p></p>
                </div>
                <a href="http://yinran.cdfn.com.cn/ch/index.aspx" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
            <li>
                <a href="http://www.dyebbs.com/bbs/forum.php" target="_blank"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/hzhb014.jpg"></a>
                <div class="partner-txt">
                    <h4>《染者无疆》论坛 </h4>
                    <p></p>
                </div>
                <a href="http://www.dyebbs.com/bbs/forum.php" target="_blank" class="partner-more01 fr">点击详情 &gt;&gt;</a>
            </li>
        </ul>
    </div>
    <div class="about_right i7_partner" style="display: none;">
        <div class="about_con_title">联系我们</div>
        <div class="ad"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/img0089.jpg" /></div>
        <div class="map" style="margin-bottom:50px;"><img src="http://www.i7colors.com/ec/p/public/style/default2015_my/images/mall3/img0090.jpg" /></div>
    </div>


    <div class="clear"></div>
</div>


<%@ include file="/page/common/foot.jsp" %>
</body>
</html>