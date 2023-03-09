



import 'dart:developer';

import 'authentication_client.dart';
import 'firebase_authentication_client.dart';

class UserRepository{
  FirebaseAuthenticationClient _firebaseAuthenticationClient;
  UserRepository({required FirebaseAuthenticationClient authenticationClient}) : _firebaseAuthenticationClient = authenticationClient;
  Future<void> logInWithGoogle() async {
    try {
      await _firebaseAuthenticationClient.logInWithGoogle();
    } on LogInWithGoogleFailure {
      rethrow;
    } on LogInWithGoogleCanceled {
      rethrow;
    } catch (error, stackTrace) {
      //Error.throwWithStackTrace(LogInWithGoogleFailure(error), stackTrace);
    }
  }


  Future<void> logOut() async {
    try {
      await _firebaseAuthenticationClient.logOut();
   
    } catch (error, stackTrace) {
      //Error.throwWithStackTrace(LogInWithGoogleFailure(error), stackTrace);
      
      log("hata: logOut ");
    }
  }



}