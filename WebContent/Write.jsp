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
 	function write(){
		var articleKey = firebase.database().ref().push().key;
	}
	function withdrawal() {
		swal({
			  title: "���� Ż�� �Ͻðڽ��ϱ�?",
			  text: "��� ������ �����Ǹ�, ������ �� �����ϴ�.",
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

						    swal("Ż�� �Ϸ�", {
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
					<li class="nav-item"><a class="nav-link" href="./SignUpPage.jsp">ȸ������</a></li>
					<li class="nav-item"><a class="nav-link" href="./LoginPage.jsp">�α׾ƿ�</a></li>
					<li class="nav-item"><a class="nav-link" href="javascript:void(0);" onclick="withdrawal()">ȸ��Ż��</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<header class="masthead text-center text-white" style="height: 700px; padding-top: calc(110px) !important;">
		<div class="masthead-content" id="drawCanvas">
			<div style="text-align: left !important;">

				<div class="container" role="main">
					<form name="form" id="form" role="form" method="post">

						<div class="mb-3">

							<label for="title">����</label>

							<input type="text" class="form-control" name="title" id="title" placeholder="������ �Է��� �ּ���">

						</div>
						<div class="mb-3">

							<label for="content">����</label>

							<textarea class="form-control" rows="8" name="content" id="content" placeholder="������ �Է��� �ּ���"></textarea>

						</div>

					</form>

					<div>

						<button type="button" class="btn btn-sm btn-primary" onclick="write()">�۾���</button>
					</div>
				</div>

			</div>
		</div>
		<div class="bg-circle-1 bg-circle"></div>
		<div class="bg-circle-2 bg-circle"></div>
		<div class="bg-circle-3 bg-circle"></div>
		<div class="bg-circle-4 bg-circle"></div>
	</header>

	<!-- Bootstrap core JavaScript -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script>
		function withdrawal() {
			alert(1);
		}
	</script>
</body>

</html>
