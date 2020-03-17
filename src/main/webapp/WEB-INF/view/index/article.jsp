<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@  taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${article.title }</title>
<link href="/resource/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/resource/index.css" />
<script type="text/javascript" src="/resource/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/resource/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
	function addComment(){
		var articleId = '${article.id}';
		var content = $("[name='content']").val();
		$.post("addComment",{articleId:articleId,content:content},function(flag){
			if(flag){
				alert("评论成功");
				location.reload();
			}else{
				alert("评论失败,请登陆后评论")
			}
		},"json")
	}
	//收藏
	function collect(){
		//获取文章的标题
		var title = '${article.title}';
		//获取文章的url
		var url = window.location.href;
		
		$.post("collect",{"text":title,"url":url},function(flag){
			if(flag){
				alert("收藏成功");
				window.location.reload();
			}else{
				alert("收藏失败,请登陆后收藏")
			}
		},"json")
	}
	//取消收藏
	function deleteCollect(){
		//获取id
		var id='${collect.id}';
		
		$.post("deleteCollect",{"id":id},function(flag){
			if(flag){
				alert("取消收藏成功");
				window.location.reload();
			}else{
				alert("取消收藏失败,请登陆后取消收藏")
			}
		},"json")
	}
	
</script>
</head>
<body>
	
	<div class="container-fluid">
		<!-- head -->
		<div class="row">
			<div class="col-md-12"
				style="background-color: #222222; height: 34px">
				<font color="white" size="2px" style="margin-left: 10px">下载APP</font>		
			</div>
			
		</div>

		<div class="row" style="margin-top: 10px">
		    <div class="col-md-1"></div>
			<div class="col-md-7">
				<h2>${article.title }</h2>
				<p>${article.user.username}
					<fmt:formatDate value="${article.created}"
						pattern="yyyy-MM-dd HH:mm:ss" />
				</p>
				<!-- 收藏 -->
				<c:if test="${collect!=null}">
				 <button type="button" onclick="deleteCollect()" class="btn btn-link">★ 取消收藏</button>
				</c:if>
				<c:if test="${collect==null}">
				     <button type="button" onclick="collect(1)" class="btn btn-link">☆ 未收藏</button>
				</c:if>
				
				<hr>
				${article.content}
	
				<hr>
				
				<!-- 文章评论 -->
				<div>
					<h5>文章评论</h5>
					<textarea rows="8" cols="20" style="width: 753px" name="content"></textarea>
 					<button type="button" onclick="addComment()" class="btn btn-info">提交评论</button>
				</div>
				
				<!-- 显示评论内容 -->
				<div>
					<c:forEach items="${info.list }" var="c">
						<!-- 评论人  评论时间 -->
						<h5>${c.user.username }&nbsp;&nbsp;<fmt:formatDate value="${c.created }" pattern="yyyy-MM-dd HH:mm:ss"/></h5>
						<!-- 评论信息 -->
						${c.content }
					</c:forEach>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card" style="width: 18rem; margin-top: 6px">
					<div class="card-header">评论排行榜</div>
					<div class="card-body">
						<!-- 最新文章 --10篇 -->
						<c:forEach items="${info2.list}" var="article" varStatus="i">
						 <p>  ${i.count} ${article.title }</p>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>