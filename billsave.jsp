<%@ page import="java.sql.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="Admin.jsp"%>
<%@include file="navigation.html" %>
<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	String email=(String)session.getAttribute("email");
        //String mbid = (String)session.getAttribute("bid");
	if (email == null) 
	{
		response.sendRedirect("http://localhost:8080/examples/jsp/Admin.jsp");
	}
	out.println("mail "+email);
	Connection con;
	Statement stmt,stmt1,stmt2;
	ResultSet rs=null;
	String ea="";
	String pa="";
	String ph="";
	String img="";
%>
<form method="post" action="thanks.jsp">
<%
    	try
    	{
    		Class.forName("org.postgresql.Driver");
    		con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
    		stmt=con.createStatement();
		stmt1=con.createStatement();
		stmt2=con.createStatement();
                String mph= request.getParameter("mphno");
                String madd = request.getParameter("maddress");
 
                String s= "update customer set cphno ='"+mph+"' , caddress ='"+madd+"' where cemail='"+email+"'";
                //out.println(s);
    		stmt.executeUpdate(s); 
                if(session.getAttribute("bno")!=null)  
                     {
                      
                      String mbid= session.getAttribute("bno").toString();
                      int ibid = Integer.parseInt(mbid);
 		     // out.println("------"+ibid);
                      String ss = "update bill set bstatus='paid' where bid="+ibid;
                      //out.println(ss);
                      stmt1.executeUpdate(ss);
		      String orderstatus="update orders set ostatus='yes' where oid=(select oid from bill where bid="+ibid+")";
		      //out.println(orderstatus);
		      stmt2.executeUpdate(orderstatus);
			out.println("<br><br>Proceed to buy");
                     }
                else
                     out.println("Not finding bill number");
    	}
    	catch(Exception ex)	{out.println(ex);}
%>
<input	type="submit" value="BUY">
</form>
