<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String htmlData = request.getParameter("content1") != null ? request.getParameter("content1") : "";
%>
<!doctype html>
<html>
<head>
	<meta charset="utf-8" />
	<title>KindEditor JSP</title>
		<link rel="stylesheet" href="/resource/kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="/resource/kindeditor/plugins/code/prettify.css" />
	<script charset="utf-8" src="/resource/kindeditor/kindeditor.js"></script>
	<script charset="utf-8" src="/resource/kindeditor/lang/zh-CN.js"></script>
	<script charset="utf-8" src="/resource/kindeditor/plugins/code/prettify.js"></script>
	<script>
		KindEditor.ready(function(K) {
			window.editor1 = K.create('textarea[name="content1"]', {
				cssPath : '/resource/kindeditor/plugins/code/prettify.css',
				uploadJson : '/resource/kindeditor/jsp/upload_json.jsp',
				fileManagerJson : '/resource/kindeditor/jsp/file_manager_json.jsp',
				allowFileManager : true,
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						document.forms['example'].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						document.forms['example'].submit();
					});
				}
			});
			prettyPrint();
		});
		
		
	</script>
	
	<script type="text/javascript">
		//文档就绪函数
		$(function(){
			$.post("channels/channel",function(obj){
				for ( var i in obj) {
					$("#channel").append("<option value='"+obj[i].id+"'>"+obj[i].name+"</option>");
				}
			},"json")
		})
		//改变事件
		$("#channel").change(function(){
			var cid = $(this).val();
			$("#category").empty();
			$("#category").append("<option value=''>"+"请选择分类"+"</option>");
			$.post("channels/categoryId",{"cid":cid},function(obj){
				
				for ( var i in obj) {
					$("#category").append("<option value='"+obj[i].id+"'>"+obj[i].name+"</option>");
				}
			},"json")
		})
		
		//发布文章
		function publish(){
			//
			var formData = new FormData($("#form1")[0]);
			//获取富文本编辑器里面的html内容，并封装到formData中
			formData.set("content",editor1.html());
			
			$.ajax({
				url:"my/publishb",
				type:"post",
				//告诉jQuery不要去处理发送的数据
				processData:false,
				//告诉jQuery不要去设置content-type请求头
				contentType:false,
				data:formData,
				success:function(flag){
					if(flag){
						alert("发布成功");
						//跳转到我的文章
						location.href="my";
					}
				}
			})
		}
	
	</script>
</head>
<body>
	<form id="form1">
		<div class="form-group">
			<label for="title">文章标题</label>
			<input id="title" type="text"
				name="title" class="form-control form-control-sm col-sm-10">
			</div>
		<div class="form-group form-inline">
			<label for="channel">所属栏目</label>
			<select class="form-control form-control-sm" id="channel" name="channelId">
				<option value="">请选择栏目</option>
			</select>
			
			<label for="category">所属分类</label>
			<select class="form-control form-control-sm" id="category" name="categoryId">
				<option value="">请选择分类</option>
			</select>
		</div>
		<div class="form-group">
			标题图片：<input type="file" name="file">
		</div>
		<textarea name="content1" cols="100" rows="8" style="width:928.45px;height:200px;visibility:hidden;"><%=htmlspecialchars(htmlData)%></textarea>
		<br />
		<input type="button" onclick="publish()" name="button" class="btn btn-primary" value="发布文章" /> (提交快捷键: Ctrl + Enter)
	</form>
</body>
</html>
<%!
private String htmlspecialchars(String str) {
	str = str.replaceAll("&", "&amp;");
	str = str.replaceAll("<", "&lt;");
	str = str.replaceAll(">", "&gt;");
	str = str.replaceAll("\"", "&quot;");
	return str;
}
%>