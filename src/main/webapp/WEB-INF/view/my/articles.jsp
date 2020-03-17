<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>我的文章</title>
<link href="/resource/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="/resource/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/resource/bootstrap.min.js"></script>
<script type="text/javascript">
	function goPage(page){
		$("#center").load("my/articles?pageNum="+page);
	}
	//详情  点击查询单条数据
	function xq(id){
		$.post("my/article",{"id":id},function(obj){
			$("#title").append(obj.title);
			$("#content").append(obj.content);
		},"json")
	}
</script>
</head>
<body>
	<c:forEach items="${info.list }" var="ar">
		<div class="media">
			<img src="/pic/${ar.picture}" style="width: 130px;height: 130px"  class="mr-3 rounded" alt="..." >
			<div class="media-body">
				<h5 class="mt-0">${ar.title}</h5>
				<div style="float: right;padding-top: 60px">
	     		 <!-- Button trigger modal -->
				<button type="button" onclick="xq(${ar.id})" class="btn btn-link" data-toggle="modal" data-target="#exampleModalLong">
					  详情
				</button>
				</div>
			</div>
		</div>
		<hr>
	</c:forEach>
	
	<jsp:include page="/WEB-INF/view/common/pages.jsp"></jsp:include>
	
	<!-- Modal -->
<div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle"><span id="title"></span></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="content">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
	
</body>
</html>