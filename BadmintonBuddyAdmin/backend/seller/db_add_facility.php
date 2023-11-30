<?php
// Inialize session
session_start();

// Include database connection settings
include('../include/dbconn.php');

if(isset($_POST['add'])){
	
	/* capture values from HTML form */
	$name = $_POST['name'];
	$state = $_POST['state'];
	$district = $_POST['district'];
	$address = $_POST['address'];
	$price = $_POST['price'];
	$image_url = $_POST['image_url'];
	$userid = $_POST['userid'];


	$sql = "INSERT INTO facility (name, state, district, address, price, image, userid)
			VALUES ('$name', '$state', '$district', '$address', '$price', '$image_url', '$userid')";
	$result = mysqli_query($dbconn, $sql);

	if(!$result){
	 // Jump to indexwrong page
	//  echo "<script> alert(' P! ')</script>";
    echo"<script>location.href='../404.html'</script>";
	}
	else{
        echo "<script> alert(' Success Add new Facility !')</script>";
        echo"<script>location.href='../../frontend/seller/facility-list.php'</script>";
			
        
	
		
	}	
}
mysqli_close($conn);
?>