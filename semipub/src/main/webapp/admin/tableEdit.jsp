<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.table.*" %>
<jsp:useBean id="tdao" class="com.table.TableDAO"></jsp:useBean>

<!-- Access Check -->
<%@ include file="/login/adminAccessModule.jsp" %>
<!-- Access for manager -->
<%@include file="/onlyManager.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테이블 정보 수정</title>
<link rel="stylesheet" type="text/css" href="/semipub/css/mainLayout.css">
<style>
h2{
	font-size: 40px;
 	text-align:center;
 	padding-top: 30px;
}
table{
	width: 350px;
	height: 150px;
	margin: 40px auto;
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
String tNum=request.getParameter("tNum");
String tId=request.getParameter("tId");
String tPwd=request.getParameter("tPwd");
%>
<body>
<%@include file="/header.jsp"  %>
<section>
	<%@include file="memberTopSide.jsp" %>		
	<article>
		<div class="centerSide">
		<h2><%=tNum %>번 테이블 수정</h2>
		<form name="tableEdit" action="tableEdit_ok.jsp">
		<input type="hidden" name="tNum" value="<%=tNum%>">
			<table>
				<tbody>
				<tr>
					<td>아이디: </td>
					<td><input type="text" name="tId"  value="<%=tId%>"></td>
				</tr>
				<tr>
					<td>비밀번호: </td>
					<td><input type="text" name="tPwd"  value="<%=tPwd%>"></td>
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