import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pizz_lecious/feat/actual_pizzlecious.dart';
import 'package:pizz_lecious/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Pizzelicious());
}
