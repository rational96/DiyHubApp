import 'package:mongo_dart/mongo_dart.dart';

class Account {
  ObjectId id; // MongoDB's built-in unique ID
  String username;
  String password; // This should be a hashed password
  String email;
  List<ObjectId> projects; // Assuming project IDs are also MongoDB ObjectIds

  Account({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.projects,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'username': username,
      'password': password,
      'email': email,
      'projects': projects,
    };
  }

  static Account fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['_id'],
      username: map['username'],
      password: map['password'],
      email: map['email'],
      projects: List<ObjectId>.from(map['projects']),
    );
  }
}
