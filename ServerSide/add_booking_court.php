<?php
header("Access-Control-Allow-Origin: *"); // Replace * with your Flutter app's IP address or domain.
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Origin, Content-Type, Accept");

include 'db_connect.php';

// Check if the request is a POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = file_get_contents("php://input");
    $data = json_decode($input, true);
    error_log("Received JSON Data: " . print_r($data, true));


    // Retrieve and process facility_id and request data
    // $facility_id = $data['facility_id'];
    // $requestData = $data['requestData'];

    if (isset($data['requestData']) && is_array($data['requestData'])) {
    $requestData = $data['requestData'];

    if (isset($requestData['time'])) {
        $time = $requestData['time'];
    } else {
        error_log("Missing 'time' in requestData.");
        exit;
    }

    // Repeat this for other keys (date, duration, ampm, total)

} else {
    error_log("Missing or invalid 'requestData' in JSON data.");
    exit;
}

   // Retrieve and process time data
$time = $data['requestData']['time'];
$date = $data['requestData']['date'];
$duration = $data['requestData']['duration'];
$ampm = $data['requestData']['ampm'];
$total = $data['requestData']['total'];

error_log("time: " . $time);
error_log("date: " . $date);
error_log("duration: " . $duration);
error_log("ampm: " . $ampm);
error_log("total: " . $total);




    // Prepare an SQL statement for inserting the time data
    $sql = "INSERT INTO booking (username, time, end_time, date, duration, AmPm, total) 
            VALUES ('adha', '$time', '2:00', '$date', '$duration', '$ampm', '$total')";

    if ($conn->query($sql) === TRUE) {
        $bookingID = $conn->insert_id; // Get the last inserted bookingID
        echo "Booking added successfully. Booking ID: $bookingID";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
        exit;
    }

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

    // Close the database connection
    $conn->close();
} else {
    echo "Invalid request.";
}
?>
