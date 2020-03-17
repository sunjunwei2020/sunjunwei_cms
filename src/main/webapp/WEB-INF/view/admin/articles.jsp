<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文章审核</title>
<script type="text/javascript">
	function goPage(page){
		//在中间区域加载
		$("#center").load("admin/articles?pageNum="+page);
	}
	//条件查询
	function query(){
		
		var title = $("[name='title']").val();
		var status = $("[name='status']").val();
		
		$("#center").load("admin/articles?title="+title+"&status="+status);
	}
	//更新是否热门状态
	function status(id,own){
		var hot = $(own).text()=="是"?"0":"1";
		$.post("admin/uphot",{"id":id,"hot":hot},function(flag){
			if(flag){
				$(own).text($(own).text()=="是"?"否":"是");
				$(own).attr("class",$(own).text()=="是"?"btn btn-info btn-sm":"btn btn-danger btn-sm");
			}
		},"json")
	}
	var idAll;
	//点击详情  
	function xq(id){
		idAll = id;
		//清空上一次的动态
		$("#msg").empty();
		$.post("admin/xiangqing",{"id":id},function(obj){
			$("#title").append(obj.title);
			$("#content").append(obj.content);
		},"json")
	}
	//修改状态 是否审核通过
	function updateStatus(stutus){
		//alert(stutus)
		$.post("admin/updateStatus",{"id":idAll,"status":stutus},function(flag){
			if(flag){
				$("#msg").append("操作成功!");
			}else{
				$("#msg").append("操作失败!");
			}
		},"json")
	}
</script>
</head>
<body>
	<div class="form-group form-inline">
		文章标题<input type="text" name="title" class="form-control form-control-sm"
					  value="${ar.title }">&nbsp;&nbsp;
		审核状态<select name="status" class="form-control form-control-sm col-sm-1">
					<option value="">请选择</option>
					<option value="0" ${ar.status=="0"?"selected":"" }>待审</option>
					<option value="1" ${ar.status=="1"?"selected":"" }>已审</option>
					<option value="-1" ${ar.status=="-1"?"selected":"" }>驳回</option>
			   </select>&nbsp;&nbsp;
		<button type="button" onclick="query()" class="btn btn-warning btn-sm">查询</button>
	</div>
	
	
	<table class="table table-bordered table-hover table-sm" style="text-align:center;">
		<tr>
			<td>序号</td>
			<td>标题</td>
			<td>作者</td>
			<td>发布时间</td>
			<td>所属栏目</td>
			<td>所属分类</td>
			<td>是否热门</td>
			<td>点击量</td>
			<td>其他</td>
		</tr>
		<c:forEach items="${info.list }"  var="ar" varStatus="i">
			<tr>
				<td>${i.count }</td>
				<td>${ar.title }</td>
				<td>${ar.user.username }</td>
				<td>
					<fmt:formatDate value="${ar.created }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>${ar.channel.name }</td>
				<td>${ar.category.name }</td>
				<td>
					<c:if test="${ar.hot==0 }">
						<button  class="btn btn-danger btn-sm" onclick="status(${ar.id},this)">否</button>
					</c:if>
					<c:if test="${ar.hot==1 }">
						<button  class="btn btn-info btn-sm" onclick="status(${ar.id},this)">是</button>
					</c:if>
				</td>
				<td>${ar.hits }</td>
				<td>
					<button type="button" onclick="xq(${ar.id})" class="btn btn-link" data-toggle="modal" data-target="#exampleModalLong">
					  详情
					</button>
				</td>
			</tr>
		</c:forEach>
	</table>
	<!-- 引入分页 -->
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
      	<span id="msg"></span>
        <button type="button" class="btn btn-primary" onclick="updateStatus(1)">通过</button>
        <button type="button" class="btn btn-danger" onclick="updateStatus(-1)">驳回</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>

</body>
</html>