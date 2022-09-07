import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'database.g.dart';

// Data
@DataClassName('TodoData')
class Todos extends Table {
  // PrimaryKey
  IntColumn get id => integer().autoIncrement()();
  //todo title
  TextColumn get title => text().withLength(min: 0, max: 128)();
  //todo description
  TextColumn get description => text().withLength(min: 0, max: 1028)();
  //completion
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(
  tables: [
    Todos,
  ],
)
class SharedDatabase extends _$SharedDatabase {
  // we tell the database where to store the data with this constructor
  SharedDatabase(QueryExecutor e) : super(e);

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  Future<List<TodoData>> getAllTodos() async {
    print('Getting all todos...');
    return await (select(todos)
          ..orderBy([(t) => OrderingTerm(expression: t.id)]))
        .get();
  }

  Future<TodoData?> getTodo(int id) async {
    return await (select(todos)
          ..where((tbl) => tbl.id.equals(id))
          ..limit(1))
        .getSingleOrNull();
  }

  Future<int> setTodo(TodosCompanion companion) async {
    final newId = await into(todos).insertOnConflictUpdate(companion);
    print('new id: $newId');
    //PlaylistsCompanion.insert(name: )
    return newId;
  }

  Future<bool> updateTodo(TodoData todo) async {
    return update(todos).replace(todo);
  }

  Future<int> delTodo(TodoData todo) async {
    print('deleting ${todo.title}, index ${todo.id}');
    return (delete(todos)..where((t) => t.id.equals(todo.id))).go();
  }
}
