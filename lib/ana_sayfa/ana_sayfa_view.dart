
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_islemleri/bloc/login_bloc.dart';

class AnaSayfaView extends StatelessWidget {
  const AnaSayfaView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("deneme"),
      ),

      body: Center(
        child: TextButton(
          onPressed: () {
            bloc.add(EventCikisyap(context));
          },
          child: Text("Cıkış yap")
        ),
      ),
    );
  }
}