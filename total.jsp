<%@ page import="java.sql.*,java.util.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="UserHomepage.jsp"%>
<%@include file="navigation.html" %>
<html>
<form method="post" action="bill.jsp">
<body>
<%      double mdisprice,dpr=0;
	try{
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	String email=(String)session.getAttribute("email");

	if (email == null) 
	{
		response.sendRedirect("http://localhost:8080/examples/jsp/UserHomepage.jsp");
	}
		Class.forName("org.postgresql.Driver");
		Connection con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
		//String sname ="str"+2;
		//String sid = request.getParameter(sname);out.print("---"+sid);
			//out.print(sid);
			        String imagesrc="";
				String productid="";
		String strcounter=request.getParameter("counter");
		int counterlimit = Integer.parseInt(strcounter);
		//out.println("counterlimit"+strcounter);
 		PreparedStatement ps,ps1,ps2;
		Statement stmt=con.createStatement(),stme=con.createStatement();
		String productlist = "select * from product";
   		ResultSet rscatalog=stmt.executeQuery(productlist);
                
		int i=1,j=1;double pr=0,pamt=0,tamt=0;int newid=1,newbid=1,newsrno=1,newbsrno=1;
		ResultSet rsorder=stmt.executeQuery("select max(oid)+1 as newoid from orders");
			if(rsorder.next())
			{
				newid=rsorder.getInt(1);
				out.print("New order id:"+newid);
			}
 			String strorder="insert into orders(oid,cemail) values(";
			String mmail=session.getAttribute("email").toString();
			strorder+=newid+",";
			strorder+="'"+mmail+"')";
			
			ps= con.prepareStatement(strorder);
        		ps.executeUpdate();
//bill

		ResultSet rsbill=stmt.executeQuery("select max(bid)+1 as newbid from bill");
			if(rsbill.next())
			{
				newbid=rsbill.getInt(1);
				out.print("New bill id:"+newbid);
			}
 			String strbill="insert into bill(bid,oid) values(";
			strbill+=newbid+",";
			strbill+=newid+")";
                         out.println("bill query "+strbill);
		        //String strbupdate="update bill set bamt="+tamt+" where bid="+newbid;	
			ps= con.prepareStatement(strbill);
        		ps.executeUpdate();

			session.setAttribute("bno",newbid);

  		while(i<counterlimit)
   		{
			out.print("<hr>");

			String chidname ="strch"+i;
			String checkvalue = request.getParameter(chidname);
			//out.print("<br>"+checkvalue);
			if(checkvalue!=null)  
		     	{
				//product code
                		String strpid = "str"+i;
                		productid=request.getParameter(strpid);
				//out.print("<br>product id "+productid);				
	
				// product name
				String strpname ="strname"+i;
                		String nameproduct =request.getParameter(strpname);
				out.print("<br>product name "+nameproduct);

				// path
                		String strpathid  = "strpath"+i;
                		String image=request.getParameter(strpathid);
               			String filenameqry=  "select path from product where pid ="+ productid ; 

               			ResultSet rimg = stmt.executeQuery(filenameqry);
               			if(rimg.next()) 
                   		imagesrc = rimg.getString(1);//request.getAttribute(image);
                		rimg.close();
				out.print("<br>");
%>
 				<img border="1" name =<%=image%> src="<%=imagesrc%>" heigth="160" width="160" class="images"/><br>
<%

 				// price
 				String strprid = "strpr"+i;
                		String mprice = request.getParameter(strprid);
  				out.println("<br>product price "+mprice);
				
				// qty
                                String strqid="strq"+j; 
 				//out.println(" Quantity id ="+strqid);
				String mqty=request.getParameter(strqid);

				//out.println("<br>Quantity:______"+mqty);
                                //out.println("<hr>Quantity:======"+request.getParameter("strq2"));


				//discounted price
                                String strdis = "Select discount from product where pid ="+productid;
 
				ResultSet rsdis = stme.executeQuery(strdis);
                                dpr= Double.parseDouble(mprice);
                                if(rsdis.next())
                                     {
                                     mdisprice = rsdis.getDouble(1);
 				     //out.print("<b> discount :"+mdisprice+"</b>");
                                     dpr = dpr - (dpr /100*mdisprice);
                                     out.println("<b> discounted price :"+dpr);
                                    }
	
				//amt +=Double.parseDouble(mprice);

                                pamt =dpr*1;//Double.parseDouble(mqty);
                                //out.println("product price x quantity"+pamt);
				tamt+=pamt;
		 	 	//out.print("<hr>total bill amt "+tamt);			
      
                   ResultSet rsorderdetails = stme.executeQuery("select max(srno)+1 as msrno from orderdetails");
                        if(rsorderdetails.next())
                        {
                             newsrno= rsorderdetails.getInt(1);
                             //out.print("New Srno :"+newsrno);
                        }
			out.print("<br>");
                        String strorderdetails = "insert into orderdetails(srno,oid,oqty,pid) values(";
                        strorderdetails += newsrno+",";
                        strorderdetails += newid+",";
                        strorderdetails += 1+",";
                        strorderdetails += productid +")";
                        //out.print(strorderdetails);
                        ps1 = con.prepareStatement(strorderdetails);
                        ps1.executeUpdate();


//for bill details
	ResultSet rsbilldetails = stme.executeQuery("select max(bsrno)+1 as billsrno from billdetails");
                        if(rsbilldetails.next())
                        {
                            newbsrno= rsbilldetails.getInt(1);
   //                          out.print("New bill Srno :"+newbsrno);
                        }
			out.print("<br>");
                        String strbilldetails = "insert into billdetails(bid,bqty,pid,bsrno,price) values(";
                       strbilldetails += newbid+",";
                        strbilldetails += 1+",";
                        strbilldetails += productid+",";
			strbilldetails += newbsrno+",";
                        strbilldetails += dpr+")";	
                        //out.print(strbilldetails);
                        ps2 = con.prepareStatement(strbilldetails);
                        ps2.executeUpdate();
		}
    			i=i+1; j=j+1;
	}
	String strbupdate="update bill set bamt="+tamt+" where bid="+newbid;	
         //out.println("bill update query :"+strbupdate);
			ps= con.prepareStatement(strbupdate);
        		ps.executeUpdate();
         String pmode=request.getParameter("r1");
         int imode = Integer.parseInt(pmode);
         strbupdate = "update bill set payment_mode = "+pmode+" where bid="+newbid;
        
	ps= con.prepareStatement(strbupdate);
	ps.executeUpdate();

        session.setAttribute("bno",newbid);
        
	  out.println("Payment mode "+pmode);
	//out.println("<br><hr>");
   out.println("<br> Total Amount "+tamt);
   
 }catch(Exception e){out.print(""+e.toString());}
%>
<br>

<input type="submit" value="proceed">
   </form>
   </body>	</html>
