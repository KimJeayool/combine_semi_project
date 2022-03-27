<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.menu.*" %>

<!-- Access Check -->
<%@ include file="/login/adminAccessModule.jsp" %>
<!-- Access for manager -->
<%@include file="/onlyManager.jsp"%>

<jsp:useBean id="mdao" class="com.menu.MenuDAO" scope="session"></jsp:useBean>     
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>메뉴 관리 페이지</title>
  <link rel="stylesheet" type="text/css" href="/semipub/css/mainLayout.css">
  <style>
	#menu_tag3{
		background-color: red;
		color: white;
	}
	#menu_tag3:hover {
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
	.notFoundList{
		text-align: center;
		font-size: 40px;
		padding-top: 200px;
	}
	.tableArea{
		height: 510px;
		padding-top: 10px;
	}
	table{
		margin: 0px auto;
		border-spacing: 20px;
	}
	table td{
		background-color: white;
		border-radius:10%;
		text-align: center;
	}
	table img {
		width: 120px;
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
	}
	#currentPage{
		font-size:25px;
		color: black;
		margin: 20px;
	}
	</style>
</head>
<%
String img = request.getParameter("img");
if(img==null){
	img="0.jpg";
}

String s_cateNum = request.getParameter("cateNum");
if(s_cateNum==null || s_cateNum.equals("")){
	s_cateNum = "1"; // First visted
}
int cateNum = Integer.parseInt(s_cateNum); // Menu Category Number
%>
<!----------------------------- Page Number ----------------------------- -->
<%
int totalCnt = mdao.getTotalMenuCount(cateNum); // Total Menu Count
int listSize = 8;
int pageSize = 10;

String s_cp = request.getParameter("cp");
if(s_cp==null || s_cp.equals("")){
	s_cp = "1";
}
int cp = Integer.parseInt(s_cp); // Current Page

int totalPage = (totalCnt/listSize) + 1; //Total page
if(totalCnt%listSize==0) totalPage--;

int pageGroup = cp/pageSize; //Page Group (start 0)
if(cp%pageSize==0) pageGroup--;

int startIdx = pageSize*pageGroup + 1 ; //
int endIdx = pageSize*pageGroup + pageSize;

int totalPageGroup = totalPage/pageSize;
if(totalPage%pageSize==0) totalPageGroup--;

int beforeIdx = (pageGroup-1)*pageSize + pageSize; //이전 페이지 index
int nextIdx = (pageGroup+1)*pageSize + 1; //다음 페이지 index

%>
<!-----------------------------             ----------------------------- -->
<body>
  <%@include file="/header.jsp" %>
  <section>
  <article>
	  <div class="topSide">
		    <ul>
		      <a href="/semipub/menu/menuCustom.jsp?cateNum=1" <%=cateNum==1?"id='currentCate'":"" %>><li>메인메뉴</li></a>
		      <a href="/semipub/menu/menuCustom.jsp?cateNum=2" <%=cateNum==2?"id='currentCate'":"" %>><li>사이드메뉴</li></a>
		      <a href="/semipub/menu/menuCustom.jsp?cateNum=3" <%=cateNum==3?"id='currentCate'":"" %>><li>음료</li></a>
		    </ul>
	  	</div>
	</article>
    <article>
      <div class="centerSide" align="center">
	      <%
	      	//Get Menu List By cateNum
	      	ArrayList<MenuDTO> arr=mdao.menuList(cateNum, cp, listSize);
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
		      					<div><%=dto.getPrice()%></div>
		      					<div>
		      					<%
		      					if(dto.getState().equals("품절")){
		      					%>
		      					<div id="stateRed"><%=dto.getState()%></div>
		  						<%
		      					}else{
		      					%>
		      					<div id="stateGreen"><%=dto.getState()%></div>
		      					<%
		      					}
		      					%>
		      					</div>
		      					<div><a href="menuEdit.jsp?mName=<%=dto.getmName()%>&mIdx=<%=dto.getmIdx()%>&state=<%=dto.getState()%>&price=<%=dto.getPrice()%>&cateNum=<%=dto.getCateNum()%>&img=<%=dto.getImg()%>"><input type="submit" value="편집" style="width:57px; height:25px; border-radius:8px;" id="editBt"></a></div>
		      				</td>
		      				<%
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
						<a href="menuCustom.jsp?cp=<%=beforeIdx %>&cateNum=<%=cateNum %>">&lt;&lt;</a>
						<%
					}
					
					/*페이지 리스트*/
					for(int i=startIdx; i<=endIdx; i++){
						%>&nbsp;&nbsp;<a href="menuCustom.jsp?cp=<%=i %>&cateNum=<%=cateNum %>" <%=cp==i? "id='currentPage'":"" %>><%=i %></a>&nbsp;&nbsp;<%
						if(i==totalPage) break;
					}
					
					/*다음>>*/
					if(pageGroup!=totalPageGroup){
						%>
						<a href="menuCustom.jsp?cp=<%=nextIdx %>&cateNum=<%=cateNum %>">&gt;&gt;</a>
						<%
					}
					%>
	      		</div>
	      	<%}%>
      </div>
    </article>
    <article>
  	  <div class="bottomside" align="right">
      	<div style="padding:12px; margin-right:100px;">
			<a href="menuAdd.jsp?cateNum=<%=cateNum%>"><input type="button" value="메뉴추가" id="addMenu"></a>
		</div>
      </div>
  </article>
  </section>
</body>
</html>