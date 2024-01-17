import 'package:mongo_dart/mongo_dart.dart';

class DatabaseManager {
  static final DatabaseManager _instance = DatabaseManager._internal();
  late Db _db;

  factory DatabaseManager() {
    return _instance;
  }

  DatabaseManager._internal();

  Future<void> openConnection() async {
    _db = await Db.create('mongodb+srv://Rationality96:QzBNz0MhR2Oprr0E@cluster0.mgqj1hy.mongodb.net/DIYHUB');
    await _db.open();
    print('Connected to MongoDB');
  }

  Future<void> closeConnection() async {
    await _db.close();
  }

  Future<void> insertData(String collectionName, Map<String, dynamic> data) async {
    await openConnection();
    var collection = _db.collection(collectionName);
    await collection.insertOne(data);
    await closeConnection();
  }

  Future<List<Map<String, dynamic>>> getData(String collectionName, [Map<String, dynamic>? query]) async {
    await openConnection();
    var collection = _db.collection(collectionName);
    var result = await collection.find(query).toList();
    await closeConnection();
    return result;
  }

  Future<void> deleteData(String collectionName, Map<String, dynamic> query) async {
    await openConnection();
    var collection = _db.collection(collectionName);
    await collection.deleteOne(query);
    closeConnection();
  }

  Future<void> updateData(String collectionName,  Map<String, dynamic> filter, Map<String, dynamic> updateQuery) async {
    await openConnection();
    var collection = _db.collection(collectionName);
    await collection.update(filter, updateQuery);
    await closeConnection();
  }

  Future<Map<String, dynamic>?> fetchUserData(String userId) async {
    await openConnection();
    var collection = _db.collection('Accounts');
    var result = await collection.findOne({'username': userId});
    await closeConnection();
    return result;
  }

  Future<Map<String, dynamic>?> getProjectData(String projectName) async {
    await openConnection();
    var collection = _db.collection('Projects'); 
    var result = await collection.findOne({'title': projectName});
    await closeConnection();
    return result;
  }
}