import 'package:flutter/material.dart';
import 'package:to_do/config/dependencies.dart';
import 'package:to_do/ui/home/home_page.dart';
import 'package:to_do/ui/main/main_viewmodel.dart';

void main() async {
  setup();
  final viewmodel = injector.get<MainViewmodel>();
  await viewmodel.loadThemeCommand.execute();
  runApp(
    ListenableBuilder(
      listenable: viewmodel,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: viewmodel.theme ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData.dark(),
          home: HomePage(),
        );
      },
    ),
  );
}
