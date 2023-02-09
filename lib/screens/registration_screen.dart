import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/components/rounded_button.dart';
import 'package:firebase_chat_app/constants.dart';
import 'package:firebase_chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";

  const RegistrationScreen({super.key});
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String eMail = "";
  String password = "";
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
              const Expanded(
                flex: 6,
                child: Hero(
                  tag: "logo",
                  child: Image(
                    image: AssetImage('images/logo.png'),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 133
                ),
                
                height: 80,
                width: 20,
                child: const CircularProgressIndicator(
                  color: Color(0xffFBC303),
                )
              ),

              const Spacer(),
              TextField(
                style: const TextStyle(
                  color: Colors.black
                ),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  eMail = value.trim();
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
                  password = value.trim();
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
                () async {

                  try{
             
                      final user = await _auth.createUserWithEmailAndPassword(
                      email: eMail,
                      password: password
                    ).then(
                      (value) => Navigator.pushNamed(
                        context,
                        ChatScreen.id,
                      )
                    );
                    
                  }
                  catch(e){
                    log(e.toString());
                  }
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
