<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- Access Check -->
<%@ include file="/login/adminAccessModule.jsp" %>

<!-- Access for manager -->
<%@include file="/onlyManager.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>테이블 추가</title>
	<link rel="stylesheet" type="text/css" href="/semipub/css/mainLayout.css">
	<style>
		#menu_tag2{
			background-color: red;
			color: white;
		}
		#menu_tag2:hover {
			background-color: skyblue;
			color: black;
		}
		h2{
			text-align: center;
			font-size: 40px;
			padding-top: 10vh;
			padding-bottom: 5vh;
		}
		fieldset{
			margin: 0px auto;
			width: 600px;
		}
		fieldset li{
			list-style-type: none;
			font-size: 30px;
			margin: 20px 0px;
		}
		fieldset label{
			width: 150px;
			float: left;
		}
		.textBox{
			font-size: 30px;
		}
		form div{
			clear: both;
			text-align: center;
			margin: 30px;
		}
		#button{
			width: 100px;
			font-size: 25px;
			font-weight: bold;
			background-color: skyblue;
		}
		#button:hover{
			background-color: red;
			color: white;
		}

	</style>
</head>
<%
//Get Last Table Number
String s_maxNum = request.getParameter("maxNum");
if(s_maxNum==null || s_maxNum.equals("")){
	s_maxNum = "0";
}

int tNum = Integer.parseInt(s_maxNum); //Next Table Number to ADD
%>
<body>
	<%@include file="/header.jsp" %>
	<section>
		<article>
	  		<div class="topSide">
	  		</div>
		</article>
		<article>
			<div class="centerSide">
				<h2>&lt;<%=tNum  %>&gt; 번 테이블 추가</h2>
				<form name="tableAdd" method="post" action="tableAdd_ok.jsp">
					<input type="hidden" name="tNum" value="<%=tNum%>">
					<fieldset>
						<ul>
							<li>
								<label>아이디</label>
								<input type="text" style='IME-MODE: disabled' name="tId" class="textBox" id="tableId"  minlength="4" maxlength="10" placeholder="아이디를 입력해 주세요" onkeydown="checkValue(this)" required>
							</li>
							<li>
								<label>비밀번호</label>
								<input type="password" style='IME-MODE: disabled' name="tPwd" id="tablePwd" class="textBox" minlength="4" maxlength="12"  placeholder="비밀번호를 입력해 주세요" onkeydown="checkValue(this)" required>
							</li>					
						</ul>
					</fieldset>
					<div>
						<input type="submit" value="등록" id="button" onclick="return checkValue()">
					</div>
				</form>
			</div>
		</article>
	<%@include file="/bottomSide.jsp" %>
	</section>
	<script>
		function checkValue(obj) {
			obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g,'');
		}
	</script>
</body>
</html>