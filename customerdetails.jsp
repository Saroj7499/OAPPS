<%@ page import="java.sql.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	String email=(String)session.getAttribute("email");
	if (email == null) 
	{
		response.sendRedirect("http://localhost:8080/examples/jsp/UserHomepage.jsp");
	}
	String memail=session.getAttribute("email").toString();
	Connection con;
	Statement stmt;
	ResultSet rs=null;
	String ea="";
	String pa="";
	String ph="";
	String img="";
    	try
    	{
    		Class.forName("org.postgresql.Driver");
    		con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
    		stmt=con.createStatement();
    		rs=stmt.executeQuery("select cname,cphno,caddress from customer where cemail='"+memail+"'");    		
    		if(rs.next())
    		{
    			ea=rs.getString(1);ph=rs.getString(2);	pa=rs.getString(3);
    		}rs.close();
		rs=stmt.executeQuery("select pid,path,pname,price,description from product");
    	}
    	catch(Exception ex)	{out.println(ex);}
%>
<html><head><title>
OAPPS ADMINSIDE
</title>

<script type="text/javascript">
function check(){
	var name=document.addcust.name.value;
//	var phno=document.addcust.phno.value;
	var address=document.addcust.address.value;
	if(name=="" || phno=="" || address=="")
	{
		alert("fields cannot be blank");
		return false;
	}
}	
</script>
</head>
<body bgcolor="#ccddff">
<form method="post" action="pro.jsp">
<h1 align="center">Customer details</h1>
		<p align="center"> </p>
		<form name="addcust" method="post" action="#" onSubmit="return check()">
<table border="2" align="center" cellpadding="7" cellspacing="7">	
<tr>
<td><strong>Name</strong></td>
<td> <input type="text" name="name" id="item" value=<%=ea%>></td>
</tr>

<tr>
<td><strong>Phone no.</strong></td>
<td> <input type="text" name="phno" id="quan" value=<%=ph%>></td>
</tr>

<tr>
<td><strong>Address</strong></td>
<td> <input type="text" name="address" id="desc" value=<%=pa%>></td>
</tr>
<td> <input type="submit" value="Proceed">
</td>
</tr>
</table>

<table>
<%
while(rs.next())
{%>
<tr><td><input type="text" value=<%=rs.getString(1)%>></td></tr>
</table>
<%}%>
</form>
</body>
</html>
