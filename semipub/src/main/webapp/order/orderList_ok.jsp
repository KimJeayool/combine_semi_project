<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>    
<jsp:useBean id="odao" class="com.order.OrderDAO"></jsp:useBean>    
<%
/**get Parameter*/
	String action = request.getParameter("action");
	String [] s_orders = request.getParameterValues("orders");
	String s_price = request.getParameter("price");
	String s_count = request.getParameter("count");

	if(s_count==null||s_count.equals("")){
		s_count="0";
	}
	int count = Integer.parseInt(s_count);
	
	
	if(s_price==null||s_price.equals("")){
		s_price="0";
	}
	int price = Integer.parseInt(s_price);

	ArrayList<Integer> orders = new ArrayList<Integer>();
	for(int i=0;i<s_orders.length;i++){
		orders.add(Integer.parseInt( s_orders[i]));
	}
	int result = 0;
	
/**order Cancel or Complete*/	
	if(action.equals("선택 취소")){
		result = odao.orderCancel(orders);
		//update guest total(-)
		odao.totalMinus(price, 2);
		
		
		%>
		<script>
			window.alert('<%=result%>개의 주문이 취소되었습니다.');			
			window.location.href="orderList.jsp";
			window.self.close();
		</script>
		<%		
	}else{
		result = odao.orderComplete(orders);	
		odao.totalPlus(price, 2);
		%>
		<script>
			window.alert('<%=result%>개의 주문이 완료되었습니다.');
			window.location.href="orderList.jsp";
			window.self.close();
		</script>
		<%		
	}	

	

%>