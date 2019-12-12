<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String can_sign_up = (String) session.getAttribute("canSignUp");
	String info = (String) session.getAttribute("info");
%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
<meta charset="utf-8">
<title></title>
<link rel="stylesheet" href="./css/signup.css">
<link href="https://fonts.googleapis.com/css?family=Permanent+Marker" rel="stylesheet">
<!-- The core Firebase JS SDK is always required and must be listed first -->
<script src="https://www.gstatic.com/firebasejs/7.5.0/firebase-app.js"></script>
<!-- sweetalert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- TODO: Add SDKs for Firebase products that you want to use
     https://firebase.google.com/docs/web/setup#available-libraries -->
<script src="https://www.gstatic.com/firebasejs/5.5.8/firebase.js"></script>

<!-- google recaptcha -->
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
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
	
	function init(){
		var canSignUp = "<%=can_sign_up%>";
		var user_info = "<%=info%>";
		var id = user_info.split("@")[0];
		var pw = user_info.split("@")[1];
		var name = user_info.split("@")[2];
		var email = user_info.split("@")[3];
		if(canSignUp == "true"){
            firebase.database().ref('/user_data/' + id).set({
                user_id: id,
                user_pw: pw,
            });
            firebase.database().ref('/user_profile/' + id).set({
            	user_id: id,
                user_name: name,
                user_email: email,
            });
        	swal({
				title : "가입 완료!",
				text : "정상적으로 회원가입 되었습니다!",
				icon : "success",
				timer : 2000,
				button : false
			})
			setTimeout(function() {
				window.location.href = "./LoginPage.jsp";
			}, 1300)
		}
	}
</script>
</head>
<body onload="init()">

	<script>
		
		var user_data = firebase.database().ref('user_data');
		function sign_up() {
			var id = document.getElementById("id").value;
			var pw = document.getElementById("pw").value;
			var name = document.getElementById('name').value;
			var email = document.getElementById('email').value;
			if(id=="admin"){
			   	swal({
					title : "관리자 아이디는 사용하실 수 없습니다.\n",
					text : "\n",
					icon : "warning",
					timer : 1200,
					button : false
				})
				return;
			}
			if(id==""||pw ==""||name==""||email==""){
				swal("","모든 정보를 입력해주세요.","warning");
				return;
			}
			
			var canSignUp = true;
			
			user_data.once('value', (snapshot) => {
		            snapshot.forEach((node) => {
		                console.log(node.val().user_id);
		                if(node.val().user_id === id) {
		                	swal({
								title : "이미 존재하는 ID 입니다.\n",
								text : "\n",
								icon : "error",
								timer : 1300,
								button : false
							});
		                    canSignUp = false;
		                }
		            });
		            var response = grecaptcha.getResponse();
		            if(canSignUp) {
		            	if(response.length ==0){
		    			    //reCaptcha not verified
		    			   	swal({
		    					title : "reCAPTCHA 인증이 되지 않았습니다.\n",
		    					text : "\n",
		    					icon : "error",
		    					timer : 1300,
		    					button : false
		    				})
		            	}
		            	else{
		            		
		            		var user_info = "";
		            		user_info = id+"@"+pw+"@"+name+"@"+email;
		            		var form = document.createElement("form");
		            		form.setAttribute("method", "post");
		            		form.setAttribute("action", "./HashingServlet");
		            		 
		            		var Field = document.createElement("input");
		            		Field.setAttribute("type", "hidden");
		            		Field.setAttribute("name", "info");
		            		Field.setAttribute("value", user_info);
		            		 
		            		form.appendChild(Field);
		            		 
		            		document.body.appendChild(form);
		            		form.submit();
		            		
		            		
		            		

		            	}
		            	

		            }
		        });
		}
	</script>
	<div class="signup-form">
		<form class="" action="index.html" method="post">
			<h1>회원가입</h1>
			<input type="text" placeholder="ID" id="id" class="txtb">
			<input type="password" placeholder="Password" id="pw" class="txtb">
			<input type="email" placeholder="Email" id="email" class="txtb">
			<input type="text" placeholder="NickName" id="name" class="txtb">
			<br>
			<div class="g-recaptcha" data-sitekey="6Lee0MQUAAAAACXcFJ63NV1v4rArxojzdnFkInR7"></div>
			<input type="button" onclick="sign_up()" value="계정 만들기" class="signup-btn">
			<a href="javascript:history.back()">로그인 화면으로 이동하기</a>
		</form>

	</div>
</body>
</html>
