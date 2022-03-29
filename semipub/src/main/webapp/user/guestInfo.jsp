<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.match.*" %>
<jsp:useBean id="matchDao" class="com.match.MatchDAO" scope="session"></jsp:useBean>
<!-- Access Check -->
<%@ include file="/login/userAccessModule.jsp" %>

<%
String s_gIdx = request.getParameter("gIdx");
if(s_gIdx==null || s_gIdx.equals("")){
	response.sendRedirect("matchTableList.jsp");
}
int gIdx = Integer.parseInt(s_gIdx); // Guest Index

String sessionNum = ""+session.getAttribute("tNum"); //My table Number
String s_i = request.getParameter("i"); //Table Number
String matchStatus = request.getParameter("matchStatus");

boolean myPage = false;
if(sessionNum.equals(s_i)) myPage=true; //Check My Page

MatchDTO dto = matchDao.getMatchInfo(gIdx);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title><%=s_i %>번 테이블 매칭 정보</title>
	<link rel="stylesheet" type="text/css" href="/semipub/css/mainLayout.css">
	<style>
		#menu_tag2{
			background-color: red;
			color: white;
		}
		#menu_tag2:hover {
			background-color: skyblue;
			color: black;
		}
		h2{
			font-size: 30px;
			padding-top: 30px;
			text-align: center;
		}
		table{
			margin: 30px auto;
			width: 320px;
		}
		#button{
			margin: 10px;
			font-size: 20px;
			background-color: white;
			border-radius: 20px;
		}
	</style>
</head>
<body>
	<%@include file="/userHeader.jsp" %>
	<section>
	  	<article>
	  		<div class="topSide">
		  		<ul>
		     		<a href="/semipub/user/matchTableList.jsp"><li>테이블 현황</li></a>
		     		<a href="/semipub/user/matchStatus.jsp"><li>매칭 현황</li></a>
		    	</ul>
	  		</div>
		</article>
	    <article>
     		<div class="centerSide">
     			<h2><%=s_i %>번 테이블 정보</h2>
     			<form name="fm" action="guestInfo_ok.jsp">
     			<input type="hidden" name="part" value="1">
     			<input type="hidden" name="gIdx" value="<%=gIdx%>">
  				<table border="1">
  					<tr>
  						<th>닉네임</th>
  						<td><input type="text" size="30" name="nickName" value="<%=dto.getNickName() %>" <%=myPage==false? "readonly" : "" %>></td>
  					</tr>
  					<tr>
  						<th>인원</th>
  						<td>
  							<span>남성: </span>
  							<input type="number" name="male" value="<%=dto.getMale() %>" min="0" max="9" <%=myPage==false? "readonly" : "" %>>
  							<span>여성: </span>
  							<input type="number" name="female" value="<%=dto.getFemale() %>" min="0" max="9" <%=myPage==false? "readonly" : "" %>>
  						</td>
  					</tr>
  					<tr>
  						<th>코멘트</th>
  						<td>
  							<textarea rows="10" cols="30" name="msg" <%=myPage==false? "readonly" : "" %>><%=dto.getMsg() %></textarea>
  						</td>
  					</tr>
  					<tr>
  					<%
  					if(myPage==true){
  						%>
  						<td colspan="2" align="center">
  							<input type="submit" value="수정하기" id="button" >
  							<input type="button" value="목록보기" id="button" onclick="matchList()">
  						</td> 
  						<%
  					}else{
	  					if(matchStatus.equals("비매칭")){
	  						%>
	  						<td colspan="2" align="center">
	  							<input type="button" value="매칭신청" id="button" onclick="matchOk()">
	  							<input type="button" value="목록보기" id="button" onclick="matchList()">
	  						</td> 
	  						<%
	  					}else if(matchStatus.equals("매칭")){
	  						%>
	  						<td colspan="2" align="center">
								<input type="button" value="목록보기" id="button" onclick="matchList()">
							</td> 
							<%
	  					}
  					}
  					%>
  					</tr>
  				</table>
  				</form>
     		</div>
     	</article>
     	<%@include file="/bottomSide.jsp" %>
	</section>
	<script>
		function matchList(){
			location.href = 'matchTableList.jsp';
		}
		function matchOk(){
			location.href = 'guestInfo_ok.jsp?part=2&partner=<%=s_i%>';
		}
	
	</script>
</body>
</html>