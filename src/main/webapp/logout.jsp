<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp" %>
<% 
	session.removeAttribute("secret");
    session.removeAttribute("loginname"); 
    session.removeAttribute("usertype");
    session.removeAttribute("op_id");
    session.removeAttribute("userPurview");
    session.removeAttribute("cus_id");
    session.removeAttribute("userid");
	response.sendRedirect("login.jsp");
%>