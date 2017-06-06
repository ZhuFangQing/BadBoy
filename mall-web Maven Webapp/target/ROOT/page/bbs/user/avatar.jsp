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
    <link href="/css/placeorder.css" rel="stylesheet" type="text/css" />
    <link href="/css/bbs.css" rel="stylesheet" type="text/css" />
    <script>
        var picUrl = "${picUrl}";

        $(document).ready(function(){
            if($.notNull(picUrl)){
                $("#picUrl").attr("src", itx + picUrl)
            }


            $("#file_input").change(function(){
               uploadImg();
            });
        });

        function uploadImg() {
            var url = '/bbs/uploadImage';
            var imgFileId = "file_input";
            var urlInputId = "avatarPath";

            uploadFile(url, imgFileId, urlInputId);
        }


        function uploadFile(url, fileId, urlInputId) {
            $.ajaxFileUpload({
                url : url,
                secureuri : false,
                fileElementId : fileId,
                dataType : 'text',
                // 服务器成功响应处理函数
                success : function(data) {
                    data = $.parseJSON(data);
                    if (data.result == 1) {
                        alert("上传成功");
                        $("#" + urlInputId).val(data.url);
                        $("#picUrl").attr("src", itx + data.url);
                    } else {
                        alert("上传失败，请稍候重新上传");
                    }
                },
                // 服务器响应失败处理函数
                error : function(data, status, e) {
                    console.log(e);
                }
            });
        }
    </script>
</head>
<body>
<%--top模块--%>
<%@ include file="/page/common/top.jsp" %>

<div class="mian_content container">
    <jsp:include page="/page/common/usercenter.jsp"></jsp:include>
    <div class="mumber_right_content">
        <div class="bbs_user_imgsetbox">
            <h1>设置我的新头像</h1>
            <input type="hidden" id="avatarPath" name="avatarPath">
            <input type="file" name="file_input" id="file_input" /><img src="/images/upload_img_btn.jpg" />
            <p>请选择一个新照片进行上传编辑<br/>头像保存后，您可能需要刷新一下本页面（按F5键），才能查看最新的头像效果</p>
        </div>
        <div class="bbs_user_imgshowbox">
            <h1>当前我的头像</h1>
            <div class="bbs_user_current_img"><img id="picUrl" src="/images/bbs_test_img.jpg" width="100%" height="100%" /></div>
            <p>如果您还没有设置自己的头像，系统会显示为默认头像，<br/>您需要自己上传一张照片来作为自己的个人头像</p>
            <div class="bbs_user_current_img big"><img src="/images/bbs_test_img.jpg" width="100%" height="100%" /></div>
        </div>
    </div>
    <div class="clear"></div>
</div>
<%@ include file="/page/common/foot.jsp" %>
</body>
</html>