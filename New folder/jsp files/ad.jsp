<html>
<head>
	<style>
		h1{color:crimson;font-size:45;font-family:Cambria;font-style:bold italic;margin-left:500;}
		h2{color:seagreen;font-size:30;font-family:Comic Sans MS;}
		h3{color:black;font-size:40;font-family:Cambria;}
    h3{color:chocolate;font-size:35;font-family:Times New Roman;}

body {
  background-image: url("admin2.png");
    background-attachment: fixed;
  background-size: cover;
}
</style>
</head>
<body>
<%@ page import = "java.io.*" %>
<%@ page import = "javax.servlet.*" %>
<%@ page import = "java.sql.*" %>
<%
	int t=0;
	String usr=request.getParameter("Name");
	String psw=request.getParameter("Password");
	try
	{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/deepika?useTimezone=true&serverTimezone=UTC","root","");
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("select * from admin");
	while(rs.next())
	{
	if(rs.getString(1).equals(usr) && rs.getString(2).equals(psw))
	{
	t = 1;
	out.println("<h1>Welcome " +usr+"</h1>");
	break;
	}
	}
	if(t==0)
	{
	out.println("<h2>You are not an authorized user"+"</h2>");
	}
	con.close();
	}
	catch(Exception e)
	{
	out.println(e);
	}
%>
<%
	if(t==1)
	{
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?useTimezone=true&serverTimezone=UTC","root","");
	Statement stt = conn.createStatement();
	ResultSet rst=stt.executeQuery("select * from users");
	out.println("<h2>The existing users are"+"</h2>");
	out.println("<h3>NAME<br>"+"</h3>");
	while(rst.next())
	{
	out.println("<h3>"+rst.getString(2)+"</h3>");
	}
	stt.close();
	rst.close();
	conn.close();
	
	}
%>
	<h2><a href="block.html">Block</a></h2>
	<h2><a href="unblock.html">Unblock</a></h2>
	<h2><a href="ses.jsp">Logout</a></h2>
</body>
</html>