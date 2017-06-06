/**
 * Created by Echos on 2017/2/27.
 */

$(document).ready(function(){
    //set search content
    $("#bbs_search_box").val(getBbsSearchContent());

    $.notNull($.getUrlParam("bbs_search_type")) ? $("#bbs_search_type").val($.getUrlParam("bbs_search_type")) : null;

    //bbs search
    $("#btn_search_box").click(function () {
        debugger;
        var type = $("#bbs_search_type").val();
        location.href = "/bbs/search?type=bbs&bbs_search_type=" + type + "&search=" + encodeURI(encodeURI($("#bbs_search_box").val()));
    });
});

function getSectionPost(sectionId,obj){
	$.ajax({
		url : '/bbs/getSectionHotPostList',
		type : 'POST',
		dataType : 'json',
		data : {
			"pageNo" : 1,
			"pageSize" : 18,
			"topSectionId" : sectionId
		},
		async : false,
		cache : false,
		success : function(result) {
			console.log(JSON.stringify(result));
			$('#all_essence ul').empty();
			$(result).each(function(index,ele){
                var node = '<li><a href="/bbs/bbsPost?id=' + ele.id + '"><strong>' + ele.title + '</strong><span>' + ele.poster.login_name + ' / ' + new Date(ele.createdAt).pattern("yyyy-MM-dd") + '</span></a></li>';
				
				if(index < 9)
					$('#all_essence .list_left_box ul:eq(0)').append(node);
				else
					$('#all_essence .list_left_box ul:eq(1)').append(node);
			});
			
			$(".bbs_head_rigth_tab span").attr('class','');
			$(obj).children('span').attr('class','active');
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert(XMLHttpRequest.status);
			alert(XMLHttpRequest.readyState);
			alert(textStatus);
		}
	});
	
}



function getBbsSearchContent(){
    return $.getUrlParam("search") == null ? "" : decodeURI($.getUrlParam("search"));
}