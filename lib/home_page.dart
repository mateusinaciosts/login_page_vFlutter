import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:login_firebase/services/auth_service.dart';
import 'package:tag_ui/tag_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "HomePage",
              style: TextStyle(color: Colors.red),
            ),
            TagButton(
              onPressed: () async {
                await context.read<AuthService>().sair();
              },
              text: "SAIR",
            )
          ],
        ),
      ),
    );
  }
}
