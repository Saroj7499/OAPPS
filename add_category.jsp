<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="Admin.jsp"%>
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
%>
<html>
<head> <title> OAPPS ADMIN SIDE </title>
<script type="text/javascript">
function check(){
	var cat=document.addcat.cat.value;
	if(cat=="")
	{
		alert("fields cannot be blank");
		return false;
	}
}	
</script>	

</head>
<body bgcolor="#ccddff">
<h1 align="center"> Add Category</h1>
<p align="center"> </p>


<form name="addcat" method="post" action="http://localhost:8080/examples/jsp/add_cat12.jsp" onSubmit="return check()">
<table border="2" align="center" cellpadding="7" cellspacing="7">	
<tr>
<td width="309"><strong> Add Category </strong> </td>
<td width="277"><input type="text" name="cat" id="cat">
<input type="submit" value="submit"></td>
</tr>
</table>
</form>
</body>
</html>
