import 'package:auto_injector/auto_injector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/data/repository/theme_repository.dart';
import 'package:to_do/data/repository/todo_repository.dart';
import 'package:to_do/data/service/storage/localStorage/local_storage.dart';
import 'package:to_do/data/service/storage/theme_storage.dart';
import 'package:to_do/ui/home/home_viewmodel.dart';
import 'package:to_do/ui/app_widget/app_widget_viewmodel.dart';

final injector = AutoInjector();

Future<void> setup() async {
  injector.addInstance<SharedPreferencesAsync>(SharedPreferencesAsync());
  injector.add<ThemeStorage>(ThemeStorage.new);
  injector.addSingleton<ThemeRepository>(ThemeRepository.new);
  injector.addSingleton<LocalStorage>(LocalStorage.new);
  injector.addSingleton<TodoRepository>(TodoRepository.new);
  injector.add<HomeViewmodel>(HomeViewmodel.new);
  injector.add<AppWidgetViewmodel>(AppWidgetViewmodel.new);

  injector.commit();

  await injector.get<ThemeRepository>().loadTheme();
}
