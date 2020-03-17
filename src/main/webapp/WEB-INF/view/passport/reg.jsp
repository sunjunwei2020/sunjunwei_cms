<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 视窗 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>注册</title>
<link rel="stylesheet" type="text/css"
	href="/resource/bootstrap.min.css" />

<link rel="stylesheet" type="text/css" href="/resource/index.css" />
<script type="text/javascript" src="/resource/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/resource/jquery.validate.js"></script>
<!-- 先引入jquery,再引入bootstrap -->
<script type="text/javascript" src="/resource/bootstrap.min.js"></script>
<script type="text/javascript">
	
	$(function(){
		//jQuery插件驗證
		$("#form1").validate({
			rules:{
				username:{required:true,rangelength:[2,10],
					//校验用户名是否已经存在 存在则不能再次注册
					remote:{
						type:"post",
						data:{
							username:function(){
								return $("#username").val();
							}
						},
						url:"passport/checkName"
					}},
				password:{required:true,rangelength:[6,10]},
				repassword:{equalTo:"#password"} 
			},
			messages:{
				username:{required:"<font color='red'>用戶名不能為空</font>",
						  rangelength:"<font color='red'>用戶名長度在2-10之間</font>",
						  remote:"<font color='red'>用戶已经被注册</font>"},
				password:{required:"<font color='red'>密碼不能為空</font>",
						  rangelength:"<font color='red'>密碼長度在6-10之間</font>"},
				repassword:{equalTo:"<font color='red'>兩次密碼不一致</font>"}
			},
			submitHandler:function(){
				//校驗通過 進行註冊
				$.post("passport/toReg",$("#form1").serialize(),function(result){
					if(result.code==200){//注册成功
						$("#title").html("<font color='red'>恭喜，注册成功，请登录</font>");
						
						$("#passport").load("passport/login");
					}else{
						alert(result.msg);
					}
				},"json")
			}
		})
		
	})
	
</script>

</head>
<body>
	<div class="container">
		<form id="form1">

			<div class="form-group">
				<label for="username">用户名</label> <input id="username" type="text"
					class="form-control" name="username">
			</div>
			<div class="form-group">
				<label for="password">密码</label> <input id="password"
					type="password" class="form-control" name="password">
			</div>
			<div class="form-group">
				<label for="repassword">确认密码</label> <input id="repassword"
					type="password" class="form-control" name="repassword">
			</div>
			<div class="form-group form-inline">
				<label for="gender">性别</label> <input id="gender" type="radio"
					class="form-check-input" name="gender" value="1">男 <input
					id="gender" type="radio" class="form-check-input" name="gender"
					value="0">女
			</div>

			<div class="form-group">
				<button type="submit" class="btn btn-info">注册</button>
				<button type="reset" class="btn btn-warning">重置</button>
			</div>


		</form>

	</div>
</body>
</html>