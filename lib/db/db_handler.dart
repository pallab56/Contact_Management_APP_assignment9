import 'package:assignment9/model/contact_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHandler {
  static final DbHandler instance = DbHandler._constructor();
  final String contactTableName = 'contact';

  //column name
  final String contactIdColumnName = 'id';

  final String contactNameColumnName = 'name';
  final String contactNumberColumnName = 'number';
  final String contactEmailColumnName = 'email';
  final String contactAddressColumnName = 'address';
  final String contactFavoriteColumnName = 'isFavorite';
  DbHandler._constructor();

  Database? db;
  Future<Database?> get database async {
    if (db != null) {
      return db!;
    }
    db = await getDatabase();
    return db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();

    final databasePath = join(databaseDirPath, 'contact_mager_db.db');

    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
      CREATE TABLE $contactTableName(
      
      $contactIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
      $contactNameColumnName TEXT NOT NULL,
      $contactNumberColumnName TEXT NOT NULL,
      $contactEmailColumnName TEXT NOT NULL,
      $contactAddressColumnName TEXT NOT NULL,
      $contactFavoriteColumnName INTEGER NOT NULL DEFAULT 0
      )
''');
      },
    );
    return database;
  }

  Future<int> addContact(ContactModel contactModel) async {
    final db = await database;
    return await db!.insert(contactTableName, {
      contactNameColumnName: contactModel.name,
      contactNumberColumnName: contactModel.number,
      contactEmailColumnName: contactModel.email,
      contactAddressColumnName: contactModel.address,
      contactFavoriteColumnName: contactModel.isFavorite,
    });
  }

  Future<List<ContactModel>> getContacts() async {
    final db = await database;
    final data = await db!.query(contactTableName);

    List<ContactModel> list = data.map((e) => ContactModel.fromMap(e)).toList();

    return list;
  }

  Future<List<ContactModel>> getFavourites() async {
    final db = await database;

    final data = await db!.query(
      contactTableName,
      where: '$contactFavoriteColumnName = ?',
      whereArgs: [1],
    );

    List<ContactModel> list = data.map((e) => ContactModel.fromMap(e)).toList();
    return list;
  }
}
