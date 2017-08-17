package com.tiexue.mcp.core.entity;

public class WxConstants {
	// 微信验证 token
	public static final String WxToken = "txmobilekey"; //ok_peng

	// 微信网页授权state
	public static final String WxOauthState = "ok"; //ok_peng

	// 微信公众号Appid
	public static final String WxAppId = "wxc2e19d731b2a7eee"; //ok_peng

	// 微信公众号AppSecret
	public static final String WxAppSecret = "4621f2160d63235249790c6a90053f16"; //ok_peng

	// 微信网页授权回调地址
	public static final String WxRedirectUrl = "http://danhuang.zhanlve5.com/wxUser/wxoauthcallback"; //ok_peng

	// 微信网页授权语言编码
	public static final String WxSnsLang = "zh_CN"; //ok_peng

	// 微信商户支付相关
	public static final String WxMch_Id = "1484388362"; //ok_peng

	// 微信商户支付秘钥
	public static final String WxMch_Key = "t0EZVIvBwvytVL4RYh2H0HuR6sygnDxv"; //ok_peng

	// 微信商户支付后回调url
	public static final String WxMch_NotifyUrl = "http://danhuang.zhanlve5.com/wxPay/wxpaycallback"; //ok_peng

	// 签名方式
	public static final String WxMch_SignType = "MD5";  //ok_peng

	// 交易发起方式
	public static final String WxMch_TradeType = "JSAPI";  //ok_peng

}
