// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/ana_sayfa/ana_sayfa_view.dart';


import 'package:firebase_chat_app/register/register_event.dart';
import 'package:firebase_chat_app/register/register_state.dart';
import 'package:firebase_chat_app/register/register_view.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

import '../widget/sayfa_gecisi.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.standard();
  
  RegisterBloc(): super(
    RegisterState(emailHataMesaji: "", sifreHataMesaji: ""),
  ){
    on<RegisterEmailChanged>(_registerEmailChanged);
    on<KayitOlEvent>(_kayitOlEvent);
    on<EventKayitOlGoogle>(_kayitOlEventGoogle);
    on<EventCikisyap>(_eventCikisYap);
  }

  
  
  void uyariMesaji(BuildContext context, String hataMesaji){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(

        elevation: 24,
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 60
        ),
        alignment:Alignment.center,
        title: const Text('Kayıt olma başarısız'),
        content: Text(hataMesaji),
        actions: <Widget>[

          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
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

  /// bu fonksiyon e-mail ve şifre yazılarak menuel olarak yeni kayıt oluşturmaktan sorumludur
  /// kullanıcı başarılı bir şekilde kayıt olduktan sonra ana sayfaya routing (yönlendirme) işlemi yapar   
  void _kayitOlEvent(KayitOlEvent kayitOlEvent, Emitter<RegisterState> emit)async{
    try{
      final UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: kayitOlEvent.email.trim(),
        password: kayitOlEvent.sifre.trim()
      );

      _firestore.collection("user").doc(userCredential.user!.uid).set(
        {
          "ad" : "${kayitOlEvent.ad} ${kayitOlEvent.soyAd}",
          "email" : kayitOlEvent.email,
        }
      );

      // Navigator.pushReplacement yöntemi, bir sayfayı geçerli sayfanın yerine kapatmak için kullanılır.
      // Bu, örneğin bir giriş sayfasından ana sayfaya geçiş yapmak için kullanışlıdır.
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        kayitOlEvent.buildContext,
        MaterialPageRoute(
          builder: (context) => const AnaSayfaView(),
        ),
      );

    }

    catch(e){
      if(e.toString()=="[firebase_auth/email-already-in-use] The email address is already in use by another account."){
        uyariMesaji(kayitOlEvent.buildContext, "The email address is already in use by another account.");
      }
      log("_kayitOlEvent'de hata var ${e.toString()}");
    }
  }


  /// bu fonksiyon google ile giriş ile otomatik olarak yeni kayıt oluşturmaktan sorumludur
  /// kullanıcı başarılı bir şekilde kayıt olduktan sonra ana sayfaya routing (yönlendirme) işlemi yapar   
  void _kayitOlEventGoogle(EventKayitOlGoogle eventKayitOlGoogle, Emitter<RegisterState> emit)async{
    try{
     
      final googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await auth.signInWithCredential(credential);
      
      _firestore.collection("user").doc(googleUser.id).set(
        {
          "ad" : googleUser.displayName,

          "email" : googleUser.email,
        }
      );

      Navigator.pushReplacement(
        eventKayitOlGoogle.buildContext,
        createRoute(sayfa: const AnaSayfaView())
      );

      log(googleUser.email);
    }

    catch(e){

      log("hata $e");
    }
  }

  

  /// bu fonksiyon hesaplardan çıkış yapar ve giriş sayfasına routing (yönlendirme) işlemi yapar.
  void _eventCikisYap(EventCikisyap eventCikisyap, Emitter emit){
    log("${auth.currentUser!.email} çıkış yapılan email");
    try{
      auth.signOut();
      _googleSignIn.signOut();

      Navigator.pushAndRemoveUntil(
        eventCikisyap.buildContext,
        geri(sayfa: const RegisterView()),
        (route) => false,
      );
    }

    catch(e){
      log("_eventCikisYap $e");
    }
  }



}