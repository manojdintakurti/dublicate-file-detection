<?php

include_once 'source/session.php';

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <style>
        h1{color:aliceblue;font-size:100;font-family:Cambria;font-style:bold italic;text-align:center;}
body {
  background-image: url("img/dashpic.png");
    background-attachment: fixed;
  background-size: cover;
}
</style>

    
</head>
<body>

    <?php if(!isset($_SESSION['username'])): header("location: logout.php");?>

    <?php else: ?>

    <?php endif ?>

    <?php echo "<h1> Welcome ".$_SESSION['username']."  </h1>" ?>
	<h2><a href = "http://localhost:8080/a.jsp" >View Files </a></h2><br>
	<h2><a href = "http://localhost:8080/upload.html" >Upload Files </a></h2><br>
    <h2><a href="logout.php">Logout</a></h2>
</body>
</html>