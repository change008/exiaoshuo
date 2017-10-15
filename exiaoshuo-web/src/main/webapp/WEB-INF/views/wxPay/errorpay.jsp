<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/include_base.jsp"%>
<title>支付失败</title>
</head>

<body>
<div class="nav-panel bookinfo-title">
		<a class="bookinfoback" href="javascript:history.go(-1)">«</a>&nbsp;&nbsp;微信支付
		<a href="<%=path%>/?fm=${fromurl}" class="icohome"></a>
	</div> 
<div class="wrap">
	<p class="panel margin-top-10">如果在微信支付的过程中提示您“无法跨号支付”，您可以考虑使用微信二维码支付。</p>
<!-- 	<a class="btn block" href="#">微信二维码充值</a> -->
	 <a class="btn block" href="<%=path%>/wxPay/pay">再次充值</a> 
	 <a class="btn block" href="<%=path%>/">返回看书</a> 
	 </div>
<%@ include file="/WEB-INF/views/include/include_footer.jsp"%>
</body>
</html>