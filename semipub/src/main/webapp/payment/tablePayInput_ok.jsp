<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.pay.*"%>
<%@ page import="com.guest.*" %>
<jsp:useBean id="pdto" class="com.pay.PayDTO" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="pdto"/>
<jsp:useBean id="pdao" class="com.pay.PayDAO" scope="session"></jsp:useBean>
<jsp:useBean id="gdao" class="com.guest.GuestDAO" scope="session"></jsp:useBean>
<%
int tNum = Integer.parseInt(request.getParameter("tNum")); // Table Number
int total = Integer.parseInt(request.getParameter("total")); // Total Price to pay
int payed = pdao.getPayed(pdto.getgIdx()); //
int price = pdto.getPrice();

// total >= (payed + price)
int result = 0;

//if(total==payed+price){
//	result += gdao.changeGuestState(pdto.getgIdx());
//}else if(total>payed+price){
//	result = pdao.inputPay(pdto);
//}
System.out.println(pdto.getaIdx());//test

if(total>=payed+price){ //27000 >=10000+17000
	result = pdao.inputPay(pdto); // Pay 1
	if(total==payed+price){
		result += gdao.changeGuestState(pdto.getgIdx()); // 미결제 -> 결제 1
		
	}
}
String msg = (result>0)? "결제 되었습니다." : "결제 실패했습니다.";
%>
<script>
	window.alert('<%=msg %>');
	switch(<%=result %>){
	case 0 : case 1 : 
		window.location.href = 'tablePayInput.jsp?tNum=<%=tNum %>&gIdx=<%=pdto.getgIdx() %>&total=<%=total %>';
		break;
	case 2 :
		window.location.href = '/semipub/table/tableList.jsp';
	}
</script>