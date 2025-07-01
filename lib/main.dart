import 'package:flutter/material.dart';
import 'package:to_do/ui/app_widget/app_widget.dart';
import 'package:to_do/config/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(AppWidget());
}
