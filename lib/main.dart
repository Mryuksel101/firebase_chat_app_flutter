import 'package:firebase_chat_app/login/login_bloc.dart';
import 'package:firebase_chat_app/login/login_page.dart';
import 'package:firebase_chat_app/login/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ana_sayfa/ana_sayfa_view.dart';


void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    BlocProvider(
      create: (context) =>LoginBloc(),
      child: const Myapp(),
    )
  );
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      
    return MaterialApp(
      
        theme: ThemeData(
            useMaterial3: true,
        ),
        /// eğer currentUser varsa kullanıcı daha önceden giriş yapmış demktir. Ana sayfayı yönlendiririz.
        home: context.read<LoginBloc>().auth.currentUser == null? const RegisterView() : const AnaSayfaView(),
    );
  }
}

