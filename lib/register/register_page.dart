import 'package:firebase_chat_app/register/register_bloc.dart';
import 'package:firebase_chat_app/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return RegisterBloc();
      },

      child: const RegisterView(),
    );
  }
}