import 'package:flutter/material.dart';
import 'changePasswordPage.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key, required this.user}) : super(key: key);
  final Map<String, dynamic> user;
  void _navigateToChangePassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChangePasswordPage(user : user)), 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text(
            user['username'], 
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            user['email'], 
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


