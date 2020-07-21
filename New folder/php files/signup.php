<?php

require_once 'source/db_connect.php';
if(isset($_POST['signup-btn'])) {

      $username = $_POST['user-name'];
      $email = $_POST['user-email'];
      $password = $_POST['user-pass'];
      $t=0;
      $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    try {
      $result = mysqli_query($conn,"select * from block");
      while($row = mysqli_fetch_array($result)){
        if(strcmp($row[2],$email)==0){
          $t=1;
          break;

        }
      }
      if($t==1){
        echo "This email is BLOCKED!!";
      }
      else{
      $SQLInsert = "INSERT INTO users (username, password, email, to_date)
                   VALUES (:username, :password, :email, now())";

      $statement = $conn->prepare($SQLInsert);
      $statement->execute(array(':username' => $username, ':password' => $hashed_password, ':email' => $email));

      if($statement->rowCount() == 1) {
        header('location: cloud.html');
      }
    }
    }
    catch (PDOException $e) {
      echo "Error: " . $e->getMessage();
    }


}

?>