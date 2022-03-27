<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>숫자 야구 게임</title>
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
			font-size: 30px;
			padding-top: 30px;
		}
		h3{
			text-align: center;
			font-size: 25px;
			padding-top: 10px;
		}
		.result{
			text-align: center;
			font-size: 25px;
			padding-top: 10px;
			font-weight: bold;
		}
		.result img{
			width: 20px;
		}
		.inputNumber table{
			margin: 30px auto;
			width: 700px;
			height: 300px;
		}
		.inputNumber table td{
			text-align: center;
		}
		#numBox{
			text-align: center;
			width: 200px;
			font-size: 150px;
			height: 250px;
		}
	    #button{
	      font-size: 40px;
	      font-weight: bold;
	      background-color: skyblue;
	      margin: 20px;
	      border-radius: 10px;
	    }
	    #button:hover{
	      background-color: red;
	    }
	    #button:active{
	      background-color: yellow;
	    }
	</style>
</head>
<%
String s_count = request.getParameter("count");
String s_num1 = request.getParameter("num1");
String s_num2 = request.getParameter("num2");
String s_num3 = request.getParameter("num3");
String s_com1 = request.getParameter("com1");
String s_com2 = request.getParameter("com2");
String s_com3 = request.getParameter("com3");
%>
<%
//Start Game Value
int count = 1;

// Computer Number
int com1 = 0;
int com2 = 0;
int com3 = 0;
int com[] = new int[3];
if(s_count==null || s_count.equals("")){ //IF Null
	
	for(int i=0; i<com.length; i++) {
		com[i] = (int)(Math.random()*9 + 1);
		for(int j=0; j<i; j++) {
			if(com[j]==com[i]) {	
				i--;
				break;
			}
		}
	}
	com1 = com[0];
	com2 = com[1];
	com3 = com[2];
}else{ //IF not Null
	com1 = Integer.parseInt(s_com1);
	com2 = Integer.parseInt(s_com2);
	com3 = Integer.parseInt(s_com3);
	com[0] = com1;
	com[1] = com2;
	com[2] = com3;
}

// User Number
int num1 = 1;
int num2 = 1;
int num3 = 1;
int user[] = new int[3];
if(s_count!=null){ //If Not Null
	count =  Integer.parseInt(s_count);
	num1 =  Integer.parseInt(s_num1);
	num2 =  Integer.parseInt(s_num2);
	num3 =  Integer.parseInt(s_num3);
	user[0] = num1;
	user[1] = num2;
	user[2] = num3;
}

int s = 0; //strike
int b = 0; //ball
for(int i=0; i<com.length; i++) {
	for(int j=0; j<user.length; j++) {
		if(com[i]==user[j] && i==j) {
			s ++;
		}else if(com[i]==user[j] && i!=j) {
			b ++;
		}
	}
}

//testCode
//System.out.println(""+com1 + com2 + com3); 
%>
<body onload="resultPage()">
	<%@include file="/userHeader.jsp" %>
	<section>
		<article>
			<div class="topSide">
			</div>
		</article>
		<article>
			<div class="centerSide">
				<h2>숫자 야구 게임</h2>
				<h3><%=count %> 회</h3>
				<div class="result"><img src="img/s.png">:<%=s %> <img src="img/b.png">:<%=b %></div>
				<div class="inputNumber">
					<form name="baseball" action="baseball.jsp">
						<input type="hidden" name="count" value="<%=count+1 %>">
						<input type="hidden" name="com1" value="<%=com1 %>">
						<input type="hidden" name="com2" value="<%=com2 %>">
						<input type="hidden" name="com3" value="<%=com3 %>">
						<table>
							<tr>
								<td><input type="number" id="numBox" name="num1" min="1" max="9" value="<%=num1 %>" required></td>
								<td><input type="number" id="numBox" name="num2" min="1" max="9" value="<%=num2 %>" required></td>
								<td><input type="number" id="numBox" name="num3" min="1" max="9" value="<%=num3 %>" required></td>
							</tr>
							<tr>
								<td colspan="3">
									<input type="submit" id="button" value="입력">
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
		function resultPage(){
			if(<%=count %>>10 || <%=s %>==3){
				window.location.href = 'baseball_ok.jsp?count=<%=count %>&s=<%=s %>&b=<%=b %>';
			}
		}
	</script>
</body>
</html>