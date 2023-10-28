import 'package:flutter/material.dart';

class APIs {
  static String ipAddress = "192.168.0.10";
  static String filePath = "BadmintonBuddyServerSide";
  static String apiGetBookingByID = "get_booking_by_id.php";
  static String apiSearchFacility = "search_facility.php";
  static String apiGetDataFacility = "get_data.php";
  static String apiAddBookingCourt = "add_booking_court.php";
  static String apiLogin = "login_account.php";
  static String apiSignup = "register_account.php";

  //list url
  static String getDataFacilityUrl = 'http://${APIs.ipAddress}/${APIs.filePath}/${APIs.apiGetDataFacility}';
  static String searchFacilityUrl = 'http://${APIs.ipAddress}/${APIs.filePath}/${APIs.apiSearchFacility}';
  static String getBookingByIdUrl = 'http://${APIs.ipAddress}/${APIs.filePath}/${APIs.apiGetBookingByID}';
  static String addBookingCourtUrl = 'http://${APIs.ipAddress}/${APIs.filePath}/${APIs.apiAddBookingCourt}';
  static String loginUrl = 'http://${APIs.ipAddress}/${APIs.filePath}/${APIs.apiLogin}';
  static String signupUrl = 'http://${APIs.ipAddress}/${APIs.filePath}/${APIs.apiSignup}';


}

