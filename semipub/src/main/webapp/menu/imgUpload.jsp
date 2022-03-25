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
		.imgUpload{
			padding-top: 200px;
			text-align: center;	
		}
		fieldset{
			width: 900px;
			margin: 0px auto;
			font-size: 30px;
		}
		fieldset legend{
			font-size: 50px;
		}
		#fileButton{
			font-size:20px;
			width: 300px;
		}
		#upLoadButton{
			font-size:30px;
			background-color: skyblue;
			
		}
		#upLoadButton:hover{
		background-color: red;
		color: white;
	}
	</style>
</head>
<%
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
      	<div class="imgUpload">
      	<form name="imgUpload" action="imgUpload_ok.jsp" method="post" enctype="multipart/form-data">
			<fieldset>
				<legend>파일업로드</legend>
				<div>	
					파일선택 : <input type="file" name="img" id="fileButton" accept="image/*" required>
					<input type="submit" value="사진올리기" id="upLoadButton">
				</div>
			</fieldset>
		</form>
		</div>
      </div>
    </article>
  <%@include file="/bottomSide.jsp" %>
  </section>
</body>
</html>