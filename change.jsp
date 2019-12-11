<%@ page import="java.sql.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="Forgot.jsp"%>
<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	String email=(String)session.getAttribute("email");
	if (email == null) 
	{
		response.sendRedirect("http://localhost:8080/examples/jsp/Forgot.jsp");
	}
	out.print(email);
%>
<html>
<head>
<!--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">-->
<title>Forgot password</title>
<link rel="stylesheet" href="Forgot.css">
<script>
function checkforblank(){
	var pass=document.forgotpwd.pass.value;	
	if(pass=="" || email=="")
	{
		alert("please enter valid details");
		return false;
	}
	else if(pass.length<6 || pass.length>12)
	{
		alert("password must be 6 to 12 characters long");
		return false;
	}
	else
	{
		return true;
	}
}	
</script>	
</head>
<body>
<div class="loginbox">
<form name="forgotpwd"  methd="post" onSubmit="return checkforblank()" action="http://localhost:8080/examples/jsp/change1.jsp">

<p>Create password</p><input type="password" name="pass">
<input type="submit" value="Submit" name="submits">
</form>
</div>
</body>
</html>
