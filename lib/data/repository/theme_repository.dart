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

  AsyncResult<Unit> loadTheme() async {
    return await _themeStorage
        .isDark()
        .flatMap((success) {
          _theme = success;
          _streamController.add(_theme);
          return Success.unit();
        })
        .onFailure((failure) {
          _theme = false;
          _streamController.add(_theme);
        });
  }

  AsyncResult<Unit> saveTheme(bool theme) {
    return _themeStorage.saveTheme(theme).flatMap((success) {
      _theme = theme;
      _streamController.add(theme);
      return Success.unit();
    });
  }
}
