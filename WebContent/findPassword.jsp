<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
<meta charset="utf-8">
<title></title>
<link rel="stylesheet" href="find_password.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
<!-- The core Firebase JS SDK is always required and must be listed first -->
<script src="https://www.gstatic.com/firebasejs/7.5.0/firebase-app.js"></script>
<!-- sweetalert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- TODO: Add SDKs for Firebase products that you want to use
     https://firebase.google.com/docs/web/setup#available-libraries -->
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

	<form action="index.html" class="login-form" id="loginForm">
		<h1>비밀번호 찾기</h1>
		<div class="txtb">
			<input type="text" id="id" name="id">
			<span data-placeholder="ID"></span>
		</div>
		<div class="txtb">
			<input type="text" id="name" name="name">
			<span data-placeholder="NickName"></span>
		</div>

		<div class="txtb">
			<input type="email" id="email" name="eamil">
			<span data-placeholder="Email"></span>
		</div>
		<input type="button" class="logbtn" onclick="find_password()" value="Find Password">

		<div class="bottom-text" style="margin-bottom: 10px!important">
			계정이 없으신가요 ? <a href="SignUpPage.jsp">회원가입</a>
		</div>
		<a href="javascript:history.back()" class = "back"
			style = "color: #000!important; transition: 0.8s!important; display: block!important;"
		>로그인 화면으로 이동하기</a>
	</form>

	<script type="text/javascript">
		$(".txtb input").on("focus", function() {
			$(this).addClass("focus");
		});

		$(".txtb input").on("blur", function() {
			if ($(this).val() == "")
				$(this).removeClass("focus");
		});

		function find_password() {
			var userName ="";
			var successFind = false;
			var id = document.getElementById("id").value;
			var name = document.getElementById("name").value;
			var email = document.getElementById("email").value;
			console.log(id + "#" + name + "#" + email);
			var user_data = firebase.database().ref('user_profile');
			user_data.once('value', function(snapshot) {
				snapshot.forEach(function(childSnapshot) {
					var tmp = childSnapshot.val();
					console.log(tmp.user_email + "@" + tmp.user_name);
					if (tmp.user_email == email) {
						if (tmp.user_name == name) {
							console.log("hello");
							userName = tmp.user_name;
							successFind = true;
						}
					}
				});

				if (successFind == true) {
					user_data = firebase.database().ref('user_data');
					user_data.once('value', function(snapshot) {
						snapshot.forEach(function(childSnapshot) {
							/* console.log(childSnapshot.val().user_id + "@" + childSnapshot.val().user_pw); */
							var tmp = childSnapshot.val();
							if (tmp.user_id == id) {
								swal(userName + " 님의 비밀 번호는,", tmp.user_pw + " 입니다.", "info");
								return;
							}
						});
					});
				} else {
					swal("일치하는 정보를 찾을 수 없습니다.", "", "error");
				}

			});
		}
	</script>


</body>
</html>
