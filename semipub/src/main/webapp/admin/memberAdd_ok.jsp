<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="mdto" class="com.member.MemberDTO"></jsp:useBean>
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="mdao" class="com.member.MemberDAO"></jsp:useBean>
<%
int result=mdao.getMember(mdto);
String msg=result>0?"직원 등록이 완료되었습니다.":"직원 등록에 실패하셨습니다.";
%>
<script>
window.alert('<%=msg%>');
location.href='memberList.jsp';
</script>