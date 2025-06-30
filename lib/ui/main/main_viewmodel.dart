import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';
import 'package:to_do/data/repository/theme_repository.dart';

class MainViewmodel extends ChangeNotifier {
  final ThemeRepository _themeRepository;
  bool get theme => _themeRepository.theme;
  late final StreamSubscription _sub;
  late final loadThemeCommand = Command0(loadTheme);

  MainViewmodel(this._themeRepository) {
    _sub = _themeRepository.themeStream.listen((event) {
      notifyListeners();
    });
  }

  AsyncResult<Unit> loadTheme() async {
    return await _themeRepository.loadTheme();
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
