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
String img = request.getParameter("img");
if(img==null){
	img="0.jpg";
}
int cateNum = Integer.parseInt(request.getParameter("cateNum"));
String mName = request.getParameter("mName");
int price = Integer.parseInt(request.getParameter("price"));
String state = request.getParameter("state");
int mIdx = Integer.parseInt(request.getParameter("mIdx"));

//System.out.println(cateNum);
//System.out.println(mName);
//System.out.println(price);
//System.out.println(state);
//System.out.println(mIdx);
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
      	<form name="imgEdit" action="imgEdit_ok.jsp?img=<%=img%>&cateNum=<%=cateNum%>&mName=<%=mName%>&price=<%=price%>&state=<%=state%>&mIdx=<%=mIdx%>" method="post" enctype="multipart/form-data">
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