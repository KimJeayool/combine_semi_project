<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String adminCheck = (String)session.getAttribute("sname");
if(adminCheck==null||adminCheck.equals("")){
	%>
	<script>
		window.alert('관리자 로그인이 필요한 페이지입니다.');
		window.location.href='/semipub/index.jsp';
	</script>
	<%
}
%>