<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.net.*" %>
<%@ page import ="java.util.*" %>
<%@ page import ="com.menu.*" %>
<%@ page import="com.Cookie.CookieModule"%>
<jsp:useBean id="medao" class="com.menu.MenuDAO" scope="session"></jsp:useBean> 
<jsp:useBean id="odao" class="com.order.OrderDAO"></jsp:useBean>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>SEMI PUB 장바구니 페이지</title>
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
		h2{
			text-align: center;
			font-size: 40px;
			padding-top: 20px;
		}
		table{
			width : 600px;
			text-align: center;
			margin : 30px auto;
		}
		table th{
			background-color: gray;
		}
		.numBox{
			width: 40px;
		}
		.formButton{
			font-size: 20px;
			background-color: skyblue;
		}		
		.formButton:hover{
			background-color: red;
			color: white;
		}
	</style>
</head>
<body>
	<%@include file="/userHeader.jsp" %>
 	<section>
  		<%@include file="/topSide.jsp" %>
   		<article>
     		<div class="centerSide">
     			<h2>장바구니 페이지</h2>
     			<form name="menuCart" action="menuCart_ok.jsp">
     				<table border="1">
     					<!-- Table Head -->
     					<thead>
			      			<tr>
			      				<th>메뉴명</th>
			      				<th>단가</th>
			      				<th>수량</th>
			      				<th>수량변경</th>
			      				<th>가격</th>
			      				<th>취소</th>
			      			</tr>
     					</thead>
     					<!-- Table body -->
     					<tbody>
						<%
						int total = 0; //Total Price
						Cookie cks[] = request.getCookies();
							
						/* IF There is Not Cookie  */
						if(cks==null || cks.length==1){
							%>
							<tr>
								<td colspan="6" align="center">
									등록된 상품이 없습니다.
								</td>
							</tr>
							<%
						/* IF There is Cookie */
						}else{
							for(int i=1; i<cks.length; i++){
								String value = cks[i].getValue();
								if(value==null || value.equals("")) value="0";
								int count = Integer.parseInt(value); // Menu Count
								
								String s_mIdx = cks[i].getName();
								if(s_mIdx==null || s_mIdx.equals("")) s_mIdx="0";
								int mIdx = Integer.parseInt(s_mIdx); // Menu mIdx
								
								MenuDTO dto = medao.getMenuInfo(mIdx);
								
								total += dto.getPrice()*count; //Plus Total
								%>
								<tr>
									<td><%=dto.getmName() %></td>
									<td><%=dto.getPrice() %></td>
								    <td>
								    	<input type="hidden" value=<%=dto.getmIdx() %> name="mIdx<%=i%>">
      									<input type="number" value=<%=count %> name="count<%=i %>" id="mCount<%=i%>" class="numBox">
     								</td>
									<td>
      									<input type="button" value="변경" onclick="javascript:window.location.href='menuCart_ok.jsp?part=2&mIdx=<%=dto.getmIdx()%>&mCount='+document.getElementById('mCount<%=i%>').value">
     								</td>
      								<td><%=dto.getPrice()*count %></td>
      								<td>
      									<input type="button" value="삭제" onclick="javascript:window.location.href='menuCart_ok.jsp?part=3&mIdx=<%=dto.getmIdx()%>'">
    								</td>
								</tr>
								<%
							}
						}
						%>
		      			</tbody>
		      			<tfoot>
		      				<tr>
		      					<td colspan="6" align="right">총 <%=total %>원</td>
		      					<input type="hidden" value="<%=total %>" name="total">
		   						<input type="hidden" value="4" name="part">
		   					</tr>
		   					<tr>
	      						<td colspan="6"><input type="submit" value="주문" class="formButton"></td>
	      					</tr>		      				
      					</tfoot>
	      			</table>
    			</form>
     		</div>
   		</article> 
 	</section>
</body>
</html>