//prod
var itx="http://static.i7colors.com";
$(function($) {
    var mySwiper_banner = new Swiper ('#banner', {
        loop: true,
        autoplay: 5000,
        paginationClickable :true,
        calculateHeight : true,

        pagination: '#banner_swp',
    })

    var mySwiper_mumber1 = new Swiper ('#mumber1', {
        mode  : 'vertical',
        slidesPerView: 5,
    })

    $('#up_arr1').on('click', function(e){
        e.preventDefault()
        mySwiper_mumber1.swipePrev()
    })
    $('#down_arr1').on('click', function(e){
        e.preventDefault()
        mySwiper_mumber1.swipeNext()
    })

    var mySwiper_product1 = new Swiper ('#hot_product1', {
        slidesPerView: 4,
        calculateHeight : true,
    })

    $('#hot_pro_prev1').on('click', function(e){
        e.preventDefault()
        mySwiper_product1.swipePrev()
    })
    $('#hot_pro_next1').on('click', function(e){
        e.preventDefault()
        mySwiper_product1.swipeNext()
    })

    var mySwiper_mumber2 = new Swiper ('#mumber2', {
        mode  : 'vertical',
        slidesPerView: 5,
    })

    $('#up_arr2').on('click', function(e){
        e.preventDefault()
        mySwiper_mumber2.swipePrev()
    })
    $('#down_arr2').on('click', function(e){
        e.preventDefault()
        mySwiper_mumber2.swipeNext()
    })

    var mySwiper_product2 = new Swiper ('#hot_product2', {
        slidesPerView: 4,
        calculateHeight : true,
    })

    $('#hot_pro_prev2').on('click', function(e){
        e.preventDefault()
        mySwiper_product2.swipePrev()
    })
    $('#hot_pro_next2').on('click', function(e){
        e.preventDefault()
        mySwiper_product2.swipeNext()
    })

    $('body').on('click','.btn_enter', function(){
        $(".popup .close").trigger("click")
    })

    //var gotop = new goTop();
    //$('.gotop').height(240);

    $('.btn_suggest').click(function(e) {
        var InfoBoxTop = ($(window).height()-261)/2 + window.scrollY;
        $('.pop_bg').height($(document).height());
        $('.pop_bg').fadeIn();
        $('#feedback').css('top',InfoBoxTop);
        $('#feedback').fadeIn();
        $('body').css('overflow','hidden');
    });

    $('#feedback_close').click(function(e) {
        $('.pop_bg').fadeOut();
        $('#feedback').fadeOut();
        $('body').css('overflow','auto');
    });

    var mySwiper_school_banner = new Swiper ('#school_banner', {
        loop: true,
        autoplay: 5000,
        paginationClickable :true,
        calculateHeight : true,

        pagination: '#school_banner_swp',
    })

    var mySwiper_new_class = new Swiper ('#new_class', {
        slidesPerView: 4,
        calculateHeight : true,
    })

    $('#sb_prev').on('click', function(e){
        e.preventDefault()
        mySwiper_new_class.swipePrev()
    })
    $('#sb_next').on('click', function(e){
        e.preventDefault()
        mySwiper_new_class.swipeNext()
    })

    $('.school_hot_list.zj h1').click(function(e) {
        if($(this).siblings('.school_zj_detil').css('display') == 'block') return;
        $('.school_hot_list.zj').removeClass('open');
        $(this).parent().addClass('open');
        $('.school_zj_detil').slideUp();
        $(this).siblings('.school_zj_detil').slideDown();
    });

    $('#open_more').click(function(e) {
        if($('.open_more_chose_list').css('display') == 'block'){
            $(this).html('更多选项 (适用材料\颜色等)');
            $(this).css('background-image','url(images/down_icon.gif)');
            $('.open_more_chose_list').slideUp();
        }else{
            $(this).html('收起更多选项');
            $(this).css('background-image','url(images/up_icon.gif)');
            $('.open_more_chose_list').slideDown();
        }
    });

    $(document).on('mouseover', '.mall_product_box ul li', function () {
    // $('.mall_product_box ul li').mouseover(function(e) {
        $('.mall_product_box ul li').removeClass('onthis');
        $('.product_detil').hide();
        $(this).addClass('onthis');
        $(this).find('.product_detil').show();
    });

    $(document).on('mouseout', '.mall_product_box ul li', function () {
    // $('.mall_product_box ul li').mouseout(function(e) {
        $('.mall_product_box ul li').removeClass('onthis');
        $('.product_detil').hide();
    });

    //var windowHeight = $(document).height();
    //$('.online_bg').height(windowHeight);

/*    var num = $('#product_num').val();
    $('.plus').click(function(e) {
        num = $('#product_num').val();
        if(num>=1) $('.reduce').removeClass('noclick');
        num++;
        $('.product_info_numbers').find('input').val(num);
    });

    $('.reduce').click(function(e) {
        num = $('#product_num').val();
        if($('.reduce').hasClass('noclick')) return;
        if(num<=2){
            $('.reduce').addClass('noclick');
        }
        num--;
        $('.product_info_numbers').find('input').val(num);
    });*/

    var $activeNav;
    $(".business-nav li").not(".active").hover(function(){
        $(".business-nav-twice").css({display:"none"});
        $(this).addClass("mouseover");
        var _left = $(this).offset().left - $('.container').offset().left;
        var _top = $(this).height();
        var data_id = $(this).attr("data-id");
        $(".business-nav-twice."+data_id).css({left:_left,top:_top,display:"block"});
        $activeNav = $(this);
        //alert($(this).offset().left);
    },function(){
        $(this).removeClass("mouseover");

    });

    $(".business-nav-twice").mouseover(function(){
        $activeNav.addClass("mouseover");
    })
    $(".business-nav-div").hover(function(){
        console.log($activeNav);
    },function(){
        $activeNav.removeClass("mouseover");
        $(".business-nav-twice").css({display:"none"});
    })

    $('.problem_list li h1').click(function(e) {
        if($(this).siblings('.problem_detil').css('display') == 'block') return;
        $('.problem_detil').slideUp();
        $(this).siblings('.problem_detil').slideDown();
    });

    $('#submit').click(function(e) {
        var popHeight = $('#popbox').height();
        var InfoBoxTop = ($(window).height()-popHeight)/2 + window.scrollY-10;
        $('.pop_bg').height($(document).height());
        $('.pop_bg').fadeIn();
        $('#popbox').css('top',InfoBoxTop);
        $('#popbox').fadeIn();
        $('body').css('overflow','hidden');
    });

    $('#close_popbox').click(function(e) {
        $('.pop_bg').fadeOut();
        $('#popbox').fadeOut();
        $('body').css('overflow','auto');
    });

    $('.input_box em').click(function(e) {
        if(!$(this).hasClass('show')){
            $(this).addClass('show');
            $(this).siblings('.text').val($(this).siblings('.pass').val());
            $(this).siblings('.text').show();
            $(this).siblings('.pass').hide();
        }else{
            $(this).removeClass('show');
            $(this).siblings('.pass').val($(this).siblings('.text').val());
            $(this).siblings('.pass').show();
            $(this).siblings('.text').hide();
        }
    });

    $('.mumber_title_bar').click(function(e) {
        if($(this).next('.mumber_menu_list').css('display') == 'block'){
            $(this).next('.mumber_menu_list').slideUp();
        }else{
            $('.mumber_menu_list').slideUp();
            $(this).next('.mumber_menu_list').slideDown();
        }
    });

    $('.level_one em').click(function(e) {
        if($(this).parent().siblings('.level_two').css('display') == 'block'){
            $(this).removeClass('open');
            $(this).parent().siblings('.level_two').slideUp();
        }else{
            $('.level_one em').removeClass('open');
            $('.level_two').slideUp();
            $(this).addClass('open');
            $(this).parent().siblings('.level_two').slideDown();
        }
    });

    $('.pro_plus').click(function(e) {
        var thisNumber = $(this).siblings('span').html();
        thisNumber++;
        $(this).siblings('span').html(thisNumber);
    });

    $('.pro_reduce').click(function(e) {
        var thisNumber = $(this).siblings('span').html();
        if(thisNumber<=1) return;
        thisNumber--;
        $(this).siblings('span').html(thisNumber);
    });

    $('.all').click(function(e) {
        if($(this).is(':checked')){
            $(this).parents('.tab_main_box').find('input[type="checkbox"]').prop("checked", true);
        }else{
            $(this).parents('.tab_main_box').find('input[type="checkbox"]').removeAttr("checked");
        }
        $(this).parents('.tab_main_box').find('input[type="checkbox"]').trigger("change");
    });

    $(".new-invoice-btn").on("click",function(){
        $(".new-invoice").css("display","block");
        $(this).css("display","none");
    })


    $("#submit").on("click",function(){
        $(".consignee-box").css("display","none");
    })

    $(".cosignee-btn").on("click",function(){
        var InfoBoxTop = ($(window).height()-430)/2 + window.scrollY;
        $('.pop_bg').height($(document).height());
        $('.pop_bg').fadeIn();
        $('#popbox2').css('top',InfoBoxTop);
        $('#popbox2').fadeIn();
        $('body').css('overflow','hidden');

        $(".invoice-box").css("display","none");


    })

    $('#close_popbox2').click(function(e) {
        $('.pop_bg').fadeOut();
        $('#popbox2').fadeOut();
        $('body').css('overflow','auto');
    });

    $('#select_type').change(function(e) {
        $('#text_type').val($(this).find('option:selected').val());
    });

    $('.consignee li').hover(function(){
        $('.consignee li').removeClass('active');
        $(this).addClass('active');
        $(this).find('p').show();
    },function(){
        $('.consignee li').removeClass('active');
        $(this).find('p').hide();
    });

    $('#all_read').click(function(e) {
        $('.mall_sms_table').find('em').addClass('read');
    });

    $('.reason').click(function(e) {
        $('.content').html($(this).html());
    });

    $('.qr_box').hover(function(){
        $('.qr_show_box').show();
    },function(){
        $('.qr_show_box').hide();
    });

    $('.search_tab > span').click(function(e) {
        $('.search_tab > span').removeClass('onthis');
        $(this).addClass('onthis');
    });
    
  //bbs JS by ivan
	var mySwiper_bbs = new Swiper ('#bbs_swp', {
		autoplay : 5000,
		loop: true,
		paginationClickable :true,
		pagination: '#bbs_swpp',
	})
	
	$('.search_tab > span').click(function(e) {
        $('.search_tab > span').removeClass('onthis');
		$(this).addClass('onthis');
    });
	
	$('#bbs_swbp').on('click', function(e){
    	e.preventDefault()
    	mySwiper_bbs.swipePrev()
  	})
	$('#bbs_swbn').on('click', function(e){
  		e.preventDefault()
    	mySwiper_bbs.swipeNext()
	});
	
	$('#bbs_type_select').change(function(e) {
        $('#bbs_type_text').val($(this).find('option:selected').html());
    });
});

function AlexTab2(tabId,boxId){this.init(tabId,boxId);}
AlexTab2.prototype = {
    _oldm : new Array(),
    init  :function(tabId,boxId){
        var self = this;
        this.tabClick(tabId,boxId);
        this._oldm[tabId] = 0;
    },
    tabClick : function(tabId,boxId){
        var self = this;
        var m = $('#'+tabId+' > span');
        $('#'+tabId+' > span').click(function(){
            var h = $(this).index();
            if(h != self._oldm[tabId]){
                $(this).addClass('active');
                $(m[self._oldm[tabId]]).removeClass('active');
                $('#'+boxId[self._oldm[tabId]]).hide();
                $('#'+boxId[h]).show();
                self._oldm[tabId] = h;
            }
        })
    }
}

function OpenPopbox(id){
    var popbox_bg = $('.pop_bg');
    $(popbox_bg).height($(document).height());
    $(popbox_bg).width($(document).width());
    var boxName = $('#'+id);
    //var InfoBoxLeft = ($(window).width()-$(boxName).width()+2)/2;
    var InfoBoxTop = ($(window).height()-$(boxName).height()+2)/2 + window.scrollY;
    $(boxName).css({'top':InfoBoxTop+'px'});
    $(popbox_bg).fadeIn(300);
    $(boxName).fadeIn(300);
    $('body').css('overflow','hidden');
}

function ClosePopbox(id){
    var popbox_bg = $('.pop_bg');
    var boxName = $('#'+id);
    $(boxName).fadeOut(300);
    $(popbox_bg).fadeOut(300);
    $('body').css('overflow','auto');
}
(function(){
    window.onscroll = function () {
        var t = document.documentElement.scrollTop || document.body.scrollTop;
        if(t <= parseInt($("body").css("height"))-1010){
            $(".index_fixedcar").css({"top":"540px","bottom":"0"});
        }else{
            // console.log($(window).height()-545);
            $(".index_fixedcar").css({"top":$(window).height()-545+"px","bottom":"545px"});
        }
        // console.log(t - (parseInt($("body").css("height"))-1000));
    }
    $(window).resize(function(){
        console.log(parseInt($("body").css("width")));
        $(".index_fixedcar").css("right",(parseInt($("body").css("width"))-1260)/2-50+"px");
    })

})()
$(function(){
    $(".index_fixedcar").css("right",(parseInt($("body").css("width"))-1260)/2-50+"px");
    $(".index_fixedcar").css({"top":"540px","bottom":"0"});

    /*var DEFAULT_VERSION = "8.0";
    var ua = navigator.userAgent.toLowerCase();
    var isIE = ua.indexOf("msie")>-1;
    var safariVersion;
    if(isIE){
        safariVersion =  ua.match(/msie ([\d.]+)/)[1];
        if(safariVersion <= DEFAULT_VERSION ){
            // 跳转至页面1
            alert("您的浏览器版本过低，请您更新您的浏览器");
            location.href = "https://support.microsoft.com/zh-cn/help/17621/internet-explorer-downloads";
        }else{
            // 跳转至页面2
        }
    }else{
        // 跳转至页面2
    }*/
})