<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/include_base.jsp"%>

<title>零点悦读-一家令你心脏扑通扑通直跳的小说网站</title>
<script>
var isRequesting=false;
$(document).ready(function(e) {
	
	//tab切换
	$("[data-role='tab']").click(function(){
		var id = parseInt($(this).attr("data-id"));
		$("[data-role='tab']").each(function(index, element) {
			$(this).toggleClass("selected",index==id);
		});
		$("[data-role='list']").each(function(index, element) {
			$(this).css("display",index==id?"block":"none");
		});
	});
	
	//剩余时间
	var remainingTime = parseInt($("[data-remaining]").attr("data-remaining")) - Date.parse(new Date())/1000;
	resetRemainingDisplay(remainingTime);
	
	//信息流加载
	var dh = $(document).height()- $(window).height()-200;
    $(document).bind("scroll", function (event) {
        if (!isRequesting) {
            if ($(document).scrollTop() > dh ) {
				//这里使用jsonp请求更多的内容
				setTimeout(function(){
					//appendNovel();
					dh = $(document).height()- $(window).height()-200;
					isRequesting = false;
				},1000);
				isRequesting = true;
            };
        }
    });	
	
	
	 var mySwiper = new Swiper ('.swiper-container', {
		direction: 'horizontal',
		loop: true,
		autoplay:3000,
		// 如果需要分页器
		pagination: '.swiper-pagination',
	  })        
});

function resetRemainingDisplay(remainingTime){
	if(remainingTime>0)
	{
		var d = Math.floor(remainingTime / 86400);
		var h = Math.floor(remainingTime / 3600 % 24);
		var m = Math.floor(remainingTime / 60 % 60);
		var s = Math.floor(remainingTime % 60);			
		
		$("[data-remaining] span").eq(0).text(d<10?"0"+d:d.toString());
		$("[data-remaining] span").eq(1).text(h<10?"0"+h:h.toString());
		$("[data-remaining] span").eq(2).text(m<10?"0"+m:m.toString());
		$("[data-remaining] span").eq(3).text(s<10?"0"+s:s.toString());
		
		
		setTimeout(resetRemainingDisplay,1000,remainingTime-1);
	}
}

function appendNovel()
{
	var html = $("#listbox").html();
	$("#listbox").append(html);
}
</script>
</head>

<body>
	<!--继续阅读，显示一条，没有的话不显示div-->
<div class="mod_lastread"> 
<a href="#"> <span class="t">《雷霆反击（解锁版）》 761 王镇北的精确打击</span><span class="i">继续阅读</span></a>
</div>

<header class="header_v2"> <a id="logo" href="/" class="logo" title=""></a>
	<ul>
		<li><a href="<%=path%>/wxPay/pay?fm=${fromurl}"><span class="ico32 pay"></span>充值</a></li>
		<li><a href="<%=path%>/wxBookrack/list?fm=${fromurl}"><span class="ico32 bookcase"></span>书架</a></li>
		<li><a href="<%=path%>/wxUser/content/?fm=${fromurl}"><span class="ico32 user"></span>个人中心</a></li>
	</ul>
</header>	


<div class="swiper-container">
    <div class="swiper-wrapper">
        <div class="swiper-slide">
			<a href="#">
				<img src="http://book.baiwancangshu.com/Uploads/adver/20170722/1408156j3pzqil.jpg">
			</a>
		</div>
        <div class="swiper-slide">
			<a href="#">
				<img src="http://book.baiwancangshu.com/Uploads/adver/20170722/1408156j3pzqil.jpg">
			</a>
		</div>
		<div class="swiper-slide">
			<a href="#">
				<img src="http://book.baiwancangshu.com/Uploads/adver/20170722/1408156j3pzqil.jpg">
			</a>
		</div>
    </div>
    <!-- 如果需要分页器 -->
    <div class="swiper-pagination"></div>
</div>


<div class="mod_tosearch"> <a href="<%=path%>/wxbook/searchlist" class="mod_tosearchinput">作者名 / 书名 / 关键字</a> </div>
<div class="mod_block"></div>
<div class="mod_title c0">
	<h1 class="f17"> <i class="home-icon-tit home-icon-tit-b"></i> 强力推荐 </h1>
</div>
<div class="mod_content2">
	<c:forEach items="${wxBooks}" var="books">
		<div class="mod_content2_item"> <a href="<%=path%>/wxbook/detail?id=${books.id}&fm=${fromurl}"> <img src="${books.coverImgs}"/>
		<p>${books.name}</p>
		<p class="author">${books.getPublisherName()}</p>
		</a> </div>
	</c:forEach>
	<br style="clear:both; line-height:0"/>
</div>
<div class="mod_block"></div>
<div class="mod_title c0">
	<h1 class="f17"> <i class="home-icon-tit home-icon-tit-b"></i> 限时畅读 </h1>
	<div class="mod_timerbox" data-remaining="1514262468"><span>00</span> : <span>00</span> : <span>00</span> : <span>00</span></div>
</div>
<div class="mod_content3">
	<div class="mod_content3_item"> <a href="#"> <img src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg"/>
		<p>抗日之流氓队</p>
		<p class="author">飘逸老爷子</p>
		<img src="<%=path%>/static/image/free.png" class="free"/> </a> </div>
	<div class="mod_content3_item"> <a href="#"> <img src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg"/>
		<p>抗日之流氓部队</p>
		<p class="author">飘逸老爷子</p>
		<img src="<%=path%>/static/image/free.png" class="free"/>
		</a> </div>
	<div class="mod_content3_item"> <a href="#"> <img src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg"/>
		<p>抗日之流氓部队</p>
		<p class="author">飘逸老爷子</p>
		<img src="<%=path%>/static/image/free.png" class="free"/>
		</a> </div>
	<div class="mod_content3_item"> <a href="#"> <img src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg"/>
		<p>抗日之流氓部队</p>
		<p class="author">飘逸老爷子</p>
		<img src="<%=path%>/static/image/free.png" class="free"/>
		</a> </div>
	<div class="mod_content3_item"> <a href="#"> <img src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg"/>
		<p>抗日之流氓部队</p>
		<p class="author">飘逸老爷子</p>
		<img src="<%=path%>/static/image/free.png" class="free"/>
		</a> </div>
	<div class="mod_content3_item"> <a href="#"> <img src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg"/>
		<p>抗日之流氓部队</p>
		<p class="author">飘逸老爷子</p>
		<img src="<%=path%>/static/image/free.png" class="free"/>
		</a> </div>
	<br style="clear:both; line-height:0"/>
</div>
<div class="mod_block"></div>
<div class="mod_title c0">
	<h1 class="f17"> <i class="home-icon-tit home-icon-tit-b"></i> 畅销排行 </h1>
	<div class="mod_taggroup"> <span class="selected" data-role="tab" data-id="0">昨</span> <span data-role="tab" data-id="1">周</span> <span data-role="tab" data-id="2">月</span> </div>
</div>
<!--昨日消费排行-->
<div class="mod_content" data-role="list" data-id="0">
	<ul>
		<li><a href="/wxbook/detail?id=22610&amp;fm="> <img class="fn-left lazy" src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg">
			<div class="mod_content_withinfo">
				<p class="bookname">抗日之流氓部队1</p>
				<p class="bookinfo"><span>飘逸老爷子</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>125万字</span></p>
				<p class="intro">薛岳无奈的说道：“那就是一个流氓加无赖。不过是一个抗日流氓。”
					日本都惊恐的喊道：“撤退，撤退，这是惹不起的疯子部队。”
					汉奸跪地求饶：“翟将军，翟大爷，我这辈子再也不当汉奸了。”
					蒋委员长愤恨的说：“我有什么办法？哪里挡不住让翟勤去。”
					何部长不耐烦的说道：“赶紧答应他的条件，让他走。”
					那些身世显赫的小姐们说道：“翟勤哥，你看我，不要看她们，需要什么我给你弄来。”
					翟勤，一个意外穿越到抗日战场的普通青年，这就是他给所有人留下的印象。
					这里没有现代武器，没有无限的YY，只有中国抗日战场的血与火、生与死和战斗豪情。</p>
			</div>
			</a></li>
		<li><a href="/wxbook/detail?id=22610&amp;fm="> <img class="fn-left lazy" src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg">
			<div>
				<p class="bookname">叛徒</p>
				<p class="intro">在举世瞩目的北非政变中，
					一个倒霉的小雇佣兵和那支小小的雇佣军一起被出卖，
					呼啸穿刺的弹雨，漫漫黄沙，烧焦的肢干，都让齐天林发誓要抓住那个叛徒！
					茫茫人海世界那么大，那里去找那杳无音信的一点线索？
					生活中也不只有仇恨，还有爱情，阴谋，奇遇，忠诚和热血！
					这一切，都交织在齐天林的传奇探索经历当中！
					推荐朋友一好书《裂日天狼》《南海争霸》</p>
			</div>
			</a></li>
		<li><a href="/wxbook/detail?id=22610&amp;fm="> <img class="fn-left lazy" src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg">
			<div>
				<p class="bookname">龙者无敌</p>
				<p class="intro">国难当头，我们无处可退！因为，中国虽大，但我们的每一寸国土都是神圣不可侵犯的！愿以我们的血肉之躯，化为万里长城的一块砖。故事梗概：一个普通青年回到1937年，靠着一腔赤诚的爱国热血，与身边的袍泽兄弟们脚踏实地、艰苦奋斗，一步一步、勇往直前，矢志不渝地为了中华的复兴而战斗到底。没有YY，没有夸张，只有血和泪的奋斗过程，只有烈火般的故事。（群128603526）</p>
			</div>
			</a></li>
		<li><a href="/wxbook/detail?id=22610&amp;fm="> <img class="fn-left lazy" src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg">
			<div>
				<p class="bookname">异界征服手册</p>
				<p class="intro">古老的帝国，打开了传说中诸神连接异世界的通道，帝国的精英们正在整装待发，准备征服一个新的世界。剑锋指向世界那一边的北京城，然后，一切就颠倒了过来。
					现代化工业强国对魔法世界的碾压，一切都是那么合情合理。
					新的大航海时代即将来临，一片地球一样广袤的世界正在等待着错过了航海时代的中国人前去征服。</p>
			</div>
			</a></li>
		<li><a href="/wxbook/detail?id=22610&amp;fm="> <img class="fn-left lazy" src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg">
			<div>
				<p class="bookname">诛日之战汉武天下</p>
				<p class="intro">他们是特战精英，身经百战；他们越狱潜逃，是被追捕的疑犯。
					一次特殊的追捕任务，让“暗箭”特种大队的文建阳、方天浩、高传辉和疑犯萧飞羽、宋明书共同穿越到战火纷飞的抗日战场。他们都是中国人，他们选择了共同面对抗击日军，国破无完人，不做倭寇鬼；无数次的铁血作战，血与火历练中，他们成长为逐鹿天下的虎狼之师。
					诛日之战,汉武天下；开疆扩土，耀我华威。.</p>
			</div>
			</a></li>
	</ul>
</div>
<!--七日消费排行-->
<div class="mod_content" data-role="list" data-id="1" style="display:none">
	<ul>
		<li><a href="/wxbook/detail?id=22610&amp;fm="> <img class="fn-left lazy" src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg">
			<div>
				<p class="bookname">抗日之流氓部队2</p>
				<p class="intro">薛岳无奈的说道：“那就是一个流氓加无赖。不过是一个抗日流氓。”
					日本都惊恐的喊道：“撤退，撤退，这是惹不起的疯子部队。”
					汉奸跪地求饶：“翟将军，翟大爷，我这辈子再也不当汉奸了。”
					蒋委员长愤恨的说：“我有什么办法？哪里挡不住让翟勤去。”
					何部长不耐烦的说道：“赶紧答应他的条件，让他走。”
					那些身世显赫的小姐们说道：“翟勤哥，你看我，不要看她们，需要什么我给你弄来。”
					翟勤，一个意外穿越到抗日战场的普通青年，这就是他给所有人留下的印象。
					这里没有现代武器，没有无限的YY，只有中国抗日战场的血与火、生与死和战斗豪情。</p>
			</div>
			</a></li>
		<li><a href="/wxbook/detail?id=22610&amp;fm="> <img class="fn-left lazy" src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg">
			<div>
				<p class="bookname">叛徒</p>
				<p class="intro">在举世瞩目的北非政变中，
					一个倒霉的小雇佣兵和那支小小的雇佣军一起被出卖，
					呼啸穿刺的弹雨，漫漫黄沙，烧焦的肢干，都让齐天林发誓要抓住那个叛徒！
					茫茫人海世界那么大，那里去找那杳无音信的一点线索？
					生活中也不只有仇恨，还有爱情，阴谋，奇遇，忠诚和热血！
					这一切，都交织在齐天林的传奇探索经历当中！
					推荐朋友一好书《裂日天狼》《南海争霸》</p>
			</div>
			</a></li>
		<li><a href="/wxbook/detail?id=22610&amp;fm="> <img class="fn-left lazy" src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg">
			<div>
				<p class="bookname">龙者无敌</p>
				<p class="intro">国难当头，我们无处可退！因为，中国虽大，但我们的每一寸国土都是神圣不可侵犯的！愿以我们的血肉之躯，化为万里长城的一块砖。故事梗概：一个普通青年回到1937年，靠着一腔赤诚的爱国热血，与身边的袍泽兄弟们脚踏实地、艰苦奋斗，一步一步、勇往直前，矢志不渝地为了中华的复兴而战斗到底。没有YY，没有夸张，只有血和泪的奋斗过程，只有烈火般的故事。（群128603526）</p>
			</div>
			</a></li>
		<li><a href="/wxbook/detail?id=22610&amp;fm="> <img class="fn-left lazy" src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg">
			<div>
				<p class="bookname">异界征服手册</p>
				<p class="intro">古老的帝国，打开了传说中诸神连接异世界的通道，帝国的精英们正在整装待发，准备征服一个新的世界。剑锋指向世界那一边的北京城，然后，一切就颠倒了过来。
					现代化工业强国对魔法世界的碾压，一切都是那么合情合理。
					新的大航海时代即将来临，一片地球一样广袤的世界正在等待着错过了航海时代的中国人前去征服。</p>
			</div>
			</a></li>
		<li><a href="/wxbook/detail?id=22610&amp;fm="> <img class="fn-left lazy" src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg">
			<div>
				<p class="bookname">诛日之战汉武天下</p>
				<p class="intro">他们是特战精英，身经百战；他们越狱潜逃，是被追捕的疑犯。
					一次特殊的追捕任务，让“暗箭”特种大队的文建阳、方天浩、高传辉和疑犯萧飞羽、宋明书共同穿越到战火纷飞的抗日战场。他们都是中国人，他们选择了共同面对抗击日军，国破无完人，不做倭寇鬼；无数次的铁血作战，血与火历练中，他们成长为逐鹿天下的虎狼之师。
					诛日之战,汉武天下；开疆扩土，耀我华威。.</p>
			</div>
			</a></li>
	</ul>
</div>
<!--三十日消费排行-->
<div class="mod_content" data-role="list" data-id="2" style="display:none">
	<ul>
		<li><a href="/wxbook/detail?id=22610&amp;fm="> <img class="fn-left lazy" src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg">
			<div>
				<p class="bookname">抗日之流氓部队3</p>
				<p class="intro">薛岳无奈的说道：“那就是一个流氓加无赖。不过是一个抗日流氓。”
					日本都惊恐的喊道：“撤退，撤退，这是惹不起的疯子部队。”
					汉奸跪地求饶：“翟将军，翟大爷，我这辈子再也不当汉奸了。”
					蒋委员长愤恨的说：“我有什么办法？哪里挡不住让翟勤去。”
					何部长不耐烦的说道：“赶紧答应他的条件，让他走。”
					那些身世显赫的小姐们说道：“翟勤哥，你看我，不要看她们，需要什么我给你弄来。”
					翟勤，一个意外穿越到抗日战场的普通青年，这就是他给所有人留下的印象。
					这里没有现代武器，没有无限的YY，只有中国抗日战场的血与火、生与死和战斗豪情。</p>
			</div>
			</a></li>
		<li><a href="/wxbook/detail?id=22610&amp;fm="> <img class="fn-left lazy" src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg">
			<div>
				<p class="bookname">叛徒</p>
				<p class="intro">在举世瞩目的北非政变中，
					一个倒霉的小雇佣兵和那支小小的雇佣军一起被出卖，
					呼啸穿刺的弹雨，漫漫黄沙，烧焦的肢干，都让齐天林发誓要抓住那个叛徒！
					茫茫人海世界那么大，那里去找那杳无音信的一点线索？
					生活中也不只有仇恨，还有爱情，阴谋，奇遇，忠诚和热血！
					这一切，都交织在齐天林的传奇探索经历当中！
					推荐朋友一好书《裂日天狼》《南海争霸》</p>
			</div>
			</a></li>
		<li><a href="/wxbook/detail?id=22610&amp;fm="> <img class="fn-left lazy" src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg">
			<div>
				<p class="bookname">龙者无敌</p>
				<p class="intro">国难当头，我们无处可退！因为，中国虽大，但我们的每一寸国土都是神圣不可侵犯的！愿以我们的血肉之躯，化为万里长城的一块砖。故事梗概：一个普通青年回到1937年，靠着一腔赤诚的爱国热血，与身边的袍泽兄弟们脚踏实地、艰苦奋斗，一步一步、勇往直前，矢志不渝地为了中华的复兴而战斗到底。没有YY，没有夸张，只有血和泪的奋斗过程，只有烈火般的故事。（群128603526）</p>
			</div>
			</a></li>
		<li><a href="/wxbook/detail?id=22610&amp;fm="> <img class="fn-left lazy" src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg">
			<div>
				<p class="bookname">异界征服手册</p>
				<p class="intro">古老的帝国，打开了传说中诸神连接异世界的通道，帝国的精英们正在整装待发，准备征服一个新的世界。剑锋指向世界那一边的北京城，然后，一切就颠倒了过来。
					现代化工业强国对魔法世界的碾压，一切都是那么合情合理。
					新的大航海时代即将来临，一片地球一样广袤的世界正在等待着错过了航海时代的中国人前去征服。</p>
			</div>
			</a></li>
		<li><a href="/wxbook/detail?id=22610&amp;fm="> <img class="fn-left lazy" src="http://s.junshishu.cn/bookcoverpic/22610_1370587305.jpg">
			<div>
				<p class="bookname">诛日之战汉武天下</p>
				<p class="intro">他们是特战精英，身经百战；他们越狱潜逃，是被追捕的疑犯。
					一次特殊的追捕任务，让“暗箭”特种大队的文建阳、方天浩、高传辉和疑犯萧飞羽、宋明书共同穿越到战火纷飞的抗日战场。他们都是中国人，他们选择了共同面对抗击日军，国破无完人，不做倭寇鬼；无数次的铁血作战，血与火历练中，他们成长为逐鹿天下的虎狼之师。
					诛日之战,汉武天下；开疆扩土，耀我华威。.</p>
			</div>
			</a></li>
	</ul>
</div>
<div class="mod_block"></div>
<div class="mod_title c0">
	<h1 class="f17"> <i class="home-icon-tit home-icon-tit-b"></i> 本站热门 </h1>
</div>
<div class="mod_content">
	<ul id="listbox" data-page="0">
	<c:forEach items="${wxBooks}" var="books">
		<li><a href="<%=path%>/wxbook/detail?id=${books.id}&fm=${fromurl}"> <img class="fn-left lazy" src="${books.coverImgs}"/>
			<div>
				<p class="bookname">${books.name}</p>
				<p class="intro">${books.getIntr()}</p>
			</div>
			</a></li>
	</c:forEach>
	</ul>
</div>
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

