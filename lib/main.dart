import 'package:flutter/material.dart';
import 'app/app_page.dart';
import 'app/di/dependency.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.init();
  runApp(const AppPage());
}
