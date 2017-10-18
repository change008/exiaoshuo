<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/include_base.jsp"%>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

body {
	background: #f6f7f9;
}

h1 {
	text-align: center;
	color: #ff6600;
	padding: 10px 0;
	font-size: 22px;
}

article {
	line-height: 32px;
	font-size: 18px;
	padding: 0 15px;
}

div.guide {
	background: #ffffff;
	border-top: solid 1px #888;
	text-align: center;
	font-size: 18px;
	color: #ff6600;
}

div.guide p {
	padding: 10px 20px;
}

div.hint_con {
	position: relative;
	height: 40px;
	text-align: center;
}

.hint_sj {
	position: absolute;
	display: block;
	width: 100%;
	animation: myfirst 0.3s linear 1s infinite alternate;
	/* Firefox: */
	-moz-animation: myfirst 0.3s linear 1s infinite alternate;
	/* Safari 和 Chrome: */
	-webkit-animation: myfirst 0.3s linear 1s infinite alternate;
	/* Opera: */
	-o-animation: myfirst 0.3s linear 1s infinite alternate;
}

@
keyframes myfirst {
	from {margin-top: 0
}

to {
	margin-top: 5px;
}
}
</style>
<title>${wxChapterSub.bookName}</title>
</head>
<body>
	<article class="theme1">
		<nav>
			<span>${wxChapterSub.title}</span>
		</nav>
		<div class="content" style="font-size: 18px;">${wxChapterIntro}</div>

		<div class="guide">
			<p>未完待续...，请关注公众号继续阅读！</p>
			<p>后续内容更加劲爆哦,长按识别下方二维码关注即可阅读</p>
			<div class="hint_con">
				<span class="hint_sj">▼</span>
			</div>
			<img src="<%=path%>/static/image/qrcode/chaosexiaoshuo.jpg" width="75%" />
			<p>长按识别二维码，关注公众号后继续阅读</p>
		</div>
	</article>
</body>

<script type="text/javascript" src="<%=path%>/static/js/public.js"></script>
<script>
	var cnzz_protocol = (("https:" == document.location.protocol) ? " https://"
			: " http://");
	document
			.write(unescape("%3Cspan id='cnzz_stat_icon_1265249837'%3E%3C/span%3E%3Cscript src='"
					+ cnzz_protocol
					+ "w.cnzz.com/q_stat.php%3Fid%3D1265249837' type='text/javascript'%3E%3C/script%3E"));
</script>
</html>