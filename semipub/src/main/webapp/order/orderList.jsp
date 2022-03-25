<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import = "com.order.*" %>
<jsp:useBean id="odao" class="com.order.OrderDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sales</title>
<link rel="stylesheet" type="text/css" href="/semipub/css/mainLayout.css">
	<script>
			function openPop() {
				return window.confirm("선택하신 주문을 처리하시겠습니까?");				
			}
	</script>
	<style>
	h2{

		text-align: center;
	}
	table{
		width: 50vw;
  	 	height: 70vh;
  	 	text-align: center;
  	 	margin : auto;
  	 	font-size : 20px;
	}
	table td{
		border-bottom: 3px solid gray;
	}
	input[type=submit], input[type=button]{
		width : 200px;
		height : 60px;
		font-size : 30px;
	}
	input[type=checkbox] {
		width : 25px;
		height : 25px;
	}
	#orderWhite{
		background-color: white;
	}
	#colorBlue{
		color: blue;
	}
	 #menu_tag1{
	 		background-color: red;
	}
	.borderNone{
		border : 0px;
	}
	.buttonGray{
		background-color: gray;
	}
	.buttonYellow{
		background-color: yellow;
	}
	</style>
</head>
<%
/**about page*/
	int totalCnt = odao.countAll();
	int listSize = 4;
	int pageSize = 5;
	String s_cp = request.getParameter("cp");
	if(s_cp==null||s_cp.equals("")){
		s_cp = "1";
	}
	int cp = Integer.parseInt(s_cp);	
	int totalPage = (totalCnt/listSize)+1;
	if(totalCnt%listSize==0){
		totalPage--;
	}
	int userGroup = cp/pageSize;
	if(cp%pageSize==0){
		userGroup--;
	}
/**about orderList grouping by tables*/
	String s_tNum = request.getParameter("tNum");
	if(s_tNum==null||s_tNum.equals("")){
		s_tNum="-1";
	}
	int tNum = Integer.parseInt(s_tNum);
	
%>
<body>
 <%@include file="/header.jsp" %>
 <section>
  <%@include file="/topSide.jsp" %>
    <article>
      <div class="centerSide">
	      <h2>전체 주문 현황</h2>
		<form name="orderList" action="orderList_ok.jsp" method="post" onsubmit="return openPop()">
			<table>
				<thead>
					<tr>
						<td colspan="7" align="right">
							잔여 주문:<%=odao.countOrders(1) %>개
						</td>
					</tr>
					<tr>
						<th><input type="checkbox"></th>
						<th>no.</th>
						<th>방번호</th>
						<th>메뉴이름</th>
						<th>수량</th>
						<th>주문시간</th>
						<th>상태</th>						
					</tr>
				</thead>
				<tfoot>
					<tr>
				<!-- page -->	
					<%
						if(tNum<0){
							%>
							<td colspan="7" align="center" class="borderNone">
							<%
								if(userGroup!=0){
									%>
										<a href="orderList.jsp?cp=<%=(userGroup-1)*pageSize+pageSize %>">&lt;&lt;</a>
									<%
								}		
								for(int i=(userGroup*pageSize+1); i<=(userGroup*pageSize+pageSize); i++){
									%>
									&nbsp;&nbsp;<a href="orderList.jsp?cp=<%=i %>"><%=i %></a>&nbsp;&nbsp;
									<%
									if(i==totalPage){
										break;
									}
								}
								if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){
									%>
									<a href="orderList.jsp?cp=<%=(userGroup+1)*pageSize+1 %>">&gt;&gt;</a>
									<%
								}
							%>	
						</td>
							<%
						}
					
					%>
						
					</tr>
					<tr>
				<!-- button -->	
					<%
					ArrayList<OrderDTO> arr = new ArrayList<OrderDTO>();
					if(tNum>0){//if tableNumber Clicked
					%>	<tr>
							<td colspan="6" align="center" class="borderNone">
								<input type="submit" value="선택 취소" name="action" >
								<input type="submit" value="선택 완료" name="action">
							</td>
							<td class="borderNone">
								<input type="button" value="전체목록" onclick="location.href='orderList.jsp' ">
							</td>
						</tr>
					
					<%
					}else{
					%>
						<tr>
							<td colspan="7" align="center" class="borderNone">
								<input type="submit" value="선택 취소" name="action" >
								<input type="submit" value="선택 완료" name="action">
							</td>							
						</tr>
					<%
					}%>					
				</tfoot>
				<tbody>
				<%	
				ArrayList<OrderDTO> arr_p = new ArrayList<OrderDTO>();
				if(tNum>0){//if tableNumber clicked
					arr_p = odao.getOrderList(tNum);
					for(int i=0; i<arr_p.size(); i++){
						%>
							<tr id=<%=arr_p.get(i).getStName().equals("주문")?"orderWhite":"" %>>
								<td><input type="checkbox" name="orders" value=<%=arr_p.get(i).getoIdx() %> > </td>
								<td><%=arr_p.get(i).getoIdx() %></td>
								<td><a href="orderList.jsp?tNum=<%=arr_p.get(i).gettNum() %>"><%=arr_p.get(i).gettNum() %></a></td>
								<td><%=arr_p.get(i).getmName() %></td>
								<td><%=arr_p.get(i).getCount() %></td>
								<td><%=arr_p.get(i).getOrderDate() %></td>
								<td style="color : <%=!arr_p.get(i).getStName().equals("완료")?!arr_p.get(i).getStName().equals("주문")?"":"blue":"green" %>" ><%=arr_p.get(i).getStName() %></td>
								<input type="hidden" value=<%=arr_p.get(i).getPrice()%> name="price">
								<input type="hidden" value=<%=arr_p.get(i).getCount() %> name="count">
							</tr>
						<%
					}
				}else{//if page number clicked
					arr_p = odao.pageList(cp, listSize);
					if(arr_p==null||arr_p.size()==0){
					%>
						<tr>
							<td colspan="7" align="center">등록된 주문이 없습니다.</td>
						</tr>
					<%	
						
					}else{
						for(int i=0; i<arr_p.size(); i++){
							
					%>
						<tr id=<%=arr_p.get(i).getStName().equals("주문")?"orderWhite":"" %> >
							<td><input type="checkbox" name="orders" value=<%=arr_p.get(i).getoIdx() %> > </td>
							<td><%=arr_p.get(i).getoIdx() %></td>
							<td><a href="orderList.jsp?tNum=<%=arr_p.get(i).gettNum() %>"><%=arr_p.get(i).gettNum() %></a></td>
							<td><%=arr_p.get(i).getmName() %></td>
							<td><%=arr_p.get(i).getCount() %></td>
							<td><%=arr_p.get(i).getOrderDate() %></td>
							<td style="color : <%=!arr_p.get(i).getStName().equals("완료")?!arr_p.get(i).getStName().equals("주문")?"":"blue":"green" %>"><%=arr_p.get(i).getStName() %></td>
							<input type="hidden" value=<%=arr_p.get(i).getPrice()%> name="price">
							<input type="hidden" value=<%=arr_p.get(i).getCount() %> name="count">
						</tr>
					<%	
						}
					}
				}	
				%>
				</tbody>
			</table>
		</form>
	</div>	
	</article>
</section>
<%@include file="/bottomSide.jsp" %>
</body>
</html>