<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="tdao" class="com.table.TableDAO" scope="session"></jsp:useBean>
<%
String tId=request.getParameter("tId");
String tPwd=request.getParameter("tPwd");
//System.out.println(tId+tPwd);

int tNum=tdao.userCheck(tId, tPwd);
if(tNum!=0){
	session.setAttribute("tNum", tNum);
	%>
<script>
location.href="../user/userEnter.jsp";
</script>
	<%
}else{
	%>
	<script>
	window.alert('아이디 또는 비밀번호가 잘못되었습니다.');
	location.href='userLogin.jsp'
	</script>
	<%
}
%>