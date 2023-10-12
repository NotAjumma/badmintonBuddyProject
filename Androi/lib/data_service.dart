import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Map<String, dynamic>>> fetchBadmintonFacilities() async {
  final response = await http.get(Uri.parse('http://192.168.137.1/BadmintonBuddyServerSide/get_data.php'));

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load facilities from the server');
  }
}

Future<List<Map<String, dynamic>>> searchBadmintonFacilities(String query) async {
  final response = await http.get(Uri.parse('http://192.168.137.1/BadmintonBuddyServerSide/search_facility.php?searchQuery=$query'));

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load search results from the server');
  }
}

// Future<List<Map<String, dynamic>>> fetchBookList() async {
//   final response = await http.get(Uri.parse('http://192.168.137.1/BadmintonBuddyServerSide/get_data.php'));
//
//   if (response.statusCode == 200) {
//     List<dynamic> jsonResponse = json.decode(response.body);
//     return jsonResponse.cast<Map<String, dynamic>>();
//   } else {
//     throw Exception('Failed to load booking data from the server');
//   }
// }
