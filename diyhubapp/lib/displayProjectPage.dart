import 'package:flutter/material.dart';

class DisplayProjectPage extends StatefulWidget {
  final String projectName; 
  DisplayProjectPage({Key? key, required this.projectName}) : super(key: key);
  @override
  _DisplayProjectPageState createState() => _DisplayProjectPageState();
}

class _DisplayProjectPageState extends State<DisplayProjectPage> {
  bool _isFavorite = false; // State to manage if the project is liked or not

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DIY HUB'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: SingleChildScrollView( 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.projectName, // Display the name of the project
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const Text(
                          '@username', // Replace with actual username
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
                    color: _isFavorite ? Colors.red : null,
                    onPressed: () {
                      setState(() {
                        _isFavorite = !_isFavorite; // Toggle the favorite state
                      });
                    },
                    iconSize: 32,
                  ),
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Materials',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  // ... List of materials
                  SizedBox(height: 16),
                  Text(
                    'Steps',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  // ... List of steps
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
