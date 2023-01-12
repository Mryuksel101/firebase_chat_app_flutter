import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_chat_app/screens/login_screen.dart';
import 'package:firebase_chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "welcome_screen";

  const WelcomeScreen({super.key});
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    debugPrint("wecome screen widget buildi");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: SizedBox(
                    height: 60.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      "Flash Chat",
                      textStyle: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                      speed: const Duration(
                        milliseconds: 100
                      )
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              Colors.lightBlueAccent,
              (){
                Navigator.pushNamed(
                  context,
                  LoginScreen.id
                );
              },

              const Text("Log In")

            ),

            RoundedButton(
              Colors.blueAccent,
              () { 
                Navigator.pushNamed(
                  context,
                  RegistrationScreen.id
                );
              },
               const Text(
                'Register',
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  Color color;
  Text text;
  VoidCallback function;
  RoundedButton(this.color, this.function, this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: function,
          minWidth: 200.0,
          height: 42.0,
          child: text
        ),
      ),
    );
  }
}
