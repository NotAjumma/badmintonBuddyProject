<?php 
    include('../../backend/include/dbconn.php');
    include ("../../backend/login/session.php");
    session_start();
    $user = $_SESSION['email'];
    if (!isset($_SESSION['email'])) {
            header('Location: index.html');
            } 
    

    // $query = "SELECT COUNT(*) as total_users FROM user"; // SQL query to count all records in the "user" table

    // $result = mysqli_query($dbconn, $query) or die ("Error: " . mysqli_error($dbconn)); 
    // // Executing the SQL query using mysqli_query. If there's an error, it will print the error message and stop the script execution.

    // $row = mysqli_fetch_assoc($result);
    // $total_users = $row['total_users']; // Fetching the count of total users from the result

    // $queryNews = "SELECT COUNT(*) as total_news FROM news"; // SQL query to count all records in the "user" table

    // $resultNews = mysqli_query($dbconn, $queryNews) or die ("Error: " . mysqli_error($dbconn)); 
    // // Executing the SQL query using mysqli_query. If there's an error, it will print the error message and stop the script execution.

    // $rowNews = mysqli_fetch_assoc($resultNews);
    // $total_news = $rowNews['total_news']; // Fetching the count of total users from the result

    // $queryTopNews = "SELECT n.news_id, n.title, n.image_url, n.location, COUNT(c.id) AS comment_count
    // FROM news n
    // LEFT JOIN comments c ON n.news_id = c.news_id
    // GROUP BY n.news_id, n.title
    // ORDER BY comment_count DESC
    // LIMIT 5;
    // ";

    // $resultTopNews = mysqli_query($dbconn, $queryTopNews) or die("Error: " . mysqli_error($dbconn));

    // $topNews = mysqli_fetch_all($resultTopNews, MYSQLI_ASSOC);

    // $queryTopNewsByLocation = "SELECT n.location, COUNT(n.news_id) AS total_news
    // FROM news n
    // GROUP BY n.location
    // ORDER BY total_news DESC;
    // ";

    // $resultTopNewsByLocation = mysqli_query($dbconn, $queryTopNewsByLocation) or die("Error: " . mysqli_error($dbconn));

    // $topNewsByLocation = mysqli_fetch_all($resultTopNewsByLocation, MYSQLI_ASSOC);
    
    // // print_r($topNewsByLocation);

    // $chartData = array();

    // // Loop through the $topNews array and format data for the chart
    // foreach ($topNewsByLocation as $news) {
    //     $location = $news['location'];
    //     $comment_count = (int)$news['total_news'];

    //     // Add data to the $chartData array
    //     $chartData[] = array($location, (int)$comment_count); // Remove the third value as it was used for annotations
    //     $customTicks[] = $location; // Add each location as a custom tick label

    // }

    // // Convert the PHP array to a JavaScript array for Google Charts
    // $jsArray = json_encode($chartData);
    // $jsTicks = json_encode($customTicks);
    // print_r($jsArray);

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
    </style>

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

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
              <li class="nav-item active">
                <a href="dashboard.php">
                  <i class="fas fa-home"></i>
                  <p>Dashboard</p>
                  <!-- <span class="badge badge-count">5</span> -->
                </a>
              </li>
              <li class="nav-item">
                <a href="facility-list.php">
                  <i class="fa-solid fa-store fa-lg"></i>
                  <p>Facility</p>
                  <!-- <span class="badge badge-count">5</span> -->
                </a>
              </li>
              <!-- <li class="nav-item ">
                <a href="qr-scanner.php">
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

		<div class="main-panel">
			<div class="content">
				<div class="page-inner">
					<div class="page-header">
						<h4 class="page-title">Dashboard</h4>
						<div class="btn-group btn-group-page-header ml-auto">
							<button type="button" class="btn btn-light btn-round btn-page-header-dropdown dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<i class="fa fa-ellipsis-h"></i>
							</button>
							<div class="dropdown-menu">
								<div class="arrow"></div>
								<a class="dropdown-item" href="#">Action</a>
								<a class="dropdown-item" href="#">Another action</a>
								<a class="dropdown-item" href="#">Something else here</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="#">Separated link</a>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body ">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center icon-primary bubble-shadow-small">
												<i class="fas fa-users"></i>
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category">Users</p>
												<h4 class="card-title"><?php echo $total_users ?></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center icon-info bubble-shadow-small">
												<i class="far fa-newspaper"></i>
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category">News</p>
												<h4 class="card-title"><?php echo $total_news ?></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
					</div>
					<div class="row">
						<div class="col-md-8">
							<div class="card" style="height: 32rem !important;">
								<div class="card-header">
									<div class="card-head-row">
										<div class="card-title">Total News by location</div>
										<!-- <div class="card-tools">
											<a href="#" class="btn btn-info btn-border btn-round btn-sm mr-2">
												<span class="btn-label">
													<i class="fa fa-pencil"></i>
												</span>
												Export
											</a>
											<a href="#" class="btn btn-info btn-border btn-round btn-sm">
												<span class="btn-label">
													<i class="fa fa-print"></i>
												</span>
												Print
											</a>
										</div> -->
									</div>
								</div>
								<div class="card-body">
									<div class="chart-container" style="min-height: 375px">
										<div id="chart_div"></div>
									</div>
									<div id="myChartLegend"></div>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="card">
								<div class="card-header">
									<div class="card-title">Top News</div>
								</div>
								<div class="card-body pb-0">

                <?php 
                  foreach ($topNews as $news) {
                      $news_id = $news['news_id']; // Get the news_id for each news article
                  ?>

                      <a href="news_comment.php?news_id=<?php echo $news_id; ?>" style="text-decoration: none; color: #575962 !important;" >
                          <div class="d-flex">
                              <div class="avatar">
                                  <img src="<?php echo $news['image_url']; ?>" alt="..." class="avatar-img rounded-circle">
                              </div>
                              <div class="flex-1 pt-1 ml-2">
                                  <h5 class="fw-bold mb-1"><?php echo $news['title']; ?></h5>
                                  <small class="text-muted"><?php echo $news['location']; ?></small>
                              </div>
                              <div class="d-flex ml-auto align-items-center">
                                  <h3 class="text-info fw-bold" style="font-size: small;"><?php echo $news['comment_count']; ?> comments</h3>
                              </div>
                          </div>
                      </a>
                      <div class="separator-dashed"></div>

                <?php } ?>

									
								</div>
							</div>
							
						</div>
					</div>
					
					
					
				</div>
			</div>
			
		</div>
		
		
	</div>
</div>
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