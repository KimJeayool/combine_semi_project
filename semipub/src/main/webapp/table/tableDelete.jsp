<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="tdao" class="com.table.TableDAO" scope="session"></jsp:useBean>

<!-- Access for manager -->
<%@include file="/onlyManager.jsp"%>

<%
String s_maxNum = request.getParameter("maxNum");
if(s_maxNum==null || s_maxNum.equals("")){
	s_maxNum = "0";
}

int tNum = Integer.parseInt(s_maxNum); // Table Number to delete
int result = tdao.deleteTable(tNum);
String msg = (result>=1)? "테이블을 삭제하였습니다." : "테이블 삭제를 실패하였습니다.";
%>
<script>
	window.alert('<%=msg%>');
	window.location.href = 'tableList.jsp';
</script>