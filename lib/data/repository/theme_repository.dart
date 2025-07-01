import 'dart:async';
import 'package:result_dart/result_dart.dart';
import 'package:to_do/data/service/storage/theme_storage.dart';

class ThemeRepository {
  final ThemeStorage _themeStorage;
  Stream<bool> get themeStream => _streamController.stream;
  late bool _theme;
  final _streamController = StreamController<bool>.broadcast();

  bool get theme => _theme;

  ThemeRepository(this._themeStorage);

  AsyncResult<Unit> loadTheme() {
    return _themeStorage
        .getTheme()
        .flatMap(_toggleTheme)
        .onFailure((failure) => _theme = false);
  }

  AsyncResult<Unit> toggleTheme(bool theme) {
    return _themeStorage.saveTheme(theme).flatMap(_toggleTheme);
  }

  Result<Unit> _toggleTheme(bool success) {
    _theme = success;
    _streamController.add(theme);
    return Success.unit();
  }
}
