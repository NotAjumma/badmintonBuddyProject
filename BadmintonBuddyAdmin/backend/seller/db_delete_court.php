<?php
	include('../include/dbconn.php');
	
	$court_id=$_GET['court_id'];
	$facility_id=$_GET['facility_id'];

	
	$delete = "DELETE FROM court WHERE courtID='$court_id'";
	$result = mysqli_query($dbconn, $delete) or die ("Error: " . mysqli_error($conn));
	//echo $delete;
	
	if(!$result){
	 // Jump to indexwrong page
	//  echo "<script> alert(' P! ')</script>";
    echo"<script>location.href='../404.html'</script>";
	}
	else{
        echo "<script> alert(' Success Deleted Court !')</script>";
		echo "<script>location.href='../../frontend/seller/facility-list.php?facility_id=$facility_id'</script>";


	}	
	
?>