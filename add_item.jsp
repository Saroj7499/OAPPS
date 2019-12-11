<%@page language="java" import="java.sql.*"%>
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
<head>
<title>
OAPPS ADMINSIDE
</title>

<script type="text/javascript">
function check(){
	var cat=document.additem.cat.value;
//	var id=document.additem.id.value;
	var item=document.additem.item.value;
	var quan=document.additem.quan.value;
	var desc=document.additem.desc.value;
	var cost=document.additem.cost.value;
	var path=document.additem.path.value;
	if(cat=="" || item=="" || quan=="" || desc=="" || cost=="" || path=="")
	{
		alert("fields cannot be blank");
		return false;
	}
}	
</script>
</head>
<body bgcolor="#ccddff">

<h1 align="center"> Add Item</h1>
		<p align="center"> </p>
		<form name="additem" method="post" action="http://localhost:8080/examples/jsp/item_add.jsp" onSubmit="return check()">
<table border="2" align="center" cellpadding="7" cellspacing="7">	
<tr>
	<td width="309"><strong>Select Category</strong> </td>
	<td width="277"><select name="cat">
	<option value="" selected>--Select--</option>
	<%
		try
	{	
		Class.forName("org.postgresql.Driver");
		Connection con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
		Statement stmt=con.createStatement();
                

		ResultSet rs= stmt.executeQuery("Select * from category");
		while(rs.next())
		{
			%>
			<option value="<% String catg12=rs.getString(1); out.print(catg12); %>"><% out.print(catg12);%> </option>
	<%
		}
	out.print("<select>");
	}
	catch(Exception e)
	{
		out.println(e);
	}	
%>
</td>
</tr>

<tr>
<td><strong> Add Product</strong></td>
<td> <input type="text" name="item" id="item"></td>
</tr>

<tr>
<td><strong> Add Quantity</strong></td>
<td> <input type="text" name="quan" id="quan"></td>
</tr>

<tr>
<td><strong> Add Description</strong></td>
<td> <textarea rows=10 cols=40 name="desc" id="desc"></textarea></td>
</tr>

<tr>
<td><strong> Add Cost</strong></td>
<td> <input type="text" name="cost" id="cost"></td>
</tr>

<tr>
<td><strong> Add Path</strong></td>
<td> <input type="file" name="path" id="path"></td>
</tr>
<tr>
<td> &nbsp;</td>
<td> <input type="submit" value="ADD">
<input type="reset" name="Reset" id="button" value="RESET"> </td>
</tr>
</table>
</form>
</body>
</html>
