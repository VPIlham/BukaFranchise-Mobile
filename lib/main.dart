import 'package:bukafranchise/pages/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BukaFranchise',
      debugShowCheckedModeBanner: false,
      supportedLocales: [Locale('en'), Locale('id', 'ID')],
      initialRoute: '/',
      home: LoginPage(),
    );
  }
}
