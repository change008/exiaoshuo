<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String pathFooter = request.getContextPath();
	String basePathFooter = request.getScheme() + "://" + request.getServerName() + ":"
			+ request.getServerPort() + pathFooter + "/";
%>
<footer style="border-top:solid 1px #e3e2e2 ">
	<div style="margin:auto;width:35%;">
		<img width="100%" src="<%=request.getContextPath()%>/static/image/qrcode.jpg">
	</div>
	
	<p>长按关注公众号，方便下次继续阅读</p>
	<p style="line-height: 22px;">
		<span class="small">©2016 All Rights Reserved.</span> 
		<span class="small">微盟（呼伦贝尔）文化传媒有限公司</span> 
		<span class="small"> 蒙ICP备14034803号</span>
	</p>
	<script>
		var cnzz_protocol = (("https:" == document.location.protocol) ? " https://"
				: " http://");
		document
				.write(unescape("%3Cspan id='cnzz_stat_icon_1263790946'%3E%3C/span%3E%3Cscript src='"
						+ cnzz_protocol
						+ "w.cnzz.com/q_stat.php%3Fid%3D1263790946' type='text/javascript'%3E%3C/script%3E"));
	</script>
</footer>