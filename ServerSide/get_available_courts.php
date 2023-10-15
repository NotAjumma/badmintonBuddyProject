<?php
header("Access-Control-Allow-Origin: *"); // Replace * with your Flutter app's IP address or domain.
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Origin, Content-Type, Accept");


include 'db_connect.php';

// Retrieve input parameters
$facilityId = isset($_GET['facility_id']) ? $_GET['facility_id'] : '';
$date = isset($_GET['date']) ? $_GET['date'] : '';
$time = isset($_GET['time']) ? $_GET['time'] : '';
$ampm = isset($_GET['ampm']) ? $_GET['ampm'] : '';
$duration = isset($_GET['duration']) ? $_GET['duration'] : '';

// Log the values for debugging
// error_log("facilityId: $facilityId", 0);
// error_log("date: $date", 0);
// error_log("time: $time", 0);
// error_log("ampm: $ampm", 0);
// error_log("duration: $duration", 0);


// $facilityId = 1;
// $date = "2023-03-03";
// $time = "11:00";
// $ampm = "AM";
// $duration = 1.5;

// Check if any of the parameters are empty
if (empty($facilityId) || empty($date) || empty($time) || empty($ampm) || empty($duration)) {
    // Handle the case where input parameters are missing
    // You can return an appropriate response or error message here
    exit; // Exit the script
}

// Construct a datetime string from date, time, and AM/PM
$datetime = "$date $time $ampm";

// echo $datetime;
// Convert the duration to minutes
$durationHours = floatval($duration); // Convert to float to handle fractions
$durationMinutes = $durationHours * 60;

// Calculate the end time based on the start time and duration in minutes
$endTime = date('H:i A', strtotime("$datetime +$durationMinutes minutes"));



// echo "endtime :" . $endTime;

// Query available courts
$sql = "SELECT c.courtID, c.name
        FROM court c
        WHERE c.facility_id = '$facilityId' 
            AND c.courtID NOT IN (
                SELECT bd.courtID
                FROM booking_detail bd
                INNER JOIN booking b ON bd.bookingID = b.bookingId
                WHERE (
                    '$date' = b.date
                    AND '$ampm' = b.AmPm
                    AND (
                        (
                            '$time' >= b.time
                            AND '$time' < b.end_time
                        )
                        OR (
                            DATE_ADD('$time', INTERVAL $duration HOUR) > b.time
                            AND DATE_ADD('$time', INTERVAL $duration HOUR) <= b.end_time
                        )
                    )
                )
            )";










$result = $conn->query($sql);

$data = array();

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
}

// Send JSON response
header('Content-Type: application/json');
echo json_encode($data);

$conn->close();
