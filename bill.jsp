<%@ page import="java.sql.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="Admin.jsp"%>
<%@include file="navigation.html" %>
<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	String email=(String)session.getAttribute("email");
	if (email == null) 
	{
		response.sendRedirect("http://localhost:8080/examples/jsp/Admin.jsp");
	}
	out.println("mail "+email);
	Connection con;
	Statement stmt;
	ResultSet rs=null;
	String ea="";
	String pa="";
	String ph="";
	String img="";
%>
<form method="post" action="billsave.jsp">
<%
    	try
    	{
    		Class.forName("org.postgresql.Driver");
    		con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
    		stmt=con.createStatement();
    		rs=stmt.executeQuery("select cname,cphno,caddress from customer where cemail='"+email+"'");    		         %><pre><%
    		if(rs.next())
    		{
    		%>
                        Customer Name   :<input type="label" name="custname" value=<%=rs.getString(1)%>>
                Confirm Customer Phone  <input type = "text" name = "mphno" value =<%=rs.getString(2)%>>
                Confirm Delivery Address<input type ="text" name ="maddress" value =<%=rs.getString(3)%>>
                <%      
    		}rs.close();
                 %><pre><%
		//rs=stmt.executeQuery("select pid,path,pname,price,description from product");
    	}
    	catch(Exception ex)	{out.println(ex);}
%>
<input	type="submit" value="confirm">
</form>
