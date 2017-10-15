<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/include_base.jsp"%>
<title>书架</title>
<style>
.bookrack_item{
	position:relative;
	height:80px;
	padding:10px 0;
	border-bottom:solid 1px #f0f1f2;
}
.bookrack_cover{
	width:55px;
	position:absolute;
	display:block;
	height:70px;
	left:10px;
}
.bookrack_cover img{
	width:100%;
	height:100%;
	box-shadow:1px 1px 2px 0px rgba(0,0,0,0.4);
}
.bookrack_info{
	position:absolute;
	left:75px;
	height:110px;
	color:#969ba3;
	font-size:14px;
}
.bookrack_info p{
	height:25px;
	overflow:hidden;
}
.bookrack_name{
	font-size:16px;
	font-weight:bold;
	color:#333;
}
.bookrack_goon{
	position:absolute;
	top:10px;
	right:0;
	color:#969ba3;
	background:#ffffff;
	line-height:25px;
	display:block;
	padding:0 5px 0 10px;
	font-size:14px;
}
</style>
</head>

<body>

	<div class="nav-panel bookinfo-title">
		<a class="bookinfoback" href="javascript:history.go(-1)">«</a>&nbsp;&nbsp;我的书架
		<a href="<%=path%>/?ch=${fromurl}" class="icohome"></a>
	</div> 
	
	<div class="panel-bar">
		<ul class="btn_area fn-clear">
			<!-- 		<li><a class="btn  block " href="#">最近阅读</a></li>
		<li><a class="btn white block" href="#">收藏书架</a></li> -->
		</ul>
	</div>
	<div class="mod_bookrack">
	<c:forEach items="${bookracks}" var="racks">
		<div class="bookrack_item">
			 <a href="<%=path%>/mynovel/novel?id=${racks.getBookid()}" class="bookrack_cover">
			 	<img class="" alt="" src="${racks.getCoverimgs()}">
			 </a>
			 <div class="bookrack_info">
				 <p class="bookrack_name">${racks.getBookname()}</p>
				 <p>最新章节：${racks.lastchaptertitle}</p>
				 <p>上次阅读：${racks.chaptertitle}</p>
			 </div>
			 
			 
			 
			 <c:if test="${racks.chapterid==null||racks.chapterid<=0}">
				 <a href="<%=path %>/myzhangjiecontent/moren?bookId=${racks.getBookid()}&ch=${fromurl}" class="bookrack_goon">
				 	继续阅读 &gt;
				 </a>
			 </c:if>
			 <c:if test="${racks.chapterid>0}">
				<a href="<%=path %>/myzhangjiecontent/index?bookId=${racks.getBookid()}&chapterId=${racks.chapterid}&ch=${fromurl}" class="bookrack_goon">
					继续阅读 &gt;
				</a>
			</c:if>
		</div>
	</c:forEach>
	
		<!-- <ul class="current">
			<c:forEach items="${bookracks}" var="racks">
				<li id="${racks.getBookid() }"><a href="<%=path%>/wxbook/detail?id=${racks.getBookid()}&fm=${fromurl}"> 
				<img class="fn-left lazy" alt="" src="${racks.getCoverimgs()}">
				</a> <a class="jxread" href="<%=path%>/wxbook/detail?id=${racks.getBookid()}">
						<div>
							<p class="nowrap">${racks.getBookname()}</p>
							<p class="small nowrap">
								最后更新：<label>${racks.lastchaptertitle}</label>
							</p>
							<c:if test="${racks.chapterid==null||racks.chapterid<=0}">
								<a href="<%=path %>/wxChapterSub/defualt?bookId=${racks.getBookid()}&fm=${fromurl}">
									<p class="small nowrap">
										阅读进度：<label class="ccode">${racks.chaptertitle}<br>继续阅读
										</label>
									</p>
								</a>
							</c:if>
							<c:if test="${racks.chapterid>0}">
								<a href="<%=path %>/wxChapterSub/index?bookId=${racks.getBookid()}&chapterId=${racks.chapterid}&fm=${fromurl}">
									<p class="small nowrap">
										阅读进度：<label class="ccode">${racks.chaptertitle}<br>继续阅读
										</label>
									</p>
								</a>
							</c:if>
						</div>
				</a> <span class="del" data-bid="${racks.getBookid() }"><span class="verticalAlign"></span><label>删除</label></span></li>
			</c:forEach>
		</ul> -->
	</div>

	<%@ include file="/WEB-INF/views/include/include_footer.jsp"%>
</body>
</html>

