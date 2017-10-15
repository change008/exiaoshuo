<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/include_base.jsp"%>
<title>充值记录</title>
<style>
	thead td{
		text-align:center;
		font-weight:bold;
		background:#333;
		color:#fff;
	}
	tbody td{
		text-align:center;
		line-height:35px;
	}
	tr:nth-child(even){
		background:#e8fff9
	}
</style>
</head>
<script type="text/javascript" src="<%=path %>/static/js/jquery/jquery-1.10.2.min.js"></script>
<body>
<div class="nav-panel bookinfo-title">
		<a class="bookinfoback" href="javascript:history.go(-1)">«</a>&nbsp;&nbsp;充值记录
		<a href="<%=path%>/?fm=${fromurl}" class="icohome"></a>
	</div> 
<div class="mod_tab_content shelf">
<table cellpadding="0" width="100%">
	<thead>
		<tr>
			<td>金额（元）</td>
			<td>小说币</td>
			<td>状态</td>
			<td>时间</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${wxpaylist}" var="wxpay">
			<tr>
				<td>${wxpay.amount}</td>
				<c:if test="${wxpay.paytype==1 }">
			 	 <td>${wxpay.count}</td>
			 	 </c:if>
			 	 <c:if test="${wxpay.paytype==2 }">
			 	  <td>${wxpay.count}${wxpay.unitName}</td>
			 	 </c:if>
				<td>${wxpay.orderstatusStr}</td>
				<td>${wxpay.createtime}</td>
			 	 
			</tr>
		</c:forEach>
	</tbody>
</table>
</div>
<ul id="pager" class="pager">
      <li class="four"><a class="btn white start"
			href="<%=path %>/wxPay/index?pageNo=0&pageSize=${pager.pageSize }&fm=${fromurl}">第一页</a></li>
		<li class="four"><c:if test="${pager.prePage>=0 }">
				<a class="btn white prev" href="<%=path %>/wxPay/index?pageNo=${pager.prePage }&pageSize=${pager.pageSize }&fm=${fromurl}">上一页</a>
			</c:if> <c:if test="${pager.prePage<0 }">
				<a class="btn white next" href="#" disabled="disabled">上一页</a>
			</c:if></li>
		<li class="four"><c:if test="${pager.nextPage>0 }">
				<a class="btn white prev"
					href="<%=path %>/wxPay/index?pageNo=${pager.nextPage }&pageSize=${pager.pageSize }&fm=${fromurl}">下一页</a>
			</c:if> <c:if test="${pager.nextPage<=0 }">
				<a class="btn white next" href="#" disabled="disabled">上一页</a>
			</c:if></li>
		<li class="four"><a class="btn white end"
			href="<%=path %>/wxPay/index?pageNo=${pager.lastPageNo }&pageSize=${pager.pageSize }&fm=${fromurl}">最末页</a></li>
</ul>
<%@ include file="/WEB-INF/views/include/include_footer.jsp"%>
</body>
</html>