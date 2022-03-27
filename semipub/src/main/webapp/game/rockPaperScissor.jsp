<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>가위 바위 보 게임</title>
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
	      text-align: center;
	      padding: 20px;
	    }
	    table{
	      margin: 0px auto;
	    }
	    table img{
	      width: 350px;
	    }
	    table td{
	      text-align: center;
	    }
	    table #button{
	      width: 100px;
	      font-size: 18px;
	      border-radius: 50%;
	      font-weight: bold;
	    }
	    .buttonArea{
	      margin: 15px;
	      text-align: center;
	      font-size: 30px;
	    }
	    .buttonArea #button{
	      font-size: 20px;
	      font-weight: bold;
	      background-color: skyblue;
	    }
	    #button:hover{
	      background-color: red;
	    }
	    #button:active{
	      background-color: yellow;
	    }
	    #player1, #player2{
	      font-size: 0px;
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
		    	<h2>가위 바위 보 게임</h2>
        		<div>
          		<table>
            			<tr>
              				<td id="box1">
                				<img src="img/1.png" alt="play1" id="img1">
                				<span id="player1"></span>
              				</td>
              				<td id="box2">
                				<img src="img/1.png" alt="play1" id="img2">
                				<span id="player2"></span>
              				</td>
            			</tr>
            			<tr>
              				<td>
                				<input type="button" value="스톱!" id="button" onclick="stopPlay1(); result();">
              				</td>
              				<td>
                				<input type="button" value="스톱!" id="button" onclick="stopPlay2(); result();">
              				</td>
            			</tr>
          			</table>
       			</div>
       			<div class="buttonArea">
         			 <input type="button" value="다시하기" id="button" onclick="replay()">
         			 <input type="button" value="목록보기" id="button" onclick="viewList()">
        		</div>
		    </div>
		</article>
		<%@include file="/bottomSide.jsp" %>
	</section>
	<script>
      function changeImg1(){
        var num1 = Math.floor(Math.random()*3)+1;
        document.getElementById('img1').src = 'img/'+num1+'.png';
        document.getElementById('player1').textContent = num1;
      }
      
      function changeImg2(){
        var num2 = Math.floor(Math.random()*3)+1;
        document.getElementById("img2").src = 'img/'+num2+'.png';
        document.getElementById('player2').textContent = num2;
      }

      var play1 = setInterval(changeImg1,50);
      var play2 = setInterval(changeImg2,50);

      function stopPlay1(){
        clearInterval(play1);
        stop1 = true;
      }
      function stopPlay2(){
        clearInterval(play2);
        stop2 = true;
      }
      function replay(){
        window.location.reload();
      }
      function viewList(){
        window.location.href = 'gameList.jsp';
      }
      
      function result() {
        if(stop1==true && stop2==true){
          var player1 = document.getElementById('player1').textContent;
          var player2 = document.getElementById('player2').textContent;
          if(player1==player2){
            document.getElementById('box1').style.backgroundColor = 'yellow';
            document.getElementById('box2').style.backgroundColor = 'yellow';
          }else if((player1+1)%3==player2%3){
            document.getElementById('box1').style.backgroundColor = 'red';
            document.getElementById('box2').style.backgroundColor = 'green';
          }else {
            document.getElementById('box1').style.backgroundColor = 'green';
            document.getElementById('box2').style.backgroundColor = 'red';
          }
        }
      }
    </script>
</body>
</html>