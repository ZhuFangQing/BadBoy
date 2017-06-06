package com.i7colors.commons.constant;

/**
 * 请求url常量
 * 
 * @author Max
 */
public class ConstUrl {
	// ====================User=================================

	// 用户登录
	public static final String USER_LOGIN = "customerUser/customerUserLogin";

	// 用户注册
	public static final String USER_REGISTER = "customerUser/registerUserInfo";

	// 企业注册
	public static final String COMPANY_REGISTER = "customerUser/registerCompanyInfo";

	// 获取用户权限
	public static final String USER_AUTH_GET = "customerUser/getUserAuth";

	// 获取用户个人信息
	public static final String USER_INFO_GET = "customerUser/getInfoById";

	// 更新用户信息
	public static final String USER_INFO_UPDATR = "customerUser/updateUserInfo";

	// 获取用户数量
	public static final String GET_USER_COUNT = "customerUser/getCustomerUserCount";

	// 找回密码验证手机号
	public static final String CHECK_FIND_PWD_PHONE = "customerUser/checkUser";

	// 创建企业用户
	public static final String CREATE_COMPANY_ACCOUNT = "company/createCompany";

	// 完善企业用户信息
	public static final String UPDATE_COMPANY_ACCOUNT = "company/updateCompany";

	// 查询企业认证信息
	public static final String SELECT_SINGLE_COMPANY_ACCOUNT = "company/queryCompanyList";

	// 获取商城通知
	public static final String GET_MALL_INFORM_LIST = "mallInform/getMallInformList";

	// 获取商城通知详情
	public static final String GET_MALL_INFORM_DETAILS = "mallInform/getMallInformDetails";

	// 删除商城通知
	public static final String DELETE_MALL_INFORM_LIST = "mallInform/deleteMallInformList";

	// 标记已读商城通知
	public static final String READED_MALL_INFORM_LIST = "mallInform/readMallInform";

	// 发送短信验证码
	public static final String SEND_SMS_CODE = "smsLog/send";

	// 发送邮件验证码
	public static final String SEND_EMAIL_CODE = "emailLog/send";

	// 检查微信 openid
	public static final String CHECK_WX_OPENID = "thirdlogin/checkOpenId";

	// 检查QQ openid
	public static final String CHECK_QQ_OPENID = "thirdlogin/checkQQ";

	// 检查手机号是否绑定微信
	public static final String CHECK_IS_BIND_WX = "thirdlogin/checkIsBindWx";

	// 检查手机号是否绑定QQ
	public static final String CHECK_IS_BIND_QQ = "thirdlogin/checkIsBindQQ";

	// 检查手机号是否绑定QQ
	public static final String BIND_WX_OPENID = "thirdlogin/bindWxOpenId";

	// 检查手机号是否绑定QQ
	public static final String BIND_QQ_OPENID = "thirdlogin/bindQQOpenId";
	// =======================资金================================
	// 获取用户余额以及信用额度信息
	public static final String GET_USER_MONEY_INFO = "userMoney/getUserBalanceInfo";
	// 获取用户现金流水信息
	public static final String GET_USER_CASH_FLOW = "userMoney/getCashFlow";
	// 获取信用额度使用信息
	public static final String GET_USER_CREDIT_FLOW = "userMoney/getCreditFlow";
	// 申请提额以及延长账期
	public static final String APPLY_USER_MONEY = "userMoney/apply";
	// 获取申请列表
	public static final String GET_APPLY_LIST = "userMoney/getApply";

	// =====================商城=============================

	// 获取商城商品属性
	public static final String MALL_MENU_PROPERTY_GET = "product_productClassification/listAllClassWithPropId";

	// 获取商城商品分类
	public static final String MALL_MENU_TYPE_GET = "product_prop/getAllPropWithType";

	// =====================产品=============================

	// 获取商品信息
	public static final String PRODUCT_INFO_GET = "product/getPlateProductList";

	// 获取单个商品详细信息
	public static final String PRODUCT_DETAIL_GET = "product/detailProductByEID";

	// 获取商品列表
	public static final String PRODUCT_LIST_GET = "product/listProduct";

	// =====================新闻资讯=============================
	// 获取行业资讯
	public static final String INDUSTRY_INFORMATION_GET = "information/industry_information";

	// 获取侧边栏资讯
	public static final String SIDE_INFORMATION_GET = "information/side_industry_information";

	// 获取资讯（根据板块）
	public static final String NEWS_BY_PLATE = "information/list_by_plate";

	// 获取热点资讯
	public static final String HOT_INFORMATION_GET = "information/hot_information";

	// 获取资讯详情
	public static final String INFO_DETAILS = "information/details";

	// 获取资讯上一条和下一条
	public static final String INFO_DETAILS_PREV_AND_NEXT = "information/details_prev_and_next";

	// 根据类型获取资讯
	public static final String GET_INFORMATION_BY_TYPE = "information/getInformationByType";

	// =====================会员风采=============================

	// 获取会员分类
	public static final String MEMBER_CLASSIFICATION_GET = "member/member_classification";

	// 获取会员分类列表
	public static final String MEMBER_MEMBER_DETAILS = "member/member_details";

	// 获取会员信息列表
	public static final String MEMBER_LIST_GET = "member/member_list";

	// 获取会员信息列表
	public static final String GET_MEMBERS_AND_SUPPLIERS = "member/membersAndSuppliers";

	// =====================合作伙伴=============================

	// 获取合作伙伴列表
	public static final String PARTNER_LIST = "partner/list";

	// =======================获取广告==================================
	// 根据code获取广告
	public static final String AD_INFOLIST_GET = "adInfo/getAdListByPlateCode";

	// =======================购物车==================================
	public static final String INQUIRY_LIST = "inquiry/queryInquiryList";
	public static final String INQUIRY_DELETE = "inquiry/deleteInquiry";
	public static final String INQUIRY_UPDATE_NUM = "inquiry/updateInquiryNum";
	public static final String INQUIRY_CREATE = "inquiry/createInquiry";
	public static final String ADD_TO_SHOP_CREATE = "inquiry/createOfferInquiry";
	public static final String INQUIRY_MULTI_DELETE = "inquiry/deleteMultiInquiry";
	public static final String PRODUCT_FAVORITE_LIST = "productFavorite/queryProductFavoriteList";
	public static final String PRODUCT_FAVORITE_MULTI_DELETE = "productFavorite/deleteMultiProductFavorite";
	public static final String PRODUCT_FAVORITE_MULTI_ADD = "productFavorite/createMultiProductFavorite";

	// =======================订单==================================
	public static final String ORDER_LIST = "parentOrder/queryParentOrderWithProductList";
	public static final String BALANCE_LIST = "balance/queryBalanceList";
	public static final String CREDIT_LIST = "credit/queryCreditList";
	public static final String PAYMENT_CREATE = "paymentInfo/createPaymentInfo";
	public static final String COMMIT_CARTS_ORDER = "parentOrder/createParentOrder";// 提交购物车订单
	// =====================================收货地址===============================
	public static final String GET_DELIVERY_ADDRESSS = "receiptAddress/queryReceiptAddressList";// 获取收货地址
	public static final String CREATE_DELIVERY_ADDRESSS = "receiptAddress/createReceiptAddress";// 新建收货地址
	public static final String UPDATE_DELIVERY_ADDRESSS = "receiptAddress/updateReceiptAddress";// 更新收货地址
	public static final String SET_DEFAULT_DELIVERY_ADDRESSS = "receiptAddress/setDefault";// 设置默认收货地址
	public static final String DELETE_DELIVERY_ADDRESSS = "receiptAddress/deleteReceiptAddress";// 删除收货地址
	// =======================================发票信息============================================
	public static final String GET_INVOICE_INFO = "invoiceInfo/queryInvoiceInfoList";// 获取发票信息
	public static final String CREATE_INVOICE_INFO = "invoiceInfo/createInvoiceInfo";// 新建发票信息
	public static final String UPDATE_INVOICE_INFO = "invoiceInfo/updateInvoiceInfo";// 更新发票信息
	public static final String SET_DEFAULT_INVOICE_INFO = "invoiceInfo/setDefault";// 设置默认发票信息
	public static final String DELETE_INVOICE_INFO = "invoiceInfo/deleteInvoiceInfo";// 删除发票信息

	// =======================================发票信息============================================
	public static final String GET_PROVINCE = "region/getProvince";// 获取省
	public static final String GET_CITY = "region/getCity";// 获取市
	public static final String GET_AREA = "region/getArea";// 获取区

	// =======================================大学堂======================================
	public static final String GET_SCHOOL_MENU = "schoolMenu/getSchoolMenuList";// 获取大学堂首页菜单
	public static final String GET_SCHOOL_INDEX_ARTICLE = "schoolIndex/getPlateArticle";// 获取大学堂首页板块内容
	public static final String GET_SCHOOL_ARTICLE_RANKING = "schoolArticle/querySchoolArticleListByRanking";// 获取大学堂文章（按点击排行）
	public static final String GET_SCHOOL_MENU_ARTICLE = "schoolMenuArticle/querySchoolMenuArticleList";// 获取大学堂菜单对应文章
	public static final String GET_SCHOOL_ARTICLE_COMMENT = "schoolComment/queryByArticle";// 获取大学堂文章评论
	public static final String GET_SCHOOL_ARTICLE_FAVORITE = "schoolArticleFavorite/querySchoolArticleFavoriteList";// 获取用户收藏文章信息
	public static final String GET_SCHOOL_HISTORY = "schoolHistory/querySchoolHistoryDetailList";// 获取用户浏览历史详细信息
	public static final String GET_SCHOOL_ARTICLE_DETAIL = "schoolArticle/querySchoolArticleList";// 获取大学堂菜单文章详情

	public static final String CREATE_ARTICLE_COMMENT = "schoolComment/createSchoolComment";// 提交评论
	public static final String CREATE_ARTICLE_FAVORITE ="schoolArticleFavorite/createSchoolArticleFavorite";//添加收藏文章
	public static final String CREATE_COMMENT_SUPPORT = "schoolSupport/createSchoolSupport";// 点赞

	// =======================================论坛======================================
	// 论坛推荐贴
	public static final String GET_BBS_RECOMMEND_POST_RELATION = "bbsRecommendPostRelation/queryBbsRecommendPostRelationList";
	// 论坛主贴列表
	public static final String GET_BBS_POST = "bbsPost/queryBbsPostList";
	// 论坛主贴数量
	public static final String GET_BBS_POST_COUNT = "bbsPost/queryBbsPostCount";
	// 论坛版块
	public static final String GET_LEVEL_BBS_SECTION_LIST = "bbsSection/queryLevelBbsSectionList";
	// 论坛版块详细
	public static final String QUERY_BBS_SECTION_LIST = "bbsSection/queryBbsSectionList";
	// 论坛主题
	public static final String QUERY_BBS_TOPIC_LIST_AND_COUNT = "bbsTopic/queryBbsTopicListAndCount";
	// 论坛回帖
	public static final String GET_REPLY_LIST = "bbsReply/queryBbsReplyList";
	// 论坛等级
	public static final String GET_LEVEL_LIST = "bbsLevel/queryBbsLevelList";
	// 论坛发帖
	public static final String POST = "bbsPost/post";
	// 论坛回帖
	public static final String REPLY = "bbsReply/createBbsReply";

	public static final String GET_USER_REPLY_LIST = "bbsPost/queryBbsUserReplyList";
	public static final String FIND_POST = "bbsPost/findPost";
	// 搜索用户
	public static final String QUERY_BBS_SEARACH_USER_LIST = "bbsSearchUser/queryBbsSearchUserList";
	// 删除消息
	public static final String DELETE_BBS_MESSAGE = "bbsMessage/deleteBbsMessage";
	// 发送消息
	public static final String CREATE_BBS_MESSAGE = "bbsMessage/createBbsMessage";
	// 消息列表
	public static final String QUERY_BBS_MESSAGE = "bbsMessage/queryBbsMessageList";
	// 论坛修改主贴
	public static final String UPDATE_BBS_POST = "bbsPost/updateBbsPost";
	// 论坛修改版块
	public static final String UPDATE_BBS_SECTION = "bbsSection/updateBbsSection";
	// 论坛修改回帖
	public static final String UPDATE_BBS_REPLY = "bbsReply/updateBbsReply";
	// 论坛管理员
	public static final String GET_MODERATOR = "bbsModerator/queryBbsModeratorList";
	// 获取版块聚合数据
	public static final String QUERY_BBS_SECTION_GROUP_DATA = "bbsSection/getGroupData";
	// 审核帖子
	public static final String AUDTING_BBS_POST = "bbsPost/audtingBbsPost";
	//删除帖子
	public static final String DELETE_BBS_POST = "bbsPost/deleteBbsPost";
	//收藏帖子
	public static final String COLLECT_BBS_POST = "bbsCollection/createBbsCollection";
	//拆分帖子
	public static final String SPLIT_BBS_REPLY = "bbsReply/splitBbsReply";
	//修改论坛话题
	public static final String UPDATE_BBS_TOPIC = "bbsTopic/updateBbsTopic";
	//删除论坛话题
	public static final String DELETE_BBS_TOPIC = "bbsTopic/deleteBbsTopic";
	//添加论坛话题
	public static final String CREATE_BBS_TOPIC = "bbsTopic/createBbsTopic";
}



