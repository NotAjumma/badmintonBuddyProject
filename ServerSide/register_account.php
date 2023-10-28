<?php
header("Access-Control-Allow-Origin: *"); // Replace * with your Flutter app's IP address or domain.
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Origin, Content-Type, Accept");

include 'db_connect.php';

// Assuming you have received data from your Flutter app
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
error_log("Starting processing...");
$input = file_get_contents("php://input");
error_log("Input data: " . $input);
$data = json_decode($input, true);
error_log("Decoded JSON Data: " . print_r($data, true));
// Insert data into the 'user' table
$name = $_POST['name'];
$phone = $_POST['mobile_phone'];
$email = $_POST['email'];
error_log("Input name: " . $name);
error_log("Input phone: " . $phone);
error_log("Input email: " . $email);
// $type = $_POST['type'];

$user_insert_sql = "INSERT INTO user (name, phone, email) VALUES ('$name', '$phone', '$email')";

if ($conn->query($user_insert_sql) === TRUE) {
    $user_id = $conn->insert_id; // Get the user ID from the inserted row
    // Insert data into the 'user_level' table
    $password = $_POST['password'];
    $level_id = 3;

    $user_level_insert_sql = "INSERT INTO user_level (user_id, password, level_id) VALUES ('$user_id', '$password', '$level_id')";

    if ($conn->query($user_level_insert_sql) === TRUE) {
        // Both insertions were successful
        echo json_encode(["message" => "User and user level data inserted successfully"]);
    } else {
        // Error in inserting into 'user_level' table
        echo json_encode(["error" => "Error: " . $conn->error]);
    }
} else {
    // Error in inserting into 'user' table
    echo json_encode(["error" => "Error: " . $conn->error]);
}

$conn->close();
} else {
    echo "Invalid request.";
}
?>
