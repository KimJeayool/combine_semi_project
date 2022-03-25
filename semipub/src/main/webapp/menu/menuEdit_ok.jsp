<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.menu.*" %>
<jsp:useBean id="mdto" class="com.menu.MenuDTO"></jsp:useBean>
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="medao" class="com.menu.MenuDAO"></jsp:useBean>
<%
String savepath="D:\\김재율\\totalSemi\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\semipub\\menu\\photos";
int result=medao.menuEdit(mdto);
String msg=result>0?"수정 성공!":"수정 실패!";
%>
<script>
window.alert('<%=msg%>');
location.href='menuCustom.jsp';
</script>