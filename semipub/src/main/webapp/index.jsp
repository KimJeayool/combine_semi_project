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
      margin-top: 90px;
      font-size: 80px;
    }
    h2{
      margin-top: 30px;
      margin-bottom: 80px;
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
  </style>
</head>
<body>
  <header>
    <h1>SEMI Pub</h1>
    <h2>USER 선택하여 로그인하십시오.</h2>
    <div class="userClick">
      <a href="login/userLogin.jsp">
        <div class="userIcon">
          <img src="img/client.png" alt="손님">
          <p>손님</p>
        </div>
      </a>
      <a href="login/adminLogin.jsp">
        <div class="userIcon">
          <img src="img/staff.png" alt="직원">
          <p>직원</p>
        </div>
      </a>
    </div>
  </header>
</body>
</html>