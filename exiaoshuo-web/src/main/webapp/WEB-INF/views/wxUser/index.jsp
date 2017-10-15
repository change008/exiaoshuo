<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/include_base.jsp"%>
<title>用户中心</title>
<style>
	.mod_userheader{
		background:#ed424b url("https://qidian.gtimg.com/qdm/img/center-header-bg.c36bb.jpg") no-repeat center;
		background-size:cover;
		padding-bottom:20px;
	}
	.bookinfo-title{
		color:white;	
	}
	.bookinfoback{
		color:white;	
	}
	.icohome{
		background-image:url(<%=path %>/static/image/home_white.png);
	}
	.mod_userinfo{
		text-align:center;
		color:white;
	}
	.purchase{
		height:60px;
		padding-left:15px;
		line-height:60px;
		font-size:18px;
	}
	.purchase a {
		float:right;
	}
</style>

</head>
<body>
<input type="hidden" id="fromurl" name="fromurl" value="${fromurl }">
<div class="mod_userheader">
	<div class="nav-panel bookinfo-title">
		<a class="bookinfoback" href="javascript:history.go(-1)">«</a>&nbsp;&nbsp;个人中心
		<a href="<%=path%>/?fm=${fromurl}" class="icohome"></a>
	</div> 
	<div class="mod_userinfo">
		<p>
			<img src="${user.getHeadericon()}" class="avatar large">
		</p>
		<p>
			${user.getName()}
		</p>
		<p>
			<c:if test="${deadline!=null&&!deadline.isEmpty()}">
				<span class="badge hot">包年VIP (${deadline})</span>
			</c:if>
			<c:if test="${deadline==null||deadline.isEmpty()}">
				<span class=" badge normal">${user.getUsertypestr()}</span>
			</c:if>
		</p>
	</div>
</div>
<div class="purchase">
	小说币&nbsp;&nbsp;&nbsp;<label class="orange">${user.getCoin() }</label><label class="orange"></label>
	<a href="<%=path%>/wxPay/pay?fm=${fromurl}"><img src="<%=path %>/static/image/purchase.png" height="60"/></a>
</div>
	
	<div class="mod_tab_content">
		<p class="solid"></p>
		<div class="">
			<ul class="class_list">
				<li><a href="<%=path%>/wxPay/index/?fm=${fromurl}"><span
						class="txt">充值记录</span><img
						src="<%=path%>/static/image/user/arrow_r.png"
						class="arrow_r"></a></li>
				<li><a href="<%=path%>/wxConsume/index/?fm=${fromurl}"><span
						class="txt">消费记录</span><img
						src="<%=path%>/static/image/user/arrow_r.png"
						class="arrow_r"></a></li>
			</ul>
		</div>
		<p class="solid"></p>
		<div class="">
			<ul class="class_list">
				<%-- <li><a href="#"><img
						src="<%=path%>/static/image/user/icon_nearread.png" class="icon"><span
						class="txt">最近阅读</span><img
						src="<%=path%>/static/image/user/arrow_r.png"
						class="arrow_r"></a></li> --%>
				<li><a href="<%=path%>/wxBookrack/list/?fm=${fromurl}"><span
						class="txt">我的书架</span><img
						src="<%=path%>/static/image/user/arrow_r.png"
						class="arrow_r"></a></li>
			<li><a href="#" onclick="loginout()"><span
						class="txt">退出登录</span><img
						src="<%=path%>/static/image/user/arrow_r.png"
						class="arrow_r"></a></li>

			</ul>
		</div>
		<p class="solid"></p>
		<div class="">
			<ul class="class_list">
			</ul>
		</div>
		<p class="solid"></p>
	</div>
	
<%@ include file="/WEB-INF/views/include/include_footer.jsp"%>
</body>
<script type="text/javascript" src="<%=path %>/static/js/public.js"></script>
<script type="text/javascript">
function loginout(){
	var fromurl=$("#fromurl").val();
	setCookie("wx_gzh_token","",-1);
	window.location.href="<%=path %>/?fm="+fromurl; 
}
</script>
</html>
