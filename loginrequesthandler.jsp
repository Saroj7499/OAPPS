<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        String email=request.getParameter("email");
        String p=request.getParameter("p");
       
        if((email.equals("autohub@gmail.com") && p.equals("autohub.com")))
            {
            session.setAttribute("email",email);
            response.sendRedirect("AdminHomepage.jsp");
            }
        else
	{
		out.println("<script type=\"text/javascript\">");
		out.println("alert('Cannot login!');");
		out.println("location='Admin.jsp'");
		out.println("</script>");

	}
        %>
    </body>
</html>
