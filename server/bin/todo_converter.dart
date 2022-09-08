import 'package:drift/drift.dart';
import 'database/database.dart';
import 'package:todo/todo.dart';

abstract class TodoConverter {
  TodoConverter();

  static TodosCompanion companionFromTodo(Todo todo) {
    return TodosCompanion(
      title: Value(todo.title),
      description: Value(todo.description),
      completed: Value(todo.completed),
      id: Value(todo.id),
    );
  }

  static TodosCompanion companionFromTodoData(TodoData todo) {
    return TodosCompanion(
      title: Value(todo.title),
      description: Value(todo.description),
      completed: Value(todo.completed),
      id: Value(todo.id),
    );
  }

  static Todo todoFromTodoData(TodoData todo) {
    return Todo(
      todo.title,
      todo.description,
      todo.completed,
      id: todo.id,
    );
  }

  static Todo todoFromTodoDataUpdated(TodoData todo, int id) {
    return Todo(
      todo.title,
      todo.description,
      todo.completed,
      id: id,
    );
  }

  static Todo todoFromCompanionUpdate(TodosCompanion todo, int id) {
    return Todo(
      todo.title.value,
      todo.description.value,
      todo.completed.value,
      id: id,
    );
  }
}
