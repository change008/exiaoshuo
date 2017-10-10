<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/include_base.jsp"%>

<title>搜索小说</title>
<style>
.mod_tag{
	padding:10px;
}
.mod_tag a
{
	display:inline-block;
	padding:3px 12px;
	border:solid 1px #ccc;
	border-radius:12px;
	margin:0 8px 8px 0;
	font-size:12px;
	color:#999;
}
</style>
</head>

<body>
<div class="nav-panel bookinfo-title" style="background:#f2f2f2;margin-bottom:0">
		<a class="bookinfoback" href="javascript:history.go(-1)">«</a>&nbsp;&nbsp;搜索小说
		<a href="<%=path%>/?fm=${fromurl}" class="icohome"></a>
	</div>

<form method="post" action="<%=path%>/wxbook/searchlist">
		<div class="searchbox">
			<div class="searchd1">
				<input type="text" class="searchtxt" placeholder="输入书名/作者/关键字..."
					id="iptsearch" name="iptsearch" value="${iptsearch}">
			</div>
			<div class="searchd2">
				<input type="submit" class="searchbtn" value="">
			</div>
		</div>
</form>
<c:choose>
<c:when test="${iptsearch!=null&&iptsearch!=''}">
	<c:choose>
		<c:when test="${wxSearchBooks!=null&&wxSearchBooks.size()>0 }">
			<div class="mod_content">
			<ul>
			<c:forEach items="${wxSearchBooks}" var="books">
		      <li>
		        
		      	<a onclick="addbookrack('${books.id}','0')" href="<%=path%>/wxbook/detail?id=${books.id}&fm=${fromurl}"> 
		      	<img class="fn-left lazy" src="${books.coverImgs}" dataimg="${books.coverImgs}" alt="${books.name}">
				<div>
					<p>${books.name}</p>
					<p class="intro">${books.getIntr()}</p>
				</div>
				</a> 
		      </li>
		     </c:forEach>
				</ul>
			</div>
		</c:when>
		<c:otherwise>
			<div class="mod_content">
			<ul>
				<li>没有搜索到 ${iptsearch} 相关小说</li>
				</ul>
			</div>
			</c:otherwise>
	</c:choose>
</c:when>
<c:otherwise>

		
		<div class="mod_block" style="height:40px;line-height:55px;padding-left:10px;color:#999">大家都在搜</div>
		<div class="mod_tag">
			<c:forEach items="${wxBooks}" var="books">
				<a href="<%=path%>/wxbook/detail?id=${books.id}&fm=${fromurl}">${books.name}</a>
			</c:forEach>
		</div>
</c:otherwise>
</c:choose>


<!-- <div>
<a href="#" onclick="testaddcookie()">测试登录</a>
</div> -->


<%@ include file="/WEB-INF/views/include/include_footer.jsp"%>
</body>
<script type="text/javascript" src="<%=path %>/static/js/public.js"></script>
<script type="text/javascript">
function testaddcookie(){
	setCookie("wx_gzh_token","9519B0A907BB60F8ACADA7184CA0EEA5C984F95C9E7BE0956612C4F3B65B0F0239DB04E0BFC5BB36","1")
}
</script>
</html>

