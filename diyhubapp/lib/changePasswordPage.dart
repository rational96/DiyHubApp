import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'mongoConnect.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key, required this.user}) : super(key: key);
  final Map<String, dynamic> user;

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();

  void _changePassword() async {
    String oldPassword = _oldPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmNewPassword = _confirmNewPasswordController.text;

    var oldPasswordHash = sha256.convert(utf8.encode(oldPassword));

    if (oldPasswordHash.toString() != widget.user['password']) {
      _showMessage('Incorrect old password', context);
      return;
    }

    if (newPassword != confirmNewPassword) {
      _showMessage('New passwords do not match', context);
      return;
    }

    var newPasswordHash = sha256.convert(utf8.encode(newPassword));

    if (newPassword == oldPassword) {
      _showMessage('New password must be different from old password', context);
      return;
    }

    // This is where you would call your backend service to update the user's password
    var userId = widget.user['username']; // Replace with actual user id key if different

    // Create the filter query to find the user document.
    var filterQuery = {'username': userId};

    // Create the update query to set the new password.
    var updateQuery = {
      '\$set': {'password': newPasswordHash.toString()}
    };
    await DatabaseManager().updateData('Accounts', filterQuery, updateQuery);
    // For now, let's just print a confirmation message
    _showMessage('Password changed successfully', context);

    // Pop the current page off the navigation stack after changing password
    Navigator.of(context).pop();  
  }

  void _showMessage(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _oldPasswordController,
              decoration: const InputDecoration(
                labelText: 'Old Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _newPasswordController,
              decoration: const InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmNewPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _changePassword,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Theme.of(context).colorScheme.primary, // Text color
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
