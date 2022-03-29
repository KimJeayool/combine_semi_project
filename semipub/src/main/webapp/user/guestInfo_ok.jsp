<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.match.*" %>
<jsp:useBean id="matchDto" class="com.match.MatchDTO" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="matchDto"/>
<jsp:useBean id="matchDao" class="com.match.MatchDAO" scope="session"></jsp:useBean>

<%
String part = request.getParameter("part"); // 1->Update, 2->match request
String s_partner = request.getParameter("partner");

String msg = "";
switch(part){

	case "1": // Update Geust Info
		int result1 = matchDao.updateMatchInfo(matchDto);
		msg = (result1>0)? "수정이 완료되었습니다." : "수정이 실패되었습니다.";
		break;
		
	case "2": // Update matchNum 
		String s_mytNum = ""+session.getAttribute("tNum");
		int mytNum = Integer.parseInt(s_mytNum);
		int mygIdx = matchDao.getMygIndex(mytNum); //My gIdx
		
		int partner = Integer.parseInt(s_partner); //Partner tNum to Request
		
		System.out.println("mytNum:"+mytNum);//test
		System.out.println("mygIdx:"+mygIdx);
		System.out.println("partner:"+partner);
		
		int result2 = matchDao.requestMatch(mygIdx, partner);
		msg = (result2>0)? "신청이 완료되었습니다.." : "신청이 실패되었습니다.";
		break;
}
%>

<script>
	alert('<%=msg %>');
	location.href= 'matchTableList.jsp';
</script>