import 'package:flutter/material.dart';
import 'package:notes_app/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quickly Notes App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: RouteManager.splashScreen,
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}
