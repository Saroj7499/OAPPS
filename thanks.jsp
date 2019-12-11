<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="UserHomepage.jsp"%>
<%@ page import="java.io.*"%>
<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	String email=(String)session.getAttribute("email");
	if (email == null) 
	{
		response.sendRedirect("http://localhost:8080/examples/jsp/UserHomepage.jsp");
	}
%>
<%@include file="navigation.html" %>
<%
out.println("<strong>Thank you for shopping , your order will be delivered within 1 week</strong><a href='http://localhost:8080/examples/jsp/UserHomepage1.jsp'>Continue Shopping!!!</a>");
%>
