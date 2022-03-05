import 'package:firebase_example/screens/auth/data/providers/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(
          child: Text("log out"),
          onPressed: () {
            Provider.of<AuthState>(context, listen: false).signOutWithEmail();
          },
        ),
      ),
    );
  }
}
