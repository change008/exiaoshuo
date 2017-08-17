<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String pathFooter = request.getContextPath();
	String basePathFooter = request.getScheme() + "://" + request.getServerName() + ":"
			+ request.getServerPort() + pathFooter + "/";
%>
<footer>

	
	<div style="background-color: #CDAA7D; padding: 8px 10px;">
		<a style="color: white" href="http://mp.weixin.qq.com/s?__biz=MzU0MzEyOTQ1Mw==&mid=100000003&idx=1&sn=e7d5046ab13faa4d4c9144681e569319&chksm=7b116b014c66e217a5abee1d18bad4cfe12b872abd252781d79c8e27c9dcbafcdd630629d7be#rd"> 点击关注公众号“<span style="color: white; border-bottom: 1px solid">蛋黄小说</span>”方便下次继续阅读
		</a>
	</div>

	<p style="line-height: 20px">
		<a href="<%=pathFooter%>/?fm=${fromurl}">首页</a><span class="sp"></span> <a href="<%=pathFooter%>/wxBookrack/list/?fm=${fromurl}" title="书架">书架</a> <span class="sp"></span><a href="#">客服</a> <span
			class="sp"></span><a href="#">帮助</a>
	</p>
	<p style="line-height: 22px;">
		<span class="small">©2016 蛋黄小说</span> <span class="small"> 京ICP备14034803号-5</span>
	</p>
	<script>
		var cnzz_protocol = (("https:" == document.location.protocol) ? " https://"
				: " http://");
		document
				.write(unescape("%3Cspan id='cnzz_stat_icon_1262618547'%3E%3C/span%3E%3Cscript src='"
						+ cnzz_protocol
						+ "w.cnzz.com/q_stat.php%3Fid%3D1262618547' type='text/javascript'%3E%3C/script%3E"));
	</script>
</footer>