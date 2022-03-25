<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.menu.*" %>
<jsp:useBean id="mdto" class="com.menu.MenuDTO"></jsp:useBean>
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="medao" class="com.menu.MenuDAO"></jsp:useBean>
<jsp:useBean id="wfs" class="com.wf.WebFolderService" scope="session"></jsp:useBean>
<%
String savepath="D:\\김재율\\totalSemi\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\semipub\\menu\\photos";
String img=request.getParameter("img");
int result=medao.menuDelete(mdto);
wfs.delete(img);
String msg=result>0?"삭제 성공!":"삭제 실패!";
%>
<script>
window.alert('<%=msg%>');
location.href='menuCustom.jsp';
</script>