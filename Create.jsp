<html>
<head>
<!--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">-->
<link rel="stylesheet" href="Create.css">
<title>Create acount</title>
<script type="text/javascript">
function check(){
	var n=document.createacc.n.value;
	var e=document.createacc.e.value;
	var ph=document.createacc.ph.value;
	var pwd=document.createacc.pwd.value;
	var rpwd=document.createacc.rpwd.value;
	var addr=document.createacc.addr.value;
	//var altaddr=document.createacc.altaddr.value;
	var pet=document.createacc.pet.value;
	var alpha=/^[a-zA-Z ]+$/;
	
	if(n=="" || e=="" || ph=="" || pwd=="" || rpwd=="" || addr=="" || pet=="")
	{
		alert("fields cannot be blank");
		return false;
	}
	
	else if(ph.length>10 || ph.length<10 || isNaN(ph))
	{
		alert("enter valid phone no.");
		return false;
	}		
	/*else if(e.indexOf('@')<=0 || ((e.charAt(e.length-4)!='.') && (e.charAt(e.length-3)!='.')))
	{
		alert("invalid emailid");
		return false;
	}*/
	else if(pwd.length<6 || pwd.length>12)
	{
		alert("password must be 6 to 12 characters long");
		return false;
	}
	else if(pwd!==rpwd)
	{
		alert("password does not match");
		return false;
	}
	else if(!n.match(alpha))
	{
		alert("invalid name");
		return false;
	}
	else
	{
		return true;
	}
}	
</script>	
</head>
<body>
<div class="loginbox">
<h1>CREATE ACCOUNT</h1>
<form name="createacc" method="post" action="http://localhost:8080/examples/jsp/Create.jsp" onSubmit="return check()">
<p>Name</p><input type="text" name="n" placeholder="Enter name"><br>
<p>email id</p><input type="email"  name="e" placeholder="Enter email id"><br>
<p>phone no.</p><input type="text"  name="ph" placeholder="Enter phone no."><br>
<p>Address</p><input type="text"  name="addr" placeholder="Enter address"><br>
<!--<p>Alternate Address</p><input type="text"  name="altaddr" placeholder="Enter alternate address"><br>-->
<p>Create password</p><input type="password" name="pwd" placeholder="Enter password"><br>
<p>Repeat password</p><input type="password" name="rpwd" placeholder="Repeat password"><br><br>
-----Security Question-----<br><br>
<p>Enter your pet's name</p><input type="text"  name="pet" autocomplete="off"><br>
<input type="submit" value="Submit">
<a href='http://localhost:8080/examples/jsp/User.jsp'>Click here to log in</a>
</form>
</div>
</body>
</html>
<%@ page import="java.sql.*,java.io.* " %>
    <% String cname=request.getParameter("n");
    	String cphno=request.getParameter("ph");
    	String cpwd=request.getParameter("pwd");
    	String cemail=request.getParameter("e");
	String address=request.getParameter("addr");
	//String altaddress=request.getParameter("altaddr");
	String pets=request.getParameter("pet");
    	try
    	{
		Connection con;
		Statement stmt;
		PreparedStatement pstmt;
    		Class.forName("org.postgresql.Driver");
    		con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
    		stmt=con.createStatement();
    		pstmt=con.prepareStatement("insert into customer values(?,?,?,?,?,?)");
		if(con!=null)
		{	
			pstmt.setString(1,cname);
			pstmt.setString(2,cphno);
			pstmt.setString(3,cpwd);
			pstmt.setString(4,cemail);
			pstmt.setString(5,address);
			pstmt.setString(6,pets);
			int rs=pstmt.executeUpdate();
			if(rs>=1)
			{
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Registered successfully!');");
				out.println("location='User.jsp'");
				out.println("</script>");	
			}
    		}
	}
    	catch(Exception e)
    	{
		System.out.println(e);
    	}
    	
    	%> 
