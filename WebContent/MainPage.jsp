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
		
		var rank_info = [];
		function rankingComposition(){
			rank_info = [];
			var rankingRef = firebase.database().ref("user_ranking").orderByChild('score').limitToLast(100);;
			rankingRef.once('value', function(snapshot) {
				snapshot.forEach(function(childSnapshot) {
					
					var tmp = childSnapshot.val();
					console.log(tmp.score+"@"+tmp.user_id);
					rank_info.push(tmp.user_id+"@"+tmp.score);
				});
				var table_body = document.getElementById("table_body");
				var innerHtml = "";
				var temp = 1;
				for(var i=rank_info.length-1;i>=0;i--){
					innerHtml+="<tr>"
					+"<td>" +temp+"</td>"
					+"<td>" +rank_info[i].split("@")[0]+"</td>"
					+"<td>" +rank_info[i].split("@")[1]+"</td>"
					+"</tr>";
					temp++;
				}
				console.log("composit..."+innerHtml);
				table_body.innerHTML = innerHtml;
			});
			//
			
		}
	
		function registerRanking(score){
			var id = "<%=id%>";
			var user_score = (score==-1?0:score);
			var nowDay = new Date();
			firebase.database().ref('/user_ranking/' + id).set({
				user_id: id,
                score: Number(score),
                rgstrDate: nowDay.toString(),
            });

        	swal({
				title : "��� �Ϸ�!",
				text : "����������  ��ŷ�� ��� �Ǿ����ϴ�!",
				icon : "success",
				timer : 1200,
				button : false
			})
			
			rankingComposition();
		}
	

	var canvas;
	var context;
	var dx = 5;
	var dy = 5;
	var WIDTH = 600;
	var HEIGHT = 600;
	var theta = 0.1;
	var radius = 80;
	var x = 300 + radius * Math.cos(theta);
	var y = 300 + radius * Math.sin(theta);
	function circle(x, y, r) {
		context.beginPath();
		context.arc(x, y, r, 0, Math.PI * 2, true);
		context.fill();
	}

	function mainHexagon() {
		var hexa = document.querySelector('#MyCanvas').getContext('2d'),side = 0,
	    size= 70,
	    x = 300,
	    y = 300;
		
		hexa.beginPath();
		hexa.moveTo(x + size * Math.cos(0), y + size * Math.sin(0));

		for (side; side <6; side++) {
		  hexa.lineTo(x + size * Math.cos(side * 2 * Math.PI / 6), y + size * Math.sin(side * 2 * Math.PI / 6));
		}

		hexa.fillStyle = "#3498db";
		hexa.fill();

	}

	function rect(x, y, w, h) {
		context.beginPath();
		context.rect(x, y, w, h);
		context.closePath();
		context.fill();
		context.stroke();
	}
	
	function rect2(x, y, w, h) {
		context.beginPath();
		context.fillStyle ="#8e44ad";
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
				x = 300 + radius * Math.cos(theta);
				y = 300 + radius * Math.sin(theta);

				evt.preventDefault();
				break;
			case 39: /* Right arrow was pressed */

				theta += 0.1;
				x = 300 + radius * Math.cos(theta);
				y = 300 + radius * Math.sin(theta);

				evt.preventDefault();
				break;
		}

	}

	function drawField(){
		
		var hexa = document.querySelector('#MyCanvas').getContext('2d'),side = 0,
	    size= 1000,
	    x = 300,
	    y = 300;
		hexa.beginPath();
		hexa.moveTo(300,300);
		hexa.lineTo(0, 0);
		hexa.lineWidth = 3;
		hexa.stroke();
			
		hexa.beginPath();
		hexa.moveTo(300,300);
		hexa.lineTo(600, 0);
		hexa.lineWidth = 3;
		hexa.stroke();
		
		hexa.beginPath();
		hexa.moveTo(300,300);
		hexa.lineTo(0, 600);
		hexa.lineWidth = 3;
		hexa.stroke();
		
		hexa.beginPath();
		hexa.moveTo(300,300);
		hexa.lineTo(600, 600);
		hexa.lineWidth = 3;
		hexa.stroke();
	}
	
	
	var recurSeg = true;
	var speed = 1.0;
	//���ʿ��� ������� ����
	var segX=300,segY=0;
	function segment1(){
		var hexa = document.querySelector('#MyCanvas').getContext('2d'),side = 0,
	    size= 1000;
		
		if(segX<0){ recurSeg = true;}
		
		hexa.beginPath();
		hexa.moveTo(300-segX,segY - 5);
		hexa.lineTo(300+segX,segY - 5);
		hexa.lineWidth = 15;
		hexa.stroke();
		
		segX -= Math.sqrt(2)/2.0*2.2*speed;
		segY += Math.sqrt(2)/2.0*2.2*speed;

	}
	
	//�����ʿ��� ������� ����
	var segX2=600,segY2=0;
	function segment2(){
		var hexa = document.querySelector('#MyCanvas').getContext('2d'),side = 0,
	    size= 1000;
		
		if(segX2<300){ recurSeg = true;}
		
		hexa.beginPath();
		hexa.moveTo(segX2 + 5,segY2);
		hexa.lineTo(segX2 + 5,600 - segY2);
		hexa.lineWidth = 15;
		hexa.stroke();
		
		segX2 -= Math.sqrt(2)/2.0*2.2*speed;;
		segY2 += Math.sqrt(2)/2.0*2.2*speed;;
	}
	
	//���ʿ��� ������� ����
	var segX3=0,segY3=0;
	function segment3(){
		var hexa = document.querySelector('#MyCanvas').getContext('2d'),side = 0,
	    size= 1000;
		
		if(segX3>300){ recurSeg = true;}
		
		hexa.beginPath();
		hexa.moveTo(segX3 - 5,segY3);
		hexa.lineTo(segX3 - 5,600 - segY3);
		hexa.lineWidth = 15;
		hexa.stroke();
		
		segX3 += Math.sqrt(2)/2.0*2.2*speed;;
		segY3 += Math.sqrt(2)/2.0*2.2*speed;;
	}
	
	//�Ʒ����� ������� ����
	var segX4=300,segY4=600;
	function segment4(){
		var hexa = document.querySelector('#MyCanvas').getContext('2d'),side = 0,
	    size= 1000;
		
		if(segX4<0){ recurSeg = true;}
		
		hexa.beginPath();
		hexa.moveTo(300-segX4,segY4 + 5);
		hexa.lineTo(300+segX4,segY4 + 5);
		hexa.lineWidth = 15;
		hexa.stroke();
		
		segX4 -= Math.sqrt(2)/2.0*2.2*speed;;
		segY4 -= Math.sqrt(2)/2.0*2.2*speed;
		
		
	}
	var gen_seg = [false,false,false,false];
	function initSeg(){
		segX=300,segY=0;
		segX2=600,segY2=0;
		segX3=0,segY3=0;
		segX4=300,segY4=600;
	}
	
	
	
	
	
	var numOfSeg;
	var gameOver = false;
	var intervalId;
	var score = 0;
	function draw() {
		clear();
		context.fillStyle = "white";
		context.strokeStyle = "black";
		context.lineWidth = 1.2;
		rect(0, 0, WIDTH, HEIGHT);
		if(recurSeg&&!gameOver){
			score++;
			initSeg();
			document.getElementById("score").innerHTML = "<h3> &nbspScore: "+score.toString() +"</h3>";
			speed += 0.07;
			gen_seg = [false,false,false,false];
			recurSeg = false;
			numOfSeg =Math.floor(Math.random() * 3) + 1;
			console.log(numOfSeg);
			switch(numOfSeg){
				case 1:
					while(numOfSeg--){
						console.log("selecting at 1");
						var select = Math.floor(Math.random() * 4);
						if(gen_seg[select] == false)  gen_seg[select] = true;
					}
					break;
				case 2:
					while(numOfSeg--){
						console.log("selecting at 2");
						var select = Math.floor(Math.random() * 4);
						if(gen_seg[select] == false)  gen_seg[select] = true;
					}
					break;
				case 3:
					while(numOfSeg--){
						console.log("selecting at 3");
						var select = Math.floor(Math.random() * 4);
						if(gen_seg[select] == false)  gen_seg[select] = true;
					}
					break;
			}
		}
		console.log((gameOver == true?1:0));
		if(!gameOver){
			if(gen_seg[0] == true){
				segment1();
				
				if(segX < 90 && segY > 210 && y< 243  && segY < 220){
					gameOver = true;
					console.log("collision");
				}
			}
			if(gen_seg[1] == true) {
				segment2();

				if(segX2 < 390 && segY2 > 210 && x > 354  && segY2 < 220){
					gameOver = true;
					console.log("collision");
				}
				
			}
			if(gen_seg[2] == true){
				segment3();
				
				if(segX3 > 210 && segY3 > 210 && x < 240  && segY3 < 220){
					gameOver = true;
					console.log("collision");
				}
				
			}
			if(gen_seg[3] == true) {
				segment4();
				if(segX4 < 90 && segY4 > 380 && y > 350  && segY4 < 390){
					gameOver = true;
					console.log("collision");
				}
			}
		}else{
			clearInterval(intervalId);
			swal("Game Over!","�� ������ "+(score==-1?0:score.toString())+" �Դϴ�." , {
				  buttons: {
				    rank:{
				    	text: "��ŷ ���",
				    	value: "rank",
				    },
				    reGame: {
				      text: "�ٽ� �ϱ�",
				      value: "reGame",
				    },
				    �׸��ϱ�: true,
				  },
				})
				.then((value) => {
				  switch (value) {
				 
					
				 	
				    case "reGame":
				      gameOver = false;
				      initSeg();
				      startGame();
				      break;
				    case "rank":
						registerRanking(score);
				    default:
				      gameOver = false;
				  }
				});
		}
		
		drawField();
		context.lineWidth = 0.1;
		rect2(300-50*Math.tan(Math.PI/4),300-50*Math.tan(Math.PI/4),100*Math.tan(Math.PI/4),100*Math.tan(Math.PI/4));
		context.fillStyle = "#8e44ad";
		circle(x, y, 10);
		context.fillStyle = "#3498db";
		
		//test code
	}
	
	
	var context;
	var canvas;
	function startGame() {
		speed = 1;
		score = -1;
		gameOver = false;
		initSeg();
		document.getElementById("drawCanvas").innerHTML = '<input type="button" class="btn btn-primary btn-xl rounded-pill mt-5" onclick="startGame()" value="���� ����" style="margin-bottom: 20px;"><br>'
		+'<div style="font-family: Noto Sans KR; color: white; width: 500px; height: 3em;text-align: right; padding-right: 300px; margin-left: 25%; vertical-align: middle;margin-right: 200px;" id="score"><h3> &nbspScore: 0</h3></div>' 
		+'<canvas width="600" height="600" id="MyCanvas" style="text-align: center !important;"></canvas>';
		canvas = document.getElementById("MyCanvas");
		context = canvas.getContext("2d");
		document.getElementById("tableWrap").style["visibility"] = "visible";
		document.getElementById("tableWrap").style["width"] = "25%";
		document.getElementById("tableWrap").style["float"] = "left";
		document.getElementById("tableWrap").style["padding-left"] = "3em";
	
		intervalId = setInterval(draw, 1000 / 60);
		rankingComposition();
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
					<li class="nav-item"><a class="nav-link" href="./Board.jsp">�Խ���</a></li>
					<li class="nav-item"><a class="nav-link" href="./SignUpPage.jsp">ȸ������</a></li>
					<li class="nav-item"><a class="nav-link" href="./LoginPage.jsp">�α׾ƿ�</a></li>
					<li class="nav-item"><a class="nav-link" href="javascript:void(0);" onclick="withdrawal()">ȸ��Ż��</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<header class="masthead text-center text-white" style="padding-top: 125px;">
		<div class="container masthead-content" id="tableWrap" style="font-family: 'Noto Sans KR', sans-serif !important; visibility: hidden; height: 75%; margin-left: 10%;">
			<br>
			<table class="table table-stripted" style="color: white !important; width: 220px; text-align: center; padding-right: 0;" id="tableWrap">
				<thead style="font-weight: bolder;">
					<tr>
						<th>&nbsp&nbsp#&nbsp</th>
						<th>user</th>
						<th>score</th>
					</tr>
				</thead>
				<tbody id="table_body">
					
				</tbody>
			</table>
		</div>
		<div class="masthead-content" id="drawCanvas">

			<div class="container">
				<h1 class="masthead-heading mb-0">ȯ���մϴ�!</h1>
				<h2 class="masthead-subheading mb-0" id="welcome"><%=id%>�� �ȳ��ϼ���!
				</h2>
				<input type="button" class="btn btn-primary btn-xl rounded-pill mt-5" onclick="startGame()" value="���� ����">
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
