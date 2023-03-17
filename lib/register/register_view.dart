import 'dart:developer';

import 'package:firebase_chat_app/register/register_bloc.dart';
import 'package:firebase_chat_app/register/register_event.dart';
import 'package:firebase_chat_app/register/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatefulWidget {
  
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();

}

class _RegisterViewState extends State<RegisterView> {
    final TextEditingController ctrAd = TextEditingController();
    final TextEditingController ctrSoyAd = TextEditingController();
    final TextEditingController ctrsifre = TextEditingController();
    final TextEditingController ctrMail = TextEditingController();
    final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final bloc = context.read<RegisterBloc>();
    
    
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          autovalidateMode: AutovalidateMode.disabled,
          key: _formKey,
          
        child: Column(
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
          
                BlocBuilder<RegisterBloc, RegisterState>(

                  builder: (context, state) {
                    
                    log("bloc builder calişti");
                      return TextFormField(
                      
                      controller: ctrMail,
                      decoration: const InputDecoration(
                        hintText: "mail adresinizi girin",
                  
                      ),

                      onChanged: (value) {
                        bloc.add(RegisterEmailChanged(email: value.toString()));
                      },
                      
                      validator: (value) {
                        if(value!.isNotEmpty){
                          log("validator ın içindeyim");
                          // event tanımla
                          // eventten bloca gitsin
                          // buradan dinle
                          
                          if(state.emailHataMesaji!.isEmpty){
                            log("ifdeyiz");
                            return null;
                          }
                  
                          else{
                            log("elsedeyiz");
                            return state.emailHataMesaji;
                          }
                        }
                      },
                    );
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  TextButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                      log("doğrulandi");
                        bloc.add(
                          KayitOlEvent(
                            ad: ctrAd.text,
                            soyAd: ctrSoyAd.text,
                            email: ctrMail.text,
                            sifre: ctrsifre.text,
                            buildContext: context,
                          )
                        );  
                      }
                      
                    },
                    child: Text("giriş yap"),
                  ),

                  TextButton(
                    onPressed: () {
                      bloc.add(EventKayitOlGoogle(context));
                    },
                    child: Text("google ile kayıt ol")
                  ),

                  TextButton(
                    onPressed: () {
                      bloc.add(EventCikisyap(context));
                    },
                    child: Text("cikiş yap")
                  ),
                ],
              ),

             
          
            ],
          )
         
          
        ),
      ),
    );
  }
}