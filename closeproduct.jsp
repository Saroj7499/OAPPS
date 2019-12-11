<%@ page import="java.sql.*"%>
<%@include file="navigation1.html" %>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="Admin.jsp"%>
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

<!doctype html public"-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Update offers</title>
<style>
.images {
  padding: 20px;
  transition: transform .2s;
  width: 100px;
  height: 100px;
  margin: 0 auto;
}

.images:hover {
  -ms-transform: scale(1.5); /* IE 9 */
  -webkit-transform: scale(1.5); /* Safari 3-8 */
  transform: scale(1.5); 
}

</style>
</head>
<body bgcolor="#ccddff">

<p>
<%
int counter,desid=1;
	try
{
		
		String strdes="";
		Class.forName("org.postgresql.Driver");
		Connection con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
PreparedStatement ps=con.prepareStatement("select * from product");
Statement stmt=con.createStatement();
 ResultSet rs=ps.executeQuery();
%>
</p>
<form action="saveoffers.jsp" method="post">
<fieldset>
<legend> Product Information</legend>
<table border=1% width=100%>
<tr><th>Name</th><th>Description</th><th>Price</th><th>Quantity</th><th>Discount</th>
<%while(rs.next())
{%>
<tr>
<td><%=rs.getString("pname")+"\t"%></td>
<td><%=rs.getString("description")+"\t"%></td>
<td><%=String.format("$%.2f",rs.getDouble("price"))+"\t"%></td>
<td><%=rs.getString("pqty")+"\t"%></td>
<% strdes = "str"+desid++;%>
<td><input type="text" name=<%=strdes%> value =<%=rs.getInt("Discount")+"\t"%>> percent   <%=strdes%></td>
</tr>
<%}%>
</table>
<input type="submit" value="value offers">
</fieldset>
<%
}
catch (Exception e)
{
	out.println(e);
}

 %>
<input type ="hidden" name="lastid" value = <%=desid%>> 
</body>
</html>
