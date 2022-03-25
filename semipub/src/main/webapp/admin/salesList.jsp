<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.sales.*" %>
<jsp:useBean id="sdao" class="com.sales.SalesDAO" ></jsp:useBean>
<jsp:useBean id="sdto" class="com.sales.SalesDTO" scope="session"></jsp:useBean>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출현황</title>
<link rel="stylesheet" type="text/css" href="/semipub/css/mainLayout.css">

<style>
#menu_tag4{
	background-color: red;
	color: white;
}
#menu_tag4:hover {
	background-color: skyblue;
	color: black;
}
h1{
font-size: 200%;
}
#tb{
width: 60%;
margin: 0px auto;
}

#RTB{
width: 100%;
text-align: center;
margin: 0px auto;
border: 1px solid black;
border-collapse: collapse;
}
table{
width: 100%;
text-align: center;
margin: 0px auto;
}

#RTB th, #RTB td{
border: 1px solid black;
border-collapse: collapse;
}


#th1{
width: 10%;
}
#th2{
width: 12%;
}
#th3{
width: 15%;
}
#th4{
width: 18%;
}
#th5{
width: 15%;
}
#th6{
width: 10%;
}
</style>


</head>

<%
//시작 달력, 종료 달력 파라미터 값 받기
String startdate = request.getParameter("startdate");
String enddate = request.getParameter("enddate");
String all = request.getParameter("all"); 

if(all != null){ 
	if(all.equals("Y")){ 
		sdto.setStartdate(""); 
		sdto.setEnddate("");
	}
}

if(startdate == null || startdate == ""){ 
	if(sdto.getStartdate() == null || sdto.getStartdate().equals("")){
		sdto.setStartdate("");
	}
}else{ 
	sdto.setStartdate(startdate);
}

if(enddate == null || enddate == ""){ 
	if(sdto.getEnddate() == null || sdto.getEnddate().equals("")){
		sdto.setEnddate("");
	}
}else{
	sdto.setEnddate(enddate);
}

int totalCnt = sdao.getTotalCnt(sdto.getStartdate(), sdto.getEnddate()); // 총 게시물 수
int totalPrice = sdao.getTotalPrice(sdto.getStartdate(), sdto.getEnddate()); // 합계액 

int listSize = 10; //보여줄 게시물 수
int pageSize = 5; //보여줄 페이지 수

//페이징 파라미터 
String s_cp = request.getParameter("cp");
if(s_cp==null||s_cp.equals("")){
	s_cp="1";
}
int cp = Integer.parseInt(s_cp)	; //cp=사용자가 있는 페이지 

int totalPage = (totalCnt / listSize)+1;
if(totalCnt%listSize==0)totalPage--;

int userGroup = cp/pageSize;  
if(cp%pageSize==0)userGroup--;

%>
<script>
	//날짜검색
	function searchList(){
		location.href = "salesList.jsp?startdate="+document.salesfm.startdate.value+"&enddate="+document.salesfm.enddate.value;
	}
	//전체검색 
	function allList(){
		document.salesfm.startdate.value = "";
		document.salesfm.enddate.value = "";
		location.href = "salesList.jsp?all=Y";//파라미터값 all
	}
</script>
<body>
<%@include file="/header.jsp"  %>
	<section>
		<article>
			<div class="topSide">		
			</div>
		</article>
	    <article>
	      <div class="centerSide">
	      <form name="salesfm">
	     <div id="title"><h1 align="center">총 매출 현황</h1></div><br><br>
	     
	     <div id="tb">
	     <div id="dt" align="right"> <input type="button" value="전체" onclick="allList();"> <input type="date" value="<%=sdto.getStartdate() %>" name="startdate"> <input type="date" value="<%=sdto.getEnddate() %>" name="enddate">&nbsp;<input type="button" value="검색" name="searchbt" onclick="searchList();"></div><br>
	     <table id="RTB">
	     	<tr>
	     	<th id="th1">NO</th>
	     	<th id="th2">테이블번호</th>
	     	<th id="th3">총 가격</th>
	     	<th id="th4">결제일</th>
	     	<th id="th5">담당자</th>
	     	<th id="th6">상세</th>
	     	</tr>
	     	
	     	
	     		<%
					ArrayList<SalesDTO> arr=sdao.getSalesList(cp, listSize, sdto.getStartdate(), sdto.getEnddate());
					if(arr==null||arr.size()==0){
				%><tr><td colspan="6">데이터가 없습니다.</td></tr>
				<%
					}else{
						
						for(int i=0;i<arr.size();i++){
							sdto = arr.get(i);
						%>
						<tr>
						<td><%=sdto.getPayIdx() %></td>
						<td><%=sdto.gettNum() %></td>
						<td><%=sdto.getTotal() %></td>
						<td><%=sdto.getPayDate() %></td>
						<td><%=sdto.getName() %></td>
						<td><a href="#">결제내역</a></td>
						</tr>
						<%
						}
					}
				%>
	     </table><br>
	     <div id="amoun" align="right">총 매출액:<%=totalPrice %>원</div>
	      </div>
	      
	      	<table >
	      		<tfoot>
	      		<tr>
	      			<td>
						<%
							if(userGroup!=0){
								%>
								<a href="salesList.jsp?cp=<%=(userGroup-1)*pageSize+pageSize%>">&lt;&lt;</a>
								<%
							}
							%>
							<%
							for(int i=(userGroup*pageSize+1) ; i<=(userGroup*pageSize+pageSize) ; i++){
								%>&nbsp;&nbsp;<a href="salesList.jsp?cp=<%=i%>"><%=i%></a>&nbsp;&nbsp;<%
								if(i==totalPage)break;
							}
							%>
							
							<%
							if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){
								%>
								<a href="salesList.jsp?cp=<%=(userGroup+1)*pageSize+1%>">&gt;&gt;</a>
								<%
							}
						%>
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