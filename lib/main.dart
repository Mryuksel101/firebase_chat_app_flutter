import 'package:firebase_chat_app/screens/chat_screen.dart';
import 'package:firebase_chat_app/screens/login_screen.dart';
import 'package:firebase_chat_app/screens/registration_screen.dart';
import 'package:firebase_chat_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';


void main() => runApp(const FlashChat()); 

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black
          ),

          

        ),
      ),

      initialRoute: WelcomeScreen.id,
      routes: {
        ChatScreen.id :(context) => const ChatScreen(),
        LoginScreen.id :(context) => const LoginScreen(),
        RegistrationScreen.id :(context) => const RegistrationScreen(),
        WelcomeScreen.id : (context) => const WelcomeScreen(),
      },
  
    );
  }
}
