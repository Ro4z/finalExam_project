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

 ��й�ȣ: <input type="text" id="pwd">   
<input type="button" onclick="myUpdate()" value="����"> 

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
			    document.getElementById("name").innerHTML = "�̸�: "+tmp.user_name;
  			    document.getElementById("sex").innerHTML = "����: "+tmp.user_sex;
  			    document.getElementById("major").innerHTML = "����: "+tmp.user_major;
  			    document.getElementById("grade").innerHTML = "�г�: "+tmp.user_grade;
  			    document.getElementById("hobby").innerHTML = "���ɻ�: "+tmp.user_hobby;
		  });
		 
		  
function myUpdate(){
	if(document.getElementById("pwd").value == pwd){
		var user_data = firebase.database().ref('user_data/'+id);
		user_data.remove();
		var user_prof = firebase.database().ref('user_profile/'+id);
		user_prof.remove();
		alert("���� �Ϸ�");
	}
	else alert("��й�ȣ�� Ʋ�Ƚ��ϴ�.");

}

  </script> 
</body>
</html>