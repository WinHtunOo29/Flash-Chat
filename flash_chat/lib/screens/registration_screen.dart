import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/components/input_textfield.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static const String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";

  void showAlertDialog() {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Input'),
          content: const Text('Please Fill Email & Password'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              } , 
              child: const Text('OK')
            )
          ],
        );
      }
    );
    
  }

  void _handleRegisterBtn() async {
    if (email != "" || password != "") {
      try {
        await _auth.createUserWithEmailAndPassword(email: email, password: password);
        Navigator.pushNamed(context, ChatScreen.id);
      } catch (e) {
        print(e);
      }
    } else {
      showAlertDialog();
    }
  }

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
                email = value;
              },
            ),
            const SizedBox(
              height: 8.0,
            ),
            InputTextField(
              isPassword: true,
              hintText: 'Enter your password',
              onChanged: (value) {
                password = value;
              },
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              buttonColor: Colors.lightBlueAccent,
              title: 'Register',
              onPressed: () {
                _handleRegisterBtn();
                // _auth.createUserWithEmailAndPassword(email: email, password: password);
              },
            )
          ],
        ),
      ),
    );
  }
}