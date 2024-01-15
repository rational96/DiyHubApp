import 'package:flutter/material.dart';
import 'mongoConnect.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';


class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key, required this.title});
  final String title;
  @override
  CreateAccountPageState createState() => CreateAccountPageState();
}

String hashPassword(String password) {
  // WARNING: This is a simple hash, not suitable for production use!
  var bytes = utf8.encode(password);
  return sha256.convert(bytes).toString();
}


class CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () async {
                // Input validation
                if (_passwordController.text != _confirmPasswordController.text) {
                  // Show some error that passwords do not match
                  return;
                }
                if (_usernameController.text.isEmpty || _emailController.text.isEmpty) {
                  // Show some error that username or email cannot be empty
                  return;
                }
                // More validation can be added as needed

                // Hash the password - implement the hashPassword method according to your security requirements
                String hashedPassword = hashPassword(_passwordController.text);

                // Create a user document
                Map<String, dynamic> newUser = {
                  'username': _usernameController.text,
                  'password': hashedPassword,
                  'email': _emailController.text,
                  'projects': [] // Starts with an empty array of projects
                };

                // Insert the new user into the database
                var dbManager = DatabaseManager();
                await dbManager.insertData('Accounts', newUser);

                // Navigate to the login page or show a success message
              },
              child: const Text('Create Account'),
            ),

          ],
        ),
      ),
    );
  }
}
