import 'package:flutter/material.dart';
import 'changePasswordPage.dart'; // Make sure you have this page created in your project

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  void _navigateToChangePassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChangePasswordPage()), // Replace with the actual ChangePasswordPage widget
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const ListTile(
          title: Text(
            'Username', // Replace with actual username
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'email@example.com', // Replace with the actual email
            style: TextStyle(color: Colors.grey),
          ),
          leading: Icon(Icons.person),
        ),
        ElevatedButton(
          onPressed: () => _navigateToChangePassword(context),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Theme.of(context).colorScheme.primary, // Text color
          ),
          child: const Text('Change Password'),
        ),
      ],
    );
  }
}
