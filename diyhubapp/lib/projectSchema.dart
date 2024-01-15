import 'package:mongo_dart/mongo_dart.dart';

class Project {
  ObjectId id; // MongoDB's built-in unique ID
  String title;
  List<String> materials;
  List<String> steps;

  Project({
    required this.id,
    required this.title,
    required this.materials,
    required this.steps,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'title': title,
      'materials': materials,
      'steps': steps,
    };
  }

  static Project fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['_id'],
      title: map['title'],
      materials: List<String>.from(map['materials']),
      steps: List<String>.from(map['steps']),
    );
  }
}
