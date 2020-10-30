import 'package:flutter/material.dart';
import 'package:flutter_sqlite/db_helper.dart';
import 'package:flutter_sqlite/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initilizaeDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'My Shopping list'),
    );
  }
}