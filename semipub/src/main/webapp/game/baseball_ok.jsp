<%@page import="java.util.concurrent.atomic.AtomicInteger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>야구 게임 결과 페이지</title>
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
	h2{
		text-align: center;
		padding: 30px;
		font-size: 45px;
	}
	table{
		margin: 0px auto;
		width: 600px;
		border-spacing: 10px;
	}
	table td{
		text-align: center;
		width: 50%;
	}
	#result{
		font-size: 40px;
		font-weight: bold;
	}
	table img{
		width: 70px;
	}
	.score{
		font-size: 50px;
		font-weight: bold;
	}
   	#button{
      font-size: 40px;
      font-weight: bold;
      background-color: yellow;
      margin: 20px;
      border-radius: 10px;
    }
    #button:hover{
      background-color: red;
    }
    #button:active{
      background-color: yellow;
    }
	</style>
</head>
<%
int count = Integer.parseInt(request.getParameter("count"));
int s = Integer.parseInt(request.getParameter("s"));
int b = Integer.parseInt(request.getParameter("b"));

String msg = "아쉽게 실패하셨습니다.";
if(s==3){
	msg = "축하합니다. 성공하셨습니다."; 
}
%>
<body>
	<%@include file="/userHeader.jsp" %>
	<section>
		<article>
			<div class="topSide">
			</div>
		</article>
		<article>
			<div class="centerSide">
				<h2>결과</h2>
				<div class="tableArea">
					<table>
						<tr>
							<td colspan="2" id="result"><%=msg %></td>
						</tr>
						<tr>
							<td><img alt="s" src="img/s.png"></td>
							<td class="score"><%=s %></td>
						</tr>
						<tr>
							<td><img alt="b" src="img/b.png"></td>
							<td class="score"><%=b %></td>
						</tr>
						<tr>
							<td colspan="2">							
								<input type="button" id="button" value="게임목록" onclick="gameList()">
							</td>
						</tr>
					</table>
				</div>
			</div>
		</article>
		<%@include file="/bottomSide.jsp" %>
	</section>
	<script>
		function gameList(){
			window.location.href = 'gameList.jsp';
		}
	</script>
</body>
</html>