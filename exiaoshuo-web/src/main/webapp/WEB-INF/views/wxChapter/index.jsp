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
	
	
	</style>
<script type="text/javascript">
	var isRequesting = false;
	var hasDone = false;
	
	$(document).ready(function(){
		$(document).bind("scroll", function (event) {
	        if (!hasDone &&!isRequesting) {
	        	
	        	var dh = $(document).height()- $(window).height()-200;
	            if ($(document).scrollTop() > dh ) {
					
					//这里使用jsonp请求更多的内容
					/*$.ajax("url?jsonpCallback=jsonpCallback",{
						type:"POST",
						data:{index:10,count:10},
						dataType:"jsonp",
						complete:function(){									
							isRequesting = false;
						}					
					});*/
					
					//临时测试
					setTimeout(jsonpCallback,2000,[{"title":"章节名","bookid":12,"chapterid":12345,"isfree":true},{"title":"章节名","bookid":12,"chapterid":12345,"isfree":true},{"title":"章节名","bookid":12,"chapterid":12345,"isfree":true},{"title":"章节名","bookid":12,"chapterid":12345,"isfree":true},{"title":"章节名","bookid":12,"chapterid":12345,"isfree":true},{"title":"章节名","bookid":12,"chapterid":12345,"isfree":true},{"title":"章节名","bookid":12,"chapterid":12345,"isfree":true},{"title":"章节名","bookid":12,"chapterid":12345,"isfree":true}]);
					isRequesting = true;
	            };
	        }
	    });	
	});
	
	function jsonpCallback(list)
	{	
		isRequesting = false;
		if(!list || list.length==0)
		{
			hasDone = true;
			return;
		}
		var buildHtml=function(vo){
			var htmlNode = $("<li>");
			
			$("<a>").attr("href","/exiaoshuo-web/wxChapterSub/index?bookId="+vo.bookid+"&chapterId="+vo.chapterid)
			.addClass("chapter")
			.text(vo.title)
			.appendTo(htmlNode);
			
			if(vo.isfree){
				$("<span>").addClass("fn-right c999").text("免费").appendTo(htmlNode);
			}
			
			return htmlNode;
		};
		
		for(var i=0;i<list.length;i++)
		{
			var html = buildHtml(list[i]);
			$("#container_menu").append(html);
		}	
	}
</script>
<title>${wxBook.name}</title>
</head>
<body>
<input type="hidden" name="bookId" id="bookId" value="${bookId}">
<input type="hidden" name="fromurl" id="fromurl" value="${fromurl}">
	<div class="nav-panel bookinfo-title">
		<a class="bookinfoback" href="<%=path%>/wxbook/detail?id=${wxBook.id}">«</a>&nbsp;&nbsp;我的书架
		<a href="<%=path%>/?fm=${fromurl}" class="icohome"></a>
	</div>

	<ul class="menu" id="container_menu">
		<c:if test="${wxChapters==null||fn:length(wxChapters)<=0}">
			<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
		</c:if>
		<c:forEach items="${wxChapters}" var="chapters">
			<li><c:if test="${chapters.getChaptertype()==0}">
			    <a class="chapter" onclick="addbookrack('${wxBook.id}','${chapters.id}')"
				href="<%=path%>/wxChapterSub/index?bookId=${wxBook.id}&chapterId=${chapters.id}&fm=${fromurl}">
					${chapters.title} </a>
					<span class="fn-right c999">免费</span>
				</c:if>
				<c:if test="${chapters.getChaptertype()!=0}">
			    <a class="chapter" onclick="addbookrack('${wxBook.id}','${chapters.id}')"
				href="<%=path%>/wxChapterSub/vip?bookId=${wxBook.id}&chapterId=${chapters.id}&fm=${fromurl}">
					${chapters.title} </a>
				</c:if>
		    </li>
		</c:forEach>
	</ul>
	
	<%@ include file="/WEB-INF/views/include/include_footer.jsp"%>
</body>
<script type="text/javascript" src="<%=path %>/static/js/public.js"></script>
<script type="text/javascript">
	function jumpPage() {
		var jumpPage = $("#jump_page").val();
		var totalPage = $("#totalPage").val();
		var pageSize = $("#pageSize").val();
		var fromurl = $("#fromurl").val();
		var bookId = $("#bookId").val();
		if (isNaN(jumpPage) || jumpPage <= 0) {
			alert("请输入大于0的数字");
			return;
		}
		if (jumpPage > totalPage) {
			alert("超出最大页数");
		} else {
			var pageNo = (jumpPage - 1) * pageSize;
			window.location.href="<%=path%>/wxChapter/index?bookId="
					+bookId +"&pageNo="+ pageNo+"&jumpPage="+jumpPage+"&fm="+fromurl;
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





