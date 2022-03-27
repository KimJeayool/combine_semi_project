<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		font-size: 45px;
		padding-top: 30px;
	}
	.explain{
		text-align: center;
		font-size: 20px;
		margin: 10px;
	}
	table{
		margin: 0px auto;
		text-align: center;
		border-spacing: 10px;
	}
	.imgArea{
		width: 600px;
		height: 300px;
	}
	.imgArea img{
		width: 290px;
	}
	.inputBox{
		font-size: 20px;
	}
	</style>
</head>
<%
String name = request.getParameter("name");
if(name==null || name.equals("")){
	name="";
}

String img = "";
String subject = request.getParameter("subject");
if(subject==null || subject.equals("")){
	img="";
	subject="";
}else{
	img ="img/" + subject + ".png";
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
			<h2>스무고개 게임</h2>
			<div class="explain">player1은 주제를 선택하여 정답을 입력해 주세요.</div>
			<div class="tableArea">
				<table>
					<tr>
						<td class="imgArea" id="img">
							<img src="<%=img %>">
						</td>
					</tr>
					<tr>
						<td>
							<form name="hill" action="twentyHillsPlay.jsp" method="post">
							<input type="hidden" name="img" value="<%=img %>">
							<select name="subject" id="subject" onchange="changeImg()" class="inputBox">
								<option value="" >선택</option>
								<option value="ta" <%=subject.equals("ta")? "selected":"" %>>인물</option>
								<option value="tb" <%=subject.equals("tb")? "selected":"" %>>음식</option>
								<option value="tc" <%=subject.equals("tc")? "selected":"" %>>도구</option>
								<option value="td" <%=subject.equals("td")? "selected":"" %>>지역</option>
								<option value="te" <%=subject.equals("te")? "selected":"" %>>교통</option>
								<option value="tf" <%=subject.equals("tf")? "selected":"" %>>명칭</option>
							</select>
							<input type="text" name="play1" value="<%=name%>" class="inputBox" required>
							<input type="submit" value="결정" class="inputBox">
							</form>
						</td>
					</tr>
				</table>
			</div>
			</div>
		</article>
		<%@include file="/bottomSide.jsp" %>
	</section>
	<script>
		function changeImg(){
			var subject = document.getElementById('subject').value;
			window.location.href = 'twentyHills.jsp?name=<%=name%>&subject=' + subject ;
		}
	</script>
</body>
</html>