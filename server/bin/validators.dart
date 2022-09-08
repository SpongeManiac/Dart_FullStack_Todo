import 'dart:convert';
import 'package:todo/todo.dart';

class TodoValidator {
  TodoValidator();

  static Todo? validate(String jsonTxt) {
    try {
      Todo todo = Todo.fromJson(json.decode(jsonTxt) as Map<String, dynamic>);
      //print('todo: ${todo.title}');
      return todo;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
