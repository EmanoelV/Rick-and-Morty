import 'package:flutter/material.dart';
import 'routes/routes.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        initialRoute: '/characters',
        routes: routes,
      );
}
