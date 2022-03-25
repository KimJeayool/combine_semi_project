<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdto" class="com.member.MemberDTO" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="mdao" class="com.member.MemberDAO" scope="session"></jsp:useBean>
<%
int result=mdao.editMember(mdto);
String msg=result>0?"수정이 완료되었습니다.":"수정에 실패하였습니다.";
%>
<script>
window.alert('<%=msg%>');
location.href='memberList.jsp';
</script>