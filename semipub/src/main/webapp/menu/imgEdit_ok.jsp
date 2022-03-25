<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<jsp:useBean id="medao" class="com.menu.MenuDAO"></jsp:useBean>
<%
String savepath="D:\\김재율\\totalSemi\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\semipub\\menu\\photos";
MultipartRequest mr=new MultipartRequest(request,savepath,10485760,"utf-8");
String img=mr.getFilesystemName("img");
int cateNum = Integer.parseInt(request.getParameter("cateNum"));
String mName = request.getParameter("mName");
int price = Integer.parseInt(request.getParameter("price"));
String state = request.getParameter("state");
int mIdx = Integer.parseInt(request.getParameter("mIdx"));
%>
<script>
location.href='menuEdit.jsp?img=<%=img%>&cateNum=<%=cateNum%>&mName=<%=mName%>&price=<%=price%>&state=<%=state%>&mIdx=<%=mIdx%>';
</script>