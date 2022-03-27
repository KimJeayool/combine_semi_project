<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "com.menu.*" %>
<%@page import = "java.util.*" %>    
<%@page import = "com.Cookie.CookieModule" %>
<jsp:useBean id="medao" class="com.menu.MenuDAO" scope="session"></jsp:useBean>    

<!-- Access Check -->
<%@ include file="/login/userAccessModule.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>SEMI PUB 메뉴 목록</title>
	<link rel="stylesheet" type="text/css" href="/semipub/css/mainLayout.css">
	<style>
	#menu_tag1{
		background-color: red;
		color: white;
	}
	#menu_tag1:hover {
		background-color: skyblue;
		color: black;
	}
	#currentCate{
		background-color: antiquewhite;
   		border-radius: 40px;
	}
	#currentCate li{
		font-size: 35px;
	}
	#outer{
		width : 600px;
		text-align: center;
		margin : 0px auto;
	}
	#inner{
		width : 200px;
		text-align: center;
		margin : 0px auto;
	}
		.notFoundList{
		text-align: center;
		font-size: 40px;
		padding-top: 200px;
	}
	.tableArea{
		height: 550px;
		padding-top: 10px;
	}
	table{
		margin: 0px auto;
		border-spacing: 20px;
		width: 750px;
	}
	table td{
		background-color: black;
		border-radius:10%;
		text-align: center;
		width: 160px;
		color: white;
	}
	table img {
		width: 220px;
		height: 150px;
		border-top-left-radius: 20px;
		border-top-right-radius: 20px;
	}
	#editBt{
		background-color:white;
	}
	#editBt:hover{
		background-color: red;
		color: white;
	}
	#addMenu{
		font-size: 30px;
		font-weight: bold;
		width:170px; 
		height:50px; 
		background-color:yellow; 
		border-radius:10px;
	}
	#addMenu:hover{
		background-color: red;
		color: white;
	}
	#stateRed{
		color: red;
	}
	#stateGreen{
		color: #81c147;
	}
	.pageNum a{
		text-decoration: none;
		font-size:20px;
		font-weight: bold;
	}
	#currentPage{
		font-size:25px;
		color: black;
		margin: 20px;
	}
	#mCount1{
		text-align: center;
	}
	.numBox{
		text-align: center;
		width: 50px;
		border-radius: 20px;
	}
	.button{
		font-size: 15px;
		border-radius: 20px;
		font-weight: bold;
		background-color: white;
	}
	</style>
</head>
<%
String s_cateNum =request.getParameter("cateNum");
if(s_cateNum==null||s_cateNum.equals("")){
	s_cateNum="1";
}
int cateNum = Integer.parseInt(s_cateNum);
		
		
int totalCnt = medao.getTotalCnt(cateNum);
int listSize = 8;
int pageSize = 10;
		
String s_cp = request.getParameter("cp");
if(s_cp==null || s_cp.equals("")){
	s_cp = "1";
}
int cp = Integer.parseInt(s_cp); 

int totalPage = (totalCnt/listSize) + 1; 
if(totalCnt%listSize==0) totalPage--;

int pageGroup = cp/pageSize; 
if(cp%pageSize==0) pageGroup--;

int startIdx = pageSize*pageGroup + 1 ; 
int endIdx = pageSize*pageGroup + pageSize;

int totalPageGroup = totalPage/pageSize;
if(totalPage%pageSize==0) totalPageGroup--;

int beforeIdx = (pageGroup-1)*pageSize + pageSize; 
int nextIdx = (pageGroup+1)*pageSize + 1; 													


%>
<body>
	<%@include file="/userHeader.jsp" %>
  	<section>
     	<article>
		  	<div class="topSide">
			    <ul>
			      <a href="/semipub/user/menuList.jsp?cateNum=1" <%=cateNum==1?"id='currentCate'":"" %>><li>메인메뉴</li></a>
			      <a href="/semipub/user/menuList.jsp?cateNum=2" <%=cateNum==2?"id='currentCate'":"" %>><li>사이드메뉴</li></a>
			      <a href="/semipub/user/menuList.jsp?cateNum=3" <%=cateNum==3?"id='currentCate'":"" %>><li>음료</li></a>
			    </ul>
		  	</div>
		</article>
	     <article>
	      <div class="centerSide" align="center">
		      <%
		      	//Get Menu List By cateNum
		      	ArrayList<MenuDTO> arr=medao.menuList(cateNum, cp, listSize);
		      	if(arr==null||arr.size()==0){
		      		%>
	      			<div class="notFoundList">
	      			등록된 사진이 없습니다.
	      			</div>
		      		<%
		      	}else{
		      		%>
		      		<div class="tableArea">
			      		<table>
			      			<tr>
			      			<%
			      			for(int i=0; i<arr.size(); i++){
			      				MenuDTO dto = arr.get(i);
			      				%>
			      				<td>
			      					<div><img src="/semipub/menu/photos/<%=dto.getImg()%>"></div>
			      					<div><%=dto.getmName()%></div>
			      					<div><input type="number" value="1" class="numBox" min="1" max="20" id="mCount<%=i%>"/></div>
			      					<div><%=dto.getPrice()%></div>
			      					<%
			      					if(dto.getState().equals("품절")){
			      					%>
			      					<div id="stateRed">
			      						주문불가
			      					</div>
			  						<%
			      					}else{
			      					%>
			      					<div id="stateGreen">
			      						<input type="button" class="button" value="담기" onclick="javascript:window.location.href='menuCart_ok.jsp?part=1&mIdx=<%=arr.get(i).getmIdx() %>&mCount='+document.getElementById('mCount<%=i%>').value">
			      					</div>
			      					<%
			      					}
			      				if((i+1)%4==0){
			      					%></tr><tr><%
			      				}
			      			}
			      			%>
			      			</tr>
			      		</table>
		      		</div>
		      		<div class="pageNum">
		      			<%
						/*<<이전*/
						if(pageGroup!=0){
							%>
							<a href="menuList.jsp?cp=<%=beforeIdx %>&cateNum=<%=cateNum %>">&lt;&lt;</a>
							<%
						}
						
						/*페이지 리스트*/
						for(int i=startIdx; i<=endIdx; i++){
							%>&nbsp;&nbsp;<a href="menuList.jsp?cp=<%=i %>&cateNum=<%=cateNum %>" <%=cp==i? "id='currentPage'":"" %>><%=i %></a>&nbsp;&nbsp;<%
							if(i==totalPage) break;
						}
						
						/*다음>>*/
						if(pageGroup!=totalPageGroup){
							%>
							<a href="menuList.jsp?cp=<%=nextIdx %>&cateNum=<%=cateNum %>">&gt;&gt;</a>
							<%
						}
						%>
		      		</div>
		      	<%}%>
	      </div>
    </article>
    </article>
  <%@include file="/bottomSide.jsp" %>
  </section>
</body>
</html>