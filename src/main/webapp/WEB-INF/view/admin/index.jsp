<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>今日头条--管理中心</title>
<link href="/resource/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="/resource/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/resource/popper.min.js"></script>
<script type="text/javascript" src="/resource/bootstrap.min.js"></script>

<script type="text/javascript">
$(function(){
	//默认页面
	var url = $("a").attr("data");
	
	$("#center").load(url);
	//点击事件
	$("a").click(function(){
		//获取data信息 是a标签
		var url = $(this).attr("data");
		//去除样式
		$("a").removeClass("active");
		//让当前点击的li 添加样式
		$(this).addClass("active");
		//在中间区域显示url的内容
		$("#center").load(url);
	})
})
</script>
</head>
<body>
	
	<div class="container-fluid" >
		<!-- 头 -->
		<div class="row form-group" style="height:  60px">
			<div class="col-md-12" style="background-color:#FFD1A4">
				<img alt="" src="images/aaa.png" style=" height:60px;padding-top: 0px;padding-left: 1px" class="rounded">
				<span>今日头条--管理中心</span>
				
				<div class="btn-group dropleft" style="float: right">
							<button type="button" class="btn btn-link dropdown-toggle"
								data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">	<font color="white" size="2px">登录信息</font></button>
							<%-- <div class="dropdown-menu" >
								<a class="dropdown-item" href="#">${sessionScope.admin.username }</a> <a
									class="dropdown-item" href="/passport/logout">注销</a>
							</div> --%>
						</div> 
			</div>
		</div>
		<!-- 身体 -->
		<div class="row form-group" style="padding-top: 10px;height: 550px">
			<!-- 左侧 -->
			<div class="col-md-2 rounded" 
			style="background-color: #ccc; text-align: center;margin-left: 13px;padding-top: 10px">
				<nav class="nav flex-column">
					<a class="list-group-item active" href="#" data="admin/articles">文章审核</a> 
					<a class="list-group-item " href="#" data="admin/users">用户管理</a> 
					<a class="list-group-item " href="#">栏目管理</a> 
					<a class="list-group-item " href="#">分类管理</a>
					<a class="list-group-item " href="#">系统设置</a>
				</nav>
				
			</div>
			<!-- 中间内容 -->
			<div class="col-md-9" id="center">
				
			</div>
		</div>
	</div>
	
	
</body>
</html>