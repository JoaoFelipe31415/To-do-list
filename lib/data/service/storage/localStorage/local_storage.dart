import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferencesAsync _service;

  const LocalStorage(this._service);

  AsyncResult<T> read<T extends Object>(String key) async {
    try {
      Object? value;
      if (T == String) {
        value = await _service.getString(key);
      } else if (T == int) {
        value = await _service.getInt(key);
      } else if (T == double) {
        value = await _service.getDouble(key);
      } else if (T == bool) {
        value = await _service.getBool(key);
      } else {
        return Failure(
          Exception('Key "$key" not found or unsupported type: $T'),
        );
      }
      if (value != null) return Success(value as T);
      return Failure(
        Exception('Key "$key" not found or null value received for type: $T'),
      );
    } catch (e) {
      return Failure(Exception('An error occurred: $e'));
    }
  }

  AsyncResult<T> write<T extends Object>(String key, T data) async {
    try {
      if (T == String) {
        await _service.setString(key, data as String);
      } else if (T == int) {
        await _service.setInt(key, data as int);
      } else if (T == double) {
        await _service.setDouble(key, data as double);
      } else if (T == bool) {
        await _service.setBool(key, data as bool);
      } else {
        return Failure(Exception('Unsupported type: $T'));
      }
      return Success(data);
    } catch (e) {
      return Failure(Exception('An error occurred: $e'));
    }
  }
}
