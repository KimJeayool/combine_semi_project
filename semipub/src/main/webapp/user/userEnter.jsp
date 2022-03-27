<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.guest.*" %>
<jsp:useBean id="tdao" class="com.table.TableDAO" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html lang="ko">
<%
int tNum=(int)(session.getAttribute("tNum"));
%>
<head>
  <meta charset="UTF-8">
  <title>테이블 입장 화면</title>
  <style>
    body {
      background-color: black;
      color: white;
      text-align: center;
    }
    h1{
      margin-top: 110px;
      font-size: 80px;
    }
    h2{
      margin-top: 30px;
      margin-bottom: 80px;
    }
    input[type="button" i]{
      width: 200px;
      height: 50px;
      font-size: 30px;
      color: white;
      background-color: rgb(0, 156, 218);
      border-radius: 20px;
    }
  </style>
  <script>
    function toMain() {
      window.location.href = 'tableMain.html';
    }
  </script>
</head>
<body>
  <h1>SEMI PUB</h1>
  <h2><%=tNum%>번 테이블에 오신걸 환영합니다.</h2>
  <div>
    <input type="button" value="방 입장" onclick="location.href='userEnter_ok.jsp'">
  </div>
</body>
</html>