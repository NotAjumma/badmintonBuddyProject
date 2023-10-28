<?php
header("Access-Control-Allow-Origin: *"); // Replace * with your Flutter app's IP address or domain.
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Origin, Content-Type, Accept");

include 'db_connect.php';

// Check if the request is a POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
error_log("Starting processing...");
$input = file_get_contents("php://input");
error_log("Input data: " . $input);
$data = json_decode($input, true);
error_log("Decoded JSON Data: " . print_r($data, true));

// Check if 'requestData' exists and decode it
    if (isset($data['requestData'])) {
        $requestData = json_decode($data['requestData'], true);

        // Extract the necessary values
        $time = $requestData['time'];
        $date = $requestData['date'];
        $duration = $requestData['duration'];
        $ampm = $requestData['ampm'];
        $total = $requestData['total'];
        $endTime = $requestData['endT'];


        // Prepare an SQL statement for inserting the time data
        $sql = "INSERT INTO booking (username, time, end_time, date, duration, AmPm, total) 
                VALUES ('adha', '$time', '$endTime', '$date', '$duration', '$ampm', '$total')";

        if ($conn->query($sql) === TRUE) {
            $bookingID = $conn->insert_id; // Get the last inserted bookingID

            // Output the booking ID
            error_log("Booking added successfully. Booking ID: $bookingID");
            echo "Booking added successfully. Booking ID: $bookingID";

            // Retrieve and process court details
            $courtDetails = $requestData['court_details'];

            if (is_array($courtDetails)) {
                foreach ($courtDetails as $court) {
                    $courtID = $court['courtID'];

                    // Insert court details into the 'booking_detail' table with the same bookingID
                    $sqlBD = "INSERT INTO booking_detail (bookingID, courtID) VALUES ('$bookingID', '$courtID')";
                    if ($conn->query($sqlBD) !== TRUE) {
                        echo "Error: " . $sqlBD . "<br>" . $conn->error;
                        exit;
                    }
                }
            } else {
                echo "Invalid court details. Court details should be an array.";
                exit;
            }
        } else {
            echo "Error: " . $sql . "<br>" . $conn->error;
        }
    }






    // Close the database connection
    $conn->close();
} else {
    echo "Invalid request.";
}
?>
