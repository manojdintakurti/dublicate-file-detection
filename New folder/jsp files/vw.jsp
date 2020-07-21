<%@ page import = "java.io.*"%>
<%@ page import = "javax.servlet.*"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<body>
	<%
	int t =0;
	String filename = request.getParameter("file");
	      String appPath = application.getRealPath("/");
  String filepath1 = appPath + "uploaded/"+filename;
	try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/deepika?useTimezone=true&serverTimezone=UTC","root","");
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("select * from files");
	while(rs.next()){
	if(rs.getString(1).equals(filepath1)){
	t=1;

}
}
}
catch(Exception e){
	out.println(e);
}
%>
	<%
	if(t==1){
	String filename1 = "/textfiles/"+filename;
	InputStream ins = application.getResourceAsStream(filename1);
	try
{
if(ins == null)
{
response.setStatus(response.SC_NOT_FOUND);
}
else
{
BufferedReader br = new BufferedReader((new InputStreamReader(ins)));
String data;
while((data= br.readLine())!= null)
{
out.println(data+"<br>");
}
} 
}
catch(IOException e)
{
out.println(e.getMessage());
}
}
else{
	out.println("Given File Is Not Uploaded");
}
%>
</body>

</html>