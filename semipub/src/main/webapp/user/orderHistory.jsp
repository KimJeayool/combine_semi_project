<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.order.*" %>
<jsp:useBean id="odao" class="com.order.OrderDAO" ></jsp:useBean>
<jsp:useBean id="odto" class="com.order.OrderDTO" scope="session"></jsp:useBean>
    

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주문내역</title>
	<link rel="stylesheet" type="text/css" href="/semipub/css/mainLayout.css">
	<style>
	#menu_tag5{
		background-color: red;
		color: white;
	}
	#menu_tag5:hover {
		background-color: skyblue;
		color: black;
	}
	h1{
	font-size: 200%;
	}
	/* Page Area*/
	.tb{
	width: 70%;
	height: 80%;
	margin: 0px auto;
	}
	#bottom{
	width:80%;
	}
	#RTB{
	width: 100%;
	text-align: center;
	margin: 0px auto;
	border-collapse: collapse;
	}
	.page {
	width: 100%;
	text-align: center;
	margin: 0px auto;
	border: 0px;
	}
	.table th{
	border-collapse: collapse;
	color: #168;
	}
	.table th {
	  color: white;
	  background-color:black;
	  border-bottom-width: thick;
	}
	.table th, .table td {
	  border: 1px solid gray;
	}
	.table th:first-child, .table td:first-child {
	  border-left: 0;
	}
	.table th:last-child, .table td:last-child {
	  border-right: 0;
	}
	#th1{
	width: 35%;
	}
	#th2{
	width: 20%;
	}
	#th3{
	width: 20%;
	}
	#th4{
	width: 25%;
	}
	input[type=text] {
	  width: 10px;
	  height: 20px;
	  font-size: 15px;
	  border: 0;
	  border-radius: 5px;
	  outline: none;
	  padding-left: 10px;
	  background-color: rgb(233, 233, 233);
	  text-align: center;
	  
	}
	#dptext{
	text-align: center;
	}
	.buttonSide{
		padding-left: 62vw;
		text-aligin: center;
	}
	.buttonSide .button{
		width: 130px;
		height: 50px;
		font-size: 20px;
		margin: 10px;
		background-color: #057BD5;
		color: white;
		font-weight: bolder;
	}
	.button:hover {
		background-color: red;
	}
	</style>
<%
int gIdx = (Integer)session.getAttribute("gIdx");
int totalCnt = odao.getOrderCount(gIdx);
int totalPrice = odao.getTotalPrice(gIdx);

int listSize = 10;
int pageSize = 5; 


String s_cp = request.getParameter("cp");
if(s_cp==null||s_cp.equals("")){
	s_cp="1";
}
int cp = Integer.parseInt(s_cp)	;  

int totalPage = (totalCnt / listSize)+1;
if(totalCnt%listSize==0)totalPage--;

int userGroup = cp/pageSize;  
if(cp%pageSize==0)userGroup--;

%>

<script>
function payRequest(){
	if(confirm('카운터에 결제요청 하시겠습니까?')){
			
		
			location.href="orderHistory_ok.jsp?gIdx=<%=gIdx%>"; 
		}
		return false;
	}


</script>
</head>
<body>
  <%@include file="../userHeader.jsp" %>
  <section>
 	<article>
			<div class="topSide">		
			</div>
	</article>
    <article>
      <div class="centerSide">
      <br>
	      <div class="tb">
	      
	      <div id="title"><h1 align="center">주문내역</h1>
	      <br><br>
	      <table id="RTB" class="table">
	      	<thead>
	      	<tr>
	      		<th>메뉴명</th>
	      		<th >단가</th>
	      		<th>수량</th>
	      		<th >가격</th>
	      	</tr>
	      	</thead>
	      	
	      	<tbody>
	      		<%
				//Get Guest Order List
				ArrayList<OrderDTO> dtos = odao.getTableOrder(gIdx, cp, listSize);
				if(dtos==null || dtos.size()==0){
					%>
					<tr>
						<td colspan="4" align="center">
						주문한 내역이 존재하지 않습니다.
						</td>
					</tr>
					<%
				}else{
					for(int i=0; i<dtos.size(); i++){
						%>
						<tr >
							<td><%=dtos.get(i).getmName() %></td>
							<td><%=dtos.get(i).getPrice() %></td>
							<td><%=dtos.get(i).getCount() %></td>
							<td><%=dtos.get(i).getPrice()*dtos.get(i).getCount() %></td>
						</tr>
						<%
					}
				}
				%>
			</tbody>
	      </table>
	      <form>
	      <div align="Right">
	      <strong>더치페이</strong> <input type=button value="-" onClick="minusAmount();">
	      <input type="text" name="amount" id="dptext" value="1">
	      <input type=button value="+" onClick="plusAmount();"> :<span id="totalPrice"><%=totalPrice%></span>원
	      </div> <div id="amoun" align="Right">
	      <strong>합계&nbsp;</strong>:&nbsp;<span style="color: red;"><strong><%=totalPrice %></strong></span>원&nbsp;
	      </div>
	      <br>
	   	  </form>
	   	  <script>
	   	  	function minusAmount(){
	   	  		var totalPrice = <%=totalPrice%>; 
	   	  		var amount = parseInt(document.getElementById('dptext').value);//텍스트 입력 값을 amount로 
		   	  	amount--;
	   	  		if(amount < 1){
	   	  			alert("최소 인원은 1명입니다.");
	   	  			return false;
	   	  		}else{
		   	  		document.getElementById('dptext').value = amount;
		   	  		document.getElementById('totalPrice').innerHTML = Math.round(totalPrice/amount);
	   	  		}
	   	  	}
	   	  	
	   	  	function plusAmount(){
		   	  	var totalPrice = <%=totalPrice%>;
	   	  		var amount = parseInt(document.getElementById('dptext').value);
	   	  		amount++;
	   	  		document.getElementById('dptext').value = amount;
	   	  		document.getElementById('totalPrice').innerHTML =Math.round(totalPrice/amount);
	   	  	}
	   	  </script>
	      
	    
	      <div class="page">
					<%
					if(dtos==null || dtos.size()==0){
						%><div>1</div><%
					}else{
					
						if(userGroup!=0){
							%>
							<a href="orderHistory.jsp?cp=<%=(userGroup-1)*pageSize+pageSize%>">&lt;&lt;</a>
							<%
						}
						%>
						<%
						for(int i=(userGroup*pageSize+1) ; i<=(userGroup*pageSize+pageSize) ; i++){
							%>&nbsp;&nbsp;<a href="orderHistory.jsp?cp=<%=i%>"><%=i%></a>&nbsp;&nbsp;<%
							if(i==totalPage)break;
						}
						%>
						
						<%
						if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){
							%>
							<a href="orderHistory.jsp?cp=<%=(userGroup+1)*pageSize+1%>">&gt;&gt;</a>
							<%
						}
					}
					%>
	     			
	     	</div>
	     	
      </div>
      </div>
      <div id="bottom">
      <div class="buttonSide">
      <input type="button" value="계산하기" class="button" onclick="payRequest()">
      </div>
      </div>
      
    </article>
  <%@include file="../bottomSide.jsp" %>
  
  </section>
</body>
</html>