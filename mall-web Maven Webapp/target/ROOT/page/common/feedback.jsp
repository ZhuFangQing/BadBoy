<%--
  Created by IntelliJ IDEA.
  User: Echos
  Date: 2016/12/3
  Time: 12:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="pop_bg"></div>
<div class="feedback_box" data-html2canvas-ignore="true" id="feedback">
    <div class="feedback_title">
        <a class="feedback_close" id="feedback_close">×</a>
        <h3>意见反馈</h3>
    </div>
    <div class="feedback_body">
        <div><span>反馈内容</span><span class="red">（*必填）</span></div>
        <textarea maxlength="400" class="feedback_content" name="issuedesc" data-exclude="true" placeholder="欢迎提出您在使用过程中遇到的问题或宝贵建议（400字以内），感谢您的支持。"></textarea>
        <div class="feedback_phone">联系方式</div>
        <input type="text" class="feedback_email" maxlength="100" placeholder="请留下您的联系方式，以便我们及时回复您。">
        <div class="feedback_footer"><div class="feedback_btn">提交反馈</div></div>
    </div>
</div>