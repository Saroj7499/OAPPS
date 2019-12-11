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

<title>Save offers</title>
</head>
<body bgcolor="#ccddff">

<p>
<%
	try
{
		
		int counter,desid=1;
		String strdes="";
		Class.forName("org.postgresql.Driver");
		Connection con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
PreparedStatement ps=con.prepareStatement("select * from product");
Statement stmt=con.createStatement();
 ResultSet rs=ps.executeQuery();


int lastid=Integer.parseInt(request.getParameter("lastid").toString());
//out.println("--"+lastid);
String strdesid="str",pid="str",strpname="str",strprid="str",strpathid="str",strchid="str", strqid="str";
int i=1,mdis=1;
while(i<lastid)
    {
     String strid = "str"+i;
     //out.print("String id"+strid);
     String mid = request.getParameter(strid).toString();
     if(mid!=null)
	mdis = Integer.parseInt(mid);
  //  out.print("  "+mdis);
    String strupd="update product set discount=  "+ mdis +" where pid="+i    ;
    //out.print(strupd);
    //out.print("<br>");
    ps=con.prepareStatement(strupd);
    ps.executeUpdate();

	i++;
    }	out.println("<strong>UPDATED</strong>");
}
catch (Exception e)
{
	out.println(e);
}
%>
</p>
</body>
</html>
