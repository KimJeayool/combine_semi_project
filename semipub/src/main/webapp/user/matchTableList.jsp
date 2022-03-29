<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.table.*" %>
<%@ page import="com.match.*" %>
<jsp:useBean id="tdao" class="com.table.TableDAO" scope="session"></jsp:useBean>
<jsp:useBean id="matchDao" class="com.match.MatchDAO" scope="session"></jsp:useBean>

<!-- Access Check -->
<%@ include file="/login/userAccessModule.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>SEMI PUB 매칭 테이블</title>
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
		.buttonSide{
			padding-top: 3vw;
			text-aligin: center;
		}
		.buttonSide .button{
			width: 100px;
			height: 30px;
			font-size: 20px;
			margin: 10px;
			background-color: white;
			font-weight: bolder;
			border-radius: 20px;
		}
		.square{
			width: 15px;
			height: 15px;
			border: 1px solid black;
			display: inline-block;
		}
		.explanation{
			display: inline;
			margin-right: 10px;
		}
		.button:hover {
			background-color: red;
		}
		#black{
			background-color: black;
			margin-left: 21%;
		}
		#white{
			background-color: white;
		}
		#yellow{
			background-color: yellow;
		}
		#spaceRigth{
			margin-right: 180px;
		}
		.tableArea{
			width: 83vw;
			height: 430px;
		}
		table{
			border-spacing: 20px;
			margin: 5px auto;
		}
		table td{
			width: 170px;
			height: 170px;
			border: 6px double black;
			text-align: center;
			font-size: 25px;
			background-color: white;
			border-radius: 20%;
		}
		table a:link{
			text-decoration: none;
			color: black;
		}
		.tableInfo{
			font-size: 20px;
		}
		#tNum{
			font-weight: bold;
		}
		#green{
			color: green;
		}
		#red{
			color: red;
		}
		.emtyTable{
			background-color: gray;
			color: white;
		}
		.pageNum{
			text-align: center;
			font-size: 25px;
		}
		.pageNum a:link{
			text-decoration: none;
			color: blue;
		}
		#cp{
			color: black;
			font-size: 30px;
		}
		#notFoundMsg{
			margin-top: 18%;
			text-align: center;
			font-size: 30px;
		}
		#pageNum{
			bottom: 0px;
		}
	</style>
</head>
<!-------- Paging Code --------->
<%
int maxNum = tdao.getTableCount(); //Total Table Count
int listSize = 8; //Table List Size

String s_cp = request.getParameter("cp");
if(s_cp==null || s_cp.equals("")){
	s_cp = "0";
}
int cp = Integer.parseInt(s_cp); //Current Page

int totalPage = maxNum/listSize; //totalPage
if(maxNum%listSize==0) totalPage--;

int startIdx = (cp*listSize) + 1; //Start Table Index to view
int endIdx = (cp*listSize) + listSize; //Edn Table Index to view
if(maxNum<=endIdx) endIdx = maxNum;
%>
<!------------------  -------------------->
<body>
  <%@include file="/userHeader.jsp" %>
  <section>
  	<article>
  		<div class="topSide">
	  		<ul>
	     		<a href="/semipub/user/matchTableList.jsp"><li>테이블 현황</li></a>
	     		<a href="/semipub/user/matchStatus.jsp"><li>매칭 현황</li></a>
	    	</ul>
  		</div>
	</article>
    <article>
     	<div class="centerSide">
     		<!-- Button Block (Not use) -->
      		<div class="buttonSide">
      		</div>
      		<!-- Table Block -->
      		<%
      		ArrayList<MatchDTO> dtos = matchDao.getMatchInfo(startIdx, endIdx); // Get Match Info
      		
      		if(maxNum==0){
      			%><div id="notFoundMsg">등록된 테이블이 없습니다.</div><%
      		}else{
      			%>
      			<div class="tableArea">
	      			<table>
	      				<tr>
	      				<% 
	      				for(int i=startIdx; i<=endIdx; i++){
	      					boolean isGeust = false;
	      					for(MatchDTO dto : dtos){
	      						if(dto.gettNum()==i){
	      							isGeust = true;
	    	      					%>
	    	      					<td>
	    	      						<a href="/semipub/user/guestInfo.jsp?i=<%=i %>&gIdx=<%=dto.getgIdx()%>&matchStatus=<%=dto.getMatchStatus()%>">
	    		      						<div id="tNum"><%=i %>방</div>
	    		      						<div class="tableInfo"><%=dto.getNickName()%></div>
	    		      						<div class="tableInfo">남성:<%=dto.getMale() %> 여성:<%=dto.getFemale() %></div>
	    		      						<div class="tableInfo" <%=(dto.getMatchStatus()=="매칭")? "id='green'" : "id='red'" %>><%=dto.getMatchStatus() %></div>
	    	      						</a>
	    	      					</td>
	    	      					<%
	    	      					break;
	      						}
	      					}
	      					if(isGeust==false){	      						
		      					%>
		      					<td class="emtyTable">
			      					<a href="/semipub/user/matchTableList.jsp?cp=<%=cp %>">
			      						<div><%=i %>방</div>
			      						<div>-</div>
			      						<div>-</div>
			      						<div>-</div>
			      					</a>
		      					</td>
		      					<%
	      					}
	      					if(i%4==0){
	      						out.println("</tr><tr>");
	      					}
	      				}
	      				%>
	      				</tr>
	      			</table>
	      		</div>
      		<!-- Page Number Block -->
   			<div class="pageNum">
     			<%
     			for(int i=0; i<=totalPage; i++){
     				%>
     				<a href="/semipub/user/matchTableList.jsp?cp=<%=i%>"><span <%=cp==i?"id='cp'":"" %>><%=i+1%></span></a>
     				<%
     			}
     			%>
     		</div>
      			<%
      		}
      		%>
     	</div>
    </article>
  <%@include file="/bottomSide.jsp" %>
  </section>
  <script>
  	function openAdd(){
  		if(confirm('테이블을 추가하시겠습니까?')){
  			window.location.href= 'tableAdd.jsp?maxNum=<%=maxNum+1%>';
  		}
  		return false;
  	}
  	function openDelete(){
  		if(confirm('테이블을 삭제하시겠습니까??')){
  			if(<%=maxNum%>==0){
  				alert('삭제할 테이블이 존재하지 않습니다.');
  				return false;
  			}
  			window.location.href = 'tableDelete.jsp?maxNum=<%=maxNum%>';
  		}
  		return false;
  	}
  </script>
</body>
</html>