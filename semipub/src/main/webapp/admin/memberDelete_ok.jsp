<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdto" class="com.member.MemberDTO"></jsp:useBean>
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="mdao" class="com.member.MemberDAO"></jsp:useBean>

<%
int aIdx=Integer.parseInt(request.getParameter("idx"));
System.out.println(aIdx);
%>
<script>
var msg=window.confirm('직원을 삭제하시겠습니까?');
if(msg){
	if(<%=aIdx%>>1){
		<%
		mdao.deleteMember(aIdx);
		%>
		window.alert('직원 삭제를 완료하였습니다.');
		location.href='memberList.jsp';
	}else{
		window.alert('직원 삭제에 실패하였습니다.');
	}
}else{
	window.alert('직원 삭제에 실패하였습니다.');
}
location.href='memberList.jsp';
</script>