import 'package:cst/pages/main/home.dart';
import 'package:cst/widges/drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CST());
}

class CST extends StatelessWidget {
  const CST({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid Status Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => const Scaffold(
        drawer: NavigationDrawerWidget(),
      );
}
