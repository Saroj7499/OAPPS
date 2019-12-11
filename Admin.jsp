<html>
<head>
<title>Admin login</title>
<link rel="stylesheet" href="Admin.css">
<script type="text/javascript">
function checkforblank(){
	var email=document.alogin.email.value;
	var p=document.alogin.p.value;
	if(e=="" && p=="")
	{
		alert("fields cannot be blank");
		return false;
	} 
	if(email=="")
	{
		alert("please enter email");
		return false;
	}
	else if(p=="")
	{
		alert("please enter password");
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
<img src="sa.png" class="images" alt="image cannot be displayed">
<h1>ADMIN LOGIN</h1>
<form name="alogin" method="post" action="http://localhost:8080/examples/jsp/loginrequesthandler.jsp" onSubmit="return checkforblank()">

<p>Email id</p><input type="email"  name="email" placeholder="Enter emailid">
<br>

<p>Password</p><input type="password"  name="p" placeholder="Enter Password">
<br>

<input type="submit" value="login">
</form>
</div>
</body>
</html>
