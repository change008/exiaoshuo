<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/include_base.jsp"%>
<title>充值</title>
</head>

<body>
	<input type="hidden" id="bookid" name="bookid" value="${bookid }">
	<input type="hidden" id="chapterid" name="chapterid"
		value="${chapterid }">
	<input type="hidden" id="fromurl" name="fromurl" value="${fromurl }">
	<div class="nav-panel bookinfo-title">
		<a class="bookinfoback" href="<%=path%>/mynovel/novel?id=${wxBook.id}">«</a>&nbsp;&nbsp;充值阅币
		<a href="<%=path%>/?ch=${fromurl}" class="icohome"></a>
	</div>
	<div class="mod_content panel c1  "
		style="padding-top: 8px; padding-bottom: 2px;">
		<ul class="gray">
			<li>充值账号：<label class="orange">${user.name }</label><br>
				用户余额：<label class="orange">${user.coin}</label>阅币
			</li>
		</ul>
	</div>
	<div class="mod_block"></div>
	<ul class="pay_money moneylist margin-top-10">
		<li><span data-money="3000" data-premium="300" data-type="1">
				<span>3000+300阅币</span>
				<dl>30元(送3元)
				</dl>
		</span></li>
		<li><span style="border: 1px solid #ff6600;" data-money="5000"
			data-premium="1000" data-type="1">
				<div class="top_up_send">热</div> <span>5000+1000阅币</span>
				<dl>50元(送10元)
				</dl>
		</span></li>
		<li><span data-money="10000" data-premium="2500" data-type="1">
				<span>10000+2500阅币</span>
				<dl>100元(送25元)
				</dl>
		</span></li>
		<li><span data-money="20000" data-premium="6000" data-type="1">
				<span>20000+6000阅币</span>
				<dl>200元(送60元)
				</dl>
		</span></li>
		<li><span data-money="50000" data-premium="20000" data-type="1">
				<span>50000+20000阅币</span>
				<dl>500元(送200元)
				</dl>
		</span></li>
		<li><span data-money="100000" data-premium="50000" data-type="1">
				<span>100000+50000阅币</span>
				<dl>1000元(送500元)
				</dl>
		</span></li>
	</ul>

	<a class="btn block" href="#" onclick="defaultPay();">确认充值</a>

	
	<div class="myt" style="position: absolute;bottom: 10px;right: 10px;width: 15px;height: 15px;">
		<span data-money="100" data-premium="0" data-type="1"> </span>
	</div>
	

	<script>
		$(".pay_money li").click(function() {
			var bookid = $("#bookid").val();
			var chapterid = $("#chapterid").val();
			var fromurl = $("#fromurl").val();
			var span = $(this).find("span");
			var money = span.attr("data-money");
			var premium = span.attr("data-premium");
			var type = span.attr("data-type");

			var form = $("<form></form>", {
				'method' : 'post',
				'action' : 'ipay_now',
				'style' : 'display:none'
			}).appendTo($("body"));

			form.append($("<input>", {
				'type' : 'hidden',
				'name' : 'money',
				'value' : money
			}));
			form.append($("<input>", {
				'type' : 'hidden',
				'name' : 'premium',
				'value' : premium
			}));
			form.append($("<input>", {
				'type' : 'hidden',
				'name' : 'type',
				'value' : type
			}));
			form.append($("<input>", {
				'type' : 'hidden',
				'name' : 'bookid',
				'value' : bookid
			}));
			form.append($("<input>", {
				'type' : 'hidden',
				'name' : 'chapterid',
				'value' : chapterid
			}));
			form.append($("<input>", {
				'type' : 'hidden',
				'name' : 'fromurl',
				'value' : fromurl
			}));
			form.submit();
		});

		function defaultPay() {
			var bookid = $("#bookid").val();
			var chapterid = $("#chapterid").val();
			var fromurl = $("#fromurl").val();
			var money = 5000;
			var premium = 900;
			var type = 1;
			var form = $("<form></form>", {
				'method' : 'post',
				'action' : 'ipay_now',
				'style' : 'display:none'
			}).appendTo($("body"));

			form.append($("<input>", {
				'type' : 'hidden',
				'name' : 'money',
				'value' : money
			}));
			form.append($("<input>", {
				'type' : 'hidden',
				'name' : 'premium',
				'value' : premium
			}));
			form.append($("<input>", {
				'type' : 'hidden',
				'name' : 'type',
				'value' : type
			}));
			form.append($("<input>", {
				'type' : 'hidden',
				'name' : 'bookid',
				'value' : bookid
			}));
			form.append($("<input>", {
				'type' : 'hidden',
				'name' : 'chapterid',
				'value' : chapterid
			}));
			form.append($("<input>", {
				'type' : 'hidden',
				'name' : 'fromurl',
				'value' : fromurl
			}));
			form.submit();
		}

		$(".myt").click(function() {
			var bookid = $("#bookid").val();
			var chapterid = $("#chapterid").val();
			var fromurl = $("#fromurl").val();
			var span = $(this).find("span");
			var money = span.attr("data-money");
			var premium = span.attr("data-premium");
			var type = span.attr("data-type");
			var form = $("<form></form>", {
				'method' : 'post',
				'action' : 'ipay_now',
				'style' : 'display:none'
			}).appendTo($("body"));

			form.append($("<input>", {
				'type' : 'hidden',
				'name' : 'money',
				'value' : money
			}));
			form.append($("<input>", {
				'type' : 'hidden',
				'name' : 'premium',
				'value' : premium
			}));
			form.append($("<input>", {
				'type' : 'hidden',
				'name' : 'type',
				'value' : type
			}));
			form.append($("<input>", {
				'type' : 'hidden',
				'name' : 'bookid',
				'value' : bookid
			}));
			form.append($("<input>", {
				'type' : 'hidden',
				'name' : 'chapterid',
				'value' : chapterid
			}));
			form.append($("<input>", {
				'type' : 'hidden',
				'name' : 'fromurl',
				'value' : fromurl
			}));
			form.submit();
		});
	</script>
</body>
</html>
