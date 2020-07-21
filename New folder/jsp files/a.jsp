<!DOCTYPE html>
<html>
<head>
	<style>
		h1{color:teal;font-size:45;font-family:Cambria;font-style:bold italic;}
		h2{color:firebrick;font-size:30;font-family:Comic Sans MS;margin-left:500;}
		h3{color:teal;font-size:40;font-family:Cambria;font-style:bold italic;}
    h3{color:saddlebrown;font-size:35;font-family:Times New Roman;}
body {
  background-image: url("viewpic.png");
    background-attachment: fixed;
  background-size: cover;
}
</style>
</head>
<body>
	<align="left">
<%@ page import="java.io.File" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.*" %>
<%
      File directoryPath = new File("C:\\xampp\\tomcat\\webapps\\ROOT\\uploaded");
      //List of all files and directories
      String contents[] = directoryPath.list();
      out.println("<h1>List of files and directories in the specified directory:"+"</h1>");
      out.println("<br>");
	for(int i=0; i<contents.length; i++) {
         out.println("<h2>"+contents[i]+"</h2>");
	 out.println("<br>");
	}
%>
<a href="view.html"><h3>View</h3></a>
</align>
</body>
</html>