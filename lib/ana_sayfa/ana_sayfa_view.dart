import 'package:firebase_chat_app/register/register_bloc.dart';
import 'package:firebase_chat_app/register/register_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnaSayfaView extends StatelessWidget {
  const AnaSayfaView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterBloc>();
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