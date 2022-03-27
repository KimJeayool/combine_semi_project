<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.order.*" %>
<jsp:useBean id="odto" class="com.order.OrderDTO" scope="page"></jsp:useBean>    
<jsp:useBean id="odao" class="com.order.OrderDAO" scope="session"></jsp:useBean>
<%
int gIdx = Integer.parseInt(request.getParameter("gIdx"));
int result = odao.updateOutdate(gIdx);
String msg = "";
String url = "";

	if(result==1){ 
		msg = "결제요청을 전달하였습니다";
		url = "userEnter.jsp";
	}else{
		msg = "결제요청 중 에러가 발생했습니다.";
		url = "orderHistory.jsp";
	}

//Out Guest
session.removeAttribute("gIdx");
	
 %>
 <script>
	window.alert('<%=msg%>');
	window.location.href = '<%=url%>';
</script>