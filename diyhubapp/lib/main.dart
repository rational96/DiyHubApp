import 'package:flutter/material.dart';
import 'login.dart';
import 'mongoConnect.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseManager().openConnection();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DIY HUB',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 196, 0)),
        useMaterial3: true,
      ),
      home:  const LoginPage(),
    );
  }
}
