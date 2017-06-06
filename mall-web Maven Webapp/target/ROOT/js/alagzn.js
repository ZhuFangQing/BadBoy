(function(_jq) {
    var window = this;
    $.extend(window, {
        NavManger: {
            init: function() {
                var container = $(".navlist");
            },
            scroll: function() {
                $(window).bind("scroll", NavManger.detailFx);
                $(window).bind("scroll", NavManger.fixScroll);
            },
            fixScroll: function() {

                var fixNumber = 111;

                var height = Math.max(document.documentElement.scrollTop, document.body.scrollTop);
                var container = $(".navlist");

                /*if (height > fixNumber) {
                    container.addClass("navFixed");
                } else {
                    container.removeClass("navFixed");
                }*/
            },
        }

    });

    $(document).ready(function() {
        NavManger.init();
        NavManger.scroll();
    });
})(jQuery);
// 快速导航宽度自适应
$(document).ready(function() {
    var liN = $(".menu-nav li").length;
    var liW = 100 / liN;
    $(".menu-nav li").css("width", liW + "%");
});
//JQ 锚点
$(document).ready(function() {
    $(".menu-nav li").click(function() {
        var obj = $(this);
        var inx = obj.index();

        if (inx == 0) {
            $('html,body').animate({
                scrollTop: 0
            }, 500);
            return false;
        }
        $('html,body').stop();
        $('html,body').animate({
            scrollTop: ($(".dw").eq(inx).offset().top)
        }, 500);
    });
});