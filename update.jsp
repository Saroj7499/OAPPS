<body bgcolor="#ccddff">
<%@ page import="java.sql.*" session="true" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	int pid=Integer.parseInt(request.getParameter("id"));
	out.print(pid);
	session.setAttribute("amit",pid);
	//String pqty=request.getParameter("quan");
	//String description=request.getParameter("desc");
	//String price=request.getParameter("cost");
	try
	{	
		Class.forName("org.postgresql.Driver");
		Connection con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
		Statement stmt=null;
		Statement stmt2=con.createStatement();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String id="";
		int ids=0;
		stmt=con.createStatement();
		rs=stmt.executeQuery("select * from product where pid="+pid);
		//http://localhost:8080/examples/jsp/updatesave.jsp
                %><body><form method="post" action="updatesave.jsp" >
		<table><%
  		if(rs.next())
                {
			//ids=rs.getInt("pid");out.print("<br><br><br>"+ids);
                 %>
		
		<tr><td>Id:<input type="text" name="pid" value=<%=rs.getInt("pid")%> disabled="disabled"></td></tr>
               <tr><td>Name:<input type ="text" name ="pname" value =<%=rs.getString("pname")%> disabled ="disabled"></td></tr>
               <tr><td>Quantity:<input type ="text" name="pqty" value =<%=rs.getInt("pqty")%>></td></tr>
               <tr><td>Description:<input type ="text" name="description" value =<%=rs.getString("description")%>></td></tr>
               <tr><td>Price<input type ="text" name="price" value =<%=rs.getString("price")%>></td></tr>
               <tr><td>Path<input type ="text" name="path" value =<%=rs.getString("path")%> disabled="disabled"></td></tr>
	       <tr><td>Category<input type ="text" name="category_name" value =<%=rs.getString("category_name")%> disabled ="disabled"></td></tr>
		<tr><td>Delete this product<input type ="text" name="del" placeholder="yes or no" value =<%=rs.getString("deleted")%>></td></tr>
		<tr><td><input type="submit" value="send"></td></tr>
                <%
                 }
		else
		{
			out.print("<strong>This item does not exist</strong>");
		}
		//session.setAttribute("p_id",pid);
                %></table></form></body>
<%
	}
	catch(Exception e){
		out.println("Data is stored");
	}
%>

