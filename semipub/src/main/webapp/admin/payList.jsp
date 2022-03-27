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
#menu_tag4 {
	background-color: red;
	color: white;
}

#menu_tag4:hover {
	background-color: skyblue;
	color: black;
}
h2{
	font-size: 30px;
	text-align: center;
	padding-top: 30px;
}
.tableArea{
	text-align: center;
}
table{
	margin: 25px auto;
	width: 60%;
	height: 70%;
	border: 1px;
	border-collapse: collapse;
}
table th{
	background-color: black;
	color: white;
	font-size: 20px;
}
table td{
	font-size: 18px;
}
table tbody td{
	border-bottom: 1px solid black;
}
.amount{
	width: 60%
	margin: 0px auto;
}
#button{
	font-size: 20px;
	background-color: white;
	font-weight: bold;
	border-radius: 20px;
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
				<div class="tableArea">
					<table>
						<thead>
							<tr>
								<th>메뉴</th>
								<th>수량</th>
								<th>단가</th>
							</tr>
						</thead>
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
						<tbody>
							<tr>
								<td><%=sdto.getmName() %></td>
								<td><%=sdto.getCount() %></td>
								<td><%=sdto.getPrice() %></td>
							</tr>
						</tbody>
							<%
								}
							}
						%>
						<tfoot>
							<tr height="15"></tr>
							<tr>
								<td colspan="3" align="right">합계: <%=total %></td>
							</tr>
							<tr>
								<td colspan="3" align="right">담당자:<%=name %></td>
							</tr>
							<tr>
								<td colspan="3" align="right">결제시각:<%=payDate %></td>
							</tr>
						</tfoot>
					</table>
					<div>
						<input type="button" value="목록보기" id="button" onclick="location.href='salesList.jsp'">
					</div>
				</div>
			</div>
		</article>
	<%@include file="/bottomSide.jsp"%>
	</section>
</body>
</html>