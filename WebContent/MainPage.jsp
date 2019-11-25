<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
<meta charset="utf-8">
<title></title>
<link rel="stylesheet" href="style.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
</head>
<body>

	<form action="index.html" class="login-form">
		<h1>환영합니다!</h1>

		<div class="txtb">
			<input type="text"><span data-placeholder="Username"></span>
		</div>

		<div class="txtb">
			<input type="password"> <span data-placeholder="Password"></span>
		</div>

		<input type="submit" class="logbtn" value="Login">

		<div class="bottom-text">
			계정이 없으신가요 ^_^? <a href="#">회원가입</a>
		</div>

	</form>

	<script type="text/javascript">
		$(".txtb input").on("focus", function() {
			$(this).addClass("focus");
		});

		$(".txtb input").on("blur", function() {
			if ($(this).val() == "")
				$(this).removeClass("focus");
		});
	</script>


</body>
</html>
