<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.match.*" %>
<jsp:useBean id="matchDao" class="com.match.MatchDAO" scope="session"></jsp:useBean>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>매칭 현황</title>
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
			text-align: center;
			padding-top: 30px;
		}
		fieldset{
			width: 600px;
			margin: 30px auto;
		}
		fieldset legend{
			font-size: 20px;
			font-weight: bold;
		}
		fieldset table{
			margin: 0px auto;
			width: 500px;
		}
		table td{
			text-align: center;
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
     			<h2>매칭 현황</h2>
     			<%
     			String s_mytNum = ""+session.getAttribute("tNum");
     			int mytNum = Integer.parseInt(s_mytNum);
     			int mygIdx = matchDao.getMygIndex(mytNum); //My gIdx
     			
     			int partnertNum = matchDao.getPartnertNum(mygIdx);
     			int partnergIdx = matchDao.getMygIndex(partnertNum);
     			
     			MatchDTO dto = matchDao.getMatchInfo(partnergIdx);
     			%>
     			<fieldset>
     				<legend>신청한 테이블</legend>
     				<table>
     					<tr>
     						<th>테이블</th>
     						<th>닉네임</th>
     						<th>남자</th>
     						<th>여자</th>
     						<th>버튼</th>
     					</tr>
     					<tr>
     					<%
     					if(dto==null){
     						%>
     						<tr>
     							<td colspan="5" align="center">
     							신청한 내역을 찾을 수 없습니다.
     							</td>
     						</tr>
     						<%
     					}else{
     						%>
     						<tr>
     							<td><%=dto.gettNum() %></td>
     							<td>
     								<a href="/semipub/user/guestInfo.jsp?i=<%=dto.gettNum() %> %>&gIdx=<%=dto.getgIdx()%>&matchStatus=<%=dto.getMatchStatus()%>">
     								<%=dto.getNickName() %>
     								</a>
     							</td>
     							<td><%=dto.getMale() %></td>
     							<td><%=dto.getFemale() %></td>
     							<td>
     								<input type="button" value="취소" onclick="requestCancel()">
     							</td>
     						</tr>
     						<%
     					}
     					%>
     				</table>
     			</fieldset>
     			<%
     			ArrayList<Integer> arr = matchDao.getTablegIdxs(mytNum);
     			MatchDTO me = matchDao.getMatchInfo(mygIdx);
     			%>
     			<fieldset>
     				<legend>신청 받은 테이블</legend>
     				<table>
     					<tr>
     						<th>테이블</th>
     						<th>닉네임</th>
     						<th>남자</th>
     						<th>여자</th>
     						<th>버튼</th>
     					</tr>
     					<%
     					if(me.getMatchStatus().equals("매칭")){
     						%>
						     <tr>
     							 <td colspan="5" align="center">
     							 	<input type="button" value="매칭취소" onclick="location.href='matchStatus_ok.jsp?part=3&mygIdx=<%=mygIdx%>'">
     							 </td>
     						</tr>
     						<%
     					}else{
	     					if(arr==null || arr.size()==0){
	     						%>
	     						<tr>
	     							<td colspan="5" align="center">등록된 정보를 찾을 수 없습니다.</td>
	     						</tr>
	     						<%
	     					}else{
	     						for(int i=0; i<arr.size(); i++){
	     							MatchDTO mdto = matchDao.getMatchInfo(arr.get(i));
	     							%>
	     							<tr>
	     								<td><%=mdto.gettNum() %></td>
	     								<td><%=mdto.getNickName() %></td>
	     								<td><%=mdto.getMale() %></td>
	     								<td><%=mdto.getFemale() %></td>
	     								<td>
	     									<input type="button" value="수락" onclick="location.href='matchStatus_ok.jsp?part=2&mygIdx=<%=mygIdx%>&yougIdx=<%=mdto.getgIdx()%>'">
	     								</td>
	     							</tr>
	     							<%
	     						}
	     					}
     					}
     					%>
     				</table>
     			</fieldset>
     		</div>
     	</article>
     	<%@include file="/bottomSide.jsp" %>
	</section>
	<script>
		function requestCancel(){
			location.href = 'matchStatus_ok.jsp?part=1&mygIdx=<%=mygIdx%>';
		}
	</script>
</body>
</html>