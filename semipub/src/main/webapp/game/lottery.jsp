<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로또 번호 추출하기</title>
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
<body>
	<%@include file="/userHeader.jsp" %>
	<section>
		<article>
			<div class="topSide">
			</div>
		</article>
		<article>
		    <div class="centerSide">
		    	<h2>로또 번호 추출하기</h2>
		    	<div class="tableArea">
		    		<table>
		    			<tr>
		    				<td id="num1"><div id="lotto1"></div></td>
		    				<td id="num2"><div id="lotto2"></div></td>
		    				<td id="num3"><div id="lotto3"></div></td>
		    				<td id="num4"><div id="lotto4"></div></td>
		    				<td id="num5"><div id="lotto5"></div></td>
		    				<td id="num6"><div id="lotto6"></div></td>
		    			</tr>
		    		</table>
		    		<div>
		    			<input type="button" value="로또번호 뽑기" id="button" onclick="getLottery()">
		    		</div>
		    	</div>
		    </div>
		</article>
		<%@include file="/bottomSide.jsp" %>
	</section>
	<script>
		function getLottery(){
			location.href = 'lotteryResult.jsp';
		}
		function lottery(){
			var num = Math.floor(Math.random()*45)+1
			document.getElementById('lotto1').textContent = num;
			document.getElementById('lotto2').textContent = num;
			document.getElementById('lotto3').textContent = num;
			document.getElementById('lotto4').textContent = num;
			document.getElementById('lotto5').textContent = num;
			document.getElementById('lotto6').textContent = num;
		}
		
		setInterval(lottery,100);
	</script>
</body>
</html>