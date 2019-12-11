<html>
<head>
<!--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">-->
<title>Forgot password</title>
<link rel="stylesheet" href="Forgot.css">
<script>
function checkforblank(){
	var ema=document.forgotpwd.email.value;	
	var pet=document.forgotpwd.pet.value;
	if(pet="" || ema=="")
	{
		alert("please enter valid details");
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
<h1>FORGOT PASSWORD</h1>
<form name="forgotpwd"  methd="post" onSubmit="return checkforblank()">
<p>Enter email id</p><input type="email" name="email">
<p>Enter your pet's name</p><input type="text"  name="pet" autocomplete="off"><br>
<input type="submit" value="Submit" name="submits" method="post">
</form>
</div>
<%@ page import="java.sql.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	if(request.getParameter("submits")!=null)
	{
	    	String cemail=request.getParameter("email");
		String secure=request.getParameter("pet");
		Connection con;
		Statement stmt;
		PreparedStatement pstmt;
		ResultSet rs;
		String ea="";
		String pa="";
		try
    		{
    			Class.forName("org.postgresql.Driver");
    			con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
    			stmt=con.createStatement();
    			rs=stmt.executeQuery("select security,cemail from customer where cemail='"+cemail+"'");    
    			while(rs.next())
    			{
    				ea=rs.getString(1);
				pa=rs.getString(2);
			}
			if(ea.equals(secure) && pa.equals(cemail))
	    		{
				session.setAttribute("email",cemail);
				response.sendRedirect("change.jsp");	
	    		}
	    		else
	    		{
    				out.println("<script type=\"text/javascript\">");
				out.println("alert('Invalid details');");
				out.println("location='Forgot.jsp'");
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
