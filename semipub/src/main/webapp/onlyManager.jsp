<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String slev=(String)session.getAttribute("slev");
if(slev==null||slev.equals("")){
	%>
	<script>
		window.alert('관리자 로그인이 필요한 페이지입니다.');
		window.location.href='/semipub/index.jsp';
	</script>
	<%
}else if (!slev.equals("관리자")){
	%>
	<script>
	window.alert('관리자만 접근 가능합니다.');
	location.href='/semipub/order/orderList.jsp'
	</script>
	<%
	return;
}
%>