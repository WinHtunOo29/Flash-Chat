import 'package:flash_chat/components/input_textfield.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'logo',
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            InputTextField(
              isPassword: false,
              hintText: 'Enter your email',
              onChanged: (value) {

              },
            ),
            const SizedBox(
              height: 8.0,
            ),
            InputTextField(
              isPassword: true,
                hintText: 'Enter your password',
                onChanged: (value) {

                }
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              buttonColor: Colors.lightBlueAccent,
              title: 'Log In',
              onPressed: () {

              },
            )
          ],
        ),
      ),
    );
  }
}