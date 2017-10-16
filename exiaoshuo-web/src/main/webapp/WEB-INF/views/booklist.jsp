<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/include_base.jsp"%>

<title>零点悦读-一家令你心脏扑通扑通直跳的小说网站</title>
<script>
	var isRequesting = false;
	$(document).ready(
			function(e) {

				//tab切换
				$("[data-role='tab']").click(function() {
					var id = parseInt($(this).attr("data-id"));
					$("[data-role='tab']").each(function(index, element) {
						$(this).toggleClass("selected", index == id);
					});
					$("[data-role='list']").each(function(index, element) {
						$(this).css("display", index == id ? "block" : "none");
					});
				});

				//剩余时间
				var remainingTime = parseInt($("[data-remaining]").attr(
						"data-remaining"))
						- Date.parse(new Date()) / 1000;
				resetRemainingDisplay(remainingTime);

				//信息流加载
				var dh = $(document).height() - $(window).height() - 200;
				$(document).bind(
						"scroll",
						function(event) {
							if (!isRequesting) {
								if ($(document).scrollTop() > dh) {
									//这里使用jsonp请求更多的内容
									setTimeout(function() {
										//appendNovel();
										dh = $(document).height()
												- $(window).height() - 200;
										isRequesting = false;
									}, 1000);
									isRequesting = true;
								}
								;
							}
						});

				var mySwiper = new Swiper('.swiper-container', {
					direction : 'horizontal',
					loop : true,
					autoplay : 3000,
					// 如果需要分页器
					pagination : '.swiper-pagination',
				})
			});

	function resetRemainingDisplay(remainingTime) {
		if (remainingTime > 0) {
			var d = Math.floor(remainingTime / 86400);
			var h = Math.floor(remainingTime / 3600 % 24);
			var m = Math.floor(remainingTime / 60 % 60);
			var s = Math.floor(remainingTime % 60);

			$("[data-remaining] span").eq(0).text(
					d < 10 ? "0" + d : d.toString());
			$("[data-remaining] span").eq(1).text(
					h < 10 ? "0" + h : h.toString());
			$("[data-remaining] span").eq(2).text(
					m < 10 ? "0" + m : m.toString());
			$("[data-remaining] span").eq(3).text(
					s < 10 ? "0" + s : s.toString());

			setTimeout(resetRemainingDisplay, 1000, remainingTime - 1);
		}
	}

	function appendNovel() {
		var html = $("#listbox").html();
		$("#listbox").append(html);
	}
</script>
</head>

<body>
	<!--继续阅读，显示一条，没有的话不显示div-->
	<div class="mod_lastread">
		<c:if test="${bookrack.bookid>0&&bookrack.chapterid>0}">
			<a
				href="<%=path %>/myzhangjiecontent/index?bookId=${bookrack.bookid}&chapterId=${bookrack.chapterid}&ch=${fromurl}"><span
				class="t">《${bookrack.bookname}》 ${bookrack.chaptertitle} </span><span
				class="i">继续阅读</span></a>
		</c:if>
		<c:if
			test="${bookrack.bookid>0&&(bookrack.chapterid==null||bookrack.chapterid<=0)}">
			<span class="i">继续阅读:</span>
			<a
				href="<%=path %>/myzhangjiecontent/moren?bookId=${bookrack.bookid}&ch=${fromurl}">
				<span class="t">《${bookrack.bookname}》</span><span class="i">继续阅读</span>
			</a>
		</c:if>
		<c:if test="${bookrack==null||bookrack.bookid<=0}">
		</c:if>

	</div>

	<div style="text-align: center; padding: 10px 0">
		<a id="logo" href="/" class="logo" title=""><img
			src="<%=path%>/static/image/logo2.png" width="170" /></a>
	</div>

	<%-- <div class="mod_tosearch">
		<a href="<%=path%>/mynovel/ssindex" class="mod_tosearchinput">作者名
			/ 书名 / 关键字</a>
	</div> --%>

	<div class="mod_fastico">
		<a href="<%=path%>/myshujia/index?ch=${fromurl}"><img
			src="<%=path%>/static/image/ico1.png" /></a> <a
			href="<%=path%>/myzhifu/pay?ch=${fromurl}"><img
			src="<%=path%>/static/image/ico2.png" /></a> <a
			href="<%=path%>/myuser/model/?ch=${fromurl}"><img
			src="<%=path%>/static/image/ico3.png" /></a>
	</div>
	<div class="mod_block"></div>

	<!-- 
<div class="mod_title c0">
	<h1 class="f17"> 本站必读 </h1>
</div>
<div class="mod_content3">
	<div class="mod_content3_item"> <a href="#"> <img src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg"/>
		<p>抗日之流氓队</p>
		<p class="author">飘逸老爷子</p></a> </div>
	<div class="mod_content3_item"> <a href="#"> <img src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg"/>
		<p>抗日之流氓部队</p>
		<p class="author">飘老爷子</p>
		</a> </div>
	<div class="mod_content3_item"> <a href="#"> <img src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg"/>
		<p>抗日之流氓部队</p>
		<p class="author">飘逸老爷子</p>
		</a> </div>
	<div class="mod_content3_item"> <a href="#"> <img src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg"/>
		<p>抗日之流氓部队</p>
		<p class="author">飘逸老爷子</p>
		</a> </div>
	<div class="mod_content3_item"> <a href="#"> <img src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg"/>
		<p>抗日之流氓部队</p>
		<p class="author">飘逸老爷子</p>
		</a> </div>
	<div class="mod_content3_item"> <a href="#"> <img src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg"/>
		<p>抗日之流氓部队</p>
		<p class="author">飘逸老爷子</p>
		</a> </div>
	<br style="clear:both; line-height:0"/>
</div>
<div class="mod_block"></div>
<div class="mod_title c0">
	<h1 class="f17">  强力推荐 </h1>
</div>
<div class="mod_content2">
	<c:forEach items="${wxBooks}" var="books">
		<div class="mod_content2_item"> <a href="<%=path%>/mynovel/novel?id=${books.id}&ch=${fromurl}"> <img src="${books.coverImgs}"/>
		<p>${books.name}</p>
		<p class="author">${books.getPublisherName()}</p>
		</a> </div>
	</c:forEach>
	<br style="clear:both; line-height:0"/>
</div>

<div class="mod_block"></div>
<div class="mod_title c0">
	<h1 class="f17"> 本站热门 </h1>
</div>
<div class="mod_content">
	<ul id="listbox" data-page="0">
	<c:forEach items="${wxBooks}" var="books">
		<li><a href="<%=path%>/mynovel/novel?id=${books.id}&ch=${fromurl}"> <img class="fn-left lazy" src="${books.coverImgs}"/>
			<div>
				<p class="bookname">${books.name}</p>
				<p class="intro">${books.getIntr()}</p>
			</div>
			</a></li>
	</c:forEach>
	</ul>
</div>

 -->

	<%@ include file="/WEB-INF/views/include/include_footer.jsp"%>
</body>
<script type="text/javascript" src="<%=path%>/static/js/public.js"></script>
<script type="text/javascript">
	function testaddcookie() {
		setCookie(
				"wx_gzh_token",
				"9519B0A907BB60F8ACADA7184CA0EEA5C984F95C9E7BE0956612C4F3B65B0F0239DB04E0BFC5BB36",
				"1")
	}
</script>
</html>

