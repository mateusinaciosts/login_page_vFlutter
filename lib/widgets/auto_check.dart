import 'package:flutter/material.dart';
import 'package:login_firebase/services/auth_service.dart';
import 'package:provider/provider.dart';

import '../home_page.dart';
import '../login_page.dart';

class AutoCheck extends StatefulWidget {
  const AutoCheck({Key? key}) : super(key: key);

  @override
  State<AutoCheck> createState() => _AutoCheckState();
}

class _AutoCheckState extends State<AutoCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    if (auth.isLoandig) {
      return loading();
    } else if (auth.Usuario == null) {
      return Login();
    } else {
      return HomePage();
    }
  }
}

loading() {
  return const Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );
}
