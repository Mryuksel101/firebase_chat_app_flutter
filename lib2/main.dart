import '../lib2/screens/chat_screen.dart';
import '../lib2/screens/chat_screen_user_to_user.dart';
import '../lib2/screens/kullanicilar_screen.dart';
import '../lib2/screens/login_screen.dart';
import '../lib2/screens/registration_screen.dart';
import '../lib2/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    
  );
  return runApp(const FlashChat()); 
} 

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
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
        Kullanicilar.id :(context) => const Kullanicilar(),
        
      },
  
    );
  }
}
