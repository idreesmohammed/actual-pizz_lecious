import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddOnLandingPage extends StatefulWidget {
  const AddOnLandingPage({super.key});

  @override
  State<AddOnLandingPage> createState() => _AddOnLandingPageState();
}

class _AddOnLandingPageState extends State<AddOnLandingPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("add ons"),
      ),
    );
  }
}
