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
<title>직원 등록</title>
<link rel="stylesheet" type="text/css" href="/semipub/css/mainLayout.css">
<style>
h2{
	font-size: 30px;
 	text-align:center;
}
table{
	width: 350px;
	height: 250px;
	margin: 0px auto;
	font-size: 18px;
}
#menu_tag5{
	background-color: red;
	color: white; 
}
form{
	margin-top: 20px;
}
#addbutton{
	text-align: center;
	width: 70px;
    height: 35px;
    background-color: gray;
    color: white;
}
</style>
</head>
<script>
function openIdCheck(){
	window.open('../login/idCheck.jsp','idCheck','width=450,height=150');
}
function checkValue(obj){
	obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
}
</script>
<body>
<%@include file="/header.jsp"  %>
<section>
	<article>
		<div class="topSide">		
		</div>
	</article>
	<article>
		<div class="centerSide">
		<h2>직원 등록</h2>
		<form name="memberAdd" action="memberAdd_ok.jsp">
		<table>
			<tbody>
				<tr>
					<td>아이디 </td>
					<td><input type="text" name="aId" onkeydown="checkValue(this)" readonly>
					<input type="button" value="중복검사" onclick="openIdCheck()">
					</td>
				</tr>
				<tr>
					<td>비밀번호 </td>
					<td><input type="text" name="aPwd" onkeydown="checkValue(this)"></td>
				</tr>
				<tr>
					<td>이름 </td>
					<td><input type="text" name="name"></td>
				</tr>
				<tr>
					<td>직급 </td>
					<td>
						<select name="lev">
							<option value="스탭">스탭</option>
							<option value="관리자">관리자</option>
						</select>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="등록" id="addbutton">
						<input type="button" value="취소" id="addbutton" onclick="location.href='memberList.jsp'">
					</td>
				</tr>
			</tfoot>
		</table>
		</form>
	</div>
	</article>
	<%@include file="/bottomSide.jsp" %>
</section>
</body>
</html>