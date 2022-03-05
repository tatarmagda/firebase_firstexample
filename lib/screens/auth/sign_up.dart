import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _signUp = false;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email"),
                  controller: _emailController,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      icon: Icon(_showPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                  controller: _passwordController,
                  obscureText: !_showPassword,
                ),
              ),
              Center(
                child: ElevatedButton(
                    child: Text(_signUp ? "Sign up" : "Log in"),
                    onPressed: _signUp ? () {} : () {}),
              ),
              Center(
                child: TextButton(
                  child: Text(!_signUp ? "Sign up" : "Log in"),
                  onPressed: () {
                    setState(() {
                      _signUp = !_signUp;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
