<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.sales.*"%>
<jsp:useBean id="sdao" class="com.sales.SalesDAO"></jsp:useBean>
<jsp:useBean id="sdto" class="com.sales.SalesDTO" scope="session"></jsp:useBean>

<!-- Access Check -->
<%@ include file="/login/adminAccessModule.jsp" %>
<!-- Access for manager -->
<%@include file="/onlyManager.jsp"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/semipub/css/mainLayout.css">
<style>

#table{
width: 60%;
height: 70%;
border: 1px;
}

</style>

</head>
<%
int gIdx = Integer.parseInt(request.getParameter("gIdx")); //Get Guest Index
int total = 0;
String name = "";
java.sql.Timestamp payDate = new Timestamp(System.currentTimeMillis());
%>
<body>
	<%@include file="/header.jsp"%>
	<section>
		<article>
			<div class="topSide"></div>
		</article>
		<article>
			<div class="centerSide">
			
				
				<h2>결제내역</h2>	
				<table border="1">
					<tr>
					<th>메뉴</th>
					<th>수량</th>
					<th>단가</th>
					</tr>
					<%
						ArrayList<SalesDTO> arr = sdao.arr(gIdx);
						if (arr != null || arr.size() != 0) {
					%>		
					<%
							for (int i = 0; i < arr.size(); i++) {
								sdto = arr.get(i);
								total += sdto.getPrice()*sdto.getCount();
								if(i == arr.size()-1){
									name = sdto.getName();
									payDate = sdto.getPayDate();
								}
					%>
						<tr>
							<td><%=sdto.getmName() %></td>
							<td><%=sdto.getCount() %></td>
							<td><%=sdto.getPrice() %></td>
						</tr>
						<%
							}
						}
					
					%>
						
					합계: <%=total %>
					담당자:<%=name %>
					결제시각:<%=payDate %>
					
						
					
					
					
					
				
				</table>
			</div>
		</article>
	<%@include file="/bottomSide.jsp"%>
	</section>
</body>
</html>