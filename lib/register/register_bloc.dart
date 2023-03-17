import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/register/register_event.dart';
import 'package:firebase_chat_app/register/register_state.dart';
import 'package:firebase_core/firebase_core.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  RegisterBloc(): super(
    RegisterState(emailHataMesaji: "", sifreHataMesaji: ""),
  ){
    on<RegisterEmailChanged>(_registerEmailChanged);
    on<KayitOlEvent>(_kayitOlEvent);
  }





  void _registerEmailChanged(RegisterEmailChanged registerEmailChanged, Emitter emit){
    final RegExp emailRegExp = 
    RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',);
    
    log(registerEmailChanged.email);
    String hataMesaji = "";
    if(emailRegExp.hasMatch(registerEmailChanged.email.trim())){
      emit(
        state.copyWith(
          email: hataMesaji,
        ),
      );
    }

    else{
      

      log("invaild e mail: ${registerEmailChanged.email}");
      hataMesaji = "geçersiz e-mail";
      emit(
        state.copyWith(
          email: hataMesaji,
        ),
      );
    }
  }

  void _kayitOlEvent(KayitOlEvent kayitOlEvent, Emitter<RegisterState> emit){
    try{
      _firebase.createUserWithEmailAndPassword(
        email: kayitOlEvent.email,
        password: kayitOlEvent.sifre
      );
    }

    catch(e){
      log("_kayitOlEvent'de hata var ${e.toString()}");
    }
  }
}