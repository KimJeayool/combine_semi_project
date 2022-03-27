<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로또 번호 결과</title>
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
			font-size: 40px;
			padding-top: 30px;
		}
		.tableArea {
			text-align: center;
		}
		.tableArea table{
			width: 1000px;
			margin: 50px auto;
			border-spacing: 30px;
		}
		table td{
			text-align: center;
			font-size: 100px;
			border-radius: 50%;
			width: 120px;
		}
		#num1{
			background-color: red;
		}
		#num2{
			background-color: yellow;
		}
		#num3{
			background-color: blue;
		}
		#num4{
			background-color: green;
		}
		#num5{
			background-color: pink;
		}
		#num6{
			background-color: orange;
		}
		#button{
			font-size: 30px;
			background-color: skyblue;
		}
	</style>
</head>
<%
int lotto[] = new int[6];

for(int i=0; i<lotto.length; i++) {
	lotto[i] = (int)(Math.random()*45+1);
	
	for(int j=0; j<i; j++) {
		if(lotto[i]==lotto[j]) {
			i--;
			break;
		}
	}
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
		    	<h2>당신의 당첨 번호</h2>
		    	<h2>이 번호로 부자 되세요!</h2>
		    	<div class="tableArea">
		    		<table>
		    			<tr>
		    				<td id="num1"><div id="lotto1"><%=lotto[0] %></div></td>
		    				<td id="num2"><div id="lotto2"><%=lotto[1] %></div></td>
		    				<td id="num3"><div id="lotto3"><%=lotto[2] %></div></td>
		    				<td id="num4"><div id="lotto4"><%=lotto[3] %></div></td>
		    				<td id="num5"><div id="lotto5"><%=lotto[4] %></div></td>
		    				<td id="num6"><div id="lotto6"><%=lotto[5] %></div></td>
		    			</tr>
		    		</table>
		    		<div>
		    			<input type="button" value="게임목록" id="button" onclick="gameList()">
		    		</div>
		    	</div>
		    </div>
		</article>
		<%@include file="/bottomSide.jsp" %>
	</section>
	<script>
		function gameList(){
			location.href = 'gameList.jsp';
		}
	</script>
</body>
</html>