import 'package:dart_frog/dart_frog.dart';
import 'package:todo/todo.dart';
import 'HttpMethodHandler.dart';
import 'database/database.dart';

class TodoIDHandler extends RouteHandler<String, int> {
  TodoIDHandler(super.context, super.input);

  @override
  bool validate() {
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
    if (validate() && sanitized_input != null) {
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
}
