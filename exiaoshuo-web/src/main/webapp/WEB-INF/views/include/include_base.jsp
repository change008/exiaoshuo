<meta charset="utf-8"/>
<meta name='apple-mobile-web-app-capable' content='yes' />
<meta name='apple-mobile-web-app-status-bar-style' content='default' />
<meta name="format-detection" content="telephone=no" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<link rel="stylesheet" href="<%=path %>/static/css/common.css?w=5"/>
<link rel="stylesheet" href="<%=path %>/static/css/common_v2.css"/>
<link rel="stylesheet" href="<%=path %>/static/css/swiper-3.4.2.min.css"/>
<script type="text/javascript" src="<%=path %>/static/js/jquery/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="<%=path %>/static/js/swiper-3.4.2.jquery.min.js"></script>