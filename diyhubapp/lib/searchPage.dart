import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final TextEditingController _searchController = TextEditingController();

  // Example search results. Replace with actual data.
  final List<Map<String, dynamic>> _searchResults = [];

  void _onSearchSubmitted(BuildContext context, String value) {
    // Handle the search logic when the user submits a search
    print('User searched for: $value');
    // TODO: Implement the search logic and update the _searchResults list
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onSubmitted: (value) => _onSearchSubmitted(context, value),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  _searchResults[index]['projectName'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  _searchResults[index]['username'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                onTap: () {
                  // Implement what happens when you tap the project
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
