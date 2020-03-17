<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
<script type="text/javascript">
	//分页
	function goPage(page){
		//在中间区域加载
		$("#center").load("admin/users?pageNum="+page);
	}
	//查询
	function query(){
		var username = $("[name='username']").val();
		var locked = $("[name='locked']").val();
		
		$("#center").load("admin/users?username="+username+"&locked="+locked);
	}
	//改变用户状态
	function update(id,own){
		//0正常   1禁用
		var locked = $(own).text()=="正常"?1:0;
		
		$.post("admin/updateLocked",{"id":id,"locked":locked},function(flag){
			if(flag){
				//改变按钮
				$(own).text($(own).text()=="正常"?"禁用":"正常");
				//改变按钮样式
				$(own).attr("class",locked==0?"btn btn-info btn-sm":"btn btn-danger btn-sm");
			}
		},"json")
		
	}
	//管理员
	function manger(){
		alert("管理员无法操作")
	}
</script>
</head>
<body>
	<div class="form-group form-inline ">

		用戶名： <input type="text" name="username"
			class="form-control form-control-sm" value="${user.username }">
		&nbsp;&nbsp; 
		用户状态： <select name="locked"
			class="form-control form-control-sm col-sm-1">
			<option value="">请选择</option>
			<option value="0" ${user.locked=="0"?"selected":"" }>正常</option>
			<option value="1" ${user.locked=="1"?"selected":"" }>禁用</option>
		</select>
		 &nbsp;&nbsp;
 <button type="button" onclick="query()" class="btn btn-warning btn-sm">查询</button>

	</div>
	 <hr>
	<table class="table table-bordered table-hover table-sm" style="text-align: center;">
		<tr>
			<td>序号</td>
			<td>用户名</td>
			<td>昵称</td>
			<td>性别</td>
			<td>生日</td>
			<td>注册时间</td>
			<td>用户状态</td>
		</tr>
		<c:forEach items="${info.list }" var="u" varStatus="i">
			<tr>
				<td>${i.count }</td>
				<td>${u.username }</td>
				<td>${u.nickname }</td>
				<td>${u.gender==0?"女":"男" }</td>
				<td>
					<fmt:formatDate value="${u.birthday }" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${u.created }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<!-- 判断是不是管理员 -->
					<c:if test="${u.role==1 }">
						<button type="button" class="btn btn-info btn-sm" onclick="manger()">管理员</button>
					</c:if>
					<c:if test="${u.role!=1 }">
						<!-- 用户正常状态 -->
						<c:if test="${u.locked==0 }">
							<button type="button" class="btn btn-info btn-sm" onclick="update(${u.id},this)">正常</button>
						</c:if>
						<!-- 用户禁用状态 -->
						<c:if test="${u.locked==1 }">
							 <button type="button" class="btn btn-danger btn-sm" onclick="update(${u.id},this)">禁用</button>
						</c:if>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
	<!-- 引入分页 -->
	<jsp:include page="/WEB-INF/view/common/pages.jsp"></jsp:include>
	
</body>
</html>