import 'dart:developer';

import 'package:firebase_chat_app/register/register_bloc.dart';
import 'package:firebase_chat_app/register/register_event.dart';
import 'package:firebase_chat_app/register/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body:  Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              return Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      // event tanımla
                      // eventten bloca gitsin
                      // buradan dinle
                      context.read<RegisterBloc>().add(RegisterEmailChanged(email: value.toString()));
                      return "musttafa";
                    },
                    decoration: InputDecoration(
                      hintText: "adınızı girin"
                    ),
                  ),
            
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "soy adınızı girin",
                    ),
                  ),
            
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "imei girin",
                    ),
                  ),
            
                ],
              );
            },
            
          ),
          
        ),
      ),
    );
  }
}