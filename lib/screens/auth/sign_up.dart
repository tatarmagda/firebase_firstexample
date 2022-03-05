import 'package:firebase_example/screens/auth/data/providers/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your e-mail";
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                        .hasMatch(_emailController.text)) {
                      return "Please enter a valid e-mail";
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    } else if (value.length < 8) {
                      return "Password need to be 8 characters long";
                    }
                    return null;
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                    child: Text(_signUp ? "Sign up" : "Log in"),
                    onPressed: _signUp
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              Provider.of<AuthState>(
                                context,
                                listen: false,
                              ).signOnWithEmail(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text);
                            }
                          }
                        : () {
                            if (_formKey.currentState!.validate()) {
                              Provider.of<AuthState>(
                                context,
                                listen: false,
                              ).signInWithEmail(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text);
                            }
                          }),
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
