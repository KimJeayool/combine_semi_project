<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.pay.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="pdao" class="com.pay.PayDAO" scope="session"></jsp:useBean>

<!-- Access Check -->
<%@ include file="/login/adminAccessModule.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>결제 페이지</title>
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
		.totalPay{
			text-align: center;
			font-size: 25px;
			padding-top: 10px;
			font-weight: bold;
		}
		.totalPay span{
			background-color: yellow;		
		}
		.guestPay{
			text-align: center;
			font-size: 20px;
			padding-top: 10px;
			font-weight: bold;
			color: blue;
		}
		.tableArea{
			margin: 20px;
			height: 150px;
		}
		table{
			margin: 0px auto;
			width: 550px;
		}
		table th{
			background-color: black;
			color: white;
		}
		table td{
			text-align: center;
		}
		#cancelMsg{
			font-weight: bold;
		}
		.pageArea{
			text-align: center;
			margin: 0px 0px 20px 0px;
		}
		.pageArea a{
			text-decoration:none;
		}
		#currentPage{
			color: black;
			font-size: 20px;
		}
		.formArea fieldset{
			margin: 0px auto;
			width: 550px;
			border-radius: 25px;
		}
		fieldset li{
			list-style-type: none;
			font-size: 20px;
			margin: 20px 0px;
		}
		fieldset label{
			width: 150px;
			float: left;
			font-weight: bold;
		}
		#price{
			font-size: 20px;
			width: 300px;
		}
		fieldset div{
			text-align: center;
		}
		#button{
			width: 100px;
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
int tNum = Integer.parseInt(request.getParameter("tNum")); //Get Table Number
int gIdx = Integer.parseInt(request.getParameter("gIdx")); //Get Guest Number
int total = Integer.parseInt(request.getParameter("total")); //Get Tatal to pay

int payed = pdao.getPayed(gIdx); // Get Total payed

int aIdx = 0;


String saidx = ""+session.getAttribute("saidx");
if(saidx==null || saidx.equals("")){
	saidx = "0";
}
aIdx = Integer.parseInt(saidx);
%>

<!-------------- Page Number ------------------>
<%
int totalCnt = pdao.getPayCount(gIdx); // Total Pay Count By gIdx
int listSize = 4;
int pageSize = 5;

String s_cp = request.getParameter("cp");
if(s_cp==null || s_cp.equals("")){
	s_cp = "1";
}
int cp = Integer.parseInt(s_cp); // Current Page

//Total Page
int totalPage = (totalCnt/listSize) + 1;
if(totalCnt%listSize==0) totalPage--;

//Current Page Group (Start to 0)
int pageGroup = cp/pageSize;
if(cp%pageSize==0) pageGroup--;

//Page Group start, end index
int startIdx = pageSize*pageGroup + 1 ;
int endIdx = pageSize*pageGroup + pageSize;

//Total Page Group
int totalPageGroup = totalPage/pageSize;
if(totalPage%pageSize==0) totalPageGroup--;

int beforeIdx = (pageGroup-1)*pageSize + pageSize; //Before Page Index
int nextIdx = (pageGroup+1)*pageSize + 1; //Next Page Index
%>
<!--------------             ------------------>
<body>
	<%@include file="/header.jsp" %>
	<section>
		<article>
  			<div class="topSide">
  			</div>
		</article>
		<article>
			<div class="centerSide">
				<div class="tableTitle">&lt;<%=tNum %>&gt;번 테이블 결제하기</div>
				<div class="totalPay"><span>총결제 : <%=total %>원</span></div>
				<div class="guestPay">결제됨 : <%=payed %>원 </div>
				<div class="tableArea">
					<table border="1">
						<tr>
							<th>No</th>
							<th>결제 금액</th>
							<th>결제 수단</th>
							<th>결제 시간</th>
							<th>기능</th>
						</tr>
						<%
						ArrayList<PayDTO> dtos = pdao.getPayList(gIdx, cp, listSize); //Get Payed List
						if(dtos==null || dtos.size()==0){
							%>
							<tr>
								<td colspan="5">결제된 내역이 존재하지 않습니다.</td>
							</tr>
							<%
						}else{
							for(int i=0; i<dtos.size(); i++){
								%>
								<tr>
									<td><%=i+1 %></td>
									<td><%=dtos.get(i).getPrice() %></td>
									<%
									String type = "";
									switch(dtos.get(i).getPayType()){
									case 1: type="카드"; break;
									case 2: type="현금"; break;
									case 3: type="취소"; break;
									}
									%>
									<td><%=type %></td>
									<td><%=dtos.get(i).getPayDate() %></td>
									<%
									if(dtos.get(i).getPayType()==3){
										%>
										<td id="cancelMsg">취소됨</td>
										<%
									}else{
										%>
										<td><input type="button" value="취소" onclick="payedCancle(<%=dtos.get(i).getPayIdx()%>)"></td>
										<%
									}
									%>
								</tr>
								<%
							}
						}
						%>
					</table>
				</div>
				<div class="pageArea">
					<%
					if(dtos==null||dtos.size()==0){
						%>1<%
					}else{
					/*Before*/
					if(pageGroup!=0){
						%>
						<a href="tablePayInput.jsp?cp=<%=beforeIdx %>&tNum=<%=tNum %>&gIdx=<%=gIdx %>&total=<%=total %>">&lt;&lt;</a>
						<%
					}
					
					/*Page List*/
					for(int i=startIdx; i<=endIdx; i++){
						%>&nbsp;&nbsp;<a href="tablePayInput.jsp?cp=<%=i %>&tNum=<%=tNum %>&gIdx=<%=gIdx %>&total=<%=total %>" <%=(i==cp)?"id='currentPage'":"" %>><%=i %></a>&nbsp;&nbsp;<%
						if(i==totalPage) break;
					}
					
					/*Next*/
					if(pageGroup!=totalPageGroup){
						%>
						<a href="tablePayInput.jsp?cp=<%=nextIdx %>&tNum=<%=tNum %>&gIdx=<%=gIdx %>&total=<%=total %>">&gt;&gt;</a>
						<%
					}
					}
					%>
				</div>
				<div class="formArea">
					<fieldset>
						<form name="pay" action="tablePayInput_ok.jsp">
							<input type="hidden" name="tNum" value="<%=tNum %>">
							<input type="hidden" name="total" value="<%=total %>">
							<input type="hidden" name="gIdx" value="<%=gIdx %>">
							<input type="hidden" name="aIdx" value="<%=aIdx %>">
							<ul>
								<li>
									<label>결제 방법</label>
									<input type="radio" name="payType" value="1" checked>  카드
									<input type="radio" name="payType" value="2">  현금
								</li>
								<li>
									<label>결제 금액</label>
									<input type="text" name="price" id="price" placeholder="결제할 금액을 입력해 주세요." onkeypress="checkNum(this)" required>
								</li>
							</ul>
							<div>
								<input type="submit" id="button" value="결제">
							</div>
						</form>
					</fieldset>
				</div>
			</div>
		</article>
	<%@include file="/bottomSide.jsp" %>
	</section>
	<script>
		function payedCancle(payIdx){
			window.location.href = 'tablePayCancel.jsp?payIdx='+payIdx+'&tNum=<%=tNum %>&gIdx=<%=gIdx %>&total=<%=total %>&cp=<%=cp %>';
		}
		function checkNum(){
			var num = event.keyCode;
			if(num<48 || num>57){
				event.returnValue = false;
				alert('숫자만 입력 가능합니다.');
			}
		}
	</script>
</body>
</html>