<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
	<center>
		<form action="LoginServlet">
			
			<table>
				<tr><td colspan="2" align="middle"><h2>SIGN IN</h2></td></tr>
				<tr>
					<td>User Name: </td>
					<td><input type="text" name="userName"/></td>
				</tr>
				<tr>
					<td>Password: </td>
					<td><input type="password" name="passwD"/></td>
				</tr>
				<tr>
					<td colspan="2">
						<hr/>
					</td>
				</tr>	
				<tr>
					<td colspan="2">
						<center>
							<input type="submit" value="Sign in">
						</center>
					</td>
				</tr>
			</table>
		</form>
	</center>	
</body>
</html>