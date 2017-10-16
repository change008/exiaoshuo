<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/include_base.jsp"%>
<!-- 因为图片路径路径不能写单独的css-->
<%-- <link href="<%=path%>/static/css/wxChapter/fenye.css" type="text/css" rel="stylesheet" /> --%>
<style type="text/css">
	.fenye {
    margin: 10px 10px;
}
.fenye .fy {
    float: left;
    width: 96%;
    margin-left: 1%;
    margin-right: 2%;
    margin-left: 0px;
}
.fenye .showpage {
    position: fixed;
    display: none;
    width: 80%;
    height: 60%;
    top: 15%;
    left: 10%;
    background-color: #fff;
    z-index: 9999;
}
.r3 {
    border-radius: 3px;
}
#spagebg {
    display: none;
    position: fixed;
    left: 0px;
    right: 0px;
    top: 0px;
    bottom:0px;
    background-color: #000;
    z-index: 999;
}
.spage {
    width: 100%;
    height: 30px;
    line-height: 30px;
    border-style: solid;
    border-width: 1px;
    padding: 0px 5px;
    text-align: center;
    border-color: #1ABC9C;
    background: #fff no-repeat center right url(<%=path%>/static/list2.png);
    border-radius: 3px;
}
.fenye .showpage div {
    border-bottom-style: solid;
    border-bottom-width: 1px;
    height: 40px;
    line-height: 40px;
    text-align: center;
}
.bk {
    border-color: #CCC;
}
.fenye .showpage ul {
    position: absolute;
    top: 40px;
    bottom: 0px;
    left: 10px;
    right: 10px;
    overflow: auto;
}
.fenye .showpage a {
    display: block;
    border-bottom-style: solid;
    border-bottom-width: 1px;
    height: 40px;
    line-height: 40px;
    margin: 0px 10px;
    font-size: 12px;
}
.xbk {
    border-color: #E2E2E2;
}
.fenye .showpage .this {
    background: right center no-repeat url(<%=path%>/static/image/yes.gif);
}
.tb {
    color: #1ABC9C;
}

.fenye .desc {
    float: right;
    width: 18%;
    margin-right: 0%;
}
.fenye .desc a {
    display: block;
    color: #fff;
    text-align: center;
    height: 30px;
    line-height: 30px;
}
.dise {
    background-color: #1ABC9C;
}
	.mod_pager{
		text-align:center;
		margin-top:15px;
	}
	
	.mod_pager a{
		background:#c7a116;
		display:inline-block;
		color:#ffffff;
		line-height:35px;
		padding:0 15px;
	}
	
	</style>

<title>${wxBook.name}</title>
</head>
<body>
<input type="hidden" name="bookId" id="bookId" value="${bookId}">
<input type="hidden" name="fromurl" id="fromurl" value="${fromurl}">
	<div class="nav-panel bookinfo-title">
		<a class="bookinfoback" href="<%=path%>/mynovel/novel?id=${wxBook.id}">«</a>&nbsp;&nbsp;我的书架
		<a href="<%=path%>/?ch=${fromurl}" class="icohome"></a>
	</div>

	<ul class="menu" id="container_menu">
		<c:if test="${wxChapters==null||fn:length(wxChapters)<=0}">
			<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
		</c:if>
		<c:forEach items="${wxChapters}" var="chapters">
			<li><c:if test="${chapters.getChaptertype()==0}">
			    <a class="chapter" onclick="addbookrack('${wxBook.id}','${chapters.id}')"
				href="<%=path%>/myzhangjiecontent/index?bookId=${wxBook.id}&chapterId=${chapters.id}&ch=${fromurl}">
					${chapters.title} </a>
					<span class="fn-right c999"></span>
				</c:if>
				<c:if test="${chapters.getChaptertype()!=0}">
			    <a class="chapter" onclick="addbookrack('${wxBook.id}','${chapters.id}')"
				href="<%=path%>/myzhangjiecontent/shoufei?bookId=${wxBook.id}&chapterId=${chapters.id}&ch=${fromurl}">
					${chapters.title} </a>
					<span class="fn-right" style="color:#c7a116">vip</span>
				</c:if>
		    </li>
		</c:forEach>
	</ul>
	
	<div class="mod_pager">
		<a href="<%=path %>/myzhangjie/list?bookId=${bookId}&pageNo=${pager.prePage }&ch=${fromurl}">上一页</a>&nbsp;&nbsp;
		<a href="<%=path %>/myzhangjie/list?bookId=${bookId}&pageNo=${pager.nextPage }&ch=${fromurl}">下一页</a>&nbsp;&nbsp;
		<a href="javascript:jumpPage()">跳转指定页</a>
	</div>
	
	<%@ include file="/WEB-INF/views/include/include_footer.jsp"%>
</body>
<script type="text/javascript" src="<%=path %>/static/js/public.js"></script>
<script type="text/javascript">
	function jumpPage() {
		var jumpPage = prompt("输入要跳转的页数，最多${totalRecord}页");
		if(/\d+/.test(jumpPage))
		{
			var totalPage = ${totalRecord};
			var pageSize = ${pager.pageSize};
			var fromurl = "${fromurl}";
			var bookId = ${bookId};
			
			if (jumpPage > totalPage) {
				alert("超出最大页数");
			} else {
				var pageNo = (jumpPage - 1) * pageSize;
				location.href="<%=path%>/myzhangjie/list?bookId="
						+bookId +"&pageNo="+ pageNo+"&pageto="+jumpPage+"&ch="+encodeURIComponent(fromurl);
			}
		}
	}
	$("#zjlb .spage").click(
			function() {
				$("#zjlb .showpage").show(300);
				$("#spagebg").css("opacity", "0.7").fadeIn(500);
			});
	$("#spagebg").click(function() {
		$(this).fadeOut(700);
		$("#zjlb .showpage").hide(300);
	});
</script>
</html>





