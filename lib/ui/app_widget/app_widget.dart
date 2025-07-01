import 'package:flutter/material.dart';
import 'package:to_do/config/config.dart';
import 'package:to_do/ui/home/home_page.dart';
import 'package:to_do/ui/app_widget/app_widget_viewmodel.dart';

class AppWidget extends StatelessWidget {
  AppWidget({super.key});
  final _viewmodel = injector.get<AppWidgetViewmodel>();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewmodel,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: _viewmodel.theme ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData.dark(),
          home: HomePage(),
        );
      },
    );
  }
}
