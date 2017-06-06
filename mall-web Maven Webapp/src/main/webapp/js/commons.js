/**
 * Created by Echos on 2016/12/12.
 */

//邮箱验证
var REG_EMAIL = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
var REG_QQ = /^\d{5,11}$/;


/**
 * 对Date的扩展，将 Date 转化为指定格式的String
 * 月(M)、日(d)、12小时(h)、24小时(H)、分(m)、秒(s)、周(E)、季度(q) 可以用 1-2 个占位符
 * 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
 * eg:
 * (new Date()).pattern("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423
 * (new Date()).pattern("yyyy-MM-dd E HH:mm:ss") ==> 2009-03-10 二 20:09:04
 * (new Date()).pattern("yyyy-MM-dd EE hh:mm:ss") ==> 2009-03-10 周二 08:09:04
 * (new Date()).pattern("yyyy-MM-dd EEE hh:mm:ss") ==> 2009-03-10 星期二 08:09:04
 * (new Date()).pattern("yyyy-M-d h:m:s.S") ==> 2006-7-2 8:9:4.18
 */
Date.prototype.pattern=function(fmt) {
    if(undefined == fmt || null == fmt){
        fmt = "yyyy-MM-dd hh:mm:ss";
    }
    var o = {
        "M+" : this.getMonth()+1, //月份
        "d+" : this.getDate(), //日
        "h+" : this.getHours()%12 == 0 ? 12 : this.getHours()%12, //小时
        "H+" : this.getHours(), //小时
        "m+" : this.getMinutes(), //分
        "s+" : this.getSeconds(), //秒
        "q+" : Math.floor((this.getMonth()+3)/3), //季度
        "S" : this.getMilliseconds() //毫秒
    };
    var week = {
        "0" : "/u65e5",
        "1" : "/u4e00",
        "2" : "/u4e8c",
        "3" : "/u4e09",
        "4" : "/u56db",
        "5" : "/u4e94",
        "6" : "/u516d"
    };
    if(/(y+)/.test(fmt)){
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
    }
    if(/(E+)/.test(fmt)){
        fmt=fmt.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length>2 ? "/u661f/u671f" : "/u5468") : "")+week[this.getDay()+""]);
    }
    for(var k in o){
        if(new RegExp("("+ k +")").test(fmt)){
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
        }
    }
    return fmt;
};

var i7Utils = {
    //使用对象值填充{xxx}
    mix : function(str,group) {
        str = str.replace(/\{([^{}]+)\}/gm,function (m,n) {
            return (group[n] != undefined) ? group[n] : '';
        });
        return str;
    },
    getTalkToken: function(){
        return parseInt(Math.random()*5000000 + 95000000);
    }
};


$(function($) {
    /*var i7Utils = {
        //使用对象值填充{xxx}
        mix : function(str,group) {
            str = str.replace(/\{([^{}]+)\}/gm,function (m,n) {
                return (group[n] != undefined) ? group[n] : '';
            });
            return str;
        }
    };*/

    $.notNull = function (param) {
        return !$.isNull(param);
    };
    $.isNull = function (param) {
        return undefined == param || null == param || param == '';
    };
    $.ajaxSuccess = function (resp) {
        return $.notNull(resp) && resp['code'] == 'SUCCESS';
    }

    $.getUrlParam = function (name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }

    $.paymentType = function (code) {
        if ($.notNull(code)) {
            if (code == 'cash') {
                return '现金支付';
            }
            if (code == 'credit') {
                return '信用额度';
            }
            if (code == 'balance') {
                return '现金余额';
            }
        }

        return '未支付'
    }

    $.orderStatus = function (code) {
        if ($.notNull(code)) {
            if (code == 'notPay') {
                return '未支付';
            }
            if (code == 'paying') {
                return '支付中';
            }
            if (code == 'waitCheck') {
                return '待审核';
            }
            if (code == 'checkFail') {
                return '审核不通过';
            }
            if (code == 'waitDelivery') {
                return '待发货';
            }
            if (code == 'alreadyDelivery') {
                return '已发货';
            }
            if (code == 'finish') {
                return '已完成';
            }
            if (code == 'cancel') {
                return '已取消';
            }
        }

        return '未支付'
    }
})


function login(){
    var url = location.href;
    location.href = '/login?back_url=' + url
}

//login_out
function login_out() {
    debugger;
    $.cookie('I7COLOR_USER_NAME',null, { path: '/', expires: -1 });
    $.cookie('I7COLOR_USER_LOGIN_TOKEN',null, { path: '/', expires: -1 });
    location.href='/';
}

//是否登录
function isLogin(){
	return $.notNull($.cookie('I7COLOR_USER_NAME')) && $.notNull($.cookie('I7COLOR_USER_LOGIN_TOKEN'));
}

//论坛表情转译
function toEmoticon(str) {
    var emoticonArray = [
        {
            sign: new RegExp(/(:\))/g),
            fileName: 'smile.gif'
        },
        {
            sign: new RegExp(/(:\()/g),
            fileName: 'sad.gif'
        },
        {
            sign: new RegExp(/(:D)/g),
            fileName: 'biggrin.gif'
        },
        {
            sign: new RegExp(/(:'\()/g),
            fileName: 'cry.gif'
        },
        {
            sign: new RegExp(/(:@)/g),
            fileName: 'huffy.gif'
        },
        {
            sign: new RegExp(/(:o)/g),
            fileName: 'shocked.gif'
        },
        {
            sign: new RegExp(/(:P)/g),
            fileName: 'tongue.gif'
        },
        {
            sign: new RegExp(/(:\$)/g),
            fileName: 'shy.gif'
        },
        {
            sign: new RegExp(/(;P)/g),
            fileName: 'titter.gif'
        },
        {
            sign: new RegExp(/(:L)/g),
            fileName: 'sweat.gif'
        },
        {
            sign: new RegExp(/(:Q)/g),
            fileName: 'mad.gif'
        },
        {
            sign: new RegExp(/(:lol)/g),
            fileName: 'lol.gif'
        },
        {
            sign: new RegExp(/(:hug:)/g),
            fileName: 'hug.gif'
        },
        {
            sign: new RegExp(/(:victory:)/g),
            fileName: 'victory.gif'
        },
        {
            sign: new RegExp(/(:time:)/g),
            fileName: 'time.gif'
        },
        {
            sign: new RegExp(/(:kiss:)/g),
            fileName: 'kiss.gif'
        },
        {
            sign: new RegExp(/(:handshake)/g),
            fileName: 'handshake.gif'
        },
        {
            sign: new RegExp(/(:call:)/g),
            fileName: 'call.gif'
        },
        {
            sign: new RegExp(/(:loveliness:)/g),
            fileName: 'loveliness.gif'
        },
        {
            sign: new RegExp(/(:funk:)/g),
            fileName: 'funk.gif'
        }
    ];
    for (var i in emoticonArray) {
        str = str.replace(emoticonArray[i].sign, '<img src="' + itx + '/bbsEmoticon/' + emoticonArray[i].fileName + '" style="width:20;height:20"/>');
    }
    return str;
}

//标签处理
function regexpTag(str) {
    var tagArr = [
        {
            name: 'color',
            br: false
        },
        {
            name: 'b',
            br: false
        },
        {
            name: 'size',
            br: false
        },
        {
            name: 'i',
            br: false
        },
        {
            name: 'font',
            br: false
        },
        {
            name: 'u',
            br: false
        },
        {
            name: 'email',
            br: false
        },
        {
            name: 'qq',
            br: false
        },
        {
            name: 'align',
            br: false
        }
    ];
    for (var i in tagArr) {
        var tag = tagArr[i];
        var regexp1 = new RegExp('\\[' + tag.name + '([^A-z]+?.*?\\]|\\])', 'g');
        var regexp2 = new RegExp('\\[\\/' + tag.name + '([^A-z]+?.*?\\]|\\])', 'g');
        str = str.replace(regexp1, '');
        if (tag.name == 'align') {
            str = str.replace(regexp2, '<br/>')
        } else {
            str = str.replace(regexp2, '')
        }
    }

    //url标签处理
    var urlStr;
    urlStr = str.match(new RegExp('\\[url\\].+?\\[\\/url\\]', 'g'));
    if (urlStr) {
        for (var i in urlStr) {
            var url = urlStr[i].replace(new RegExp('\\[\\/?url\\]', 'g'), '');
            str = str.replace(urlStr[i], '<i><a href="' + url + '" target="_blank">' + url + '</a></i><br/>');
        }
    }
    urlStr = str.match(new RegExp('\\[url.+?\\].+?\\[\\/url\\]', 'g'));
    if (urlStr) {

        for (var i in urlStr) {
            var url = urlStr[i];
            console.log(url);
            url = url.replace('[url=', '<i><a href="');
            url = url.replace(']', '" target="_blank">');
            url = url.replace('[/url]','</a></i><br/>');
            console.log(url);

            str = str.replace(urlStr[i], url);
        }
    }

    //图片标签处理
    var imgStr;
    imgStr = str.match(new RegExp('\\[img\\].+?\\[\\/img\\]', 'g'));
    if (imgStr) {
        for (var i in imgStr) {
            var img = imgStr[i].replace(new RegExp('\\[\\/?img\\]', 'g'), '');
            str = str.replace(imgStr[i], '<img src="'+img+'"/>');
        }
    }


    var regexp = new RegExp('\\[\\/?table([^A-z]+?.*?\\]|\\])(<br\\/>)?', 'g');
    var matchStr = str.match(regexp);
    if (matchStr) {
        for (var i in matchStr) {
            var s = matchStr[i];
            var widthStr = s.match(new RegExp('=.+?\\]', 'g'));
            if (widthStr) {
                var attr = widthStr[0];
                attr = attr.substring(1, attr.length - 1);
                s = '<table width="' + attr + '">'
            }
            s = s.replace('[', '<');
            s = s.replace(']', '>');
            s = s.replace('<br/>', '');
            str = str.replace(matchStr[i], s);
        }
    }

    regexp = new RegExp('\\[\\/?tr([^A-z]+?.*?\\]|\\])(<br\\/>)?', 'g');
    var matchStr = str.match(regexp);
    if (matchStr) {
        for (var i in matchStr) {
            var s = matchStr[i];
            var widthStr = s.match(new RegExp('=.+?\\]', 'g'));
            // console.log(widthStr);
            if (widthStr) {
                var attr = widthStr[0];
                attr = attr.substring(1, attr.length - 1);
                s = '<tr width="' + attr + '">'
            }
            s = s.replace('[', '<');
            s = s.replace(']', '>');
            s = s.replace('<br/>', '');
            str = str.replace(matchStr[i], s);
        }
    }


    regexp = new RegExp('\\[\\/?td([^A-z]+?.*?\\]|\\])(<br\\/>)?', 'g');
    var matchStr = str.match(regexp);
    if (matchStr) {
        for (var i in matchStr) {
            var s = matchStr[i];
            var widthStr = s.match(new RegExp('=.+?\\]', 'g'));
            if (widthStr) {
                var attr = widthStr[0];
                attr = attr.substring(1, attr.length - 1);
                attr = attr.split(',');
                if (attr.length == 1) {
                    s = '<td width="' + attr[0] + '">'
                } else if (attr.length == 3) {
                    s = '<td colspan="' + attr[0] + '" rowspan="' + attr[1] + '" width="' + attr[1] + '">';
                }
            }
            s = s.replace('[', '<');
            s = s.replace(']', '>');
            s = s.replace('<br/>', '');
            str = str.replace(matchStr[i], s);
        }
    }

    return str;
}

function removeHtml(str){
    str = str.replace(new RegExp(/(<.+>)/g),'');
}

//是否禁言
function isSilence(){
    var isSilence = true;
    $.ajax({
        url: '/bbs/isSilence',
        type: 'POST',
        dataType: 'json',
        async: false,
        cache: false,
        success: function (result) {
            isSilence = result;
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert(XMLHttpRequest.status);
            alert(XMLHttpRequest.readyState);
            alert(textStatus);
        }
    });

    return isSilence;
}

//代码验证
function codeValidate(str) {
    console.log(str);
    return !(new RegExp('<[A-z]+.*>').test(str));
}

//获取搜索框内容
function getSearchContent(){
    return $.getUrlParam("search") == null ? "" : decodeURI($.getUrlParam("search"));
}

$(document).ready(function() {
    $("input[name='search']").focus();

    $(".search_tab span").click(function(){
        $("input[name='search']").attr("placeholder", $(this).attr("data-desc"));
        $("input[name='search']").focus();
    });

    $("input[name='search']").keydown(function(e){
        if(e.keyCode==13){
            $(".search_box #btn_search").click();
        }
    });

    //set search box
    $(".search_box #btn_search").click(function () {
        var url = $(".search_tab span.onthis").attr("data-url");
        var type = $(".search_tab span.onthis").attr("data-type");
        location.href = url + "?type=" + type + "&search=" + encodeURI(encodeURI($(".search_box input[name='search']").val().trim()));
    });
    var searchContent = getSearchContent();
    if($.notNull(searchContent)){
        $(".search_box input[name='search']").val(searchContent);
    }
    var searchType = $.getUrlParam("type");
    if($.notNull(searchType)){
        $(".search_tab span[data-type='"+searchType+"']").click();
    }

    //set nav
    var url = location.pathname;
    var array = url.split("/");
    if (array.length >= 2) {
        if (array[1] == '') {
            $(".nav_bar_ul li.nav_index").addClass("onthis");
        } else {
            $(".nav_bar_ul li").removeClass("onthis");
            if($.notNull(array[1])){
                $(".nav_bar_ul li.nav_" + array[1]).addClass("onthis");
            }
            //set user center menu
            if(url=='/u'){
                $(".mumber_menu_list").hide();
                $(".mumber_menu_list li[data-menu*='/company/toCertificationPage']").addClass("onthis");
                $(".mumber_menu_list li[data-menu*='company/toCertificationPage ']").parent().show();
            }else{
                $(".mumber_menu_list").hide();
                $(".mumber_menu_list li[data-menu*='" + url + "']").addClass("onthis");
                $(".mumber_menu_list li[data-menu*='" + url + "']").parent().show();
            }
        }
    }

    //set user
    var username = decodeURI($.cookie('I7COLOR_USER_NAME'));
    if (undefined != username && username != '' && username != null && "undefined" != username) {
        $("span.i7colors_username").html(username);
        $(".log_reg_box").attr("href", "/u");
        $(".log_reg_box_desc").html("个人中心");
        $("span.i7colors_login_out").html("<a style='color:red' href='javascript:void(0)' onclick='login_out()'>退出</a>");

        //设置购物车商品数量
        $.ajax({
            url:'/carts/count',
            type:'GET',
            data:{
            },
            dataType:'json',
            success:function(resp){
                console.log(resp);
                if($.ajaxSuccess(resp)){
                    $(".cart_num").html(resp['data']);
                }
            }
        });
    } else {
        $("span.i7colors_username").html("<a style='color:red' href='javascript:void(0)' onclick='login()'>请登录</a>");
    }

    if (array.length >= 2) {
        if (array[1] == '') {
            $(".nav_bar_ul li.nav_orders").addClass("onthis");
        } else {
            $(".nav_bar_ul li").removeClass("onthis");
            if($.notNull(array[1])){
                $(".nav_bar_ul li.nav_" + array[1]).addClass("onthis");
            }
        }
    }


});