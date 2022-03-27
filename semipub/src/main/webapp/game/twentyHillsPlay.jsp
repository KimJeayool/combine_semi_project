<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>스무고개 게임</title>
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
		padding: 20px;
	}
	.tableArea table{
		margin: 0px auto;
		border-spacing: 10px;
		text-align: center;
	}
	.imgArea:hover{
		background-color: yellow;
	}
	table img{
		width: 300px;
	}
	.inputArea{
		font-size: 20px;
		margin: 10px;
	}
	</style>
</head>
<%
request.setCharacterEncoding("UTF-8"); // To Get KOREAN Answer

// Change name to Hide Answer (play1->target)
String play1 = request.getParameter("play1");
String target = "";
if(play1!=null){
	target = play1;
}else{
	target = java.net.URLDecoder.decode(request.getParameter("target"));
}

int count = 20; // Count 20->0
String s_count = request.getParameter("count");
if(s_count!=null){
	count = Integer.parseInt(s_count);
	count--;
}

String img = request.getParameter("img");
%>
<body onload="endGame()">
	<%@include file="/userHeader.jsp" %>
	<section>
		<article>
			<div class="topSide">
			</div>
		</article>
		<article>
			<div class="centerSide">
			<h2>play2는 play1에게 질문을 해 주세요.</h2>
			<h2>남은 기회 : <%=count %></h2>
			<div class="tableArea">
				<form name="fm" action="twentyHillsPlay_ok.jsp">
					<input type="hidden" name="target" value="<%=target %>">
					<input type="hidden" name="count" value="<%=count %>">
					<input type="hidden" name="img" value="<%=img %>">
					<table>
						<tr>
							<td onclick="minusCount()" class="imgArea"><img src="img/yes.png"></td>
							<td onclick="minusCount()" class="imgArea"><img src="img/no.png"></td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="text" name="user" class="inputArea" required>
								<input type="submit" value="정답" class="inputArea"> 
							</td>
						</tr>
					</table>
				</form>
			</div>
			</div>
		</article>
		<%@include file="/bottomSide.jsp" %>
	</section>
	<script>
		history.replaceState({},null,location.pathname); //Hide Parameter Value
		
		function minusCount(){
			window.location.href = 'twentyHillsPlay.jsp?count=<%=count %>&target=<%=target %>&img=<%=img%>';
		}
		function endGame(){
			if(<%=count%>==0){
				window.location.href = 'twentyHillsPlay_ok.jsp?target=<%=target %>&img=<%=img %>&count=0'
			}
		}
	</script>
</body>
</html>