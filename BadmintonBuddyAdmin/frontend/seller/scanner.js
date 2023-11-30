const video = document.getElementById("qr-video");
const qrResult = document.getElementById("qr-result");

let scanner = new Instascan.Scanner({ video: video });

// Access the facilityIdFromPHP variable defined in qr-scanner.php
scanner.addListener("scan", function (content) {
  qrResult.textContent = content;

  // Encode the facility_id and append it to the URL
  var encodedFacilityId = encodeURIComponent(facilityIdFromPHP);
  console.log("Redirect URL:", encodedFacilityId);

  var redirectUrl = content + "?facility_id=" + encodedFacilityId;
  // console.log("Redirect URL:", encodedFacilityId);
  // Redirect to the scanned URL with facility_id
  window.location.href = content + "&facility_id=" + encodedFacilityId;

  $("#entrancePassModal").modal("show");
});

// Automatically start the scanner when the page loads
document.addEventListener("DOMContentLoaded", function () {
  Instascan.Camera.getCameras()
    .then(function (cameras) {
      if (cameras.length > 0) {
        scanner.start(cameras[0]);
      } else {
        alert("No cameras found.");
      }
    })
    .catch(function (e) {
      console.error(e);
    });
});
