<html>
<head>
	<style>
		h1{color:gold;font-size:40;font-family:Comic Sans MS;}
body {
  background-image: url("blpic.png");
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
	String usr=request.getParameter("name");
	String id="",name="",pass="",mail="",date="";
	try
	{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?useTimezone=true&serverTimezone=UTC","root","");
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("select * from users");
	while(rs.next()){
	if(rs.getString(2).equals(usr)){
	id = rs.getString(1);
	name = rs.getString(2);
	pass = rs.getString(3);
	mail = rs.getString(4);
	date = rs.getString(5);
	break;

}
}
	st.close();
	rs.close();
	PreparedStatement stt = con.prepareStatement("insert into block values(?,?,?,?,?)");
	stt.setString(1,id);
	stt.setString(2,name);
	stt.setString(3,pass);
	stt.setString(4,mail);
	stt.setString(5,date);
	stt.executeUpdate();
	stt.close();
	Statement st1= con.createStatement();
	st1.executeUpdate("delete from users where id="+id);
	out.println("<h1>User Blocked"+"</h1>");
	out.println("<br>");
	st1.close();
	con.close();
}
catch(Exception e){
	out.println(e);
}
%>
<h2><a href="http://localhost:8080/admin1.html">Go To Admin Page</a></h2>
</body>
</html>
