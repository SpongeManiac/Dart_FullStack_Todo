import 'package:dart_frog/dart_frog.dart';
import 'package:todo/todo.dart';
import '../todo_converter.dart';
import '../validators.dart';
import 'RouteHandler.dart';
import '../database/database.dart';

class TodoIDHandler extends RouteHandler<String, int> {
  TodoIDHandler(super.context, super.input);

  Future<SharedDatabase> getDB() async {
    return await context.read<Future<SharedDatabase>>();
  }

  @override
  bool validate_input() {
    int? id = int.tryParse(input);
    if (id != null && id > 0) {
      sanitized_input = id;
      return true;
    }
    sanitized_input = null;
    return false;
  }

  @override
  Future<Response> getAsync() async {
    if (validate_input() && sanitized_input != null) {
      //get todo by id
      SharedDatabase db = await context.read<Future<SharedDatabase>>();
      TodoData? data = await db.getTodo(sanitized_input!);
      if (data != null) {
        Todo todo = Todo(
          data.title,
          data.description,
          data.completed,
          id: data.id,
        );
        return Response.json(body: todo);
      } else {
        return notFound();
      }
    } else {
      return badRequest();
    }
  }

  @override
  Future<Response> postAsync() async {
    if (validate_input() && sanitized_input != null) {
      SharedDatabase db = await getDB();
      TodoData? data = await db.getTodo(sanitized_input!);
      if (data != null) {
        TodosCompanion currentTodo = TodoConverter.companionFromTodoData(data);
        Todo? todo = TodoValidator.validate(await context.request.body());
        if (todo != null) {
          //make sure we are updating the todo specified in the url
          todo.id = currentTodo.id.value;
          TodosCompanion newTodo = TodoConverter.companionFromTodo(todo);
          await db.setTodo(newTodo);
          return Response.json(body: todo);
        } else {
          return badRequest();
        }
      } else {
        return notFound();
      }
    } else {
      return badRequest();
    }
  }

  @override
  Future<Response> putAsync() async {
    var resp = await postAsync();
    if (resp.statusCode == 201) {
      return Response.json(
        statusCode: 200,
        body: resp.body(),
      );
    } else {
      return resp;
    }
  }

  @override
  Future<Response> deleteAsync() async {
    if (validate_input() && sanitized_input != null) {
      SharedDatabase db = await getDB();
      TodoData? data = await db.getTodo(sanitized_input!);
      if (data != null) {
        await db.delTodo(data);
        return Response(statusCode: 200);
      } else {
        return notFound();
      }
    } else {
      return badRequest();
    }
  }

  @override
  Future<Response> optionsAsync() async {
    return Response(
      statusCode: 200,
      headers: {
        'Allow': '*',
        'Access-Control-Allow-Methods': '*',
      },
    );
  }
}
