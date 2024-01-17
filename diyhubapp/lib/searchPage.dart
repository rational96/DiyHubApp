import 'package:flutter/material.dart';
import 'mongoConnect.dart';
import 'displayProjectPage.dart';

class SearchPage extends StatefulWidget {
  final Map<String, dynamic> user;

  SearchPage({Key? key, required this.user}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) async {
    var results = await DatabaseManager().getData('Projects', {
      'title': {'\$regex': query, '\$options': 'i'} // This is a MongoDB regex query for case-insensitive partial matches
    });

    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  _performSearch(_searchController.text);
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  _searchResults[index]['title'], // Assuming 'title' is the field name in your documents
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  _searchResults[index]['username'] ?? 'Unknown', // Adjust field name as necessary
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                onTap: () {
                  String projectName = _searchResults[index]['title'];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayProjectPage(projectName: projectName),
                    ),
                  );
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
