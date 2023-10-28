<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Origin, Content-Type, Accept");

include 'db_connect.php';

$email = $_GET['email'];
// Modify the SQL query to retrieve booking information along with court and facility details
$sql = "SELECT b.bookingID, b.email, b.time, b.end_time, b.date, b.duration, b.AmPm, b.total,
               bd.courtID, c.name AS court_name, c.facility_id,
               f.name AS facility_name, f.state, f.district
        FROM booking b
        LEFT JOIN booking_detail bd ON b.bookingID = bd.bookingID
        LEFT JOIN court c ON bd.courtID = c.courtID
        LEFT JOIN facility f ON c.facility_id = f.id
        WHERE b.email = '$email'";

$result = $conn->query($sql);

$data = array();

if ($result->num_rows > 0) {
    $bookings = array();
    $bookingData = array();
    $bookingID = null;

    while ($row = $result->fetch_assoc()) {
        if ($row['bookingID'] != $bookingID) {
            // New booking, create a booking record
            if ($bookingData) {
                $bookings[] = $bookingData;
            }

            $bookingData = $row;
            $bookingData['court'] = array();
            $bookingData['facility'] = array();
            $bookingID = $row['bookingID'];
        }

        // Add court details to the current booking
        $courtData = array('courtID' => $row['courtID'], 'court_name' => $row['court_name']);
        $bookingData['court'][] = $courtData;

        // Add facility details to the current booking
        $facilityData = array(
            'facility_id' => $row['facility_id'],
            'facility_name' => $row['facility_name'],
            'state' => $row['state'],
            'district' => $row['district']
        );
        $bookingData['facility'] = $facilityData;
    }

    if ($bookingData) {
        $bookings[] = $bookingData;
    }

    // Remove the top-level "courtID," "court_name," "facility_id," and "facility_name" from each booking
    foreach ($bookings as &$booking) {
        unset($booking['courtID']);
        unset($booking['court_name']);
        unset($booking['facility_id']);
        unset($booking['facility_name']);
    }

    $data = $bookings;
}

echo json_encode($data);

$conn->close();
?>
