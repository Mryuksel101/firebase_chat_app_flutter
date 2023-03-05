import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import '../../lib2/components/rounded_button.dart';
import '../../lib2/constants.dart';
import '../../lib2/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";

  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
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
                flex: 6,
                child: Hero(
                  tag: "logo",
                  child: Image(
                    image: AssetImage('images/logo.png')
                  )
                ),
              ),

              showSpinner? const CustomSpinner(): const SizedBox(),

              const Spacer(),
              
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
              
               

              RoundedButton(
                Colors.lightBlueAccent,
                () async {
                  try{
                    showSpinner = true;
                    setState(() {
                      
                    });
                    await _auth.signInWithEmailAndPassword(
                      email: eMail.trim(),
                      password: password.trim(),
                    ).then(
                      (value) => Navigator.pushNamed(
                         context,
                         ChatScreen.id,
                        ),
                    );
                  }

                  catch(e){
                    showSpinner = false;
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
