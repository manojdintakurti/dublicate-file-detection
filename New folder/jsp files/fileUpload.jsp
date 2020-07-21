<html>
<head>
<style>
h1{color:black;font-size:40;font-family:forte;}

body {
  background-image: url("fileUploadpic.png");
    background-attachment: fixed;
  background-size: cover;
}
</style>
</head>
<body>
<%@ page import="java.io.*,javax.servlet.http.HttpServletRequest,javax.servlet.ServletInputStream" %>
<%@ page import="java.io.FileWriter,java.io.IOException" %>
<%@ page import="java.util.Random"%>
<%@ page import="java.security.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%
 String savePath = "", filepath = "", filename = "";
 String contentType = "", fileData = "", strLocalFileName = "";
 int startPos = 0;
 int endPos = 0;
%>
<%!
 //copy specified number of bytes from main data buffer to temp data buffer
 void copyByte(byte[] fromBytes, byte[] toBytes, int start, int len)
 {
for(int i=start;i<(start+len);i++)
  {
   toBytes[i-start] = fromBytes[i];
  }
 }
%>
<%
 int BOF = 0, EOF = 0;
 contentType = request.getContentType();
 if((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0))
 {
  DataInputStream in = new DataInputStream(request.getInputStream());
  DataInputStream in1 = in;
  int formDataLength = request.getContentLength();
  byte dataBytes[] = new byte[formDataLength];
  int byteRead = 0;
  int totalBytesRead = 0;
  while (totalBytesRead < formDataLength)
  {
   byteRead = in1.read(dataBytes, totalBytesRead, formDataLength);
   totalBytesRead += byteRead;
  }
  //String file = new String(dataBytes);
  //out.println("<br>FileContents:<br>////////////////////////////////////<br>" + file + "<br>////////////////////////////////<br>");
 
  byte[] line = new byte[128];
  if (totalBytesRead < 3)
  {
    return; //exit if file length is not sufficiently large
  }
 
String boundary = "";
String s = "";
int count = 0;
int pos = 0;
 
  //loop for extracting boundry of file
  //could also be extracted from request.getContentType()
  do
  {
   copyByte(dataBytes, line, count ,1); //read 1 byte at a time
   count+=1;
   s = new String(line, 0, 1);
   fileData = fileData + s;
   pos = fileData.indexOf("Content-Disposition: form-data; name=\""); //set the file name
   if(pos != -1)
    endPos = pos;
  }while(pos == -1);
  boundary = fileData.substring(startPos, endPos);
 
  //loop for extracting filename
  startPos = endPos;
  do
  {
   copyByte(dataBytes, line, count ,1); //read 1 byte at a time
   count+=1;
   s = new String(line, 0, 1);
   fileData = fileData + s;
   pos = fileData.indexOf("filename=\"", startPos); //set the file name
   if(pos != -1)
    startPos = pos;
  }while(pos == -1);
  do
  {
   copyByte(dataBytes, line, count ,1); //read 1 byte at a time
   count+=1;
   s = new String(line, 0, 1);
   fileData = fileData + s;
   pos = fileData.indexOf("Content-Type: ", startPos);
   if(pos != -1)
    endPos = pos;
  }while(pos == -1);
  filename = fileData.substring(startPos + 10, endPos - 3); //to eliminate " from start & end
  strLocalFileName = filename;
  int index = filename.lastIndexOf("\\");
  if(index != -1)
   filename = filename.substring(index + 1);
  else
   filename = filename;
 
  //loop for extracting ContentType
  boolean blnNewlnFlag = false;
  startPos = endPos; //added length of "Content-Type: "
  do
  {
   copyByte(dataBytes, line, count ,1); //read 1 byte at a time
   count+=1;
   s = new String(line, 0, 1);
   fileData = fileData + s;
   pos = fileData.indexOf("\n", startPos);
   if(pos != -1)
   {
    if(blnNewlnFlag == true)
     endPos = pos;
    else
    {
     blnNewlnFlag = true;
     pos = -1;
    }
   }
  }while(pos == -1);
  contentType = fileData.substring(startPos + 14, endPos);
 
  //loop for extracting actual file data (any type of file)
  startPos = count + 1;
  do
  {
   copyByte(dataBytes, line, count ,1); //read 1 byte at a time
   count+=1;
   s = new String(line, 0, 1);
   fileData = fileData + s;
   pos = fileData.indexOf(boundary, startPos); //check for end of file data i.e boundry value
  }while(pos == -1);
  endPos = count - boundary.length();
  //file data extracted
 
out.println("<br><br>1. filename = " + filename);
out.println("<br>2. contentType = " + contentType);
 
  //create destination path & save file there
  
 }
 else
 {
  out.println("Error in uploading ");
 }
%>
 <%
        String appPath = application.getRealPath("/");
  String filepath1 = appPath + "textfiles/";
  filepath1 = filepath1 + filename;
        MessageDigest messageDigest = MessageDigest.getInstance("MD5");
         
        FileInputStream fileInput = new FileInputStream(filepath1);
        byte[] dataBytes = new byte[1024];
        int bytesRead = 0;
 
        while ((bytesRead = fileInput.read(dataBytes)) != -1) {
            messageDigest.update(dataBytes, 0, bytesRead);
        }
         
 
        byte[] digestBytes = messageDigest.digest();
 
        StringBuffer sb = new StringBuffer("");
         
        for (int i = 0; i < digestBytes.length; i++) {
            sb.append(Integer.toString((digestBytes[i] & 0xff) + 0x100, 16).substring(1));
        }
  out.println("<br>");
String s=sb.toString();
        out.println("Checksum for the File: " + s);
         
        fileInput.close();
 %>
<%

int flag=0;
String destFolder = appPath + "uploaded/";
  filename= destFolder + filename;
 try
 {
  Class.forName("com.mysql.jdbc.Driver");
  Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/deepika?useTimezone=true&serverTimezone=UTC","root","");
  Statement st=con.createStatement();
  ResultSet rs=st.executeQuery("select * from files");
  while(rs.next())
  {
   if(rs.getString(1).equals(filename))
   {
    if(rs.getString(2).equals(s))
    {
      flag=1;
      out.println("<br>");
      out.println("<h1>File already exists</h1>");
      break;
    }
    else
    {
      flag=1;
      out.println("<br>");
      out.println("<h1>File with same name is already present but content is different</h1>");
      break;
    }
   }
   else
   {
    if(rs.getString(2).equals(s))
    {
     flag=1;
     out.println("<br>");
     out.println("<h1>File with same content already exists</h1>");
     break;
    }
   }
  }
  st.close();
  if(flag==0)
  {
    
   FileOutputStream fileOut = new FileOutputStream(filename);
   fileOut.write(dataBytes, startPos, (endPos - startPos));
   fileOut.flush();
   fileOut.close();
   out.println("<br>File saved as >> " + filename);
 
  //file saved at destination
  //out.println("<br>File data : <br><br>**************************<br>" + (new String(dataBytes,startPos, (endPos - startPos))) + "<br><br>**************************");
   PreparedStatement stt=con.prepareStatement("insert into files values(?,?)");
   stt.setString(1,filename);
   stt.setString(2,s);
   stt.executeUpdate();
   stt.close();

   out.println("<br>");
   out.println("<h1>File Uploaded Successfully!!</h1>");
   con.close();

  }
 }
 catch(Exception e)
 {
  out.println(e);
 }

%>

</body>
</html>

  