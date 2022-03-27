<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>    
<jsp:useBean id="odao" class="com.order.OrderDAO"></jsp:useBean>    
<%
/**get Parameter*/
	int gIdx = Integer.parseInt(request.getParameter("gIdx")); 
	String action = request.getParameter("action");
	String [] s_orders = request.getParameterValues("orders");
	String s_price = request.getParameter("price");
	String s_count = request.getParameter("count");
	
	
	String s_size = request.getParameter("size");
	int size = Integer.parseInt(s_size);
	
	int total = 0;
	for(int i=0; i<size; i++){
		int price = Integer.parseInt((request.getParameter("price"+i)));
		int count = Integer.parseInt((request.getParameter("count"+i)));
		total += price*count;
	}
	
	System.out.println("total:" + total);//testcode
	

	//if(s_count==null||s_count.equals("")){
	//	s_count="0";
	//}
	//int count = Integer.parseInt(s_count);
	
	//if(s_price==null||s_price.equals("")){
	//	s_price="0";
	//}
	//int price = Integer.parseInt(s_price);
	
	//int total = price*count;

	ArrayList<Integer> orders = new ArrayList<Integer>();
	for(int i=0;i<s_orders.length;i++){
		orders.add(Integer.parseInt( s_orders[i]));
	}
	int result = 0;
	
/**order Cancel or Complete*/	
	if(action.equals("선택 취소")){//orderCancel
		//Update stNum(3) of Semi_order table 
		result = odao.orderCancel(orders);
	
		//Update Total(-) of Guest table
		odao.totalMinus(total, gIdx);
		
		
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