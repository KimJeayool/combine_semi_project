<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.Cookie.CookieModule" %>
<jsp:useBean id="medao" class="com.menu.MenuDAO" scope="session"></jsp:useBean>
<jsp:useBean id="odao" class="com.order.OrderDAO" scope="session"></jsp:useBean>

<%
	String part = request.getParameter("part");
	String mIdx =	request.getParameter("mIdx");
	String mCount = request.getParameter("mCount");
	String s_total = request.getParameter("total");
	String mIdxes[] = request.getParameterValues("mIdx");
	int gIdx = (Integer) session.getAttribute("gIdx");
	
	Cookie cks[] = request.getCookies(); // Cookie List 
	
	switch(part){//At the Cart
	case "1" : 
		if(CookieModule.getCookie(mIdx, request)!=null){//Cookie already made
			%>
			<script>
				var result = window.confirm('장바구니에 있는 상품입니다. 수량을 추가하시겠습니까?');
				if(result){
					<%
					String bf = CookieModule.getCookie(mIdx, request);//beforeAmount
					 int af= Integer.parseInt(bf)+Integer.parseInt(mCount);
					CookieModule.setCookie(mIdx, af+"", 60*60*24, response);//before Cookie(mCount)+after Cookie(mCount)
					%>
					window.alert('수량이 추가되었습니다.');
					
				}
				window.location.href="menuList.jsp";
			</script>
			<%
			
		}else{//new Cookie make
			CookieModule.setCookie(mIdx, mCount, 60*60*24, response);
			%>
				<script>
				window.alert('장바구니에 상품이 담겼습니다.');
				window.location.href="menuList.jsp";
				</script>
			<%
		
		
		}
		break;
		
	case "2" :	//menu Count Changed
		for(int i=1; i<cks.length; i++){
			if(cks[i].getName().equals(mIdx)){
				CookieModule.setCookie(mIdx, mCount, 60*60*24, response);
				%>
				<script>
					window.alert('수량이 변경되었습니다.');
					window.location.href="menuCart.jsp";
				</script>
				<%
			}
		}
		break;
		
	case "3" :	//menu Delete 
		CookieModule.setCookie(mIdx, "", 0, response);
		%>
		<script>
			window.location.href="menuCart.jsp";
		</script><%
		break;
		
	case "4" :	//menu Order(SET MENU TABLE)
		int result = 0;
		for(int i=1; i<cks.length; i++){
			int i_mIdx = Integer.parseInt(cks[i].getName());
			int i_mCount = Integer.parseInt(cks[i].getValue());
			odao.sendOrder(gIdx, i_mIdx, i_mCount);
			CookieModule.setCookie(cks[i].getName(), "", 0, response);
			result++;
		}
		
		//plus totalAmount at GUEST TABLE
		if(result>0){
			if(s_total==null || s_total.equals("")) s_total="0";
			int total = Integer.parseInt(s_total);
			odao.setTotal(gIdx,total);
			%>
			<script>
				window.alert('<%=result%>개의 상품이 주문되었습니다.');
				window.location.href="menuCart.jsp";
			</script>
			<%
		}
		break;
	}

%>