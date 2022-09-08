import 'package:dart_frog/dart_frog.dart';
import 'package:drift/drift.dart';
import 'package:todo/todo.dart';

import '../../bin/database/database.dart';
import '../../bin/validators.dart';

Future<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return await get(context);
    case HttpMethod.post:
      return await post(context);
    default:
      return await notFound(context);
  }
  //get all todos
}

Future<SharedDatabase> getDB(RequestContext context) {
  return context.read<Future<SharedDatabase>>();
}

Future<Response> get(RequestContext context) async {
  final db = await getDB(context);
  var todos = await db.getAllTodos();
  return Response.json(
    body: todos,
  );
}

Future<Response> post(RequestContext context) async {
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
      return Response.json(body: todo);
    } else {
      return Response(statusCode: 500);
    }
  } else {
    return badRequest(context);
  }
}

Future<Response> badRequest(RequestContext context) async {
  return Response(statusCode: 400);
}

Future<Response> notFound(RequestContext context) async {
  return Response(statusCode: 404);
}
