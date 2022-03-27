<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.guest.*" %>
<jsp:useBean id="gdao" class="com.guest.GuestDAO" scope="session"></jsp:useBean>
<%
int tNum=(int)(session.getAttribute("tNum"));
gdao.userIndate(tNum);

/**plus*/
int gIdx = gdao.getGIdx(tNum);
session.setAttribute("gIdx", gIdx);

%>
<script>
	location.href ='menuList.jsp';
</script>