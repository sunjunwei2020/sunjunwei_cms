<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>本月评选</title>
<link href="/resource/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="/resource/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/resource/popper.min.js"></script>
<script type="text/javascript" src="/resource/bootstrap.min.js"></script>
<script type="text/javascript">

	$(function(){	
		
		var ida = '${list.size()}';
		var ca = '${list}';
		
		for ( var i in ida) {
			
			$.post("articleId",{id:ca[i-1].id},function(abj){
				$("#h").html(abj.title);
			},"json")
		}
	})
</script>
</head>
<body>
	
	
	<c:forEach items="${list }" var="ar">
		<div class="media">
			
			<div class="media-body">
				<h5 class="mt-0" id="h">${ar.title }</h5>
				<div style="padding-top: 60px">
	     		 <!-- Button trigger modal -->
				<button type="button" onclick="xq(${ar.id})" class="btn btn-info" >
					  A
				</button>
				<button type="button" onclick="xq(${ar.id})" class="btn btn-info" >
					  B
				</button>
				<button type="button" onclick="xq(${ar.id})" class="btn btn-info" >
					 C
				</button>
				<button type="button" onclick="xq(${ar.id})" class="btn btn-info" >
					D
				</button>
				</div>
			</div>
		</div>
		<hr>
	</c:forEach>
	
	
</body>
</html>