<?php 
    include('./backend/dbconn.php');
    include ("./backend/session.php");
    session_start();
    $user = $_SESSION['username'];
    if (!isset($_SESSION['username'])) {
            header('Location: index.html');
            } 

    // SQL Select news by news_id
    $query = "SELECT * FROM admin WHERE username='$user'";
	$result = mysqli_query($conn, $query) or die ("Error: " . mysqli_error($conn));
	$row = mysqli_fetch_array($result);
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Admin Profile</title>
    <meta
      content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
      name="viewport"
    />
    <link rel="icon" href="./assets//img/icon.ico" type="image/x-icon" />

    <!-- Fonts and icons -->
    <script src="./assets//js/plugin/webfont/webfont.min.js"></script>
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
          urls: ["./assets//css/fonts.css"],
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
    <link rel="stylesheet" href="./assets//css/bootstrap.min.css" />
    <link rel="stylesheet" href="./assets//css/azzara.min.css" />
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="./assets//css/demo.css" />
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
                        HazardSpotter

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
                    <a class="dropdown-item" href="admin_profile.php"
                      >My Profile</a
                    >
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
              <li class="nav-item">
                <a href="news-list.php">
                  <i class="fa-solid fa-newspaper fa-lg"></i>
                  <p>News</p>
                  <!-- <span class="badge badge-count">5</span> -->
                </a>
              </li>
              <li class="nav-item">
                <a href="users-list.php">
                  <i class="fa-solid fa-users fa-lg"></i>
                  <p>User</p>
                  <!-- <span class="badge badge-count">5</span> -->
                </a>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <!-- End Sidebar -->
      <div class="main-panel">
        <div class="content">
          <div class="page-inner">
            <h4 class="page-title">Admin Profile</h4>
            <div class="row">
              <div class="col-md-8">
                <div class="card card-with-nav">
                  <div class="card-header">
                    <div class="row row-nav-line">
                      <ul
                        class="nav nav-tabs nav-line nav-color-secondary"
                        role="tablist"
                      >
                        <li class="nav-item">
                          <a
                            class="nav-link"
                            data-toggle="tab"
                            href="#profile"
                            role="tab"
                            aria-selected="false"
                            >Profile</a
                          >
                        </li>
                      </ul>
                    </div>
                  </div>
                  <form method="post" action="./backend/db_edit_profile_admin.php">
                    <div class="card-body">
                      <div class="row mt-3">
                        <div class="col-md-6">
                          <div class="form-group form-group-default">
                            <label>Username</label>
                            <input
                              type="text"
                              class="form-control"
                              name="username"
                              placeholder="username"
                              value="<?php echo $row['username']; ?>"
                              readonly
                            />
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group form-group-default">
                            <label>Password</label>
                            <input
                              type="password"
                              class="form-control"
                              name="password"
                              placeholder="password"
                              value="<?php echo $row['password']; ?>"
                            />
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group form-group-default">
                            <label>Name</label>
                            <input
                              type="text"
                              class="form-control"
                              name="name"
                              placeholder="Name"
                              value="<?php echo $row['name']; ?>"
                            />
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group form-group-default">
                            <label>Email</label>
                            <input
                              type="email"
                              class="form-control"
                              name="email"
                              placeholder="Email"
                              value="<?php echo $row['email']; ?>"
                            />
                          </div>
                        </div>
                      </div>
                      <div class="row mt-3">
                        <div class="col-md-4">
                          <div class="form-group form-group-default">
                            <label>Phone</label>
                            <input
                              type="text"
                              class="form-control"
                              value="<?php echo $row['phone']; ?>8"
                              name="phone"
                              placeholder="phone"
                            />
                          </div>
                        </div>
                      </div>

                      <div class="row mt-3 mb-1">
                        <div class="col-md-12">
                          <div class="form-group form-group-default">
                            <label>Address</label>
                            <textarea
                              class="form-control"
                              name="address"
                              placeholder="Address"
                              rows="3"
                            ><?php echo $row['address']; ?></textarea
                            >
                          </div>
                        </div>
                      </div>
                      <div class="text-right mt-3 mb-3">
                        <input
                          type="submit"
                          value="Save"
                          name="save"
                          class="btn btn-success"
                        />
                      </div>
                    </div>
                  </form>
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
    <!-- Moment JS -->
    <script src="./assets/js/plugin/moment/moment.min.js"></script>
    <!-- DateTimePicker -->
    <script src="./assets/js/plugin/datepicker/bootstrap-datetimepicker.min.js"></script>
    <!-- Bootstrap Toggle -->
    <script src="./assets/js/plugin/bootstrap-toggle/bootstrap-toggle.min.js"></script>
    <!-- jQuery Scrollbar -->
    <script src="./assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>
    <!-- Azzara JS -->
    <script src="./assets/js/ready.min.js"></script>
    <!-- Azzara DEMO methods, don't include it in your project! -->
    <script src="./assets/js/setting-demo.js"></script>
    <script>
      $("#datepicker").datetimepicker({
        format: "MM/DD/YYYY",
      });
    </script>
  </body>
</html>
