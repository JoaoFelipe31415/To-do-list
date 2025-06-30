import 'package:result_dart/result_dart.dart';
import 'package:to_do/domain/dtos/todo_dto.dart';
import 'package:to_do/domain/models/todo_model.dart';

class TodoRepository {
  final List<TodoModel> _todos = [];

  Result<List<TodoModel>> getTodos() {
    final copy = _todos.sublist(0);
    return copy.toSuccess();
  }

  Result<Unit> create(TodoDto dto) {
    final todo = TodoModel(
      id: _todos.length + 1,
      title: dto.title,
      completed: dto.completed,
    );
    _todos.add(todo);
    return Success.unit();
  }

  Result<TodoModel> getById(int id) {
    final index = _todos.indexWhere((element) => id == element.id);
    if (index == -1) {
      return Failure(Exception("Erro ao criar o TODO"));
    }
    final todo = _todos[index];
    return todo.toSuccess();
  }

  Result<Unit> update(int id, TodoDto dto) {
    final index = _todos.indexWhere((element) => id == element.id);
    if (index == -1) {
      return Failure(Exception("Erro ao atualizar o TODO"));
    }
    final todo = TodoModel(id: id, title: dto.title, completed: dto.completed);
    _todos.removeAt(index);
    _todos.add(todo);
    return Success.unit();
  }

  Result<Unit> delete(int id) {
    final index = _todos.indexWhere((element) => id == element.id);
    if (index == -1) {
      return Failure(Exception("Erro ao deletar o TODO"));
    }
    _todos.removeAt(index);
    return Success.unit();
  }
}
