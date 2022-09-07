import 'package:dart_frog/dart_frog.dart';
import 'package:todo/todo.dart';

Response onRequest(RequestContext context) {
  return Response.json(
    body: Todo(
      'Test Todo',
      'This todo was made to check if serialization works.',
      false,
      id: 0,
    ),
  );
}
