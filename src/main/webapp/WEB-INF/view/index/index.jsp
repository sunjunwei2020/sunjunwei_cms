<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@  taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>今日头条</title>
<link href="/resource/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/resource/index.css" />
<script type="text/javascript" src="/resource/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/resource/popper.min.js"></script>
<script type="text/javascript" src="/resource/bootstrap.min.js"></script>

<script type="text/javascript">
	//分页
	function goPage(page) {
		var channelId = '${article.channelId}';
		var categoryId = '${article.categoryId}';
		var url = "/?pageNum=" + page + "&channelId=" + channelId;
		if (categoryId != "") {
			url += "&categoryId=" + categoryId;
		}

		location = url;
	}
	
	//註冊
	function reg(){
		$("#title").append("用户注册");
		$("#passport").load("passport/reg");
	}
	//登录
	function login(){
		$("#title").append("用户登录");
		$("#passport").load("passport/login");
	}
	
</script>
</head>
<body>

	<div class="container-fluid">
		<!-- head -->
		<div class="row">
			<div class="col-md-12"
				style="background-color: #222222; height: 34px">
				<font color="white" size="3px"
					style="margin-left: 10px; margin-top: 5px">下载APP</font>
				
				<!-- 註冊 -->
				<div style="float: right">
					
					<!-- 从session获取当前有没有登录，如果用户已经登录，则不显示登录和注册 -->
					<c:if test="${null==sessionScope.user}">
						<button type="button" class="btn btn-link" onclick="reg()"
							data-toggle="modal" data-target="#exampleModal"><font color="white" size="2px">注册</font></button>
						<button type="button" class="btn btn-link" onclick="login()"
							data-toggle="modal" data-target="#exampleModal"><font color="white" size="2px">登录</font></button>
					</c:if>
					<c:if test="${null!=sessionScope.user}">
						<div class="btn-group dropleft">
							<button type="button" class="btn btn-link dropdown-toggle"
								data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">	<font color="white" size="2px">登录信息</font></button>
							<div class="dropdown-menu">
								<a class="dropdown-item" href="#">${sessionScope.user.username }</a> <a
									class="dropdown-item" href="/my">个人中心</a> <a
									class="dropdown-item" href="/passport/logout">注销</a>
							</div>
						</div>
					</c:if>
					
				</div>
			</div>

		</div>
		<!-- 左侧 -->
		<div class="row">
			<div class="col-md-2" style="padding-top: 10px">
				<ul>
					<!-- 今日头条的logo -->
					<li style="margin-bottom: 10px"><a class="channel" href="/">
							<img alt="" src="/images/logo-index.png"
							style="width: 108px; height: 27px">

					</a></li>
					<!-- 热点文章 -->
					<li><a href="/?hot=1"
						class="channel-item ${article.channelId==null?'active':''}" >热点
					</a></li>

					<c:forEach items="${list}" var="channel">
						<li><a href="/?channelId=${channel.id }"
							class="channel-item ${channel.id==article.channelId?'active':'' }">${channel.name }</a></li>
					</c:forEach>
				</ul>



			</div>
			<div class="col-md-7">
				<!-- 如果 栏目ID 为null 说明点击 左侧的栏目的热点  则显示轮播图 即广告 -->
				<c:if test="${article.channelId==null}">

					<div style="margin: 5px 5px 5px 5px">
						<div id="carouselExampleCaptions" class="carousel slide"
							data-ride="carousel">
							<ol class="carousel-indicators">
								<c:forEach items="${slides }" var="s" varStatus="i">
									<li data-target="#carouselExampleCaptions"
										data-slide-to="${i.index }" class="active"></li>
								</c:forEach>
							</ol>
							<div class="carousel-inner">
								<c:forEach items="${slides }" var="s" varStatus="i">
									<div class="carousel-item ${i.index==0?'active':'' }">
										<img src="/pic/${s.url }" class="d-block w-100 rounded"
											alt="..." style="width: 350px; height: 320px">
										<div class="carousel-caption d-none d-md-block">
											<h5>${s.title }</h5>
										</div>
									</div>
								</c:forEach>
							</div>
							<a class="carousel-control-prev" href="#carouselExampleCaptions"
								role="button" data-slide="prev"> <span
								class="carousel-control-prev-icon" aria-hidden="true"></span> <span
								class="sr-only">Previous</span>
							</a> <a class="carousel-control-next" href="#carouselExampleCaptions"
								role="button" data-slide="next"> <span
								class="carousel-control-next-icon" aria-hidden="true"></span> <span
								class="sr-only">Next</span>
							</a>
						</div>

					</div>
					<hr>

					<div>
						<c:forEach items="${info.list}" var="article">
							<div class="media">
								<img src="/pic/${article.picture}" class="mr-3 rounded"
									alt="..." style="width: 190px; height: 160px">
								<div class="media-body">
									<h5 class="mt-0">
										<a href="article?id=${article.id }" target="_blank">${article.title }</a>
									</h5>
									<p>${article.user.username }&nbsp;·&nbsp;${article.hits }&nbsp;·&nbsp;浏览时间<fmt:formatDate
											value="${article.created }" pattern="yyyy-MM-dd" />
									</p>
								</div>
							</div>
							<hr>
						</c:forEach>
					</div>

				</c:if>


				<!-- 如果栏目ID 不为null 说明点击 左侧的栏目 -->
				<c:if test="${article.channelId!=null }">
					<!-- 显示栏目下子分类 -->
					<div class="subchannel">
						<ul>
							<li class="sub-item ${article.categoryId==null?"sub-selected":"" }" ><a
								href="/?channelId=${article.channelId }">全部</a></li>
							<c:forEach items="${category}" var="category">
								<li class="sub-item ${article.categoryId==category.id?"sub-selected":"" }"><a
									href="/?channelId=${article.channelId }&categoryId=${category.id}">${category.name }</a></li>
							</c:forEach>
						</ul>

					</div>

					<!-- 分类下的文章 -->
					<div>
						<c:forEach items="${info.list}" var="article">
							<div class="media">
								<img src="/pic/${article.picture}" class="mr-3 rounded"
									alt="..." style="width: 190px; height: 160px">
								<div class="media-body">
									<h5 class="mt-0">
										<a href="article?id=${article.id }" target="_blank">${article.title }</a>
									</h5>
									<p>${article.user.username }&nbsp;·&nbsp;${article.hits }&nbsp;·&nbsp;浏览时间<fmt:formatDate
											value="${article.created }" pattern="yyyy-MM-dd" />
									</p>
								</div>
							</div>
							<hr>
						</c:forEach>
					</div>
				</c:if>
				<!-- 引入分页工具 -->
	<jsp:include page="/WEB-INF/view/common/pages.jsp"></jsp:include>
				
			</div>
			<div class="col-md-3">
				<!-- 投票评选 -->
				<div class="card" style="width: 18rem; margin-top: 6px">
					<div class="card-header">本月评选</div>
					<div class="card-body">
					<!-- 最新文章 10篇 -->
					
					<c:forEach items="${ch }" var="c" varStatus="i">
						<div class="media">
							<%-- <img alt="" src="/pic/${ar.picture }" class="mr-3 rounded"
								style="width: 60px; height: 60px"> --%>
							<div class="media-body">
								<p>${i.count}: 好好学习天天向上</p>
								<p>A:${c.bfbA }%&nbsp;B:${c.bfbB }%&nbsp;C:${c.bfbC }%&nbsp;D:${c.bfbD }%</p>
							</div>
							
							
						</div>
						<hr>
					</c:forEach>
					
					<c:forEach items="${ch }" var="c" varStatus="i">
						<div class="media">
							<%-- <img alt="" src="/pic/${ar.picture }" class="mr-3 rounded"
								style="width: 60px; height: 60px"> --%>
							<div class="media-body">
								<p>2: 知识很简单</p>
								<p>A:${c.bfbC }%&nbsp;B:${c.bfbB }%&nbsp;C:${c.bfbD }%&nbsp;D:${c.bfbA }%</p>
							</div>
							
							
						</div>
						<hr>
					</c:forEach>
					
					<c:forEach items="${ch }" var="c" varStatus="i">
						<div class="media">
							<%-- <img alt="" src="/pic/${ar.picture }" class="mr-3 rounded"
								style="width: 60px; height: 60px"> --%>
							<div class="media-body">
								<p>3: 学习很快乐</p>
								<p>A:${c.bfbA }%&nbsp;B:${c.bfbD }%&nbsp;C:${c.bfbC }%&nbsp;D:${c.bfbB }%</p>
							</div>
							
							
						</div>
						<hr>
					</c:forEach>
					
					<c:forEach items="${ch }" var="c" varStatus="i">
						<div class="media">
							<%-- <img alt="" src="/pic/${ar.picture }" class="mr-3 rounded"
								style="width: 60px; height: 60px"> --%>
							<div class="media-body">
								<p>4: 葫芦娃</p>
								<p>A:${c.bfbD }%&nbsp;B:${c.bfbC }%&nbsp;C:${c.bfbA }%&nbsp;D:${c.bfbB }%</p>
							</div>
							
							
						</div>
						<hr>
					</c:forEach>
					<c:forEach items="${ch }" var="c" varStatus="i">
						<div class="media">
							<%-- <img alt="" src="/pic/${ar.picture }" class="mr-3 rounded"
								style="width: 60px; height: 60px"> --%>
							<div class="media-body">
								<p>5: 震惊,某蛇窝被轰炸!!!</p>
								<p>A:${c.bfbC }%&nbsp;B:${c.bfbB }%&nbsp;C:${c.bfbD }%&nbsp;D:${c.bfbA }%</p>
							</div>
							
							
						</div>
						<hr>
					</c:forEach>
					</div>
				</div>
			
			
				<div class="card" style="width: 18rem; margin-top: 6px">
					<div class="card-header">最新文章</div>
					<div class="card-body">
					<!-- 最新文章 10篇 -->
					<c:forEach items="${lastArticles.list }" var="ar">
						<div class="media">
							<img alt="" src="/pic/${ar.picture }" class="mr-3 rounded"
								style="width: 60px; height: 60px">
							<div class="media-body">
								<p>${ar.title }</p>
							</div>
						</div>
						<hr>
					</c:forEach>
					</div>
				</div>
			</div>
		</div>
		
		
		<!-- 模態框,登录/注册 -->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">
							<span id="title"></span>
						</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body" id="passport">
					
					</div>
				
				</div>
			</div>
		</div>
		
		
	</div>
	
</body>
</html>