<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String pathFooter = request.getContextPath();
	String basePathFooter = request.getScheme() + "://" + request.getServerName() + ":"
			+ request.getServerPort() + pathFooter + "/";
%>
<footer>

	
	<div style="background-color: #CDAA7D; padding: 8px 10px;">
		<a style="color: white" href="http://mp.weixin.qq.com/s?__biz=MzU0MDE2NzA4Mw==&mid=100000007&idx=1&sn=09df81a816edb1ec32a0d3bc5fa3b5e5&chksm=7b3c1fc34c4b96d552ccabba5022a03b544ecbadea60b019e5d6de3b444113ce8516d4fa7038#rd"> 点击关注公众号“<span style="color: white; border-bottom: 1px solid">爱漾小说</span>”方便下次继续阅读
		</a>
	</div>

	<p style="line-height: 20px">
		<a href="<%=pathFooter%>/?fm=${fromurl}">首页</a><span class="sp"></span> <a href="<%=pathFooter%>/wxBookrack/list/?fm=${fromurl}" title="书架">书架</a> <span class="sp"></span><a href="#">客服</a> <span
			class="sp"></span><a href="#">帮助</a>
	</p>
	<p style="line-height: 22px;">
		<span class="small">©2016 爱漾小说</span> <span class="small"> 京ICP备14034803号-5</span>
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