<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.invalidate();
response.sendRedirect("http://localhost:9090/semipub/index.jsp"); //다시 메인으로 돌아감
%>