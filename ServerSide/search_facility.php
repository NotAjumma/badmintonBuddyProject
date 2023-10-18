<?php
header("Access-Control-Allow-Origin: *"); // Replace * with your Flutter app's IP address or domain.
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Origin, Content-Type, Accept");

include 'db_connect.php';

// Retrieve the search query from the query parameters
$searchQuery = isset($_GET['query']) ? $_GET['query'] : '';

// Check if the search query is empty
if (empty($searchQuery)) {
    // Handle the case where the search query is empty
    // You can return an appropriate response or error message here
    exit; // Exit the script
}
$sql = "SELECT * FROM facility WHERE name LIKE '%$searchQuery%' OR state LIKE '%$searchQuery%' OR district LIKE '%$searchQuery%'";
$result = $conn->query($sql);

$data = array();

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
}

echo json_encode($data);

$conn->close();
?>
