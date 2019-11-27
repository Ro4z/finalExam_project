<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<base href="<%=basePath%>">
<title>Insert title here</title>
</head>
<script src="https://www.gstatic.com/firebasejs/5.5.9/firebase.js"></script>
<script>
	// Initialize Firebase
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

<body>

	<%
		String id = (String) session.getAttribute("id");
	%>
	<%
		String password = (String) session.getAttribute("pwd");
	%>
	
	<div id="login_id"></div>
	<div id="login_pwd"></div>

	<script>
		var id = "<%=id%>";
		var pwd ="<%=password%>";
		document.getElementById("login_id").innerHTML = "ID: " + id;
		document.getElementById('login_pwd').innerHTML = "PW: " + pwd;
	</script>
</body>
</html>