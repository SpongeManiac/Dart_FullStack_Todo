import 'package:dart_frog/dart_frog.dart';
import 'package:drift/drift.dart';
import 'package:todo/todo.dart';

import '../database/database.dart';
import '../validators.dart';
import 'RouteHandler.dart';

class TodoHandler extends RouteHandler<String, int> {
  TodoHandler(super.context, super.input);

  Future<SharedDatabase> getDB(RequestContext context) {
    return context.read<Future<SharedDatabase>>();
  }

  @override
  bool validate_input() {
    return true;
  }

  @override
  Future<Response> getAsync() async {
    final db = await getDB(context);
    var todos = await db.getAllTodos();
    return Response.json(
      statusCode: 200,
      body: todos,
    );
  }

  @override
  Future<Response> postAsync() async {
    final db = await getDB(context);
    final body = await context.request.body();
    print('Req Body:');
    print(body);
    Todo? todo = TodoValidator.validate(body);
    if (todo != null) {
      print('todo valid.');
      todo.id = await db.setTodo(
        TodosCompanion(
          title: Value(todo.title),
          description: Value(todo.description),
          completed: Value(todo.completed),
        ),
      );
      if (todo.id > -1) {
        return Response.json(
          statusCode: 201,
          body: todo,
        );
      } else {
        return badRequest();
      }
    } else {
      return badRequest();
    }
  }
}
