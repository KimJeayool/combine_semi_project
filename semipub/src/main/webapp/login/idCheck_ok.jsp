<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="com.member.MemberDAO"></jsp:useBean>
<%
String userid=request.getParameter("id");
boolean result=mdao.idCheck(userid);
if(result){
	%>
	<script>
	window.alert('<%=userid%>는 이미 가입되어있는 아이디입니다.');
	location.href='idCheck.jsp';
	</script>
	<%
}else{
	%>
	<script>
	window.alert('<%=userid%>는 사용가능한 아이디입니다.');
	opener.document.memberAdd.aId.value='<%=userid%>';
	window.self.close();
	</script>
	<%
}
%>