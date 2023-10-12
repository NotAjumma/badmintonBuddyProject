import 'package:flutter/material.dart';

// SearchResultScreen
class SearchResultScreen extends StatelessWidget {
  final List<Map<String, dynamic>> searchResults;
  final String searchQuery; // Search query
  final VoidCallback clearFilterCallback; // Callback to clear the filter

  const SearchResultScreen({
    Key? key,
    required this.searchResults,
    required this.searchQuery, // Pass the search query
    required this.clearFilterCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Call the callback to clear the filter
            clearFilterCallback();
            Navigator.pop(context); // Navigate back to HomeScreen
          },
        ),
        title: Text("Search Results"),
        // title: Text("Search Query: $searchQuery"), // Display the search query
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final result = searchResults[index];
          // Create a widget to display each search result
          return ListTile(
            title: Text(result['name']), // Example: Display the facility name
            // Add more details or customize the ListTile as needed
          );
        },
      ),
    );
  }
}

