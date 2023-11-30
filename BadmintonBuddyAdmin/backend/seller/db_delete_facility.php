<?php
	include('../include/dbconn.php');
	
	$facility_id=$_GET['facility_id'];
	
	$delete = "DELETE FROM facility WHERE id='$facility_id'";
	$result = mysqli_query($dbconn, $delete) or die ("Error: " . mysqli_error($conn));
	//echo $delete;
	
	if(!$result){
	 // Jump to indexwrong page
	//  echo "<script> alert(' P! ')</script>";
    echo"<script>location.href='../404.html'</script>";
	}
	else{
        echo "<script> alert(' Success Deleted Facility !')</script>";
		echo"<script>location.href='../../frontend/seller/facility-list.php'</script>";

	}	
	
?>