<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的收藏</title>
<link href="/resource/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="/resource/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/resource/bootstrap.min.js"></script>
<script type="text/javascript">
	function goPage(page){
		$("#center").load("my/collect?pageNum="+page);
	}
	//取消收藏
	function qx(id){
		$.post("deleteCollect",{id:id},function(flag){
			if(flag){
				alert("取消收藏成功");
				window.location.reload();
			}else{
				alert("取消收藏失败");
			}
		},"json")
	}
	
</script>
</head>
<body>
	
	<c:forEach items="${info.list }" var="co">
		<div class="media">
			<%-- <img src="/pic/${co.picture}" style="width: 130px;height: 130px"  class="mr-3 rounded" alt="..." > --%>
			<div class="media-body">
				<h5 class="mt-0">${co.text}</h5>
				
					收藏时间：<fmt:formatDate value="${co.created }" pattern="yyyy-MM-dd HH:mm:ss"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="button" class="btn btn-info" onclick="qx(${co.id})">取消收藏</button>
			</div>
		</div>
		<hr>
	</c:forEach>
	
	<jsp:include page="/WEB-INF/view/common/pages.jsp"></jsp:include>
	
	
</body>
</html>