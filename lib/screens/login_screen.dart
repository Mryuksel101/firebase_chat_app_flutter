import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/components/rounded_button.dart';
import 'package:firebase_chat_app/constants.dart';
import 'package:firebase_chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";

  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String eMail = "";
  String password = "";
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Expanded(
                child: Hero(
                  tag: "logo",
                  child: Image(
                    image: AssetImage('images/logo.png')
                  )
                ),
              ),
              const SizedBox(
                height: 28.0,
              ),
              TextField(
                style: const TextStyle(
                  color: Colors.black
                ),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  eMail = value;
                  //Do something with the user input.
                },
                decoration: kInputDecoration.copyWith(
                  hintText: "Enter your e mail",
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                style: const TextStyle(
                  color: Colors.black
                ),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: kInputDecoration.copyWith(
                  hintText: "Enter your password"
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                Colors.lightBlueAccent,
                () async {
                  try{
                    await _auth.signInWithEmailAndPassword(
                      email: eMail,
                      password: password
                    ).then(
                      (value) => Navigator.pushNamed(
                         context,
                         ChatScreen.id,
                        ),
                    );
                  }

                  catch(e){
                    log(e.toString());
                  }
                  //Implement login functionality.
                  
                },
                const Text(
                  'Log In',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
