<%@ page import="java.sql.*,java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="UserHomepage.jsp"%>
<%@include file="navigation.html" %>
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
<!doctype html public"-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Display</title>
</head>
<body bgcolor="#ccddff">
<p>
<%
	try
{
	
		Class.forName("org.postgresql.Driver");
		Connection con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
PreparedStatement ps=con.prepareStatement("select path,pname,ord.odate,price,discount,ord.ostatus from orderdetails o,orders ord,product p where o.pid=p.pid and ord.oid=o.oid and ord.ostatus='yes'");
Statement stmt=con.createStatement();
 ResultSet rs=ps.executeQuery();
%>
</p>
<fieldset>
<legend> Your Orders </legend>
<table border=1>
<tr>
<th colspan=2>Product</th><th>Order date</th><th>Price</th><th>Order status</th>
</tr>
<%
 int i;
while(rs.next())
{

		double mdiscountprice = 0.0;
           //String strprice       = String.valueOf(rscatalog.getDouble("price"));
           //double mprice 	 = Double.parseDouble(strprice);
	   //int    dis 		 = rscatalog.getInt("discount");
   //out.println(" "+dis);
	   double mprice=Double.parseDouble(rs.getString("price"));
	   int discount=Integer.parseInt(rs.getString("discount"));
   	   mdiscountprice 	 = (mprice /100)* discount;
   	   mdiscountprice	 = mprice-mdiscountprice;
//   	   out.println("Discount:");
//    	   out.print("Rs."+mdiscountprice);

%><tr><td><img border="1" src="<%=rs.getString("path")%>" heigth="160" width="160"/></td>
	<td><%=rs.getString("pname")%></td>		
	<td><%=rs.getString("odate")%></td>
	<td><%=mdiscountprice%></td>
	<td><%=rs.getString("ostatus")%></td>
</tr>
<%}%>
</table>
</fieldset>
<%
}
catch (Exception e)
{
	out.println();
}
 %>
</body>
</html>
