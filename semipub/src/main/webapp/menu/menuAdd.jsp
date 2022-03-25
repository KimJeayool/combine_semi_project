<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 페이지</title>
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
	.title{
		text-align: center;
		font-size: 30px;
		padding-top: 20px;
		padding-bottom: 50px;
	}
	table{
		margin: 0px auto;
		border-spacing: 10px;
	}
	table td{
		text-align: center;
	}
	#imgUpload{
		width:80px; 
		height:40px; 
		background-color:white;
		font-weight: bold;
		border-radius: 10px;
	}
	#imgUpload:hover{
		background-color: red;
		color: white;
	}
	img{
		width: 280px;
		height: 180px;
		border-radius: 20px;
	}
	#submitButton{
		margin: 30px;
		width:120px; 
		height:50px; 
		font-weight: bold;
		font-size: 25px;
		background-color: skyblue;  
		border-radius: 10px;
	}
	#submitButton:hover{
		background-color: red;
		color: white;
	}
	</style>
</head>
<%
String img = request.getParameter("img"); //Img File Name
if(img==null){
	img="0.jpg";
}

String s_cateNum = request.getParameter("cateNum");
if(s_cateNum==null || s_cateNum.equals("")){
	s_cateNum = "1"; // First visted
}
int cateNum = Integer.parseInt(s_cateNum); // Menu Category Number
%>
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
		<div class="centerSide">
			<div class="title">메뉴 추가 페이지</div>
			<div class="tableArea">
				<form name="menuUpload" action="menuUpload_ok.jsp">
					<input type="hidden" value="<%=img%>" name="img">
					<table>
						<tr>
							<td>
								<img src='/semipub/menu/photos/<%=img%>'>
								<div><input type="button" value="사진올리기" id="imgUpload" onclick="upLoadpage()"></div>
							</td>
							<td>
								<table>
							    	<tr>
								    	<td style="font-weight:bold;">카데고리 : </td>
								    	<td>
											<select name="cateNum" style="width:158px; height:50px; font-weight: bold;">
											<option value="1">메인</option>
											<option value="2">사이드</option>
											<option value="3">음료</option>
											</select>      			
								      	</td>
							    	</tr>
							    	<tr>
							      		<td style="font-weight:bold;">상품명 : </td>
							      		<td><input type="text" name="mName" style="width:150px; height:40px;"></td>
							      	</tr>
							      	<tr>
							      		<td style="font-weight:bold;">가격 : </td>
							      		<td><input type="text" name="price" style="width:150px; height:40px;"></td>
							      	</tr>
							      	<tr>
							    		<td style="font-weight:bold;">상태 : </td>
								    	<td>
											<select name="state" style="width:158px; height:50px; font-weight: bold;">
											<option value="판매">판매</option>
											<option value="품절">품절</option>
											</select>      			
								      	</td>
							    	</tr>
							      		
							    </table>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="submit" value="메뉴등록" id="submitButton">	
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
    </article>
  <%@include file="/bottomSide.jsp" %>
  </section>
  <script>
  	function upLoadpage(){
  		window.location.href = 'imgUpload.jsp';
  	}
  </script>
</body>
</html>