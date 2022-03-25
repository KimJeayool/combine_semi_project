<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.member.*" %>
<jsp:useBean id="mdao" class="com.member.MemberDAO" scope="session"></jsp:useBean>
<%
String aId=request.getParameter("aId");
String aPwd=request.getParameter("aPwd");
MemberDTO dto =mdao.adminCheck(aId, aPwd);

if(dto!=null){
	session.setAttribute("sname", dto.getName());
	session.setAttribute("saidx", dto.getaIdx());
	session.setAttribute("slev", dto.getLev());
	%>
<script>
//location.href="../order/orderList_all.jsp";
location.href="/semipub/order/orderList.jsp";
</script>
	<%
}else{
	%>
	<script>
	window.alert('아이디 또는 비밀번호가 잘못되었습니다.');
	location.href='adminLogin.jsp'
	</script>
	<%
}
%>