<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome!!</title>
<link rel="stylesheet" href="style.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>


<form action="index.html" class="login-form">
	<h1>Login</h1>
	
	<div class="txtb">
		<input type="text">
		<span data-placeholder = "Username"></span>
	</div>
	
	<div class="txtb">
	<input type="password">
	<span data-placeholder="Password"></span>
	</div>
	
	<input type="submit" class= "logbtn" value="login">
	<div calss="bottom-text">
		Don't have account? <a href="#">Sign up</a>
	</div>
</form>
</body>
</html>