<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게임 메인 화면</title>
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
		h2{
      		font-size: 30px;
      		padding: 30px 0px 60px 0px;
      		text-align: center;
    	}
	    table{
		    margin: 0px auto;
		    width: 1000px;
		    height: 300px;
	    }
	    table img{
	     	width: 200px;
	    }
	    table td{
		    text-align: center;
		    font-size: 25px;
		    font-weight: bold;
		    border-radius: 10px;
	    }
	    table a{
		    text-decoration: none;
		    color: black;
	    }
	    table td:hover {
	      	background-color: blanchedalmond;
	    }
	    table td:hover img{
	    	width: 250px;
	    }
	</style>
</head>
<body>
  <%@include file="/userHeader.jsp" %>
  <section>
		<article>
		  <div class="topSide">
		  </div>
		</article>
	    <article>
	      <div class="centerSide">
	        <h2>미니 게임</h2>
	        <div>
	          <table>
	            <tr>
	              <td>
	                <a href="rockPaperScissor.jsp">
	                  <div>
	                    <img src="img/rock-paper-scissors.png" alt="">
	                    <div>가위바위보</div>
	                  </div>
	                </a>
	              </td>
	              <td>
	                <a href="baseball.jsp">
	                  <div>
	                    <img src="img/baseball.png" alt="">
	                    <div>야구게임</div>
	                  </div>
	                </a>
	              </td>
	              <td>
	                <a href="twentyHills.jsp">
	                  <div>
	                    <img src="img/hill.png" alt="">
	                    <div>스무고개</div>
	                  </div>
	                </a>
	              </td>
	              <td>
	                <a href="lottery.jsp">
	                  <div>
	                    <img src="img/lottery.png" alt="">
	                    <div>로또</div>
	                  </div>
	                </a>
	              </td>
	            </tr>
	          </table>
	        </div>
	      </div>
	    </article>
  		<%@include file="/bottomSide.jsp" %>
  </section>
</body>
</html>