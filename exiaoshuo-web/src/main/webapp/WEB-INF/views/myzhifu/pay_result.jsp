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
		<a class="bookinfoback" href="<%=path%>/mynovel/novel?id=${wxBook.id}">«</a>&nbsp;&nbsp;微信支付
		<a href="<%=path%>/?ch=${fromurl}" class="icohome"></a>
	</div>
<div class="wrap">
	<p class="panel margin-top-10">充值成功</p>
	 <a class="btn block" href="<%=path%>/myzhifu/pay?ch=${fromurl}">再次充值</a> 
	 <a class="btn block" href="<%=path%>/?ch=${fromurl}">返回看书</a> 
</div>


<%@ include file="/WEB-INF/views/include/include_footer.jsp"%>
</body>
</html>