<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.table.*" %>
<jsp:useBean id="tdto" class="com.table.TableDTO" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="tdto"/>
<jsp:useBean id="tdao" class="com.table.TableDAO" scope="session"></jsp:useBean>
<% 
int tNum = Integer.parseInt(request.getParameter("tNum"));
int result = 0;
String msg = "";
String url = "";

// Check ID to able to use
boolean canUse = tdao.checkId(tdto.gettId());
if(canUse==true){ //can
	result = tdao.addTable(tdto); //input info to DB(geust_table)
	msg = (result>=1)? "테이블을 추가하였습니다." : "테이블 추가를 실패하였습니다.";
	url = "tableList.jsp";
}else{ //can not
	msg = "사용할 수 없는 아이디입니다.";
	url = "tableAdd.jsp?maxNum=" + tNum;
} 
%>
<script>
	window.alert('<%=msg%>');
	window.location.href = '<%=url%>';
</script>