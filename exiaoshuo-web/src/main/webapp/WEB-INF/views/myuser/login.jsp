<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/include_base.jsp"%>
<title>用户登录</title>
</head>

<body>
<div class="nav-panel bookinfo-title">
		<a class="bookinfoback" href="javascript:history.go(-1)">«</a>&nbsp;&nbsp;一键登录
		<a href="<%=path%>/?ch=${fromurl}" class="icohome"></a>
	</div>
<div class="panel">
	
	<div class="other_login">
        
		<ul>
			<li><a class="btn block btn_login" href="<%=path%>/myuser/wechatdologin/?ch=${fromurl}"><span class="bgs login_wxpng"></span>微信登录</a></li>
		</ul>
		<br>
	</div>
</div>
<div class="mod_content c1">
	<ul>
        <li class="orange"><strong>温馨提示：</strong></li>
		<li>微信和手机方式登录的账号相互独立，各账号内的小说币和小说豆不能共用！</li>       
		
	</ul>
</div>
<%@ include file="/WEB-INF/views/include/include_footer.jsp"%>
</body>
</html>
