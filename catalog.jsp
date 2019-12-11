<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="UserHomepage.jsp"%>
<%@ page import="java.io.*,java.sql.*"%>
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
<%@include file="navigation.html" %>
<HTML>
    <HEAD><TITLE>Navigating in a Database Table </TITLE>
<style>
.tooltip {
  position: relative;
  display: inline-block;
  border-bottom: 1px dotted black;
}

.tooltip .tooltiptext {
  visibility: hidden;
  width: 120px;
  background-color: black;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 5px 0;
  position: absolute;
  z-index: 1;
  bottom: 100%;
  left: 50%;
  margin-left: -60px;
  
  /* Fade in tooltip - takes 1 second to go from 0% to 100% opac: */
  opacity: 0;
  transition: opacity 1s;
}

.tooltip:hover .tooltiptext {
  visibility: visible;
  opacity: 1;
}

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
</HEAD>
    <BODY>
        <FORM NAME="form1" ACTION="total.jsp" METHOD="POST">
<%
//    	int strqty=Integer.parseInt(request.getParameter("strqty"));
//	out.print("---"+strqty);
	
	int pid=1,pnameid=1,prid=1,pathid=1,chid=1,qid=1,disid=1;
try{
Class.forName("org.postgresql.Driver");
Connection con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
//PreparedStatement ps=con.prepareStatement("select * from product");

//out.print("email"+musermail);
//out.println(" password"+mpwd);
//out.println("<br>");
Statement stmt=con.createStatement();
//String loginquery = "select * from customer where cemail=";
//out.print(loginquery);
//ResultSet rs=stmt.executeQuery(loginquery);
%>
<br>
<fieldset>
<legend>Select items to add to cart</legend>
<%

String productlist = "select * from cproducts";
//out.print(productlist);
ResultSet rscatalog=stmt.executeQuery(productlist);

String strpid="str",strpname="str",strprid="str",strpathid="str",strchid="str", strqid="str",strdisid="str";
%>

<table border=1>
<tr>
<th>Name</th><th>Description</th><th>Price</th><th>Category</th><th>Check item You want</th><th>Quantity</th>
</tr>
<%
while(rscatalog.next())
     {    strpid   ="str"       +pid++ ;//code
          strpname ="strname"   +pnameid++;//name
	  strprid  ="strpr"     +prid++ ;
          strpathid="strpath"   +pathid++;
	  strchid  ="strch"     +chid++ ;
	  strqid = "strq"       +qid; qid= qid+1;
	  strdisid="strdis"     +disid++;
	  %>
 	 <input type="hidden" name=<%=strpid%> value=
	 <%=rscatalog.getString("pid")%> />
	<input type="hidden" name=<%=strqid%> value=
	 <%=rscatalog.getString("pqty")%> />
	 
	 <tr align="center">
	 <td>
         
	 <img border="1" name =<%=strpathid%> src="<%=rscatalog.getString("path") %>" heigth="160" width="160" class="images"/><br>

         <input type ="text" name=<%=strpname%> value =<%out.print(rscatalog.getString("pname"));%>>
	 </td>
	 
	 <td>
	<%out.print(rscatalog.getString("description"));%>
	 </td>
	 
	 <td><strike><%=rscatalog.getString("price")%></strike>
	 <input type ="hidden" name=<%=strprid%> value=
	 <%=rscatalog.getString("price")%>>
	<br>
	<font color="red">Offer:<input type="label" name=<%=strdisid%> value=<%out.print(" "+rscatalog.getDouble("discount"));%>&percnt;></font>
   <font color="green">
	<% double mdiscountprice = 0.0;
           String strprice       = String.valueOf(rscatalog.getDouble("price"));
           double mprice 	 = Double.parseDouble(strprice);
	   int    dis 		 = rscatalog.getInt("discount");
   //out.println(" "+dis);
   	   mdiscountprice 	 = (mprice /100)* dis;
   	   mdiscountprice	 = mprice-mdiscountprice;
   	   out.println("Discount :");
    	   out.print("Rs."+mdiscountprice);

%></font>
	 </td>
	 
	<td><%
	 out.print(rscatalog.getString("category_name"));
	 %></td>
	 
	 <td>
	 <div class="tooltip"><input type ="checkbox" name=<%=strchid%> class="tooltip">
	<span class="tooltiptext">Buy</span></div>
	 </td>

	<td>
	<input type="text" name=<%=strqid%> value=1 disabled></td>
	</tr>
<%	  
	 } 
	  
 }
catch(Exception e){out.print(""+e.toString());}
%>
</table>
            <BR><br>
<table>
<tr><td><input type="radio" name="r1" value =1>COD</td>
<tr><td><input type="radio" name="r1" value =2>Paytm</td>
<tr><td><input type="radio" name="r1" value =3>Credit Card</td>
<tr><td><input type="radio" name="r1" value =4>Debit card</td>
</table>
	           <br> <input type ="submit" value="proceed"><br>
	<input type ="hidden" name="counter" value=<%=pid%> >

        </FORM>

    </BODY>
</HTML>
