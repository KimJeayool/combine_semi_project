<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.table.*" %>
<jsp:useBean id="tdao" class="com.table.TableDAO"></jsp:useBean>

<!-- Access Check -->
<%@ include file="/login/adminAccessModule.jsp" %>
<!-- Access for manager -->
<%@include file="/onlyManager.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>테이블 목록</title>
	<link rel="stylesheet" type="text/css" href="/semipub/css/mainLayout.css">
	<style> 
	h2{
		text-align:center;
		font-size: 30px;
		padding-top: 30px;
	}
	table{
		width:550px;
		margin:20px auto;
		font-size: 18px;
	}
	table th{
		background-color:gray;
	}
	table td{
		text-align: center;
	}
	table a:link{
		color: blue;
	}
	table a:hover{
		color: red;
	}
	table a:visited{
		color: blue;
	}
	#footbutton{
		text-align:center;
	}
	#menu_tag5{
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
	    	<h2>테이블 목록</h2>
		    <form name="tableList">
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>아이디</th>
						<th>비밀번호</th>
						<th>수정</th>
					</tr>
				</thead>
				<tbody>
				<%
				ArrayList<TableDTO> arr=tdao.getTableList();
				if(arr==null || arr.size()==0){
					%>
					<tr>
						<td colspan="6" align="center">
						등록된 테이블이 없습니다.
						</td>
					</tr>
					<%
				}else{
					for(int i=0;i<arr.size();i++){
						%>
						<tr>
							<td><%=arr.get(i).gettNum() %></td>
							<td><%=arr.get(i).gettId() %></td>
							<td><%=arr.get(i).gettPwd() %></td>
							<td><a href="tableEdit.jsp?tNum=<%=arr.get(i).gettNum() %>&tId=<%=arr.get(i).gettId() %>&tPwd=<%=arr.get(i).gettPwd()%>">수정</a></td>
						</tr>
						<%
					}
				}
				%>
				</tbody>
			</table>
			</form>
		</div>
	</article>
	<%@include file="/bottomSide.jsp" %>
</section>
</body>
</html>