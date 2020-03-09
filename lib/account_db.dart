import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';


class Note{
  String _username;
  String _email;
  String _password;

  Note(this._username, this._email, this._password);

  String get username => _username;

  String get email => _email;

  String get password => _password;

  set username(String newUsername){
    this._username = newUsername;
  }
  set email(String newEmail){
    this._email = newEmail;
  }
  set password(String newPassword){
    this._password = newPassword;
  }

  Map<String, dynamic> toMap(){

    var map = Map<String, dynamic>();
    map['username'] = _username;
    map['email'] = _email;
    map['password'] = _password;

    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map){
    this._username = map['username'];
    this._email = map['email'];
    this._password = map['password'];
  }
}

class DatabaseHelper{

  static DatabaseHelper _databaseHelper; //creates only one instance of the class
  static Database _database;

  String noteTable = 'note_table';
  String colUsername = 'username';
  String colEmail = 'email';
  String colPassword = 'password';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database>initializeDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path  + 'notes.db';
    
    //open db at  pathv
    var notesDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
}



  void _createDb(Database db, int newVersion) async{
    await db.execute('CREATE TABLE $noteTable($colUsername TEXT , $colEmail TEXT, $colPassword TEXT)');
  }



  //get data from db
  getNoteMapList(String users_name, String users_password) async{
    Database db = await this.database;

    //query('account', where: 'username = ?', whereArgs: [users_name])
    String holder = 'SELECT $colPassword FROM $noteTable WHERE $colUsername = ? ';
    //var result = await db.rawQuery(holder , [users_name]);
    List<dynamic> result = await db.query(
        noteTable ,
        //columns: [colPassword],
        where: '$colUsername == ?',
        whereArgs: [users_name]);

      return result.first["password"];

  }

  //inserts data to db
  Future<int> insertNote(Note note) async{
    Database db =await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }




}

















/*
start() async {
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'account_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE accounts(username TEXT PRIMARY KEY, email TEXT, password TEXT)",
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  return database;
}

final database = start();



  Future<void> insertAccount(Account account) async {

    // Get a reference to the database.
    final Database db = await database;

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'accounts',
      account.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }



Future<Account> getPassword(String users_name) async {
  //Future<Car> fetchCar(int id) async {
    var client = await database;
    final Future<List<Map<String, dynamic>>> futureMaps = client.query('account', where: 'username = ?', whereArgs: [users_name]);
    var maps = await futureMaps;
    if (maps.length != 0) {
      return Account.fromDb(maps.first);
    };
    return null;
  }
  
  Future<List<Account>> accounts() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('accounts');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Account(
        username: maps[i]['username'],
        email: maps[i]['email'],
        password: maps[i]['password'],
      );
    });
  }

  Future<void> updateAccount(Account account) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'accounts',
      account.toMap(),
      // Ensure that the Dog has a matching id.
      where: "username = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [account.username],
    );
  }

  Future<void> deleteAccount(String username) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'accounts',
      // Use a `where` clause to delete a specific dog.
      where: "username = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [username],
    );
  }

  /*var fido = Account(
    username: 'test',
    email: 'test',
    password: 'test',
  );*/

  // Insert a dog into the database.


  // Print the list of dogs (only Fido for now).
//  print(await accounts());

  // Update Fido's age and save it to the database.
  /*fido = Account(
    username: fido.username,
    email: fido.email,
    password: fido.password,
  );*/
  //await updateAccount(fido);

  // Print Fido's updated information.
  //print(await accounts());

  // Delete Fido from the database.
  //await deleteAccount(fido.username);



class Account {
  final String username;
  final String email;
  final String password;

  Account({this.username, this.email, this.password});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }

  Account.fromDb(Map<String, dynamic> map)
      : username = map['username'],
        email = map['email'],
        password = map['password'];

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Account{username: $username, email: $email, password: $password}';
  }
}*/