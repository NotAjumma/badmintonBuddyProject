import 'package:flutter/material.dart';

class APIsBook {
  static String ipAddress = "192.168.0.2";
  static String filePath = "BadmintonBuddyServerSide";
  static String apiGetBookingByID = "get_booking_by_id.php";
  static String apiSearchFacility = "search_facility.php";
  static String apiGetDataFacility = "get_data.php";
  static String apiAddBookingCourt = "add_booking_court.php";
  static String apiLogin = "login_account.php";
  static String apiSignup = "register_account.php";
  static String apiGetAvailableCourt = "get_available_courts.php";


  //list url
  static String getDataFacilityUrl = 'http://${APIsBook.ipAddress}/${APIsBook.filePath}/${APIsBook.apiGetDataFacility}';
  static String searchFacilityUrl = 'http://${APIsBook.ipAddress}/${APIsBook.filePath}/${APIsBook.apiSearchFacility}';
  static String getBookingByIdUrl = 'http://${APIsBook.ipAddress}/${APIsBook.filePath}/${APIsBook.apiGetBookingByID}';
  static String addBookingCourtUrl = 'http://${APIsBook.ipAddress}/${APIsBook.filePath}/${APIsBook.apiAddBookingCourt}';
  static String loginUrl = 'http://${APIsBook.ipAddress}/${APIsBook.filePath}/${APIsBook.apiLogin}';
  static String signupUrl = 'http://${APIsBook.ipAddress}/${APIsBook.filePath}/${APIsBook.apiSignup}';
  static String getAvailableCourtUrl = 'http://${APIsBook.ipAddress}/${APIsBook.filePath}/${APIsBook.apiGetAvailableCourt}';



}

