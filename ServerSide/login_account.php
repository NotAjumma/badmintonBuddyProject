<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Origin, Content-Type, Accept");

include 'db_connect.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['email']) && isset($_POST['password'])) {
        $email = $_POST['email'];
        $password = $_POST['password'];
        error_log("Input email: " . $email);
        error_log("Input password: " . $password);

        // Create an SQL query that joins the 'user' and 'user_level' tables based on the user_id
        $sql = "SELECT u.*, ul.level_id, ul.password as user_level_password FROM user AS u 
                JOIN user_level AS ul ON u.id = ul.user_id 
                WHERE u.email = '$email'";

        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $userLevelPassword = $row['user_level_password'];

            if ($password === $userLevelPassword) {
                // User login is successful
                // Modify the user login successful response
                echo json_encode(['success' => true, 'level_id' => $row['level_id']]);

            } else {
                // User login failed
                echo json_encode(['success' => false, 'error' => 'Invalid email or password']);
            }
        } else {
            // User with the provided email does not exist
            echo json_encode(['success' => false, 'error' => 'User not found']);
        }
    } else {
        echo json_encode(['success' => false, 'error' => 'Missing email or password in the request']);
    }
} else {
    echo json_encode(['success' => false, 'error' => 'Invalid request']);
}

$conn->close();
?>
