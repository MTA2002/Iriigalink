import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:irrigalink/app.dart';
import 'package:irrigalink/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
