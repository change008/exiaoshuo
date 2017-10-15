<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/include_base.jsp"%>
<style type="text/css">
.body1 {
	background: rgb(230, 224, 189);
}

.body2 {
	background: rgb(56, 56, 56);
}

.tc {
	text-align: center;
}

fieldset {
	border: none;
	border-top: 1px solid #ccc;
	padding: 0.25rem;
	margin: 0 0.75rem;
	font-size: 0.975rem;
}
</style>
<title>${wxChapterSub.bookName}</title>
</head>
<body>
	<article class="theme1">
		<nav>
			<span>${wxChapterSub.title}</span>
		</nav>
		<div class="content" style="font-size: 18px;">
			${wxChapterSub.content}
		</div>
		<ul class="chapter_pager">

			<li class="pn2"><c:if test="${wxChapterSub.preId>0 }">
					<a class="chapter_prev btn white block" data-cid="${wxChapterSub.preId}" href="<%=path %>/myzhangjiecontent/dcontent?bookId=${wxChapterSub.bookId}&chapterId=${wxChapterSub.preId}&ch=${fromurl}&qr=${qr}">上一章</a>
				</c:if> <c:if test="${wxChapterSub.preId<=0 }">
					<a class="chapter_prev btn white block" href="#" disabled="disabled">上一章</a>
				</c:if></li>
			<li class="pn2"><c:if test="${wxChapterSub.nextId>0 }">

					<a onclick="addbookrack('${wxChapterSub.bookId}','${wxChapterSub.nextId}')" class="chapter_next btn block" data-cid="${wxChapterSub.nextId}"
						href="<%=path %>/myzhangjiecontent/dcontent?bookId=${wxChapterSub.bookId}&chapterId=${wxChapterSub.nextId}&ch=${fromurl}&qr=${qr}">下一章</a>
				</c:if> <c:if test="${wxChapterSub.nextId<=0 }">
					<a class="chapter_next btn block" href="#" disabled="disabled">下一章</a>
				</c:if></li>
		</ul>
		<%@ include file="/WEB-INF/views/include/include_footer_QR.jsp"%>
	</article>
</body>

<script type="text/javascript" src="<%=path%>/static/js/public.js"></script>
<script>
	var cnzz_protocol = (("https:" == document.location.protocol) ? " https://"
			: " http://");
	document
			.write(unescape("%3Cspan id='cnzz_stat_icon_1263790946'%3E%3C/span%3E%3Cscript src='"
					+ cnzz_protocol
					+ "w.cnzz.com/q_stat.php%3Fid%3D1263790946' type='text/javascript'%3E%3C/script%3E"));
</script>
</html>