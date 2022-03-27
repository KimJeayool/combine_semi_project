<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import ="com.Cookie.CookieModule" %>
 
 <%
 String viewNum = ""+session.getAttribute("tNum");
 %>
 
<header>
  <div class="topMenu">
    <div>
      <img src="/semipub/img/pub.png" alt="logo">
      <h1>SEMI Pub</h1>
    </div>
    <div id="userName">
      <%=viewNum %>번 테이블
    </div>
    <%
    int cartCnt=0;
     if(CookieModule.cookieCnt(request)>0){
    	 cartCnt = CookieModule.cookieCnt(request);
     } 
    
    %>
    <nav>
      <ul>
        <a href="/semipub/user/menuList.jsp"><li id="menu_tag1">메뉴</li></a>
        <a href="#"><li id="menu_tag2"></li></a> <!-- Matching Table -->
        <a href="/semipub/game/gameList.jsp"><li id="menu_tag3">게임</li></a>
        <a href="/semipub/user/menuCart.jsp"><li id="menu_tag4">장바구니<%=cartCnt-1>0?"("+(cartCnt-1)+")":"" %></li></a>
        <a href="/semipub/user/orderHistory.jsp"><li id="menu_tag5">주문내역</li></a>
      </ul>
    </nav>
  </div>
</header>