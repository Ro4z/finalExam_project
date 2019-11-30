<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
<meta charset="utf-8">
<title></title>
<link rel="stylesheet" href="./css/login.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
<!-- The core Firebase JS SDK is always required and must be listed first -->
<!-- sweetalert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- TODO: Add SDKs for Firebase products that you want to use
     https://firebase.google.com/docs/web/setup#available-libraries -->
<script src="https://www.gstatic.com/firebasejs/7.5.0/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.8/firebase.js"></script>
<script>
	// Your web app's Firebase configuration
	var firebaseConfig = {
		apiKey : "AIzaSyDJPT1iTv_Bo0dXo78co_7hriUbhC0NQEQ",
		authDomain : "ip001-final-project.firebaseapp.com",
		databaseURL : "https://ip001-final-project.firebaseio.com",
		projectId : "ip001-final-project",
		storageBucket : "ip001-final-project.appspot.com",
		messagingSenderId : "1083544792257",
		appId : "1:1083544792257:web:315868cfabab79d41bb840"
	};
	// Initialize Firebase
	firebase.initializeApp(firebaseConfig);
</script>
</head>
<body>

	<form class="login-form" id="loginForm">
		<h1>환영합니다!</h1>

		<div class="txtb">
			<input type="text" id="id" name="id">
			<span data-placeholder="ID"></span>
		</div>

		<div class="txtb">
			<input type="password" id="pwd" name="pwd">
			<span data-placeholder="Password"></span>
		</div>

		<div class="bottom-text" style="margin-top: 0px !important">
			<a href="findPassword.jsp">비밀번호를 잊으셨나요?</a>
		</div>
		<input type="button" class="logbtn" onclick="login()" value="Login">

		<div class="bottom-text">
			계정이 없으신가요 ? <a href="SignUpPage.jsp">회원가입</a>
		</div>
	</form>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".login-form").keypress(function(e) {
				if (e.which == 13) {
					login(); // 실행할 이벤트
				}
			});
		});
		$(".txtb input").on("focus", function() {
			$(this).addClass("focus");
		});

		$(".txtb input").on("blur", function() {
			if ($(this).val() == "")
				$(this).removeClass("focus");
		});

		function login() {
			var keyCode = window.event.keyCode;
			var successLogin = false;
			var id = document.getElementById("id").value;
			var pw = document.getElementById("pwd").value;

			if (id == "admin") {
				if (pw == "passwd") {
					swal({
						title : "관리자 페이지에 접속합니다.\n",
						text : "\n",
						icon : "success",
						timer : 1300,
						button : false
					})
					setTimeout(function() {
						window.location.href = "./AdminPage.jsp";
					}, 1300)
				} else {
					swal({
						title : "사용자 정보와 일치하지 않습니다\n",
						text : "\n",
						icon : "error",
						timer : 1300,
						button : false
					})
				}
				return;
			}
			/* console.log(id + "#" + pw); */
			var user_data = firebase.database().ref('user_data');
			user_data.once('value', function(snapshot) {
				snapshot.forEach(function(childSnapshot) {
					var key = Object.keys(childSnapshot.val())[0];
					console.log(key + "@@");
					/* console.log(childSnapshot.val().user_id + "@" + childSnapshot.val().user_pw); */
					var tmp = childSnapshot.val();
					if (tmp.user_id == id) {
						if (tmp.user_pw == pw) {
							console.log("hello");
							successLogin = true;
						}
					}
				});
				if (successLogin == true) {
					var name;
					var user_data = firebase.database().ref('user_profile/' + id);
					console.log(user_data);
					user_data.once('value').then(function(snapshot) {
						name = (snapshot.val() && snapshot.val().user_name) || 'Anonymous';
					});
					swal({
						title : "로그인 성공\n",
						text : "\n",
						icon : "success",
						timer : 1300,
						button : false
					})

					setTimeout(function() {
						var form = document.getElementById("loginForm");
						form.setAttribute("action", "./LoginServlet?id=" + id + "&&pwd=" + pw + "");
						form.submit();
					}, 1300)
				} else {
					swal({
						title : "사용자 정보와 일치하지 않습니다\n",
						text : "\n",
						icon : "error",
						timer : 1300,
						button : false
					})
				}
			});

		}

		$("#login").keypress(function(e) {
			if (e.which == 13) {
				login();
			}
		});
	</script>


</body>
</html>
