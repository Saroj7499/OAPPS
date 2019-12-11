<%@ page import="java.sql.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="Admin.jsp"%>
<%@include file="navigation1.html" %>
<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	String email=(String)session.getAttribute("email");
	if (email == null) 
	{
		response.sendRedirect("http://localhost:8080/examples/jsp/Admin.jsp");
	}

	
%><html>
<head>
<title>
OAPPS ADMINSIDE
</title>

<script type="text/javascript">
function check(){
	var id=document.additem.id.value;
	if(id=="")
	{
		alert("fields cannot be blank");
		return false;
	}
}	
</script>
</head>
<body bgcolor="#ccddff">
<h1 align="center">Update Item</h1>
		<p align="center"> </p>
		<form name="additem" method="post" action="http://localhost:8080/examples/jsp/update.jsp" onSubmit="return check()">
<table border="2" align="center" cellpadding="7" cellspacing="7">	
<tr>
<td><strong>Product Id</strong></td>
<td> <input type="text" name="id" id="id"></td>
</tr>

<td> &nbsp;</td>
<td> <input type="submit" value="Select">
<input type="reset" name="Reset" id="button" value="RESET"> </td>
</tr>
</table>
</form>
</body>
</html>
