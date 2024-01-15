import 'forgotPassword.dart';
import 'mainPage.dart';
import 'mongoConnect.dart';
import 'createAccount.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('DIY HUB'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height:10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () async {
                // Use the username and password to fetch user info from the accounts collection
              var dbManager = DatabaseManager();
              List<Map<String, dynamic>> users = await dbManager.getData('accounts', {
                'username': _usernameController.text,
                // Ideally, you should hash the password before sending it to the method
                'password': _passwordController.text, // WARNING: Plain text password (hash it instead!)
              });

              if (users.isNotEmpty) {
                // User found
                var userInfo = users.first;
                // Now you can do something with userInfo, like navigating to the MainPage
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MainPage(user: userInfo))
                );
              } else {
                // User not found or wrong credentials
                // Show some error message
                print('No user found or wrong credentials!');
              }
                
               // Implement sign-in logic
            },

              child: const Text('Sign in'),
            ),

            TextButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateAccountPage(title: 'DIY HUB')), 
                );// Navigate to create account page
              },
              child: const Text('Create account'),
            ),
            
            TextButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ForgotPasswordPage(title: 'DIY HUB')), // Replace with the actual ChangePasswordPage widget
                );// Navigate to forgot password page
              },
              child: const Text('Forgot Password'),
            ),
          ],
        ),
      ),
    );
  }
}