<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>    
<jsp:useBean id="odao" class="com.order.OrderDAO" scope="session"></jsp:useBean>    
<%
/**get Parameter*/
	int gIdx = Integer.parseInt(request.getParameter("gIdx")); 
	String action = request.getParameter("action");
	String [] s_orders = request.getParameterValues("orders");
	String s_price = request.getParameter("price");
	String s_count = request.getParameter("count");
	

	ArrayList<Integer> orders = new ArrayList<Integer>();
	for(int i=0;i<s_orders.length;i++){
		orders.add(Integer.parseInt( s_orders[i]));
	}
	int result = 0;
	
/**order Cancel or Complete*/	
	if(action.equals("선택 취소")){//orderCancel
		//Update stNum(3) of Semi_order table 
		result = odao.orderCancel(orders);
	
		for(int i=0; i<s_orders.length; i++){
			int oIdx = Integer.parseInt(s_orders[i]);
			int price = odao.getOrderPrice(oIdx);
			int gIdx2 = odao.getGIdx(oIdx);
			odao.totalMinus(price, gIdx2);
		}
	
		//Update Total(-) of Guest table
		
		
		%>
		<script>
			window.alert('<%=result%>개의 주문이 취소되었습니다.');			
			window.location.href="orderList.jsp";
			window.self.close();
		</script>
		<%		
	}else{//order Complete
		//Update stNum(2) of Semi_order table
		result = odao.orderComplete(orders);
		
		//Update Total(+) of Guest table
		//odao.totalPlus(total, gIdx);
		%>
		<script>
			window.alert('<%=result%>개의 주문이 완료되었습니다.');
			window.location.href="orderList.jsp";
			window.self.close();
		</script>
		<%		
	}	

	

%>