import 'displayProjectPage.dart';
import 'package:flutter/material.dart';

class ProjectPage extends StatelessWidget {
  ProjectPage({Key? key, required this.user}) : super(key: key);
  final Map<String, dynamic> user;
  

  @override
  Widget build(BuildContext context) {
    List<String> userProjects = List<String>.from(user['projects'] as List);
    return ListView.builder(
      itemCount: userProjects.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(userProjects[index]),
          onTap: () {
            String projectName = userProjects[index];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayProjectPage(projectName: projectName)
              )
            );
          },
        );
      },
    );
  }
}
