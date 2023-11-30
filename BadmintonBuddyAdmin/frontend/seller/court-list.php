<?php 
require_once "../../backend/include/dbconn.php";
session_start();
    $userid = $_SESSION['userid'];
    if (!isset($_SESSION['userid'])) {
            header('Location: index.html');
            } 
    $facility_id = $_GET['facility_id'];	

    // SQL Select courts by facility_id
    $query = "SELECT * FROM facility WHERE id='$facility_id'";
	$result = mysqli_query($dbconn, $query) or die ("Error: " . mysqli_error($dbconn));
	$row = mysqli_fetch_array($result);

    $queryCourt = "SELECT * FROM court WHERE facility_id='$facility_id'";
	$resultCourt = mysqli_query($dbconn, $queryCourt) or die ("Error: " . mysqli_error($dbconn));
    $rowsCourt = mysqli_fetch_all($resultCourt, MYSQLI_ASSOC);
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="stylesheet" href="../../css/receipt.css" />
    <link href="https://fonts.googleapis.com/css2?family=Karla:wght@300;400;500;600;700&family=Rubik:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../../css/mystyle.css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Facility</title>
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
          urls: ["../../assets/css/fonts.css"],
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
          <div class="navbar-minimize">
            <button class="btn btn-minimize btn-rounded">
              <i class="fa fa-bars"></i>
            </button>
          </div>
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
                    <a class="dropdown-item" href="logout.php">Logout</a>
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
                <a href="news-list.php">
                  <i class="fa-solid fa-newspaper fa-lg"></i>
                  <p>Facility</p>
                  <!-- <span class="badge badge-count">5</span> -->
                </a>
              </li>
              <!-- <li class="nav-item">
                <a href="users-list.php">
                  <i class="fa-solid fa-users fa-lg"></i>
                  <p>User</p>
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
              <h4 class="page-title"><?php echo $row['name']?></h4>
              <ul class="breadcrumbs">
                <li class="nav-home">
                  <a href="dashboard.php">
                    <i class="flaticon-home"></i>
                  </a>
                </li>
                <li class="separator">
                  <i class="flaticon-right-arrow"></i>
                </li>
                <li class="nav-item">
                  <a href="facility-list.php">Facility</a>
                </li>
                <li class="separator">
                  <i class="flaticon-right-arrow"></i>
                </li>
                <li class="nav-item">
                  <a href="court-list.php?facility_id=<?php echo $facility_id; ?>"><?php echo $row['name']?></a>
                </li>
                
              </ul>
            </div>
            <div class="row">
              <div class="col-md-12">
                <div class="card">
                  <div class="card-header">
                    <div class="d-flex align-items-center">
                      <!-- <h4 class="card-title">Add Row</h4> -->
                      <button
                        class="btn btn-primary btn-round ml-auto"
                        data-toggle="modal"
                        data-target="#addRowModal"
                      >
                        <i class="fa fa-plus"></i>
                        Add Court
                      </button>
                    </div>
                  </div>
                  <div class="card-body">
                    <!-- Modal -->
                    <div
                      class="modal fade"
                      id="addRowModal"
                      tabindex="-1"
                      role="dialog"
                      aria-hidden="true"
                    >
                      <div class="modal-dialog" role="document">
                        <div class="modal-content">
                          <form action="./backend/db_add_news.php" method="post">
                          <div class="modal-header no-bd">
                            <h5 class="modal-title">
                              <span class="fw-mediumbold"> News</span>
                              <!-- <span class="fw-light"> </span> -->
                            </h5>
                            <button
                              type="button"
                              class="close"
                              data-dismiss="modal"
                              aria-label="Close"
                            >
                              <span aria-hidden="true">&times;</span>
                            </button>
                          </div>
                          <div class="modal-body">
                            <p class="small">
                              Create a new news using this form, make sure you
                              fill them all
                            </p>
                              <div class="row">
                                <div class="col-sm-12">
                                  <div class="form-group form-group-default">
                                    <label>Title</label>
                                    <input
                                      name="title"
                                      id="addName"
                                      type="text"
                                      class="form-control"
                                      placeholder="fill title"
                                      required
                                    />
                                  </div>
                                </div>
                                <div class="col-md-6 pr-0">
                                  <div class="form-group form-group-default">
                                    <label>Location</label>
                                    <input
                                      name="location"
                                      id="addPosition"
                                      type="text"
                                      class="form-control"
                                      placeholder="fill location"
                                      required
                                      
                                    />
                                  </div>
                                </div>
                                <div class="col-md-6">
                                  <div class="form-group form-group-default">
                                    <label>Date</label>
                                    <input
                                      name="date"
                                      id="addOffice"
                                      type="date"
                                      class="form-control"
                                      placeholder="fill date"
                                      required

                                    />
                                  </div>
                                </div>
                                <div class="col-sm-12">
                                  <div class="form-group form-group-default">
                                    <label>Description</label>
                                    <input
                                      name="description"
                                      id="addName"
                                      type="text"
                                      class="form-control"
                                      placeholder="fill description"
                                      required

                                    />
                                  </div>
                                </div>
                                <div class="col-sm-12">
                                  <div class="form-group form-group-default">
                                    <label>Reporter</label>
                                    <input
                                      name="reporter"
                                      id="addName"
                                      type="text"
                                      class="form-control"
                                      placeholder="fill reporter"
                                      required

                                    />
                                  </div>
                                </div>
                                <div class="col-sm-12">
                                  <div class="form-group form-group-default">
                                    <label>Image Url</label>
                                    <input
                                      name="image_url"
                                      id="image_url"
                                      type="text"
                                      class="form-control"
                                      placeholder="image_url"
                                      required

                                    />
                                  </div>
                                </div>
                              </div>
                            
                          </div>
                          <div class="modal-footer no-bd">
                            <input
                              value="Add"
                              name="add"
                              type="submit"
                              id="addRowButton"
                              class="btn btn-primary"
                            />
                            <button
                              type="button"
                              class="btn btn-danger"
                              data-dismiss="modal"
                            >
                              Close
                            </button>
                          </div>
                          </form>
                        </div>
                      </div>
                    </div>
                    <!-- Table List -->
                    <?php 
                      $queryList = "SELECT * FROM court where facility_id='$facility_id'";
		                $resultList = mysqli_query($dbconn, $queryList) or die ("Error: " . mysqli_error($dbconn));
                      // Fetch all rows into an array
                      $rows = mysqli_fetch_all($resultList, MYSQLI_ASSOC);
                      // print_r($rows);
                    if (empty($rows)) {
                        echo "No court data available";
                    } else { ?>
                    <div class="table-responsive">
                      <table
                        id="add-row"
                        class="display table table-striped table-hover"
                      >
                        <thead>
                          <tr>
                            <!-- <th style="width: 0px !important">Image</th> -->
                            <th>Name</th>
                            <th>Status</th>
                            <!-- <th>State</th>
                            <th>District</th>
                            <th>Price</th>
                            <th>Total Court</th> -->
                            <th style="width: 10%; text-align: center;">Action</th>
                          </tr>
                        </thead>

                        <tbody>
                          <?php 
                          foreach ($rows as $row) {
                            //  $facilityId = $row['id'];
                            // // Query to get the total count of courts for the current facility
                            // $queryTotalCourt = "SELECT COUNT(courtID) AS total_courts FROM court WHERE facility_id = '$facilityId'";
                            // $resultTotalCourt = mysqli_query($dbconn, $queryTotalCourt);
                            // $rowTotalCourt = mysqli_fetch_assoc($resultTotalCourt);
                            // $totalCourts = $rowTotalCourt['total_courts'];
                          
                          ?>
                          <tr>
                            <!-- <td><img style="height: 10rem; width: 12rem;" src="<?php echo $row['image'] ?>" /></td> -->
                            <td><?php echo $row['name'] ?></td>
                            <td><?php echo $row['status'] ?></td>
                        

                            <td>
                              <div class="form-button-action">
                              
                                <a
                                  href="update_news.php?court_id=<?php echo $row['courtID']; ?>"
                                  data-toggle="tooltip"
                                  title=""
                                  class="btn btn-link btn-primary btn-lg"
                                  data-original-title="Edit News"
                                >
                                  <i class="fa fa-edit"></i>
                                </a>
                                <a
                                  href="./backend/db_delete_news.php?court_id=<?php echo $row['courtID']; ?>"
                                  data-toggle="tooltip"
                                  onclick="return confirm('Are you sure you want to delete this news article ?');"
                                  title=""
                                  class="btn btn-link btn-danger"
                                  data-original-title="Remove"
                                >
                                  <i class="fa fa-times"></i>
                                </a>
                              </div>
                            </td>
                          </tr>
                          <?php } ?>
                        </tbody>
                      </table>
                    </div>
                    <?php } ?>
                    <!-- End Table List -->
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--   Core JS Files   -->
    <script src="../../assets/js/core/jquery.3.2.1.min.js"></script>
    <script src="../../assets/js/core/popper.min.js"></script>
    <script src="../../assets/js/core/bootstrap.min.js"></script>
    <!-- jQuery UI -->
    <script src="../../assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
    <script src="../../assets/js/plugin/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js"></script>
    <!-- Bootstrap Toggle -->
    <script src="../../assets/js/plugin/bootstrap-toggle/bootstrap-toggle.min.js"></script>
    <!-- jQuery Scrollbar -->
    <script src="../../assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>
    <!-- Datatables -->
    <script src="../../assets/js/plugin/datatables/datatables.min.js"></script>
    <!-- Azzara JS -->
    <script src="../../assets/js/ready.min.js"></script>
    <!-- Azzara DEMO methods, don't include it in your project! -->
    <script src="../../assets/js/setting-demo.js"></script>
    <script>
      $(document).ready(function () {
        $("#basic-datatables").DataTable({});

        $("#multi-filter-select").DataTable({
          pageLength: 5,
          initComplete: function () {
            this.api()
              .columns()
              .every(function () {
                var column = this;
                var select = $(
                  '<select class="form-control"><option value=""></option></select>'
                )
                  .appendTo($(column.footer()).empty())
                  .on("change", function () {
                    var val = $.fn.dataTable.util.escapeRegex($(this).val());

                    column
                      .search(val ? "^" + val + "$" : "", true, false)
                      .draw();
                  });

                column
                  .data()
                  .unique()
                  .sort()
                  .each(function (d, j) {
                    select.append(
                      '<option value="' + d + '">' + d + "</option>"
                    );
                  });
              });
          },
        });

        // Add Row
        $("#add-row").DataTable({
          pageLength: 5,
        });

        var action =
          '<td> <div class="form-button-action"> <button type="button" data-toggle="tooltip" title="" class="btn btn-link btn-primary btn-lg" data-original-title="Edit Task"> <i class="fa fa-edit"></i> </button> <button type="button" data-toggle="tooltip" title="" class="btn btn-link btn-danger" data-original-title="Remove"> <i class="fa fa-times"></i> </button> </div> </td>';

        // $("#addRowButton").click(function () {
        //   $("#add-row")
        //     .dataTable()
        //     .fnAddData([
        //       $("#addName").val(),
        //       $("#addPosition").val(),
        //       $("#addOffice").val(),
        //       action,
        //     ]);
        //   $("#addRowModal").modal("hide");
        // });
      });
    </script>
  </body>
</html>
