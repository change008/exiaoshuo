<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/include_base.jsp"%>
<title>	${wxBook.getName()}</title>

<style>
.bg{
	position:absolute;
	left:0;
	right:0;
	top:-20px;
	overflow:hidden;
	text-align:center;
	height:288px;
}
.bg img{
	width:110%;
	filter:blur(18px);
	-webkit-filter:blur(18px);
	opacity:0.15;
}
.panel{
	top:0;
	left:0;
	position:relative;
	background:linear-gradient(to top,#fff,rgba(255,255,255,0) 8rem) no-repeat center bottom;
}
.bookinfo-title{
	height:26px;
	margin-bottom:20px;
	font-size:18px;
	color:#333333;
}
.bookinfoback{
	display:inline-block;
	width:26px;
	height:26px;
	text-align:center;
	font-size:24px;
	float:left;
	line-height:21px;
}

</style>
</head>
<body>

<input type="hidden" id="bookid" name="bookid" value="${wxBook.getId()}">
<input type="hidden" id="bookname" name="bookname" value="${wxBook.getName()}">
<div class="bg">
	<img src="${wxBook.getCoverImgs()}"/>
</div>
<div class="panel">
	<div class="bookinfo-title">
		<a class="bookinfoback" href="javascript:history.go(-1);">«</a>&nbsp;&nbsp;${wxBook.getName()}</a>
	</div>
	<div class="fn-clear">
        <img class="cover fn-left lazy" style="margin-top:0px;" src="${wxBook.getCoverImgs()}" dataimg="${wxBook.getCoverImgs()}" width="80px" height="112px">
		<ul class="book_info">
             <li><label>专题：</label><a href="#">言情小说</a></li>
			<li><label>类别：</label><a href="#">${wxBook.tag}</a></li>
			<li><label>状态：</label>${wxBook.status}</li>
			<c:if test="${!wxBook.getContentLen().equals(\"0\")}">
				<li><label>字数：</label>${wxBook.getContentLen()}</li>
			</c:if>
			<li><label></label><span class="orange"></span> <a class="scrollTo" href="#comments"></a></li>
		</ul>
	</div>
	<ul class="btn_area fn-clear">
		<li>
		<c:if test="${bookrack.chapterid>0}">
		<a class="btn block start_read" href="<%=path %>/wxChapterSub/index?bookId=${wxBook.getId()}&chapterId=${bookrack.chapterid}&fm=${fromurl}">继续阅读</a>
		</c:if>
		<c:if test="${bookrack==null||bookrack.chapterid<=0}">
		<a class="btn block start_read" href="<%=path %>/wxChapterSub/defualt?bookId=${wxBook.getId()}&fm=${fromurl}">免费阅读</a>
		</c:if>
		</li>
		<li>
		<c:if test="${bookrack.bookid>0}">
		<a href="javascript:void(0)" class="btn white block add-fav disabled" id="btn-addbookrack" data-bid="${wxBook.getId()}" data-name="${wxBook.getName()}">
		已添加</a>
		</c:if>
		<c:if test="${bookrack==null||bookrack.bookid<=0}">
		<a href="javascript:void(0)" class="btn white block add-fav" id="btn-addbookrack" data-bid="${wxBook.getId()}" data-name="${wxBook.getName()}">
		加入书架</a>
		</c:if>
		
		</li>
		<li><a href="<%=path %>/wxChapter/index?bookId=${wxBook.getId()}&fm=${fromurl}" class="btn block white">章节目录</a></li>
	</ul>
</div>

<div class="mod_title c0">
	<h1 class="f17"> <i class="home-icon-tit home-icon-tit-b"></i> 小说介绍 </h1>
</div>
<div class="book_intro">
	<p id="summary">
	 ${wxBook.getIntr()}
	</p>
</div>


<%@ include file="/WEB-INF/views/include/include_footer.jsp"%>
</body>
<script type="text/javascript" src="<%=path %>/static/js/public.js"></script>
<script type="text/javascript" src="<%=path %>/static/js/bookdetail.js"></script>
<script type="text/javascript">
$(function(){
	$("#btn-addbookrack").click(function(){
		var text=$("#btn-addbookrack").html();
		if(text=="已添加"){
			return;
		}
		var bookid=$("#bookid").val();
		var bookname=$("#bookname").val();
		var wx_gzh_token=getCookie("wx_gzh_token");
		if(wx_gzh_token==undefined||wx_gzh_token==""){
			addbookrack(bookid,0);
			$("#btn-addbookrack").css("disabled");
			$("#btn-addbookrack").html("已添加");
		}else{
			var postData={'bookId':bookid,'bookName':bookname}
			$.ajax({
				url:"<%=path%>/wxBookrack/addBookrack",
				data:postData,
				type:"post",
				dataType:"json",
				success:function(res){
					$("#btn-addbookrack").css("disabled");
					$("#btn-addbookrack").html("已添加");
					console.log(res.msg);
				},
				error:function(res){
					//alert("失败");
				}
			});
		}
		
	});
});
	
</script>
</html>
