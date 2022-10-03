import 'package:flutter/material.dart';
import 'app/app_page.dart';
import 'app/di/dependency.dart';

Future<void> main() async {
  await Injector.init();
  runApp(const AppPage());
}
