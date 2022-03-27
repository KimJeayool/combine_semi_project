<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.order.*" %>
<jsp:useBean id="odao" class="com.order.OrderDAO" scope="session"></jsp:useBean>

<!-- Access Check -->
<%@ include file="/login/adminAccessModule.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>테이블 주문 내역</title>
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
		.tableTitle{
			text-align: center;
			font-size: 40px;
			padding-top: 30px;
		}
		.tableArea{
			height: 230px;
		}
		table{
			margin: 30px auto;
			width: 800px;
		}
		table th{
			background-color: black;
			color: white;
		}
		table td{
			text-align: center;
		}
		.pageNum{
			text-align: center;
			font-size: 20px;
		}
		.pageNum a{
			text-decoration:none;
		}
		#currentPage{
			color: black;
			font-size: 25px;
		}
		.total{
			text-align: center;
			font-size: 30px;
			font-weight: bold;
			margin: 25px 0px;
		}
		.total span{
			background-color: yellow;
		}
		.buttonArea{
			text-align: center;
		}
		#button{
			width: 120px;
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
<%
//Get Parameter Value
int cp = Integer.parseInt(request.getParameter("cp")); //Table List Page Number
int tNum = Integer.parseInt(request.getParameter("tNum")); //Get Table Number
int gIdx = Integer.parseInt(request.getParameter("gIdx")); //Get Guest Index
int total = Integer.parseInt(request.getParameter("total")); //Get Total to pay
%>

<!----------------- Page Number ------------------------->
<%
int totalOrder = odao.getOrderCount(gIdx); //Total Order Count
int listSize = 6;
int pageSize = 10;

String s_orderCp = request.getParameter("orderCp");
if(s_orderCp==null || s_orderCp.equals("")){
	s_orderCp = "1";
}
int orderCp = Integer.parseInt(s_orderCp); //Current Order List Page

int totalPage = (totalOrder/listSize) + 1;
if(totalOrder%pageSize==0) totalPage--;

int pageGroup = orderCp/pageSize;
if(orderCp%pageSize==0) pageGroup--;

int startIdx = pageSize*pageGroup + 1 ;
int endIdx = pageSize*pageGroup + pageSize;

int totalPageGroup = totalPage/pageSize;
if(totalPage%pageSize==0) totalPageGroup--;

int beforeIdx = (pageGroup-1)*pageSize + pageSize;
int nextIdx = (pageGroup+1)*pageSize + 1; 
%>
<!-- ---------------------------------------- -->
<body>
	<%@include file="/header.jsp" %>
	<section>
		<article>
  			<div class="topSide">
  			</div>
		</article>
		<article>
			<div class="centerSide">
				<div class="tableTitle">&lt;<%=tNum %>&gt;번 테이블 주문내역</div>
				
				<!-- Table Area -->
				<div class="tableArea">
					<table border="1">
						<tr>
							<th>No</th>
							<th>메뉴이름</th>
							<th>단가</th>
							<th>수량</th>
							<th>가격</th>
							<th>주문시간</th>
							<th>상황</th>
						</tr>
						<%
						//Get Guest Order List
						ArrayList<OrderDTO> dtos = odao.getTableOrder(gIdx, orderCp, listSize);
						if(dtos==null || dtos.size()==0){
							%>
							<tr>
								<td colspan="7" align="center">
								주문한 내역이 존재하지 않습니다.
								</td>
							</tr>
							<%
						}else{
							for(int i=0; i<dtos.size(); i++){
								%>
								<tr>
									<td><%=i+1 %></td>
									<td><%=dtos.get(i).getmName() %></td>
									<td><%=dtos.get(i).getPrice() %></td>
									<td><%=dtos.get(i).getCount() %></td>
									<td><%=dtos.get(i).getPrice()*dtos.get(i).getCount() %></td>
									<td><%=dtos.get(i).getOrderDate() %></td>
									<td><%=dtos.get(i).getStName() %></td>
								</tr>
								<%
							}
						}
						%>
					</table>
				</div>
				<div class="pageNum">
						<%
						if(dtos==null||dtos.size()==0){
							%>1<%
						}else{
						//Before Page
						if(pageGroup!=0){
							%>
							<a href="tablePay.jsp?cp=<%=cp %>&tNum=<%=tNum %>&gIdx=<%=gIdx %>&total=<%=total %>&orderCp=<%=beforeIdx %>">&lt;&lt;</a>
							<%
						}
						
						//Page Number
						for(int i=startIdx; i<=endIdx; i++){
							%>&nbsp;&nbsp;<a href="tablePay.jsp?cp=<%=cp %>&tNum=<%=tNum %>&gIdx=<%=gIdx %>&total=<%=total %>&orderCp=<%=i %>" <%=(i==orderCp)?"id='currentPage'":"" %>><%=i %></a>&nbsp;&nbsp;<%
							if(i==totalPage) break;
						}
						
						//Next Page
						if(pageGroup!=totalPageGroup){
							%>
							<a href="tablePay.jsp?cp=<%=cp %>&tNum=<%=tNum %>&gIdx=<%=gIdx %>&total=<%=total %>&orderCp=<%=nextIdx %>">&gt;&gt;</a>
							<%
						}
						}
						%>
				</div>
				<div class="total">
					<span>합계: <%=total %>원</span>
				</div>
				
				<!-- Button Area -->
				<div class="buttonArea">
					<%
					if(total==0){
						%><input type="button" value="돌아가기" id="button" onclick="pageBack()"><%
					}else{
						%><input type="button" value="결제하기" id="button" onclick="paymentPage()"><%
					}
					%>	
				</div>
			</div>
		</article>
		<%@include file="/bottomSide.jsp" %>
	</section>
	<script>
		function pageBack(){
			window.location.href= '/semipub/table/tableList.jsp?cp=<%=cp %>';
		}
		function paymentPage(){
			window.location.href= '/semipub/payment/tablePayInput.jsp?tNum=<%=tNum %>&gIdx=<%=gIdx %>&total=<%=total %>';
		}
	</script>
</body>
</html>