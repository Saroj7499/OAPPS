<body bgcolor="#ccddff">
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
	String cat=request.getParameter("cat");
        //int pid=Integer.parseInt(request.getParameter("id"));
	String pname=request.getParameter("item");
	String pqty=request.getParameter("quan");
	String description=request.getParameter("desc");
	String price=request.getParameter("cost");
	String path=request.getParameter("path");
	try
	{	
		Class.forName("org.postgresql.Driver");
		Connection con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
		Statement stmt=null;
		Statement stmt2=con.createStatement();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		stmt=con.createStatement();


               ResultSet rsprod = stmt.executeQuery("Select max(pid) as newpid from product"); 
               int mnewpid =101;
                
                 if(rsprod.next())
                        //mnewpid = Integer.parseInt(rsprod.getInt("newpid"));
                        mnewpid = rsprod.getInt("newpid")+1;
                else 
                        mnewpid =1;
                
		//out.print("new pid="+mnewpid);

		rs=stmt.executeQuery("select * from product where category_name='"+cat+"' and pname='"+pname+"'");
		if(rs.next())
		{
			out.print("<center><h1>This entry is already there</h1><center>");
		}
		else
		{
			String query2="insert into product values("+mnewpid+",'"+pname+"',"+pqty+",'"+description+"',"+price+",'"+path+"','"+cat+"')";
			//out.print(" new pid "+mnewpid);
			out.println("<center><h1>This item is succesfully inserted..</h1></center>");
                         //out.print("oldquery="+query2);
			stmt2.executeUpdate(query2);
		}

	}
	catch(Exception e){
		out.println(e);
	}
%>
