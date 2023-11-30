<?php
// Inialize session
session_start();

// Include database connection settings
include('./dbconn.php');

if(isset($_POST['save'])){
	
	/* capture values from HTML form */
	$username = $_POST['username'];
	$name = $_POST['name'];
	$password = $_POST['password'];
	$email = $_POST['email'];
	$phone = $_POST['phone'];
	$address = $_POST['address'];
	
	
	$sql= "UPDATE admin SET name='$name', email='$email', phone='$phone', password='$password', address='$address'
            WHERE username='$username'";
           
    $result = mysqli_query($conn, $sql);
	if(!$result){
	 // Jump to indexwrong page
	//  echo "<script> alert(' P! ')</script>";
    echo"<script>location.href='../404.html'</script>";
	}
	else{
        echo "<script> alert(' Success Updated ".$name." user !')</script>";
        echo"<script>location.href='../admin_profile.php'</script>";
			
        
	
		
	}	
}
mysqli_close($conn);
?>