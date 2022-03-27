<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.member.*" %>
<jsp:useBean id="mdao" class="com.member.MemberDAO"></jsp:useBean>

<!-- Access Check -->
<%@ include file="/login/adminAccessModule.jsp" %>
<!-- Access for manager -->
<%@include file="/onlyManager.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>직원 정보 수정</title>
	<link rel="stylesheet" type="text/css" href="/semipub/css/mainLayout.css">
	<style>
h2{
	font-size: 40px;
 	text-align:center;
 	padding-top: 30px;
}
table{
	width: 350px;
	height: 250px;
	margin: 20px auto;
	font-size: 18px;
}
#menu_tag5{
	background-color: red;
	color: white; 
}
form{
	margin-top: 20px;
}
#editbutton{
	text-align: center;
	width: 70px;
    height: 35px;
    background-color: white;
	border-radius: 20px;
}

	</style>
</head>
<%
String aIdx=request.getParameter("idx");
String aId=request.getParameter("id");
String aPwd=request.getParameter("pwd");
String name=request.getParameter("name");

%>
<body>
<%@include file="/header.jsp"  %>
<section>
	<article>
		<div class="topSide">		
		</div>
	</article>
	<article>
		<div class="centerSide">
		<h2>직원 수정</h2>
		<form name="memberEdit" action="memberEdit_ok.jsp">
		<input type="hidden" name="aIdx" value="<%=aIdx%>">
			<table>
				<tbody>
				<tr>
					<td>아이디: </td>
					<td><input type="text" name="aId"  value="<%=aId%>"></td>
				</tr>
				<tr>
					<td>비밀번호: </td>
					<td><input type="text" name="aPwd"  value="<%=aPwd%>"></td>
				</tr>
				<tr>
					<td>이름: </td>
					<td><input type="text" name="name"  value="<%=name%>"></td>
				</tr>
				<tr>
					<td>직급선택: </td>
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
				<input type="submit" value="수정" id="editbutton">
				<input type="button" value="취소" id="editbutton" onclick="location.href='memberList.jsp'">
					</td>
				</tr>
			</tfoot>	
		</table>
		</form>
	</div>
	</article>
	<%@include file="/bottomSide.jsp"%>
</section>
</body>
</html>