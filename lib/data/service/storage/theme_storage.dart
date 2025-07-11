import 'package:result_dart/result_dart.dart';
import 'package:to_do/data/service/storage/localStorage/local_storage.dart';

class ThemeStorage {
  final LocalStorage _localStorage;

  const ThemeStorage(this._localStorage);

  AsyncResult<bool> getTheme() {
    return _localStorage.read<bool>('theme');
  }

  AsyncResult<bool> saveTheme(bool theme) {
    return _localStorage.write<bool>('theme', theme);
  }
}
