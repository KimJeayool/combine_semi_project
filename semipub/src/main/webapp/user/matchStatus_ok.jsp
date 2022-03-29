<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.match.*" %>
<jsp:useBean id="matchDao" class="com.match.MatchDAO" scope="session"></jsp:useBean>

<%
String part = request.getParameter("part"); // 1->cancel, 2->

String s_mygIdx = request.getParameter("mygIdx");
if(s_mygIdx==null) s_mygIdx="0";
int mygIdx = Integer.parseInt(s_mygIdx);

String s_yougIdx = request.getParameter("yougIdx");
if(s_yougIdx==null) s_yougIdx="0";
int yougIdx = Integer.parseInt(s_yougIdx);

String msg = "";
switch(part){

	case "1":
		int result1 = matchDao.cancelMatch(mygIdx);
		msg = (result1>0)? "취소하였습니다." : "실패하였습니다.";
		break;
		
	case "2":
		MatchDTO me = matchDao.getMatchInfo(mygIdx);
		MatchDTO you = matchDao.getMatchInfo(yougIdx);
		int result2 = 0;
		if(me.gettNum()==you.getMatchNum() && me.getMatchNum()==you.gettNum()){
			result2 += matchDao.setMatch(mygIdx);
			result2 += matchDao.setMatch(yougIdx);
		}
		msg = (result2>0)? "매칭에 성공하였습니다." : "매칭에 실패하였습니다.";
		break;
		
	case "3":
		int result3 = matchDao.setCancel(mygIdx);
		msg = (result3>0)? "취소하였습니다." : "실패하였습니다.";
		break;

}
%>
<script>
	alert('<%=msg %>');
	location.href= 'matchStatus.jsp';
</script>