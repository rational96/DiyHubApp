import 'displayProjectPage.dart';
import 'package:flutter/material.dart';

class ProjectPage extends StatelessWidget {
  ProjectPage({Key? key}) : super(key: key);

  // Example list of projects. Replace with your actual project data source.
  final List<String> _projects = List.generate(50, (i) => 'Project ${i + 1}');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _projects.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_projects[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DisplayProjectPage()
              )
            );
            // Handle project tapped
            print('Tapped on project: ${_projects[index]}');
          },
        );
      },
    );
  }
}
