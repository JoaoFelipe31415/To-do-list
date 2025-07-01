import 'dart:async';
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
  late final StreamSubscription _sub;

  late List<TodoModel> _todos;
  List<TodoModel> get completos =>
      _todos.where((element) => element.completed).toList();
  List<TodoModel> get notCompletos =>
      _todos.where((element) => !element.completed).toList();

  HomeViewmodel(this._repository, this._themeRepository) {
    _sub = _repository.todoRepositoryStream.listen((event) {
      _todos = event;
      notifyListeners();
    });
  }

  late final loadCommand = Command0(getAll);

  AsyncResult<Unit> getAll() async {
    await Future.delayed(Duration(seconds: 2));
    _repository
        .getTodos()
        .onSuccess(_loadTodos)
        .onFailure((failure) => getAll());
    return Success.unit();
  }

  Result<Unit> create(String title) {
    final dto = TodoDto(title: title);
    _repository.create(dto);
    return Success.unit();
  }

  Result<Unit> update(int id, String title, bool completed) {
    final dto = TodoDto(title: title, completed: completed);
    _repository.update(id, dto);
    return Success.unit();
  }

  Result<Unit> delete(int id) {
    _repository.delete(id);
    return Success.unit();
  }

  void changeTheme() {
    _themeRepository.toggleTheme(!theme);
  }

  void _loadTodos(List<TodoModel> todos) {
    _todos = todos;
    notifyListeners();
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
