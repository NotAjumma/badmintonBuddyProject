<?php
// Inialize session
session_start();

// Include database connection settings
include('../include/dbconn.php');
	// echo "insdie";

if(isset($_POST['login'])){
	echo "insdie";
	/* capture values from HTML form */
	$email = $_POST['email'];
	$password = $_POST['password'];
	
	$sql= "SELECT u.id, u.email, ul.password, ul.level_id FROM user u, user_level ul WHERE u.email= '$email' AND ul.password= '$password'";
	$query = mysqli_query($dbconn, $sql) or die ("Error: " . mysqli_error());
	$row = mysqli_num_rows($query);
	if($row == 0){
	 // Jump to indexwrong page
	header('Location: indexwrong.html'); 
	}
	else{
	 $r = mysqli_fetch_assoc($query);
	 $email= $r['email'];
	 $userid= $r['id'];

	 //$password= $r['password'];
	 $level= $r['level_id'];
	 //echo($level_id);
	
		if($level==1) { 
			$_SESSION['email'] = $r['email'];
			$_SESSION['userid'] = $r['id'];
			// Jump to secured page
			header('Location: ../admin'); 
		} 
		elseif($level==2) {
			$_SESSION['email'] = $r['email'];
			$_SESSION['userid'] = $r['id'];
			// Jump to secured page
			header('Location: ../../frontend/seller/dashboard.php');
		}
		else {
			header('Location: index.html');
			//echo($level);
		}
		
	}	
}
mysqli_close($dbconn);
?>