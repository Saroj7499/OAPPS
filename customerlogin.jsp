<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="UserHomepage.jsp"%>
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

<%@ page import="java.io.*,java.sql.*"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
<%
	if(request.getParameter("login")!=null)
	{
    	String cpwd=request.getParameter("p");
    	String cemail=request.getParameter("email");
        //String cart="";

    	Connection con;
	Statement stmt;
	ResultSet rs;
	String ea="";
	String pa="";
    	try
    	{
    		Class.forName("org.postgresql.Driver");
    		con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
    		stmt=con.createStatement();
    		rs=stmt.executeQuery("select cemail,cpwd from customer where cemail='"+cemail+"'and cpwd='"+cpwd+"'");    		
    		while(rs.next())
    		{
    			ea=rs.getString(1);
			pa=rs.getString(2);	
    		}
		if(ea.equals(cemail) && pa.equals(cpwd))
	    	{
			session.setAttribute("email",cemail);
            		response.sendRedirect("http://localhost:8080/examples/jsp/UserHomepage1.jsp");
	    	}
	    	else
	    	{
    			out.println("<script type=\"text/javascript\">");
			out.println("alert('You are not registered');");
			out.println("location='User.jsp'");
			out.println("</script>");	
		}
    		
    	}
    	catch(Exception ex)
    	{
    		out.println(ex);
    	}
	}
    %>
    </body>
</html>
