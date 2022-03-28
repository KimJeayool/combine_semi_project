<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.member.*" %>
<jsp:useBean id="mdao" class="com.member.MemberDAO"></jsp:useBean>

<!-- Access Check -->
<%@ include file="/login/adminAccessModule.jsp" %>
<!-- Access for manager -->
<%@include file="/onlyManager.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>SEMIPUB 계정 목록</title>
	<link rel="stylesheet" type="text/css" href="/semipub/css/mainLayout.css">
	<style> 
	h2{
		 text-align:center;
		 font-size: 40px;
		 padding-top: 30px;
		 color: white;
		 text-shadow: 5px 4px 4px black;
	}
	table{
		width:650px;
		margin:40px auto;
		border-collapse: collapse;
		
	}
	table th{
		background-color:black;
		color: white;
		font-size: 20px;
	}
	table td{
		text-align: center;
		font-size: 18px;
		border-top: 1px solid black;
	}
	table tbody{
	background-color: white;
	}
	table a:link {
		color: black;
		text-decoration: underline;
	}
	table a:visited{
		color: blue;
	}
	table a:hover{
		color: red;
	}
	#footbutton{
		text-align:center;
	}
	#menu_tag5{
		background-color: red;
		color: white; 
	}
	#button{
		margin: 20px;
		font-size: 25px;
		font-weight: bold;
		background-color: white;
		border-radius: 20px;
	}
	#button:hover{
		background-color: red;
		color: white;
	}
	</style>
</head>
<body>
<%@include file="/header.jsp"  %>
	<section>
		<article>
			<div class="topSide">
				<%@include file="memberTopSide.jsp" %>
			</div>
		</article>
	    <article>
	    <div class="centerSide"> 
	    	<h2>계정목록</h2>
		    <form name="memberList">
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>아이디</th>
						<th>비밀번호</th>
						<th>이름</th>
						<th>직급</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
				<%
				ArrayList<MemberDTO> arr=mdao.getMemberList();
				if(arr==null || arr.size()==0){
					%>
					<tr>
						<td colspan="6" align="center">
						등록된 사람이 없습니다.
						</td>
					</tr>
					<%
				}else{
					for(int i=0;i<arr.size();i++){
						%>
						<tr>
							<td><%=arr.get(i).getaIdx() %></td>
							<td><%=arr.get(i).getaId() %></td>
							<td><%=arr.get(i).getaPwd() %></td>
							<td><%=arr.get(i).getName() %></td>
							<td><%=arr.get(i).getLev() %></td>
							<td><a href="memberEdit.jsp?idx=<%=arr.get(i).getaIdx() %>&id=<%=arr.get(i).getaId() %>&pwd=<%=arr.get(i).getaPwd()%>&name=<%=arr.get(i).getName()%>">수정</a></td>
							<td><a href="memberDelete_ok.jsp?idx=<%=arr.get(i).getaIdx() %>">삭제</a></td>
						</tr>
						<%
					}
				}
				%>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="7" align="center">
						<input type="button" value="추가" id="button" onclick="location.href='memberAdd.jsp'">
						</td>
					</tr>
				</tfoot>
			</table>
			</form>
		</div>
	</article>
	<%@include file="/bottomSide.jsp" %>
</section>
</body>
</html>