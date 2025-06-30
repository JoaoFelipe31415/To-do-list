import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';
import 'package:to_do/data/repository/theme_repository.dart';
import 'package:to_do/data/repository/todo_repository.dart';
import 'package:to_do/domain/dtos/todo_dto.dart';
import 'package:to_do/domain/models/todo_model.dart';

class HomeViewmodel extends ChangeNotifier {
  final TodoRepository _repository;
  final ThemeRepository _themeRepository;

  bool get theme => _themeRepository.theme;

  late List<TodoModel> _todos;
  HomeViewmodel(this._repository, this._themeRepository);
  List<TodoModel> get completos =>
      _todos.where((element) => element.completed).toList();
  List<TodoModel> get notCompletos =>
      _todos.where((element) => !element.completed).toList();

  late final loadCommand = Command0(getAll);

  AsyncResult<Unit> getAll() async {
    await Future.delayed(Duration(seconds: 2));
    _todos = _repository.getTodos().getOrThrow();
    return Success.unit();
  }

  Result<Unit> create(String title) {
    final dto = TodoDto(title: title);
    _repository.create(dto);
    _todos = _repository.getTodos().getOrThrow();
    notifyListeners();
    return Success.unit();
  }

  Result<Unit> update(int id, String title, bool completed) {
    final dto = TodoDto(title: title, completed: completed);
    _repository.update(id, dto);
    _todos = _repository.getTodos().getOrThrow();
    notifyListeners();
    return Success.unit();
  }

  Result<Unit> delete(int id) {
    _repository.delete(id);
    _todos = _repository.getTodos().getOrThrow();
    notifyListeners();
    return Success.unit();
  }

  void changeTheme() {
    _themeRepository.saveTheme(!theme);
  }
}
