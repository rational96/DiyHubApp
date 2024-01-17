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
                if (_usernameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty || _confirmPasswordController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text("Fields can not be left empty."),
                      );
                    },
                  );
                  return;
                }
                if (_passwordController.text != _confirmPasswordController.text) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text("Passwords do not match."),
                      );
                    },
                  );
                  return;
                }
                if (_usernameController.text.isEmpty || _emailController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text("Username and email cannot be empty."),
                      );
                    },
                  );
                  return;
                }
                var dbManager = DatabaseManager();
                var existingUsers = await dbManager.getData('Accounts', {'username': _usernameController.text});

                if (existingUsers.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text("Username is already taken. Please choose another one."),
                      );
                    },
                  );
                  return;
                }

                String hashedPassword = hashPassword(_passwordController.text);
                Map<String, dynamic> newUser = {
                  'username': _usernameController.text,
                  'password': hashedPassword,
                  'email': _emailController.text,
                  'projects': [] 
                };

                await dbManager.insertData('Accounts', newUser);
                Navigator.pop(context);
              },
              child: const Text('Create Account'),
            ),

          ],
        ),
      ),
    );
  }
}
