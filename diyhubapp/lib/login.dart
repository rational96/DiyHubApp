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
                String hashedInputPassword = hashPassword(_passwordController.text);
                var dbManager = DatabaseManager();
                List<Map<String, dynamic>> users = await dbManager.getData('Accounts', {
                  'username': _usernameController.text,
                });
                
                if (users.isNotEmpty && users[0]['password'] == hashedInputPassword) {
                  var userInfo = users.first;
                  Navigator.of(context).pushReplacement(
                     MaterialPageRoute(builder: (context) => MainPage(user: userInfo))
                   );
                } 
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateAccountPage(title: 'DIY HUB')), 
                );
              },
              child: const Text('Create account'),
            ),
          ],
        ),
      ),
    );
  }
}