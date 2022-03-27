<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String userCheck = ""+session.getAttribute("tNum");
if(userCheck==null||userCheck.equals("")){
	%>
	<script>
		window.alert('사용자 로그인이 필요한 페이지입니다.');
		window.location.href='/semipub/index.jsp';
	</script>
	<%
}
%>