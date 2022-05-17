import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'login_page.dart';
import 'widgets/auto_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      builder: (context, _) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TAG',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AutoCheck(),
    );
  }
}
