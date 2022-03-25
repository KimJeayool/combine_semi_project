<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 화면</title>
  <style>
    body {
      background-color: black;
      color: white;
      text-align: center;
    }
    h1{
      margin-top: 50px;
      font-size: 80px;
    }
    h2{
      margin-top: 30px;
      margin-bottom: 40px;
    }
    img{
      width: 150px;
      height: 150px;
    }
    .userClick{
      display: flex;
      justify-content: center;
    }
    .userIcon{
      width: 230px;
    }
    a:link{
      font-weight: bold;
      text-decoration: none;
      color: white;
    }
    a:hover{
      background-color: blanchedalmond;
      color:black;
    }
    ul{
   	  list-style:none;
   }
.login-page {
  width: 360px;
  margin: auto;
}
.form input {
  font-family: "Roboto", sans-serif;
  outline: 0;
  background: #f2f2f2;
  width: 100%;
  border: 0;
  margin: 0 0 15px;
  padding: 15px;
  box-sizing: border-box;
  font-size: 14px;
}
.button {
  font-family: "Roboto", sans-serif;
  text-transform: uppercase;
  outline: 0;
  background: white;
  width: 100%;
  border: 0;
  padding: 15px;
  color: black;
  font-size: 14px;
  -webkit-transition: all 0.3 ease;
  transition: all 0.3 ease;
  cursor: pointer;
}
.form button:hover,.form button:active,.form button:focus {
  background: white;
}
.form .message {
  margin: 15px 0 0;
  color: #b3b3b3;
  font-size: 12px;
}
.form .message a {
  color: #4CAF50;
  text-decoration: none;
}
.form .register-form {
  display: none;
}
.container {
  position: relative;
  z-index: 1;
  max-width: 300px;
  margin: 0 auto;
}
.container:before, .container:after {
  content: "";
  display: block;
  clear: both;
}
.container .info {
  margin: 50px auto;
  text-align: center;
}
.container .info h1 {
  margin: 0 0 15px;
  padding: 0;
  font-size: 36px;
  font-weight: 300;
  color: #1a1a1a;
}
.container .info span {
  color: #4d4d4d;
  font-size: 12px;
}
.container .info span a {
  color: #000000;
  text-decoration: none;
}
.container .info span .fa {
  color: #EF3B3A;
}
#back{
	text-align: center;
	width: 70px;
    height: 40px;
    background-color: gray;
    color: white;
}
  </style>
</head>
<script>
function checkValue(obj){
	obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
}
</script>
<body>
  <header>
    <h1>SEMI Pub</h1>
    <h2><img src="../img/staff.png" alt="직원"></h2>
    <h3>관리자 로그인</h3>
    <div>
    <div class="login-page">
  <div class="form">
    <form class="login-form" action="adminLogin_ok.jsp" method="post">
      <input type="text" name="aId" id="aId" placeholder="id" onkeydown="checkValue(this)" required/>
      <input type="password" name="aPwd" id="aPwd" placeholder="password" onkeydown="checkValue(this)" required/>
      <input type="submit" name="button" value="로그인">
    </form>
  </div>
  <div>
  	<input type="button" name="back" id="back" value="뒤로가기"  onclick="location.href='../index.jsp'">
  </div>
</div>
    </div>
  </header>
</body>