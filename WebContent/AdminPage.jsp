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

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom fonts for this template -->
<link href="https://fonts.googleapis.com/css?family=Catamaran:100,200,300,400,500,600,700,800,900" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900,900i" rel="stylesheet">
<!-- sweetalert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- Custom styles for this template -->
<link href="css/one-page-wonder.min.css" rel="stylesheet">
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
	
	var articleInfo;
	function init(){
		
		
		/* console.log(id + "#" + pw); */
		var user_write = firebase.database().ref('article');
		var table_body = document.getElementById("table_body");
		var table_body2 = document.getElementById("table_body2");
		var table_row;
		var articleNum = 0;
		articleInfo = [];
		var article ="";
		var user_data = firebase.database().ref('user_data');
		user_write.once('value', function(snapshot) {
			snapshot.forEach(function(childSnapshot) {
				article="";
				var tmp = childSnapshot.val();
				article+= tmp.author+"@"+tmp.title+"@"+tmp.content;
				articleInfo.push(article);
				table_row = document.createElement("tr");
				table_row.innerHTML = '<td>'+tmp.author+'</td><td><a href="javascript:read_article('+articleNum+
						')"style ="color: white!important;">'+tmp.title+'</a></td>';
				table_body.appendChild(table_row);
				articleNum++;
				console.log(articleNum);		
			});
				
				
				
				
				user_data.once('value', function(snapshot2) {
					snapshot2.forEach(function(childSnapshot2) {
						article="";
						var tmp = childSnapshot2.val();
						if(tmp.user_id != "admin"){
							table_row = document.createElement("tr");
							table_row.innerHTML = '<td>'+tmp.user_id+'</td><td>'
							+tmp.user_pw+'</td>'+'<td><a href = "javascript:deleteUser(\''+tmp.user_id+'\')" style ="color: white!important;">'+'계정 삭제'+'</a></td>';
							table_body2.appendChild(table_row);
						}
						
					});
				});
				
		});
		
		
	}
		
	
	
	function initRank(){
		swal({
			  title: "정말 삭제 하시겠습니까?",
			  text: "모든 정보가 삭제되며, 복구할 수 없습니다.",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
			})
			.then((willDelete) => {
			  if (willDelete) {
					
					var user_ranks = firebase.database().ref('user_ranking');
					user_ranks.remove();
			  }
		})
	}
	function deleteUser(id) {
		swal({
			  title: "정말 삭제 하시겠습니까?",
			  text: "모든 정보가 삭제되며, 복구할 수 없습니다.",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
			})
			.then((willDelete) => {
			  if (willDelete) {
					var user_id = id;
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
						    setTimeout(function(){
						    	window.location.reload();
						    },1200);
						});
					},1000);

			  } else {
			    
			  }
			});
	}
	
	function read_article(articleNum){
		var article_info = articleInfo[articleNum];
		
		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", "./ArticleServlet");
		 
		var Field = document.createElement("input");
		Field.setAttribute("type", "hidden");
		Field.setAttribute("name", "info");
		Field.setAttribute("value", article_info);
		 
		form.appendChild(Field);
		 
		document.body.appendChild(form);
		form.submit();
	}
</script>

</head>

<body onload="init()">

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark navbar-custom fixed-top">
		<div class="container">
			<a class="navbar-brand" href="./MainPage.jsp">HomePage</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link" href="./SignUpPage.jsp">회원가입</a></li>
					<li class="nav-item"><a class="nav-link" href="./LoginPage.jsp">로그아웃</a></li>
					<li class="nav-item"><a class="nav-link" href="javascript:void(0);" onclick="withdrawal()">회원탈퇴</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<header class="masthead text-center text-white" style="height: 700px; padding-top: calc(50px) !important;">
		<div class="masthead-content" id="drawCanvas">
			<br>
			<div class="container" style="font-family: 'Noto Sans KR', sans-serif !important; width: 35%; float: left; margin-left: 50px; padding-top: 10px;">
				<table class="table table-stripted" style="color: white !important; width: 85%; text-align: center;">
					<thead style="font-weight: bolder;">
						<tr>
							<th style="width: 150px !important;">작성자</th>
							<th>제목</th>
						</tr>
					</thead>
					<tbody id="table_body">

					</tbody>
				</table>
			</div>
			<div class="container" style="font-family: 'Noto Sans KR', sans-serif !important; width: 35%; float: left; margin-left: 25px; padding-top: 10px;">
				<table class="table table-stripted" style="color: white !important; width: 550px; text-align: center;">
					<thead style="font-weight: bolder;">
						<tr>
							<th style="width: 150px !important;">ID</th>
							<th>PW</th>
							<th style="width: 150px !important;">Delete</th>
						</tr>
					</thead>
					<tbody id="table_body2">

					</tbody>
				</table>
				<input type="button" class="btn btn-primary btn-xl rounded-pill mt-5" onclick="initRank()" style="float: right;" value="랭킹 초기화">
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
	<script>
		function gotoWrite() {
			window.location.href = "./Write.jsp";
		}
		
		
	</script>
</body>

</html>
