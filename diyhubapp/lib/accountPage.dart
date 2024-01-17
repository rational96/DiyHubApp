import 'package:diyhubapp/login.dart';
import 'package:flutter/material.dart';
import 'changePasswordPage.dart';
import 'login.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key, required this.user}) : super(key: key);
  final Map<String, dynamic> user;
  void _navigateToChangePassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChangePasswordPage(user : user)), 
    );
  }
  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage())
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
            foregroundColor: Colors.white, backgroundColor: Theme.of(context).colorScheme.primary, 
          ),
          child: const Text('Change Password'),
        ),
        ElevatedButton(
          onPressed: () => _navigateToLogin(context),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Theme.of(context).colorScheme.primary, 
          ),
          child: const Text('Sign Out'),
        ),
      ],
    );
  }
}


