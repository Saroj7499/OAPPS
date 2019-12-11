<%@ page import="java.sql.*"%>
<%@include file="navigation1.html" %>
<!doctype html public"-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Displaying Images</title>
<style>
.images {
  padding: 20px;
  transition: transform .2s;
  width: 100px;
  height: 100px;
  margin: 0 auto;
}

.images:hover {
  -ms-transform: scale(1.5); /* IE 9 */
  -webkit-transform: scale(1.5); /* Safari 3-8 */
  transform: scale(1.5); 
}

</style>
</head>
<body bgcolor="#ccddff">

<p>
<%
	try
{
	
Class.forName("org.postgresql.Driver");
Connection con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
PreparedStatement ps=con.prepareStatement("select * from product");
Statement stmt=con.createStatement();
 ResultSet rs=ps.executeQuery();
%>
</p>

<fieldset>
<legend> Product Information</legend>
<table>
<%while(rs.next())
{%>
<tr>
<td colspan=2>
Category:<%=rs.getString("category_name")+"\t"%>
</td>
</tr>
<tr>
<td>
<div style="">
<img border="1" src="<%=rs.getString("path") %>" heigth="160" width="160" class="images"/>
</td>

<td>
Id:<%=rs.getString("pid")+"\t"%><br>	
Name:<%=rs.getString("pname")+"\t"%>
<div align="left"><font color="blue">Description:<%=rs.getString("description")+"\t"%></font></div>
<div align="left">Price:<strike><%=String.format("Rs.%.2f",rs.getDouble("price"))+"\t"%></strike></div>
<% double mdiscountprice = 0.0;
   String strprice = String.valueOf(rs.getDouble("price"));
   double mprice = Double.parseDouble(strprice);

   int dis = rs.getInt("discount");
   //out.println(" "+dis);
   mdiscountprice = (mprice /100)* dis;
   mdiscountprice=mprice-mdiscountprice;
    //out.print(" "+mdiscountprice);
   out.println("Discount :");%>
   <font color="red"><%out.print(" "+dis);%>&percnt;</font>
   <font color="green"><%out.print(" Rs."+mdiscountprice);%></font>
   

<div align="left">Quantity:<%=rs.getString("pqty")+"\t"%></div>
<div align="left">Deleted? <%=rs.getString("deleted")+"\t"%></div>
</td>
</tr>
<%}%>
</table>
</fieldset>
<%
}
catch (Exception e)
{
	out.println(e);
}
 %>
</body>
</html>
