import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/components/rounded_button.dart';
import 'package:firebase_chat_app/constants.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";

  const RegistrationScreen({super.key});
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: const Hero(
                  tag: "logo",
                  child: SizedBox(
                    height: 200.0,
                    child: Image(
                      image: AssetImage('images/logo.png'),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                style: const TextStyle(
                  color: Colors.black
                ),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kInputDecoration.copyWith(
                  hintText: "Enter your e-mail"
                )
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black
                ),
                obscureText: true,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kInputDecoration.copyWith(
                  hintText: "Enter your password",
                )
              ),
              const SizedBox(
                height: 24.0,
              ),
    
              RoundedButton(
                Colors.blueAccent,
                () {
                  //Implement registration functionality.
                  
                },
    
                const Text("Register"),
             
              ),
            ],
          ),
        ),
      ),
    );
  }
}
