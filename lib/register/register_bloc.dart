import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:firebase_chat_app/register/register_event.dart';
import 'package:firebase_chat_app/register/register_state.dart';

import 'package:google_sign_in/google_sign_in.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.standard();
  
  RegisterBloc(): super(
    RegisterState(emailHataMesaji: "", sifreHataMesaji: ""),
  ){
    on<RegisterEmailChanged>(_registerEmailChanged);
    on<KayitOlEvent>(_kayitOlEvent);
    on<KayitOlEvenGoogle>(_kayitOlEventGoogle);
    on<EventCikisyap>(_eventCikisYap);
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

  void _kayitOlEvent(KayitOlEvent kayitOlEvent, Emitter<RegisterState> emit)async{
    try{
      final UserCredential _userCredential = await _auth.createUserWithEmailAndPassword(
        email: kayitOlEvent.email,
        password: kayitOlEvent.sifre
      );

      _firestore.collection("user").doc(_userCredential.user!.uid).set(
        {
          "ad" : kayitOlEvent.ad,
          "soy_ad" : kayitOlEvent.soyAd,
          "email" : kayitOlEvent.email,
        }
      );



      
    }

    catch(e){
      log("_kayitOlEvent'de hata var ${e.toString()}");
    }
  }

  void _kayitOlEventGoogle(KayitOlEvenGoogle kayitOlEvenGoogle, Emitter<RegisterState> emit)async{
    try{
     
      final googleUser = await _googleSignIn.signIn();

      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      
      _firestore.collection("user").doc(googleUser.id).set(
        {
          "ad" : googleUser.displayName,

          "email" : googleUser.email,
        }
      );

      log(googleUser.email);
    }

    catch(e){
      log("hata $e");
    }
  }

  


  void _eventCikisYap(EventCikisyap eventCikisyap, Emitter emit){
    try{
      _auth.signOut();
      _googleSignIn.signOut();
    }

    catch(e){
      log("_eventCikisYap $e");
    }
  }



}