<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
a:link{
      font-weight: bold;
      text-decoration: none;
      color: white;
    }
</style>
<%
String sname=(String)session.getAttribute("sname");
%>
<header>
  <div class="topMenu">
    <div>
      <img src="/semipub/img/pub.png" alt="logo">
      <h1>SEMI Pub</h1>
    </div>
    <div id="userName">
      <%=sname %>님 접속 | <a href="/semipub/adminLogout.jsp">로그아웃</a>
    </div>
    <nav>
      <ul>
        <a href="/semipub/order/orderList.jsp"><li id="menu_tag1">주문현황</li></a>
        <a href="/semipub/table/tableList.jsp"><li id="menu_tag2">테이블관리</li></a>
        <a href="/semipub/menu/menuCustom.jsp"><li id="menu_tag3">메뉴관리</li></a>
        <a href="/semipub/admin/salesList.jsp"><li id="menu_tag4">매출현황</li></a>
        <a href="/semipub/admin/memberList.jsp"><li id="menu_tag5">계정관리</li></a>
      </ul>
    </nav>
  </div>
</header>