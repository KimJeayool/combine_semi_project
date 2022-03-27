<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%
String target = request.getParameter("target");
String user = request.getParameter("user");
System.out.println(target);//test code
String img = request.getParameter("img");
String s_count = request.getParameter("count");
if(s_count==null) s_count = "0";
int count = Integer.parseInt(s_count);

// IF Count 0
String msg = "축하합니다! 정답입니다.";
if(user==null){
	user = target;
	msg = "아쉽게 실패하셨습니다.";
}

if(!user.equals(target)){
	
	response.sendRedirect("twentyHillsPlay.jsp?count="+count+"&target="+java.net.URLEncoder.encode(target)+"&img="+img);
}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>스무고개 발표</title>
	<script>
		history.replaceState({},null,location.pathname); //Hide Parameter Value

		function gameList(){
			window.location.href = 'gameList.jsp';
		}
	</script>
	<link rel="stylesheet" type="text/css" href="/semipub/css/mainLayout.css">
	<style>
	#menu_tag3{
		background-color: red;
		color: white;
	}
	#menu_tag3:hover {
		background-color: skyblue;
		color: black;
	}
	h2, div{
		text-align: center;
	}
	h2{
		font-size: 45px;
		padding-top: 20px;
	}
	div img{
		width: 300px;
		margin: 30px;
	}
	div{
		font-size: 30px;
		font-weight: bold;
	}
	#button{
		font-size: 25px;
		background-color: skyblue;
		margin: 20px;
	}
	#button:hover{
		background-color: yellos;
	}
	</style>
</head>
<body onload="checkResult()">
	<%@include file="/userHeader.jsp" %>
	<section>
		<article>
			<div class="topSide">
			</div>
		</article>
			<div class="centerSide">
				<h2>결과</h2>
				<div><img src="<%=img%>"></div>
				<div><%=target %></div>
				<div><%=msg %></div>
				<div>
					<input type="button" value="게임목록" onclick="gameList()" id="button">
				</div>
			</div>
		<%@include file="/bottomSide.jsp" %>
	</section>
</body>
</html>