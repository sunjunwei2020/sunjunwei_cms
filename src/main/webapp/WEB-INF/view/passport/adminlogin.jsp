<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理员登录</title>
<link rel="stylesheet" type="text/css"
	href="/resource/bootstrap.min.css" />

<link rel="stylesheet" type="text/css" href="/resource/index.css" />
<link rel="stylesheet" type="text/css" href="/resource/jquery/screen.css" />

<script type="text/javascript" src="/resource/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/resource/jquery.validate.js"></script>
<script type="text/javascript">
	$(function(){
		$("#form1").validate({
			rules:{
				username:{required:true},
				password:{required:true}
			},
			messages:{
				username:{required:"<font color='red'>用户名不能为空</font>"},
				password:{required:"<font color='red'>密码不能为空</font>"}
			},
			submitHandler:function(){
				//如果校验通过 则执行登录
				$.post("passport/loginTo",$("#form1").serialize(),function(result){
					if(result.code==200){//登录成功
						//回到后台
						location.href="/admin";
					}else{
						$("#msg").html("<font color='red'>"+result.msg+"</font");
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
			<span style="color: red">${msg }</span>
			<div class="form-group">
				<label for="username">用户名</label> <input id="username" type="text"
					class="form-control" name="username">
			</div>
			<div class="form-group">
				<label for="password">密码</label> <input id="password"
					type="password" class="form-control" name="password">
			</div>
			

			<div class="form-group">
				<button type="submit" class="btn btn-info">登录</button>
				<button type="reset" class="btn btn-warning">重置</button>
				<span id="msg"> </span>
			</div>

		</form>

	</div>

</body>
</html>