<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.menu.*" %>

<jsp:useBean id="medao" class="com.menu.MenuDAO"></jsp:useBean>
<%
String savepath="D:\\김재율\\totalSemi\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\semipub\\menu\\photos";
//int mIdx = Integer.parseInt(request.getParameter("mIdx"));
String mName = request.getParameter("mName");
int cateNum = Integer.parseInt(request.getParameter("cateNum"));
int price = Integer.parseInt(request.getParameter("price"));
String state = request.getParameter("state");
String img = request.getParameter("img");

int result=medao.menuInsert(mName,cateNum,price,state,img);
String msg=result>0?"등록 성공!":"등록 실패!";
%>
<script>
window.alert('<%=msg%>');
location.href='menuCustom.jsp';
</script>