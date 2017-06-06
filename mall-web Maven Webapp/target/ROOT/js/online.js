$(function(){
	var LOGIN_MODE = false;
	var onePackageNum ;
    var itx="http://static.i7colors.com";
    $.getUrlParamValue = function (name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    };
    $.notNull = function (param) {
        return undefined != param && null != param && param != '';
    };
	var userName = decodeURI($.cookie('I7COLOR_USER_NAME'));
	var token = $.cookie('I7COLOR_USER_LOGIN_TOKEN');
	if(!$.notNull(token)){
		/*alert("请先登录！");
		location.href="/";*/
		//general tmp token
		var talkToken = $.cookie('I7COLOR_TMP_TALK_TOKEN');
        token = $.notNull(talkToken) ? talkToken : "TMP_" + i7Utils.getTalkToken();
        $.cookie('I7COLOR_TMP_TALK_TOKEN', token, { path: '/', expires: 365});

        userName = "游客" + token.substring(4, token.length);
        // $.cookie('I7COLOR_USER_NAME', userName, { path: '/', expires: 365});
	}else{
        $.cookie('I7COLOR_TMP_TALK_TOKEN', null, { expires: -1 });
        LOGIN_MODE = true;
	}
	// userName = encodeURIComponent(userName);
	// userName = encodeURIComponent(userName);
	// console.log(userName);
	/*websocket*/
	//ws = new WebSocket("ws://192.168.0.190:8082/talk-app/websocket_user/"+token);

	ws = new WebSocket("ws://talk.i7colors.com/websocket_user/"+token);

	//console.log(ws);
	ws.onopen=function(){
	};
	
	
	ws.onmessage = function (evt){
    	//alert(evt.data);
        //var received_msg = evt.data;
        console.log(received_msg);
        
        
        data = evt.data;
    	//console.log(data);
    	data = JSON.parse(data);
        
        console.log(data);
        if(data == ""){
        	return;
		}
        
        //console.log(data.messageOwner);
        
        /*当前时间*/
		var nowTime = new Date().Format("yyyy.MM.dd hh:mm:ss");
	    var $timeSpan = $("<span>").html(data.messageTimeString);
	    /*如果是1，是客服消息*/
	    if(data.loadEndFlag== '1'){
	    	return;
	    }
	    
	    if(data.messageOwner == 1){
	    	/*如果消息类型为string类型*/
	    	if(data.messageType == "string"){
	    		var received_msg = data.message;
	    		received_msg = JSON.parse(received_msg.replace(/\n/,'<br>')).msg;
	    		//console.log(received_msg);
	    		
	    		/*客服消息内容div*/
			    var $returnMsgDiv = $("<div>").addClass("online_left_talk");
			    $returnMsgDiv.append("<em>").append(received_msg);
	    		
	    	} else if(data.messageType == "pic"){
	    		/*如果消息类型为pic类型*/
	    		var received_msg = data.message;
	    		received_msg = JSON.parse(received_msg).url;
	    		//console.log(received_msg);
	    		var $newImg = $("<img>").attr("src",itx+received_msg).addClass("msg-img");
	    		/*客服消息内容div*/
			    var $returnMsgDiv = $("<div>").addClass("online_left_talk");
			    $returnMsgDiv.append("<em>").append($newImg);
	    	} else if(data.messageType == "file"){
	    		/*如果是文档类型*/
	    		var received_msg = data.message;
	    		received_msg = JSON.parse(received_msg);
	    		var $fileUrlBtn = $("<a>").attr("href",itx+received_msg.url).html("下载");
	    		var $fileName = $("<p>").html("文件名称: "+received_msg.fileName+" , 文件大小: "+parseInt(received_msg.fileSize/1024)+"KB");
	    		var $returnMsgDiv = $("<div>").append($("<em>")).append($fileName).append($fileUrlBtn).addClass("online_left_talk");

	    	} else if(data.messageType = "inquiry"){
	    		//如果是询价报文
	    		var received_msg = data.message;
	    		received_msg = JSON.parse(received_msg);
	    		var askDiv = $("<div>").addClass("online_pro_box").attr("id","askNowBox");
	    		var $imgDiv = $("<img>").attr("src",itx + received_msg.largeUrl).attr("id","askNowImg").css("width","100");
	    		askDiv.append($imgDiv);
	    		var infoDiv = $("<div>").addClass("online_pro_info").append($("<h1>").text(received_msg.aliasName).attr("id","askNowTitle"));
	    		infoDiv.append($("<p>").html(received_msg.code).attr("id","askNowCode"));
	    		infoDiv.append("包装形式：");
	    		infoDiv.append($("<span>").html(received_msg.packType).attr("id","askNowPack"));
	    		infoDiv.append($("<br>"));
	    		infoDiv.append($("<strong>").html("询价数量："));
	    		infoDiv.append($("<span>").addClass("askNowNum").attr("id","askNowNum").text(received_msg.num+"公斤").css("display","inline"));
	    		infoDiv.append($("<br>"));
	    		infoDiv.append($("<strong>").html("客服报价："));
	    		infoDiv.append($("<span>").addClass("askNowNum").attr("id","askNowNum").text(received_msg.price+"元/公斤").css("display","inline"));
	    		
	    		askDiv.append(infoDiv);
	    		
	    		var $returnMsgDiv = $("<div>").addClass("online_left_talk");
			    $returnMsgDiv.append("<em>").append(askDiv);
	    	}else{
	    		return;
			}

	    	
	    	
		    /*整个客服消息div*/
		   	var $serviceDiv = $("<div>").addClass("online_left_talk_box");
		   	$serviceDiv.append($timeSpan).append($returnMsgDiv);
		   	/*把消息加入到聊天框中*/
		   	$(".online_show_talk").append($serviceDiv);
		    
	    	//让滚动条显示在最下方
			$(".online_show_talk").stop();
            $(".online_show_talk").animate({scrollTop:$(".online_show_talk").offset().top+100000}, 1000);
	    } else{
	    	/*消息背景图箭头*/
			var $rowImg = $("<em>");
	    	/*如果是0，是客户消息*/
	    	/*如果是字符串类型*/
	    	if(data.messageType == "string"){
	    		var received_msg = data.message;
	    		try{
	    			received_msg = JSON.parse(received_msg.replace(/\n/,'<br>')).msg;
	    		}catch(error){
	    			return;
	    		}
	    		//console.log(received_msg);
	    		
	    		/*消息内容盒子*/
				var $valueDiv = $("<div>").append($rowImg).append(received_msg).addClass("online_left_talk");


	    	} else if(data.messageType == "pic"){
	    		/*如果是图片类型*/
	    		var received_msg = data.message;
	    		received_msg = JSON.parse(received_msg).url;
	    		//console.log(received_msg);
	    		var $newImg = $("<img>").attr("src",received_msg).addClass("msg-img");
	    		var $valueDiv = $("<div>").append($rowImg).append($newImg).addClass("online_left_talk");


	    	} else if(data.messageType == "file"){
	    		/*如果是文档类型*/
	    		var received_msg = data.message;
	    		received_msg = JSON.parse(received_msg);
	    		var $fileUrlBtn = $("<a>").attr("href",received_msg.url).html("下载");
	    		var $fileName = $("<p>").html("文件名称: "+received_msg.fileName+" , 文件大小: "+parseInt(received_msg.fileSize/1024)+"KB");
	    		var $valueDiv = $("<div>").append($rowImg).append($fileName).append($fileUrlBtn).addClass("online_left_talk");
	    	} else if(data.messageType == "inquiry"){
	    		
	    		var received_msg = data.message;
	    		received_msg = JSON.parse(received_msg);
	    		var askDiv = $("<div>").addClass("online_pro_box").attr("id","askNowBox");
	    		var $imgDiv = $("<img>").attr("src",received_msg.largeUrl).attr("id","askNowImg").css("width","100");
	    		askDiv.append($imgDiv);
	    		var infoDiv = $("<div>").addClass("online_pro_info").append($("<h1>").text(received_msg.aliasName).attr("id","askNowTitle"));
	    		infoDiv.append($("<p>").html(received_msg.code).attr("id","askNowCode"));
	    		infoDiv.append("包装形式：");
	    		infoDiv.append($("<span>").html(received_msg.packType).attr("id","askNowPack"));
	    		infoDiv.append($("<br>"));
	    		infoDiv.append($("<strong>").html("询价数量："));
	    		infoDiv.append($("<span>").addClass("askNowNum").attr("id","askNowNum").text(received_msg.num+"公斤").css("display","inline"));
	    		
	    		askDiv.append(infoDiv);
	    		
	    		var $valueDiv = $("<div>").append($rowImg).append(askDiv).addClass("online_left_talk");
	    	}else{
                return;
			}
	    	
	    	


			/*客户头像*/
            var $userImg = $("<img>").attr("src","images/person_img.jpg");
			/*客户用户名*/
			/*userName = encodeURIComponent(data.userName);*/
            var $userName = $("<p>").html(data.userName);
            userName = data.userName;
			/*头像盒子*/
            var $userImgDiv = $("<div>").addClass("customer_box").append($userName).append($userImg).addClass("customer_box");


			/*整体消息最外层盒子*/
            var $msgBox = $("<div>").addClass("online_right_talk_box").append($userImgDiv).append($timeSpan).append($valueDiv);
			/*最后把整条消息加到聊天框中*/
            if(received_msg.length>0){
                if(!$msgBox){
                    return;
                }
                console.log(received_msg);
                $(".online_show_talk").stop();
                $(".online_show_talk").append($msgBox);
                $(".online_show_talk").animate({scrollTop:$(".online_show_talk").offset().top+100000}, 1000,function(){
                    console.log("test");
                });
            }

	    	
	    	
	    	
	    }
	    
	    
	      
        
    };
    
    		    /**
     * 关闭连接
     */
    ws.onclose = function(){
    	console.log('websocket closed...');
    	alert('由于您长时间未操作，已经自动断开连接...');
		location.href = "/";
    };
	
	
	
	
	
	(function (){
		/*时间格式函数*/
		Date.prototype.Format = function (fmt) { //author: meizz 
		    var o = {
		        "M+": this.getMonth() + 1, //月份 
		        "d+": this.getDate(), //日 
		        "h+": this.getHours(), //小时 
		        "m+": this.getMinutes(), //分 
		        "s+": this.getSeconds(), //秒 
		        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
		        "S": this.getMilliseconds() //毫秒 
		    };
		    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
		    for (var k in o)
		    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
		    return fmt;
		}
	})()
	
	
	/*点击发送按钮发送消息*/
	$(".send_btn").on("click",function(){
		
		sendMsgLocal();
		
	})
	/*按回车发送消息*/
	$(document).on("keydown",function(ev){
		//console.log(ev);
		if(ev.keyCode == "13"){
			sendMsgLocal();
			return false;
		}
	})
	/*发送消息方法*/
	function sendMsgLocal(){
        // userName = $.cookie('I7COLOR_USER_NAME');
		var value = $("#msgInp").get(0).value;
		$("#msgInp").get(0).value = "";
		//console.log(value);
		/*客户头像*/
		var $userImg = $("<img>").attr("src","images/person_img.jpg");
		/*客户用户名*/
		var $userName = $("<p>").html(userName);
		/*头像盒子*/
		var $userImgDiv = $("<div>").addClass("customer_box").append($userName).append($userImg).addClass("customer_box");
		
		
		
		/*当前时间*/
		var nowTime = new Date().Format("yyyy.MM.dd hh:mm:ss");
		//console.log(nowTime);
		var $timeSpan = $("<span>").html(nowTime);
		
		/*消息背景图箭头*/
		var $rowImg = $("<em>");
		/*消息内容盒子*/
		var $valueDiv = $("<div>").append($rowImg).append(value).addClass("online_left_talk");
		/*整体消息最外层盒子*/
		var $msgBox = $("<div>").addClass("online_right_talk_box").append($userImgDiv).append($timeSpan).append($valueDiv);
		/*最后把整条消息加到聊天框中*/
		if(value){
			$(".online_show_talk").append($msgBox);
            $(".online_show_talk").animate({scrollTop:$(".online_show_talk").offset().top+100000}, 1000);
		}
		
		
		
		/*往服务器发送消息*/
		
	    var txt = {"type":"string","body":"{\"msg\":\""+value+"\"}"};
	    txt = JSON.stringify(txt);
	    //console.log(txt);
	    /**
	     * 发送消息
	     */
	    if(txt.length>0){
	        ws.send(txt);
	        console.log(txt);
	        console.log(ws);
	    }else{
	        //alert("请输入文字");
	    }
		
	}
	/*sendMsg-end*/
	
	/*for(var i = 0;i < 100000;i++){
		$.ajax({
		type:"get",
		url:'http://192.168.11.190:8080/trade-app/service/inquiry/queryInquiryList?queryCond={\"id\":1}&pageNo=1&pageSize=10',
		success:function(result){
			console.log(result);
			var data = JSON.parse(result).data[0];
			
		},
		 error: function(XMLHttpRequest, textStatus, errorThrown) {
			 console.log(XMLHttpRequest.status);
			 console.log(XMLHttpRequest.readyState);
			 console.log(textStatus);
		 }
	})
	}*/
	
	/*获取正在询价信息*/

    var inquiryId = $.getUrlParamValue("id");
    var askNowImg = '';
    var askNowTitle = '';
    var askNowCode = '';
    var askNowNum = '';
    var askNowEid = '';
    var askNowPack = '';
    
    
    
    if($.notNull(inquiryId)){
        $.ajax({
            type:"get",
            // url:'http://localhost/trade-app/service/inquiry/queryInquiryList?queryCond={\"id\":1}&pageNo=1&pageSize=10',
            url:'/carts/ajax/'+inquiryId,
            success:function(result){
                //console.log(result);
				if(!$.notNull(result) || result.length == 0){
					alert('询价已失效，请重新询价');
					location.href = "/kefu";
				}
                var data = result[0];
                //data = data.product;
                console.log(data);
                //console.log($("#askNowImg"));
				/*正在询价的商品图片*/
                askNowImg = itx+data.product.smallUrl;
                $("#askNowImg").attr("src",askNowImg);
				/*正在询价的商品名字*/
                askNowTitle = data.product.aliasName;
                $("#askNowTitle").html(askNowTitle);
				/*正在询价的商品编号*/
                askNowCode = data.product.code;
                askNowEid = data.product.eid;
                $("#askNowCode").html(askNowCode);
				/*正在询价商品数量*/
                askNowNum = data.num;
                $("#askNowNum").html(askNowNum+" 公斤");
				/*正在询价商品数量的input框*/
                $("#askNumInp").get(0).value = data.num;
				/*包装形式*/
                var packValueArray = data.product.propTypeList;
				/*从商品数组中找到typeText为包装形式的那个，取出第一个里面的value*/
                for(var i = 0;i < packValueArray.length;i++){
                    if(packValueArray[i].typeText == "包装形式"){
                        var packValue = packValueArray[i].propList[0].name;
                        askNowPack = packValue;
                        onePackageNum = parseFloat(packValue);
                        break;
                    }
                }
                $(".online_right_box #askNowPack").html(packValue);


				/*最小询价数量*/
                if("minNum" in data.product){
                    var $minNumEm = $("<em>").html(data.product.minNum);
                    $("#askNowBox").append($minNumEm.addClass("minNumEm").css("display","none"));
                }

				/*获取companyId和productEid*/
                $(".online_this_pro #askNowBox").append($("<i>").html(data.companyId).addClass("companyId").css("display","none"));
                $(".online_this_pro #askNowBox").append($("<b>").html(data.productEid).addClass("productEid").css("display","none"));
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                console.log(XMLHttpRequest.status);
                console.log(XMLHttpRequest.readyState);
                console.log(textStatus);
            }
        })
	}else{
    	$('#alredy_coll').hide();
    	$('.online_this_pro').hide();
        $(".online_this_pro #askNowBox").append($("<i>").html("").addClass("companyId").css("display","none"));
        $(".online_this_pro #askNowBox").append($("<b>").html("").addClass("productEid").css("display","none"));
	}

    var numreg = /.*\..*/;
    
	/*获取正在询价商品*/
	
	/*增加正在询价商品数量*/
	
	$(document).on("click",".add-ask-num",function(){
        onePackageNum = parseFloat($(this).parent().parent().children().eq(2).html());
		//console.log($(this).parent().find("input"));
		$(this).parent().find("input").get(0).value = parseFloat($(this).parent().find("input").get(0).value)+parseFloat(onePackageNum);
		
		if(numreg.test($(this).parent().find("input").get(0).value)){
			$(this).parent().find("input").get(0).value = parseFloat($(this).parent().find("input").get(0).value).toFixed(2);
		}
		
		$(this).parent().parent().find(".askNowNum").html($(this).parent().find("input").get(0).value+" 公斤");
		//console.log($(this).parent().parent().find(".askNowNum"));
	})
	
	
	/*减少正在询价的商品*/
	
	$(document).on("click",".reduce-ask-num",function(){
        onePackageNum = parseFloat($(this).parent().parent().children().eq(2).html());
		//console.log($(this).parent().find("input"));
		$(this).parent().find("input").get(0).value = parseFloat($(this).parent().find("input").get(0).value)-parseFloat(onePackageNum);
		
		
		if(numreg.test($(this).parent().find("input").get(0).value)){
			$(this).parent().find("input").get(0).value = parseFloat($(this).parent().find("input").get(0).value).toFixed(2);
		}
		
		/*如果有最小询价，那么不能小于放在里面的最小询价em标签的内容*/
		if($(this).parent().parent().parent().find("em")){
			if($(this).parent().find("input").get(0).value < $(this).parent().parent().parent().find("em").html()){
				$(this).parent().find("input").get(0).value = $(this).parent().parent().parent().find("em").html();
			}
		}
        if(parseFloat($(this).parent().find("input").get(0).value) < parseFloat($(this).parent().parent().parent().find("em").html())){
            $(this).parent().find("input").get(0).value = $(this).parent().parent().parent().find("em").html();
        }
		/*如果没有最小询价值，那么最小数不能小于1*/
		/*if($(this).parent().find("input").get(0).value<1){
			$(this).parent().find("input").get(0).value = 1;
		}*/
		$(this).parent().parent().find(".askNowNum").html($(this).parent().find("input").get(0).value+" 公斤");
	})
	
	
	/*通过input框来改变正在询价的商品数量*/
	
	$(document).on("blur",".askNumInp",function(){
        onePackageNum = parseFloat($(this).parent().parent().children().eq(2).html());
		if($(this).parent().parent().parent().find("em")){
			if(parseFloat($(this).parent().find("input").get(0).value) < parseFloat($(this).parent().parent().parent().find("em").html())){
				$(this).parent().find("input").get(0).value = $(this).parent().parent().parent().find("em").html();
			}
			if((parseFloat($(this).val())*100)%(parseFloat(onePackageNum)*100)){
				$(this).val(parseFloat($(this).val())-((parseFloat($(this).val())*100)%(parseFloat(onePackageNum)*100)/100));
			}
			/*console.log(typeof (toNumber($(this).parent().find("input").get(0).value)+1));
			if(typeof (toNumber($(this).parent().find("input").get(0).value)+1) == "string"){
				$(this).parent().find("input").get(0).value = $(this).parent().parent().parent().find("em").html();
			}*/
		}
		
		if($(this).get(0).value < 1){
			$(this).get(0).value = 1;
		}
		/*后面隐藏的span值*/
		$(this).parent().parent().find(".askNowNum").html($(this).get(0).value+" 公斤");
	})
	/*只能输入数字*/
	$(document).on("keydown",".askNumInp",function(ev){
		//console.log(ev.keyCode);
		if( (ev.keyCode >= 48 && ev.keyCode <= 57) || ev.keyCode == 8 || ev.keyCode == 110
			|| (ev.keyCode >= 96 && ev.keyCode <= 105)
			|| (ev.keyCode >= 37 && ev.keyCode <= 40)){
			ev.returnValue = true;
		} else{
			return false;
		}
	})
	
	
	/*获取收藏产品列表信息*/
	if(LOGIN_MODE){

		$.ajax({
			type:"get",
			url:'/favorites/',
			success:function(result){
				//console.log(result);
				var data = result;
				console.log(data);

				$.each(data,function(index,data){
					/*收藏列表商品图片*/
					var $proImg = $("<img>").attr("src",itx+this.product.smallUrl);
					/*收藏列表信息div*/
					var $proInfoDiv = $("<div>").addClass("online_pro_info");
					/*收藏列表信息全称*/
					var $proName = $("<h1>").html(data.product.aliasName);
					/*收藏列表信息编码*/
					var $proCode = $("<p>").html(data.product.code);
					/*for循环找出包装形式的值*/
					var packValueArray = data.product.propTypeList;
					for(var i = 0;i < packValueArray.length;i++){
						if(packValueArray[i].typeText == "包装形式"){
							var packValue = packValueArray[i].propList[0].name;
							break;
						}
					}
					/*包装形式span标签*/
					var $packSpan = $("<span>").html(packValue);

					/*询价数量*/
					var $askNumSpan = $("<span>").html(data.product.num);

					var $reduceA = $("<a>").html("-").attr("href","javascript:;").addClass("reduce-ask-num");
					var $addA = $("<a>").html("+").attr("href","javascript:;").addClass("add-ask-num");
					var $numInp = $("<input>").addClass("askNumInp").attr({"type":"text","value":data.product.minNum||1});
					var $numBox = $("<span>").addClass("num-box").append($reduceA).append($numInp).append($addA);

					var $minEm = $("<em>").html(data.product.minNum||1).css("display","none");

					$proInfoDiv.append($proName).append($proCode).append("包装形式：").append($packSpan)
								.append("<br/><strong>询价数量：</strong>").append($numBox).append($minEm).append($("<a>").attr("href","javascript:;").html("询价").addClass("listAskBtn"))
								.append($("<b>").html(data.product.eid).css("display","none").addClass("productEid"));

					/*加到最外层里面*/
					var $proInfoBox = $("<div>").append($proImg).append($proInfoDiv).addClass("online_pro_box brb");

					$(".already_coll_box").append($proInfoBox);
				})



			},
			 error: function(XMLHttpRequest, textStatus, errorThrown) {
				 console.log(XMLHttpRequest.status);
				 console.log(XMLHttpRequest.readyState);
				 console.log(textStatus);
			 }
		})
    }
	
	
	
	$("#add-collect").on("click",function(){
		/*当收藏列表内存在该正在询价商品时，函数返回*/
		if($(".already_coll_box #askNowBox").length>0){
			return;
		}
		
		var $clone = $(".online_this_pro #askNowBox").clone().css("paddingLeft",0)
											.css("position","relative").append($("<a>").attr("href","javascript:;").html("询价").addClass("listAskBtn"))
		$clone.find(".askNowNum").attr("id",$clone.find(".askNowNum").attr("id")+parseFloat(Math.random()*10));
		$(".already_coll_box").prepend($clone);
		$clone.get(0).scrollIntoView();
		
		
			
		
		/*获取存储的companyId和productEid*/
		var companyIdValue = $("#add-collect").parent().children().find(".companyId").html();
		var productEidValue = $("#add-collect").parent().children().find(".productEid").html();
		
		console.log(companyIdValue);
		console.log(productEidValue);
		/*创建收藏ajax*/
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded; charset=utf-8",
			url:"/favorites/ajaxAddFavorite",
			data:{productEid:productEidValue},
			success:function(result){
				console.log(result);
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) {
				 console.log(XMLHttpRequest.status);
				 console.log(XMLHttpRequest.readyState);
				 console.log(textStatus);
		 	}
		})
		
		/*$(".add-ask-num").not($(".add-ask-num").eq(0)).each(function(){
			$(this).on("click",function(){
				//console.log($(this).parent().find("input"));
				$(this).parent().find("input").get(0).value = parseInt($(this).parent().find("input").get(0).value)+1;
			})
		})
		
		
		$(".reduce-ask-num").not($(".reduce-ask-num").eq(0)).each(function(){
			$(this).on("click",function(){
				//console.log($(this).parent().find("input"));
				$(this).parent().find("input").get(0).value = parseInt($(this).parent().find("input").get(0).value)-1;
				
				if($(this).parent().parent().parent().find("em")){
					if($(this).parent().find("input").get(0).value < $(this).parent().parent().parent().find("em").html()){
						$(this).parent().find("input").get(0).value = $(this).parent().parent().parent().find("em").html();
					}
				}
				
				if($(this).parent().find("input").get(0).value<1){
					$(this).parent().find("input").get(0).value = 1;
				}
			})
		})
		
		
		$(".askNumInp").each(function(){
			$(this).on("blur",function(){
				if($(this).get(0).value < 1){
					$(this).get(0).value = 1;
				}
			})
		})*/
	})
	/*$("#collect-btn")*/
	
	/*正在询价商品的询价按钮*/
	$("#ask-btn").on("click",function(){
		
		askPrice();
		
		
	})
	/*$("#ask-btn")*/
	
	/*点击我的收藏里面的询价按钮*/
	$(document).on("click",".listAskBtn",function(){

        $('#alredy_coll').show();
        $('.online_this_pro').show();
		console.log("list");
		/*取消加入收藏点击事件*/
		$("#add-collect").off("click");

		askNowImg = $(this).parent().parent().find("img").attr("src");
		$(".online_this_pro #askNowImg").attr("src",askNowImg);
		/*正在询价的商品名字*/
		askNowTitle = $(this).parent().find("h1").html();
		$(".online_this_pro #askNowTitle").html($(this).parent().find("h1").html());
		/*正在询价的商品编号*/
		askNowCode = $(this).parent().find("p").html();
		$(".online_this_pro #askNowCode").html($(this).parent().find("p").html());
		/*正在询价商品数量*/
		askNowNum = $(this).parent().find(".askNumInp").get(0).value;
		$(".online_this_pro #askNowNum").html($(this).parent().find(".askNumInp").get(0).value+"公斤");
		/*正在询价商品数量的input框*/
		$(".online_this_pro #askNumInp").get(0).value = $(this).parent().find(".askNumInp").get(0).value;
		$(".online_this_pro #askNowPack").html($(this).parent().children().eq(2).html());
        $(".online_this_pro .productEid").html($(this).parent().children().eq(8).html());
        console.log($(this).parent().children().eq(8).html());
		askPrice();
		
	})
	
	//进行询价操作
	function askPrice(){
		//显示询价消息
		displayAskPrice();
		//发送询价请求
		sendAskPrice();
		
	}
	
	
	
	//显示询价消息
	function displayAskPrice(){
		/*消息内容盒子*/
		var $valueDiv = $("<div>").append($rowImg).append($(".online_this_pro #askNowBox").clone(true).children()
									.find(".num-box").css("display","none")
									.parent().parent()).addClass("online_left_talk");
    	$valueDiv.find("#askNowNum").css({"display":"inline"});	
    	
    	/*当前时间*/
		var nowTime = new Date().Format("yyyy.MM.dd hh:mm:ss");
		//console.log(nowTime);
		var $timeSpan = $("<span>").html(nowTime);
    	
    	/*客户头像*/
		var $userImg = $("<img>").attr("src","images/person_img.jpg");
		/*客户用户名*/
		var $userName = $("<p>").html($.cookie('I7COLOR_USER_NAME'));
		/*头像盒子*/
		var $userImgDiv = $("<div>").addClass("customer_box").append($userName).append($userImg).addClass("customer_box");
		
		/*消息背景图箭头*/
		var $rowImg = $("<em>");
		
		
		/*整体消息最外层盒子*/
		var $msgBox = $("<div>").addClass("online_right_talk_box").append($userImgDiv).append($timeSpan).append($valueDiv);
		/*最后把整条消息加到聊天框中*/
		
		$(".online_show_talk").append($msgBox);
		$msgBox.get(0).scrollIntoView();
	}
	
	
	
	//发送询价请求
	function sendAskPrice(){
		
		/*获取存储的companyId和productEid*/
		var companyIdValue = $(".online_this_pro #ask-btn").parent().children().find(".companyId").html();
		var productEidValue = $(".online_this_pro #ask-btn").parent().children().find(".productEid").html();
		var inqurityNumValue = $(".online_this_pro #ask-btn").parent().children().find("input").get(0).value;
		console.log(inqurityNumValue)
		
		$.ajax({
			type:"post",
			url:"/carts/addInquiry",
			data:{companyId:companyIdValue,productEid:productEidValue,inquriyNum:inqurityNumValue},
			success:function(result){
				var inquiryId = result.id;
				
				sendAskPriceMsg(inquiryId,askNowImg,askNowTitle,askNowCode,askNowNum,productEidValue)
			    
				console.log(result);
			},
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                console.log(XMLHttpRequest.status);
                console.log(XMLHttpRequest.readyState);
                console.log(textStatus);
            }
		})
	}
	
	function sendAskPriceMsg(inquiryId,askNowImg,askNowTitle,askNowCode,askNowNum,askNowEid){
		
		var txt = {"type":"inquiry","body":"{\"inquiryId\":"+inquiryId+",\"num\":"+askNowNum+",\"code\":\""+askNowCode+"\",\"eid\":\""+askNowEid+"\",\"aliasName\":\""+askNowTitle+"\",\"largeUrl\":\""+askNowImg+"\"}"};
	    txt = JSON.stringify(txt);
	    //console.log(txt);
	    /**
	     * 发送消息
	     */
	    if(txt.length>0){
	        ws.send(txt);
	        console.log(txt);
	        console.log(ws);
	    }
	}
	
	/*askPrice*/
	
	
	$("#myCollect").on("click",function(){
		$("#collectBox").css("display","block");
		$("#problem").css("display","none");
		console.log("#myCollect");
	})
	
	$("#commonProblem").on("click",function(){
		$(".advie").css("display","block");
		$("#collectBox").css("display","none");
		$("#problem").css("display","block");
		//console.log("#");
	})
	
	
})
/*$(function)*/