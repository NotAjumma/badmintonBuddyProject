<?php 
require_once "../../backend/include/dbconn.php";
session_start();
    $userid = $_SESSION['userid'];
    if (!isset($_SESSION['userid'])) {
            header('Location: index.html');
            } 

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
  <style>

    .arrow-icon {
      color: #9ca3af;
    }

    .action-dropdown {
      position: relative;
      display: inline-block;
    }

    .action-btn {
      background-color: white; /* Set the background color to white */
      color: black; /* Set the text color to #9ca3af */
      padding: 8px 12px;
      font-weight: 600;  
      border: 1px solid #9ca3af; /* Add a border with the color #9ca3af */
      border-radius: 4px;
      cursor: pointer;
    }

    .dropdown-content {
      display: none;
      position: absolute;
      background-color: #f9f9f9;
      min-width: 160px;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
      z-index: 2;
    }

    .dropdown-content a {
      color: black;
      padding: 12px 16px;
      text-decoration: none;
      display: flex;
      align-items: center; /* Center the text and icon vertically */
    }

    .dropdown-content a i {
      margin-right: 8px;
      color: #9ca3af;
    }

    .dropdown-content a:hover {
      background-color: #ddd;
    }
  </style>
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
                  <i class="fa-solid fa-store fa-lg"></i>
                  <p>Facility</p>
                  <!-- <span class="badge badge-count">5</span> -->
                </a>
              </li>
              <!-- <li class="nav-item">
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
              <h4 class="page-title">Facility List</h4>
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
                  <a href="news-list.php">Facility</a>
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
                        Add Facility
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
                      <div class="modal-dialog" style="max-width: 900px !important;" role="document">
                        <div class="modal-content">
                          <form action="../../backend/seller/db_add_facility.php" method="post">
                          <div class="modal-header no-bd">
                            <h5 class="modal-title">
                              <span class="fw-mediumbold">Facility</span>
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
                              Create a new Facility using this form, make sure you
                              fill them all
                            </p>
                              <div class="row">
                                <div class="col-sm-12">
                                  <div class="form-group form-group-default">
                                    <label>Name</label>
                                    <input
                                      name="name"
                                      id="addName"
                                      type="text"
                                      class="form-control"
                                      placeholder="fill name"
                                      required
                                    />
                                  </div>
                                </div>
                                <div class="col-md-6 pr-0">
                                  <div class="form-group form-group-default">
                                    <label for="addPosition">State</label>
                                    <select name="state" id="stateDropdown" class="form-control" required>
                                      <option value="">Select a state</option>
                                      <option value="Johor">Johor</option>
                                      <option value="Kedah">Kedah</option>
                                      <option value="Kelantan">Kelantan</option>
                                      <option value="Kuala Lumpur">Kuala Lumpur</option>
                                      <option value="Labuan">Labuan</option>
                                      <option value="Melaka">Melaka</option>
                                      <option value="Negeri Sembilan">Negeri Sembilan</option>
                                      <option value="Pahang">Pahang</option>
                                      <option value="Penang">Penang</option>
                                      <option value="Perak">Perak</option>
                                      <option value="Perlis">Perlis</option>
                                      <option value="Putrajaya">Putrajaya</option>
                                      <option value="Sabah">Sabah</option>
                                      <option value="Sarawak">Sarawak</option>
                                      <option value="Selangor">Selangor</option>
                                      <option value="Terengganu">Terengganu</option>
                                    </select>
                                  </div>
                                </div>

                                <div class="col-md-6">
                                  <div class="form-group form-group-default">
                                    <label for="addOffice">District</label>
                                    <select name="district" id="districtDropdown" class="form-control" required>
                                      <option value="">Select a state first</option>
                                    </select>
                                  </div>
                                </div>



                                <div class="col-sm-12">
                                  <div class="form-group form-group-default">
                                    <label for="address">Address</label>
                                    <input
                                      name="address"
                                      id="address"
                                      type="text"
                                      class="form-control"
                                      placeholder="Enter address"
                                      required
                                    />
                                  </div>
                                </div>

                                <div class="col-sm-12">
                                  <div class="form-group form-group-default">
                                    <label for="price">Price</label>
                                    <input
                                      name="price"
                                      id="price"
                                      type="number"
                                      class="form-control"
                                      placeholder="Enter price"
                                      required
                                    />
                                  </div>
                                </div>

                                <div class="col-sm-12">
                                  <div class="form-group form-group-default">
                                    <label for="image">Image URL</label>
                                    <input
                                      name="image_url"
                                      id="image_url"
                                      type="text"
                                      class="form-control"
                                      placeholder="Enter image URL"
                                      required
                                    />
                                  </div>
                                </div>

                                <input type="hidden" name="userid" value="<?php echo $userid ?>" >

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
                      $query = "SELECT * FROM facility where userid='$userid'";
		                  $result = mysqli_query($dbconn, $query) or die ("Error: " . mysqli_error($dbconn));
                      // Fetch all rows into an array
                      $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
                      // print_r($rows);
                    if (empty($rows)) {
                        echo "No facility data available";
                    } else { ?>
                    <div class="table-responsive" style="min-height: 70vh; min-width: 70vw;">
                      <table
                        id="add-row"
                        class="display table table-striped table-hover"
                      >
                        <thead>
                          <tr>
                            <th style="width: 0px !important">Image</th>
                            <th>Name</th>
                            <th>State</th>
                            <th>District</th>
                            <th>Price Per Hour</th>
                            <th>Total Court</th>
                            <th style="width: 10%; text-align: center;">Action</th>
                          </tr>
                        </thead>

                        <tbody>
                          <?php 
                          foreach ($rows as $row) {
                             $facilityId = $row['id'];
                            // Query to get the total count of courts for the current facility
                            $queryTotalCourt = "SELECT COUNT(courtID) AS total_courts FROM court WHERE facility_id = '$facilityId'";
                            $resultTotalCourt = mysqli_query($dbconn, $queryTotalCourt);
                            $rowTotalCourt = mysqli_fetch_assoc($resultTotalCourt);
                            $totalCourts = $rowTotalCourt['total_courts'];
                          
                          ?>
                          <tr>
                            <td><img style="height: 5rem; width: 6rem;" src="<?php echo $row['image'] ?>" /></td>
                            <td><?php echo $row['name'] ?></td>
                            <td><?php echo $row['state'] ?></td>
                            <td><?php echo $row['district'] ?></td>
                            <td>RM <?php echo $row['price'] ?></td>
                            <td><?php echo $totalCourts ?></td>

                            <td>
                                <div class="form-button-action">
                                  <div class="action-dropdown">
                                      <button class="action-btn" onclick="toggleDropdown('<?php echo $facilityId; ?>')">Options <i class="fa-solid fa-chevron-down arrow-icon"></i> </button>
                                      <div class="dropdown-content" id="actionDropdown_<?php echo $facilityId; ?>">
                                          <a href="qr-scanner.php?facility_id=<?php echo $facilityId; ?>" class="action-item"><i class="fa fa-camera"></i> QR Scanner</a>
                                          <a href="court-list.php?facility_id=<?php echo $facilityId; ?>" class="action-item"><i class="fa-solid fa-eye"></i> View Courts</a>
                                          <a href="update_news.php?news_id=<?php echo $facilityId; ?>" class="action-item"><i class="fa-solid fa-edit"></i> Edit Facility</a>
                                          <a href="../../backend/seller/db_delete_facility.php?facility_id=<?php echo $facilityId; ?>" class="action-item"><i class="fa-solid fa-times"></i> Remove</a>
                                      </div>
                                  </div>
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
      function toggleDropdown(facilityId) {
    var dropdown = document.getElementById("actionDropdown_" + facilityId);
    dropdown.style.display = (dropdown.style.display === "block") ? "none" : "block";
}

  // Close the dropdown if the user clicks outside of it
  window.onclick = function(event) {
    if (!event.target.matches('.action-btn')) {
      var dropdowns = document.getElementsByClassName("dropdown-content");
      for (var i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.style.display === "block") {
          openDropdown.style.display = "none";
        }
      }
    }
  }

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

        // JavaScript to update the District dropdown based on the selected State
        document.getElementById("stateDropdown").addEventListener("change", function () {
          var stateDropdown = document.getElementById("stateDropdown");
          var districtDropdown = document.getElementById("districtDropdown");
          var selectedState = stateDropdown.value;
          districtDropdown.innerHTML = ""; // Clear the current options

          if (selectedState === "Perak") {
            // Add Perak districts
            var perakDistricts = ["Batu Gajah", "Melembu", "Lahat", "Ipoh"];
            perakDistricts.forEach(function (district) {
              var option = document.createElement("option");
              option.text = district;
              option.value = district;
              districtDropdown.appendChild(option);
            });
          }
          // Add more conditions for other states as needed
        });
    </script>
  </body>
</html>
