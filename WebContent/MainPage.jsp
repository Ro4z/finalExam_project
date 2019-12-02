<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String id = (String) session.getAttribute("id");
%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Main Page</title>

<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom fonts for this template -->
<link href="https://fonts.googleapis.com/css?family=Catamaran:100,200,300,400,500,600,700,800,900" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900,900i" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/one-page-wonder.min.css" rel="stylesheet">
<!-- TODO: Add SDKs for Firebase products that you want to use
     https://firebase.google.com/docs/web/setup#available-libraries -->
<!-- sweetalert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://www.gstatic.com/firebasejs/7.5.0/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.8/firebase.js"></script>
<script>
	// Your web app's Firebase configuration
	var db;
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
	var app = firebase.initializeApp(firebaseConfig);
	db = firebase.firestore(app);
	const firestore = firebase.firestore();
	const settings = {
		timestampsInSnapshots : true
	};
	firestore.settings(settings);
	function withdrawal() {
		swal({
			  title: "정말 탈퇴 하시겠습니까?",
			  text: "모든 정보가 삭제되며, 복구할 수 없습니다.",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
			})
			.then((willDelete) => {
			  if (willDelete) {
					var user_id = "<%=id%>";
					var user_data = firebase.database().ref('user_data');
					user_data.once('value', function(snapshot) {
						snapshot.forEach(function(childSnapshot) {
							console.log(childSnapshot.key);
							if(childSnapshot.key == user_id){
								user_data.child(childSnapshot.key).remove();
							}
							
						});
					});
					
					setTimeout(function(){
						var user_data = firebase.database().ref('user_profile');
						user_data.once('value', function(snapshot) {
							snapshot.forEach(function(childSnapshot) {
								console.log(childSnapshot.key);
								if(childSnapshot.key == user_id){
									user_data.child(childSnapshot.key).remove();
								}
								
							});

						    swal("탈퇴 완료", {
						        icon: "info",
						        button : false
						      });
						    setTimeout(function() {
								window.location.href = "./LoginPage.jsp";
							}, 1300)
						});
					},1000);

			  } else {
			    
			  }
			});
		
		
	


	}
</script>
<script>
	var canvas;
	var context;
	var dx = 5;
	var dy = 5;
	var WIDTH = 800;
	var HEIGHT = 500;
	var theta = 0.1;
	var radius = 80;
	var x = 400 + radius * Math.cos(theta);
	var y = 250 + radius * Math.sin(theta);
	function circle(x, y, r) {
		context.beginPath();
		context.arc(x, y, r, 0, Math.PI * 2, true);
		context.fill();
	}

	function mainCircle() {
		context.beginPath();
		context.arc(400, 250, 70, 0, Math.PI * 2, true);
		context.fill();

	}

	function rect(x, y, w, h) {
		context.beginPath();
		context.rect(x, y, w, h);
		context.closePath();
		context.fill();
		context.stroke();
	}

	function clear() {
		context.clearRect(0, 0, WIDTH, HEIGHT);
	}

	function doKeyDown(evt) {

		switch (evt.keyCode) {

			case 37: /* Left arrow was pressed */
				theta -= 0.1;
				x = 400 + radius * Math.cos(theta);
				y = 250 + radius * Math.sin(theta);

				evt.preventDefault();
				break;
			case 39: /* Right arrow was pressed */

				theta += 0.1;
				x = 400 + radius * Math.cos(theta);
				y = 250 + radius * Math.sin(theta);

				evt.preventDefault();
				break;
		}

	}

	function draw() {
		clear();
		context.fillStyle = "white";
		context.strokeStyle = "black";
		rect(0, 0, WIDTH, HEIGHT);
		context.fillStyle = "#8e44ad";
		circle(x, y, 10);
		context.fillStyle = "#3498db";
		mainCircle();
	}

	var context;
	var canvas;
	function startGame() {
		document.getElementById("drawCanvas").innerHTML = '<canvas width="800" height="500" id="MyCanvas"></canvas>';
		canvas = document.getElementById("MyCanvas");
		context = canvas.getContext("2d");
		return setInterval(draw, 10 / 60);
	}
	window.addEventListener('keydown', doKeyDown, true);
</script>
</head>

<body>

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark navbar-custom fixed-top">
		<div class="container">
			<a class="navbar-brand" href="./MainPage.jsp">HomePage</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link" href="./Board.jsp">게시판</a></li>
					<li class="nav-item"><a class="nav-link" href="./SignUpPage.jsp">회원가입</a></li>
					<li class="nav-item"><a class="nav-link" href="./LoginPage.jsp">로그아웃</a></li>
					<li class="nav-item"><a class="nav-link" href="javascript:void(0);" onclick="withdrawal()">회원탈퇴</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<header class="masthead text-center text-white">
		<div class="masthead-content" id="drawCanvas">
			<div class="container">
				<h1 class="masthead-heading mb-0">환영합니다!</h1>
				<h2 class="masthead-subheading mb-0" id="welcome"><%=id%>님 안녕하세요!
				</h2>
				<input type="button" class="btn btn-primary btn-xl rounded-pill mt-5" onclick="startGame()" value="게임 시작">
			</div>
		</div>
		<div class="bg-circle-1 bg-circle"></div>
		<div class="bg-circle-2 bg-circle"></div>
		<div class="bg-circle-3 bg-circle"></div>
		<div class="bg-circle-4 bg-circle"></div>
	</header>


	<!-- Footer -->
	<footer class="py-5 bg-black">
		<div class="container">
			<p class="m-0 text-center text-white small">2019 Internet Programming Final Project &copy 12181637</p>
		</div>
		<!-- /.container -->
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>

</html>
