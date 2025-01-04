import 'package:flutter/material.dart';

class DessertLandingPage extends StatefulWidget {
  const DessertLandingPage({super.key});

  @override
  State<DessertLandingPage> createState() => _DessertLandingPageState();
}

class _DessertLandingPageState extends State<DessertLandingPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Dessert"),
      ),
    );
  }
}
