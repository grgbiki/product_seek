// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao _userDaoInstance;

  ProductDao _productDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UserModel` (`id` INTEGER, `name` TEXT, `email` TEXT, `phone_number` TEXT, `address` TEXT, `role` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ProductModel` (`id` INTEGER, `title` TEXT, `images` TEXT, `price` TEXT, `description` TEXT, `category_id` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _userModelInsertionAdapter = InsertionAdapter(
            database,
            'UserModel',
            (UserModel item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'phone_number': item.phoneNumber,
                  'address': item.address,
                  'role': item.role
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _userModelMapper = (Map<String, dynamic> row) => UserModel(
      row['id'] as int,
      row['name'] as String,
      row['email'] as String,
      row['phone_number'] as String,
      row['address'] as String,
      row['role'] as String);

  final InsertionAdapter<UserModel> _userModelInsertionAdapter;

  @override
  Stream<UserModel> getUserDetail(int id) {
    return _queryAdapter.queryStream('SELECT * FROM UserModel WHERE id = ?',
        arguments: <dynamic>[id],
        queryableName: 'UserModel',
        isView: false,
        mapper: _userModelMapper);
  }

  @override
  Future<void> addUserData(UserModel userModel) async {
    await _userModelInsertionAdapter.insert(
        userModel, OnConflictStrategy.replace);
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _productModelInsertionAdapter = InsertionAdapter(
            database,
            'ProductModel',
            (ProductModel item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'images': item.images,
                  'price': item.price,
                  'description': item.description,
                  'category_id': item.categoryId
                },
            changeListener),
        _productModelUpdateAdapter = UpdateAdapter(
            database,
            'ProductModel',
            ['id'],
            (ProductModel item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'images': item.images,
                  'price': item.price,
                  'description': item.description,
                  'category_id': item.categoryId
                },
            changeListener),
        _productModelDeletionAdapter = DeletionAdapter(
            database,
            'ProductModel',
            ['id'],
            (ProductModel item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'images': item.images,
                  'price': item.price,
                  'description': item.description,
                  'category_id': item.categoryId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _productModelMapper = (Map<String, dynamic> row) => ProductModel(
      row['id'] as int,
      row['title'] as String,
      row['images'] as String,
      row['price'] as String,
      row['description'] as String,
      row['category_id'] as int);

  final InsertionAdapter<ProductModel> _productModelInsertionAdapter;

  final UpdateAdapter<ProductModel> _productModelUpdateAdapter;

  final DeletionAdapter<ProductModel> _productModelDeletionAdapter;

  @override
  Stream<List<ProductModel>> getProducts() {
    return _queryAdapter.queryListStream('SELECT * FROM ProductModel LIMIT 30',
        queryableName: 'ProductModel',
        isView: false,
        mapper: _productModelMapper);
  }

  @override
  Stream<List<ProductModel>> getProductsByCategory(int categoryId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM ProductModel WHERE category_id =? LIMIT 30',
        arguments: <dynamic>[categoryId],
        queryableName: 'ProductModel',
        isView: false,
        mapper: _productModelMapper);
  }

  @override
  Future<void> addProduct(ProductModel product) async {
    await _productModelInsertionAdapter.insert(
        product, OnConflictStrategy.replace);
  }

  @override
  Future<void> addProducts(List<ProductModel> product) async {
    await _productModelInsertionAdapter.insertList(
        product, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    await _productModelUpdateAdapter.update(product, OnConflictStrategy.abort);
  }

  @override
  Future<void> removeProduct(ProductModel product) async {
    await _productModelDeletionAdapter.delete(product);
  }
}
