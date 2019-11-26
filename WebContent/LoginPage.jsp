<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<base href="<%=basePath%>">
<title>Insert title here</title>
</head>
<body>
<% String id = (String) session.getAttribute("id"); %>
<% String password = (String) session.getAttribute("pwd"); %>
<p id="login_id"></p><br>
<p id="name"></p><br>
<p id="major"></p><Br>
<p id="grade"></p><br>
<p id="sex"></p><br>
<p id="hobby"></p><br>
<p id="last"></p><br>

 비밀번호: <input type="text" id="pwd">   
<input type="button" onclick="myUpdate()" value="삭제"> 

 <script src="https://www.gstatic.com/firebasejs/5.5.9/firebase.js"></script>
<script>
  // Initialize Firebase
  var config = {
    apiKey: "AIzaSyB9FAQHX4YLPYdMKZUHqa_Oyq2PX5cprj8",
    authDomain: "week12-2-ab211.firebaseapp.com",
    databaseURL: "https://week12-2-ab211.firebaseio.com",
    projectId: "week12-2-ab211",
    storageBucket: "week12-2-ab211.appspot.com",
    messagingSenderId: "210632559462"
  };
  firebase.initializeApp(config);
</script>

  <script>
  

  
var id = <%=id %>;
var pwd = <%=password %>;
document.getElementById("login_id").innerHTML = "ID: " + id;
  
var user_data = firebase.database().ref('user_data/');


user_data.once('value', function(snapshot) {
    snapshot.forEach(function(childSnapshot) {
      var tmp = childSnapshot.val();
      if(tmp.user_id==id)
        document.getElementById("last").innerHTML = tmp.last_login;
    });
  });

var user_ref = firebase.database().ref('user_profile/'+id);
user_ref.once('value', function(snapshot) {
		    var tmp = snapshot.val();
			    document.getElementById("name").innerHTML = "이름: "+tmp.user_name;
  			    document.getElementById("sex").innerHTML = "성별: "+tmp.user_sex;
  			    document.getElementById("major").innerHTML = "전공: "+tmp.user_major;
  			    document.getElementById("grade").innerHTML = "학년: "+tmp.user_grade;
  			    document.getElementById("hobby").innerHTML = "관심사: "+tmp.user_hobby;
		  });
		 
		  
function myUpdate(){
	if(document.getElementById("pwd").value == pwd){
		var user_data = firebase.database().ref('user_data/'+id);
		user_data.remove();
		var user_prof = firebase.database().ref('user_profile/'+id);
		user_prof.remove();
		alert("변경 완료");
	}
	else alert("비밀번호가 틀렸습니다.");

}

  </script> 
</body>
</html>