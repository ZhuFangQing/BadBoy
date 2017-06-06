<%--
  Created by IntelliJ IDEA.
  User: Echos
  Date: 2017/2/27
  Time: 13:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="bbs_search_box">
    <div class="search_input_box">
        <input type="text" placeholder="请输入搜索内容" id="bbs_search_box" />
        <div class="search_select_box">
            <select id="bbs_search_type">
                <option value="title">标题</option>
                <option value="user">用户</option>
            </select>
        </div>
    </div>
    <div class="search_btn"><img src="/images/search_icon_bbs.png" id="btn_search_box" /></div>
    <div class="hot_search_box">
        <strong>热搜：</strong>
        <a href="#">七彩云</a>
        <a href="#">数码墨水</a>
    </div>
</div>
<div class="clear"></div>