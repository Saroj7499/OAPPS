<%@ page import="java.io.*,java.sql.*" session="true" %>
<html>
<head>
<!--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">-->
<title>User login</title>
<link rel="stylesheet" href="User.css">
<script type="text/javascript">
function checkforblank(){
	var e=document.ulogin.e.value;
	var p=document.ulogin.p.value;
	if(e=="" && p=="")
	{
		window.alert("Please enter valid details")
		return false;
	}
	else if(e=="")
	{
		window.alert("Please enter email id")
		return false;
	}
	else if(p=="")
	{
		window.alert("Please enter password");
		return false;
	}
	else if(p.length<6 || p.length>12)
	{
		window.alert("password must be 6 to 12 characters long");
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
<img src="multi.png" class="images" alt="image cannot be displayed">
<h1>USER LOGIN</h1>
<form name="ulogin" method="post" action="http://localhost:8080/examples/jsp/customerlogin.jsp" onSubmit="return checkforblank()">

<p>Emailid</p><input type="text"  name="email" placeholder="Enter Emailid">
<br>

<p>Password</p><input type="password"  name="p" placeholder="Enter Password">
<br>
<input type="submit" value="Login" name="login"><br>
<a href="http://localhost:8080/examples/jsp/Forgot.jsp">forgot password</a><br>
<a href="http://localhost:8080/examples/jsp/Create.jsp">create account</a><br>
</form>
</div>
</body>
</html>
