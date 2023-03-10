import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_chat_app/register/register_event.dart';
import 'package:firebase_chat_app/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  RegisterBloc(): super(
    RegisterState(metin: "")
  ){
    on<RegisterEmailChanged>(_registerEmailChanged);
    
  }





  void _registerEmailChanged(RegisterEmailChanged registerEmailChanged, Emitter emit){
    log(registerEmailChanged.email);
  }

  
}