<?php 
    include('../../backend/include/dbconn.php');
    include ("../../backend/login/session.php");
    session_start();
    $user = $_SESSION['email'];
    if (!isset($_SESSION['email'])) {
            header('Location: index.html');
            } 
    $ticket_id = $_GET['ticket_id'];	
    $facility_idFromURL = $_GET['facility_id'];	

    // SQL Select courts by facility_id
    $query = "SELECT * FROM booking WHERE bookingID='$ticket_id'";
	$result = mysqli_query($dbconn, $query) or die ("Error: " . mysqli_error($dbconn));
	$row = mysqli_fetch_array($result);
    $bookingID = $row['bookingID'];

    // $queryCourt = "SELECT * FROM court WHERE facility_id='$facility_id'";
	// $resultCourt = mysqli_query($dbconn, $queryCourt) or die ("Error: " . mysqli_error($dbconn));
    // $rowsCourt = mysqli_fetch_all($resultCourt, MYSQLI_ASSOC);
    // print_r($row);

    $query2 = "SELECT c.*, f.id , f.name AS facility_name
          FROM court c
          JOIN booking_detail bd ON c.courtID = bd.courtID
          JOIN facility f ON c.facility_id = f.id
          WHERE bd.bookingID = '$bookingID'";

$result2 = mysqli_query($dbconn, $query2) or die("Error: " . mysqli_error($dbconn));

    $query3 = "SELECT c.*, f.id AS facility_id, f.name AS facility_name
          FROM court c
          JOIN booking_detail bd ON c.courtID = bd.courtID
          JOIN facility f ON c.facility_id = f.id
          WHERE bd.bookingID = '$bookingID'";

$result3 = mysqli_query($dbconn, $query3) or die("Error: " . mysqli_error($dbconn));

$row3 = mysqli_fetch_array($result3);

    

?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="stylesheet" href="../../css/receipt.css" />
    <link href="https://fonts.googleapis.com/css2?family=Karla:wght@300;400;500;600;700&family=Rubik:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../../css/mystyle.css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Dashboard</title>
    <meta
      content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
      name="viewport"
    />
    <link rel="icon" href="../../assets/img/icon.ico" type="image/x-icon" />

    <!-- Fonts and icons -->
    <script src="../../assets/js/plugin/webfont/webfont.min.js"></script>
    <script>
      WebFont.load({
        google: { families: ["Open+Sans:300,400,600,700"] },
        custom: {
          families: [
            "Flaticon",
            "Font Awesome 5 Solid",
            "Font Awesome 5 Regular",
            "Font Awesome 5 Brands",
          ],
          urls: ["./assets/css/fonts.css"],
        },
        active: function () {
          sessionStorage.fonts = true;
        },
      });
    </script>
    <script
      src="https://kit.fontawesome.com/607f9bcbf8.js"
      crossorigin="anonymous"
    ></script>

    <!-- CSS Files -->
    <link rel="stylesheet" href="../../assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../assets/css/azzara.min.css" />
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="../../assets/css/demo.css" />

    <style>
      .d-flex:hover{
        transform: scale(1.07);
        /* background-color: black; */
      }

    /* Shaded QR scanner region */
         #qr-shaded-region {
            position: absolute;
            border: 206px solid rgba(0, 0, 0, 0.48); /* Border for the shaded region */
            inset: 0;
            box-sizing: border-box;
        }
         /* White bars at each corner to form a square */
        .white-bar {
            position: absolute;
            background-color: rgb(255, 255, 255);
            width: 50px;
            height: 5px;
        }

        .top-left, .top-left-side {
            top: calc(50% - 150px);
            left: calc(50% - 150px);
        }

        .top-right, .top-right-side {
            top: calc(50% - 150px);
            right: calc(50% - 150px);
        }

        .bottom-left, .right-side {
            bottom: calc(50% - 150px);
            left: calc(50% - 150px);
        }

        .bottom-right, .left-side {
            bottom: calc(50% - 150px);
            right: calc(50% - 150px);
        }

        #qr-video {
            width: 100%;
            height: auto;
        }

        /* White bars on the sides */
        .white-bar.side {
            position: absolute;
            background-color: rgb(255, 255, 255);
            width: 5px;
            height: 50px;
        }

       
    </style>

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
        var facilityIdFromPHP = <?php echo json_encode($facility_id); ?>;
  
    </script>
  </head>
  
  <body>
    <div class="wrapper">
      <!--
				Tip 1: You can change the background color of the main header using: data-background-color="blue | purple | light-blue | green | orange | red"
		-->
      <div class="main-header" data-background-color="purple">
        <!-- Logo Header -->
        <div class="logo-header">
          <a href="../index.html" class="logo" style="color: #ffffff">
            <!-- <img
              src="./assets//img/logoazzara.svg"
              alt="navbar brand"
              class="navbar-brand"
            /> -->
            CourtMate

          </a>
          <button
            class="navbar-toggler sidenav-toggler ml-auto"
            type="button"
            data-toggle="collapse"
            data-target="collapse"
            aria-expanded="false"
            aria-label="Toggle navigation"
          >
            <span class="navbar-toggler-icon">
              <i class="fa fa-bars"></i>
            </span>
          </button>
          <button class="topbar-toggler more">
            <i class="fa fa-ellipsis-v"></i>
          </button>
          <!-- <div class="navbar-minimize">
            <button class="btn btn-minimize btn-rounded">
              <i class="fa fa-bars"></i>
            </button>
          </div> -->
        </div>
        <!-- End Logo Header -->

        <!-- Navbar Header -->
        <nav class="navbar navbar-header navbar-expand-lg">
          <div class="container-fluid">
            <div class="collapse" id="search-nav">
              <form class="navbar-left navbar-form nav-search mr-md-3">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <button type="submit" class="btn btn-search pr-1">
                      <i class="fa fa-search search-icon"></i>
                    </button>
                  </div>
                  <input
                    type="text"
                    placeholder="Search ..."
                    class="form-control"
                  />
                </div>
              </form>
            </div>
            <ul class="navbar-nav topbar-nav ml-md-auto align-items-center">
              <li class="nav-item dropdown hidden-caret">
                <a
                  class="dropdown-toggle profile-pic"
                  data-toggle="dropdown"
                  href="#"
                  aria-expanded="false"
                >
                  <div class="avatar-sm">
                    <img
                      src="./assets/img/admin.png"
                      alt="..."
                      class="avatar-img rounded-circle"
                    />
                  </div>
                </a>
                <ul class="dropdown-menu dropdown-user animated fadeIn">
                  <li>
                    <div class="user-box">
                      <div class="avatar-lg">
                        <img
                          src="./assets/img/admin.png"
                          alt="image profile"
                          class="avatar-img rounded"
                        />
                      </div>
                      <div class="u-text">
                        <h4>Admin</h4>
                        <p class="text-muted">admin@admin.com</p>
                      </div>
                    </div>
                  </li>
                  <li>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="admin_profile.php">My Profile</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="./backend/logout.php">Logout</a>
                  </li>
                </ul>
              </li>
            </ul>
          </div>
        </nav>
        <!-- End Navbar -->
      </div>

      <!-- Sidebar -->
      <div class="sidebar">
        <div class="sidebar-background"></div>
        <div class="sidebar-wrapper scrollbar-inner">
          <div class="sidebar-content">
            <div class="user">
              <div class="avatar-sm float-left mr-2">
                <img
                  src="./assets/img/admin.png"
                  alt="..."
                  class="avatar-img rounded-circle"
                />
              </div>
              <div class="info">
                <a
                  data-toggle="collapse"
                  href="#collapseExample"
                  aria-expanded="true"
                >
                  <span>
                    <span class="user-level" style="font-size: medium"
                      >Administrator</span
                    >
                    <span class="caret"></span>
                  </span>
                </a>
                <div class="clearfix"></div>
              </div>
            </div>
            <ul class="nav">
              <li class="nav-item">
                <a href="dashboard.php">
                  <i class="fas fa-home"></i>
                  <p>Dashboard</p>
                  <!-- <span class="badge badge-count">5</span> -->
                </a>
              </li>
              <li class="nav-item active">
                <a href="facility-list.php">
                  <i class="fa-solid fa-store fa-lg"></i>
                  <p>Facility</p>
                  <!-- <span class="badge badge-count">5</span> -->
                </a>
              </li>
              <!-- <li class="nav-item active">
                <a href="users-list.php">
                  <i class="fa-solid fa-camera fa-lg"></i>
                  <p>Scanner</p>
                  <!-- <span class="badge badge-count">5</span> -->
                </a>
              </li> -->
            </ul>
          </div>
        </div>
      </div>
      <!-- End Sidebar -->
<div style="padding: 5rem; background-color:#e8e8e8;"></div>
		<div class="main-panel">
    <div class="body-receipt">
      <div class="receipt-container">
        <?PHP if($row3['facility_id'] == $facility_idFromURL){?>
        <div class="header-receipt">
          <div class="regular-medium-text">Your order is confirmed!</div>
          <!-- Add the timer element -->
          <div id="timer"></div>
        </div>
        <div class="first-layer-receipt">
          <div class="first-layer-column regular-small-text">
            <div class="th-receipt">Date</div>
            <div><?php echo $row['date']; ?></div>
          </div>
          <div class="first-layer-column regular-small-text">
            <div class="th-receipt">Booking Code</div>
            <div>#<?php echo $row['bookingID'] ?></div>
          </div>
          <div class="first-layer-column regular-small-text">
            <div class="th-receipt">Facility Name</div>
            <div><?php echo $row3['facility_name'] ?></div>
          </div>
          <div class="first-layer-column regular-small-text">
            <div class="th-receipt">Email</div>
            <div><?php echo $row['email'] ?></div>
          </div>
        </div>
        <div class="sub-first-layer-receipt">
          <div class="first-layer-column regular-small-text">
            <div class="th-receipt">Start Time</div>
            <div><?php echo $row['time']; ?> <?php echo $row['AmPm']; ?></div>
          </div>
          <div class="first-layer-column regular-small-text">
            <div class="th-receipt">Duration</div>
            <div><?php echo $row['duration'] ?> hours</div>
          </div>
          <div class="first-layer-column regular-small-text">
            <div class="th-receipt">End Time</div>
            <div><?php echo $row['end_time'] ?> <?php echo $row['AmPm']; ?></div>
          </div>
        </div>
        <div class="second-layer-receipt">
            <div >Court Info</div>
          <?php  while ($row2 = mysqli_fetch_assoc($result2)) { ?>
          <div class="row-items" style="padding-left: 30px;">
            <div class="imgs-item-receipt" style="width: 1000px;">
              <div class="item-information">
                <div class="karla-regular-small-text"> <?php echo $row2['name'] ?></div>
              </div>
            </div>

            <!-- <div class="price-container small-double-extrabold-text">RM <?php echo $album[0]['price'] ?></div> -->
          </div>
          <?php } ?>
          
        </div>
        <div class="third-layer-receipt">
          <div class="right-container">
            <div class="information">
              <div class="karla-medium-text">Total</div>
              <div class="karla-medium-text">RM <?php echo $row['total'] ?></div>
            </div>
          </div>
        </div>
      <?PHP }else{?>
         <div class="header-receipt">
          <div class="regular-medium-text">Wrong Facility</div>
          <div id="timer"></div>
        </div>
        <?php }?>
    </div>
      <div style="padding: 5rem; background-color:#e8e8e8;"></div>
  

    </div>
    </div>

		
	</div>
   <div id="qrResult"></div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        var countdown = 5; // Set the countdown duration in seconds

        function updateTimer() {
            document.getElementById('timer').innerHTML = 'Redirecting in ' + countdown + ' seconds...';
        }

        function redirectAfterCountdown() {
            var facility_id = <?php echo json_encode($facility_idFromURL); ?>;
            window.location.href = "http://localhost/BadmintonBuddyAdmin/frontend/seller/qr-scanner.php?facility_id=" + facility_id;
        }

        updateTimer(); // Initial update
        var countdownInterval = setInterval(function () {
            countdown--;
            updateTimer();

            if (countdown <= 0) {
                clearInterval(countdownInterval);
                redirectAfterCountdown();
            }
        }, 1000); // Update the timer every 1000 milliseconds (1 second)
    });
</script>

<script src="https://rawgit.com/schmich/instascan-builds/master/instascan.min.js"></script>
    <script src="scanner.js"></script>
<!--   Core JS Files   -->
<script src="./assets/js/core/jquery.3.2.1.min.js"></script>
<script src="./assets/js/core/popper.min.js"></script>
<script src="./assets/js/core/bootstrap.min.js"></script>

<!-- jQuery UI -->
<script src="./assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script src="./assets/js/plugin/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js"></script>

<!-- jQuery Scrollbar -->
<script src="./assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

<!-- Moment JS -->
<script src="./assets/js/plugin/moment/moment.min.js"></script>

<!-- Chart JS -->
<script src="./assets/js/plugin/chart.js/chart.min.js"></script>

<!-- jQuery Sparkline -->
<script src="./assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>

<!-- Chart Circle -->
<script src="./assets/js/plugin/chart-circle/circles.min.js"></script>

<!-- Datatables -->
<script src="./assets/js/plugin/datatables/datatables.min.js"></script>

<!-- Bootstrap Notify -->
<script src="./assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>

<!-- Bootstrap Toggle -->
<script src="./assets/js/plugin/bootstrap-toggle/bootstrap-toggle.min.js"></script>

<!-- jQuery Vector Maps -->
<script src="./assets/js/plugin/jqvmap/jquery.vmap.min.js"></script>
<script src="./assets/js/plugin/jqvmap/maps/jquery.vmap.world.js"></script>

<!-- Google Maps Plugin -->
<script src="./assets/js/plugin/gmaps/gmaps.js"></script>

<!-- Sweet Alert -->
<script src="./assets/js/plugin/sweetalert/sweetalert.min.js"></script>

<!-- Azzara JS -->
<script src="./assets/js/ready.min.js"></script>
<script type="text/javascript">
    // Load the Google Charts visualization library
    google.charts.load('current', { 'packages': ['corechart'] });
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        // Convert the JavaScript array back to a DataTable
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Location');
        data.addColumn('number', 'Total News');
        data.addRows(<?php echo $jsArray; ?>);

        // Define chart options
        var options = {
            // title: 'Location', // Set the chart title here
            chartArea: { width: '60%', height: '80%' },
            hAxis: { title: 'Location', titleTextStyle: { italic: false }, ticks: <?php echo $jsTicks; ?> },
            vAxis: { title: 'Total News', minValue: 0 },
            bars: 'vertical'
        };

        // Instantiate and draw the chart
        var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
        chart.draw(data, options);
    }
</script>

</body>
</html>