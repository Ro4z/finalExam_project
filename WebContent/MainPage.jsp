<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
<meta charset="utf-8">
<title></title>
<link rel="stylesheet" href="main.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
<!-- The core Firebase JS SDK is always required and must be listed first -->
<script src="https://www.gstatic.com/firebasejs/7.5.0/firebase-app.js"></script>

<!-- TODO: Add SDKs for Firebase products that you want to use
     https://firebase.google.com/docs/web/setup#available-libraries -->

<script>
  // Your web app's Firebase configuration
  var firebaseConfig = {
    apiKey: "AIzaSyDJPT1iTv_Bo0dXo78co_7hriUbhC0NQEQ",
    authDomain: "ip001-final-project.firebaseapp.com",
    databaseURL: "https://ip001-final-project.firebaseio.com",
    projectId: "ip001-final-project",
    storageBucket: "ip001-final-project.appspot.com",
    messagingSenderId: "1083544792257",
    appId: "1:1083544792257:web:315868cfabab79d41bb840"
  };
  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);
</script>
</head>
<body>

	<form action="index.html" class="login-form">
		<h1>환영합니다!</h1>

		<div class="txtb">
			<input type="text"><span data-placeholder="ID"></span>
		</div>

		<div class="txtb">
			<input type="password"> <span data-placeholder="Password"></span>
		</div>

		<input type="submit" class="logbtn" value="Login">

		<div class="bottom-text">
			계정이 없으신가요 ? <a href="SignUpPage.jsp">회원가입</a>
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
