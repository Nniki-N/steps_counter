import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:steps_counter/common/di/locator.dart';
import 'package:steps_counter/firebase_options.dart';
import 'package:steps_counter/presentation/app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupLocator();

  await Permission.activityRecognition.request();

  runApp(const MyApp());
}
