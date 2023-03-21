
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ana_sayfa/ana_sayfa_view.dart';


void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const Myapp(),
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
        
        home: const AnaSayfaView(),
    );
  }
}

