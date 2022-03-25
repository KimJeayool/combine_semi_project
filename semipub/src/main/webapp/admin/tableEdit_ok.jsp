<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="tdto" class="com.table.TableDTO" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="tdto"/>
<jsp:useBean id="tdao" class="com.table.TableDAO" scope="session"></jsp:useBean>
<%
int result=tdao.editTable(tdto);
String msg=result>0?"수정이 완료되었습니다.":"수정에 실패하였습니다.";
%>
<script>
window.alert('<%=msg%>');
location.href='tableList.jsp';
</script>