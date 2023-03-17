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
    final TextEditingController ctrAd = TextEditingController();
    final TextEditingController ctrSoyAd = TextEditingController();
    final TextEditingController ctrsifre = TextEditingController();
    final TextEditingController ctrMail = TextEditingController();
    final bloc = context.read<RegisterBloc>();
    
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: BlocBuilder<RegisterBloc, RegisterState>(
            
            builder: (context, state) {
              log("bloc builder calişti");
              return Column(
                children: [
                  TextFormField(
                    controller: ctrAd,
                    validator: (value) {

                    },
                    decoration: const InputDecoration(
                      hintText: "adınızı girin"
                    ),
                  ),
            
                  TextFormField(
                    controller: ctrSoyAd,
                    validator: (value) {

                    },    
                    decoration: const InputDecoration(
                      hintText: "soy adınızı girin",
                    ),
                  ),
            
                  TextFormField(
                    controller: ctrMail,
                    decoration: const InputDecoration(
                      hintText: "mail adresinizi girin",

                    ),
                    
                    validator: (value) {
                     if(value!.isNotEmpty){
                       log(value.toString());
                      // event tanımla
                      // eventten bloca gitsin
                      // buradan dinle
                      bloc.add(RegisterEmailChanged(email: value.toString()));
                      if(state.emailHataMesaji!.isEmpty){
                        return null;
                      }

                      else{
                        return state.emailHataMesaji;
                      }
                     }
                    },
                  ),

                  TextFormField(
                    controller: ctrsifre,
                    decoration: const InputDecoration(
                      hintText: "şifrenizi girin",

                    ),

                    validator: (value) {
                  
                    },
                  ),

                  TextButton(
                    onPressed: () {
                      bloc.add(
                        KayitOlEvent(
                          ad: ctrAd.text,
                          soyAd: ctrSoyAd.text,
                          email: ctrMail.text,
                          sifre: ctrsifre.text
                        )
                      );
                    },
                    child: Text("giriş yap"),
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