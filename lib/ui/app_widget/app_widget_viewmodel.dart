import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:to_do/data/repository/theme_repository.dart';

class AppWidgetViewmodel extends ChangeNotifier {
  final ThemeRepository _themeRepository;
  bool get theme => _themeRepository.theme;
  late final StreamSubscription _sub;

  AppWidgetViewmodel(this._themeRepository) {
    _sub = _themeRepository.themeStream.listen((event) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
