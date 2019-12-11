<%@ page import="java.sql.*" session="true" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="navigation1.html" %>
<%
	try
	{
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	String email=(String)session.getAttribute("email");
	if (email == null) 
	{
		response.sendRedirect("http://localhost:8080/examples/jsp/Admin.jsp");
	}
	int pid=(Integer)session.getAttribute("amit");
	//int a=Integer.parseInt(pid);
	//out.println(pid);
	//int pid=0;
	//Integer.parseInt((String)session.getAttribute("amit"));
	//int pid=Integer.parseInt((String)(session.getAttribute("p_id")));	
	//int pid=Integer.parseInt(request.getParameter("pid"));
        int pqty=Integer.parseInt(request.getParameter("pqty"));
	double price=Double.parseDouble(request.getParameter("price"));
	String description=request.getParameter("description");
	String deleted=request.getParameter("del");
		Class.forName("org.postgresql.Driver");
		Connection con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
		Statement stmt=null;
		Statement stmt2=con.createStatement();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		stmt=con.createStatement();
		rs=stmt.executeQuery("select * from product where pid="+pid);
		String query2="update product set pqty="+pqty+",description='"+description+"',price="+price+", deleted='"+deleted+"' where pid="+pid;
			//out.print(query2);
			out.println("<center><h1>Product details updated</h1></center>");
			stmt2.executeUpdate(query2);
	}
	catch(Exception eo){
		out.println(eo);
	}
%>
