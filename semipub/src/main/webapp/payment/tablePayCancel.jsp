<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.pay.*" %>
<jsp:useBean id="pdao" class="com.pay.PayDAO" scope="session"></jsp:useBean>
<%
int tNum = Integer.parseInt(request.getParameter("tNum"));
int total = Integer.parseInt(request.getParameter("total"));
int gIdx = Integer.parseInt(request.getParameter("gIdx"));

String s_pidx = request.getParameter("payIdx");
int payIdx = Integer.parseInt(s_pidx);

int result = pdao.payedCancel(payIdx);
String msg = (result>0)? "결제가 취소되었습니다." : "결제 취소를 실패하였습니다.";
%>
<script>
	window.alert('<%=msg %>');
	window.location.href = 'tablePayInput.jsp?tNum=<%=tNum %>&gIdx=<%=gIdx %>&total=<%=total %>';
</script>