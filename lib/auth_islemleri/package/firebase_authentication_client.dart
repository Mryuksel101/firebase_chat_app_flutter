
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_chat_app/auth_islemleri/package/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authentication__user.dart';
import 'authentication_client.dart';




/// {@template firebase_authentication_client}
/// A Firebase implementation of the [AuthenticationClient] interface.
/// {@endtemplate}
class FirebaseAuthenticationClient{
  
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  final InMemoryTokenStorage _tokenStorage;

  FirebaseAuthenticationClient({
      required InMemoryTokenStorage tokenStorage,
      firebase_auth.FirebaseAuth? firebaseAuth,
      GoogleSignIn? googleSignIn,

    }
  ): _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
  _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
  _tokenStorage = tokenStorage{
    user.listen(_onUserChanged);
  }

  /// Stream of [AuthenticationUser] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [AuthenticationUser.anonymous] if the user is not authenticated.
  @override
  Stream<AuthenticationUser> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null
          ? AuthenticationUser.anonymous
          : firebaseUser.toUser;
    });
  }


  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleCanceled] if the flow is canceled by the user.
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  @override
  Future<void> logInWithGoogle() async {
    try {
      log("logInWithGoogle fonksiyonu başladı");
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw const LogInWithGoogleCanceled(
          //Exception('Sign in with Google canceled'),
        );
      }
      final googleAuth = await googleUser.authentication;

      log(googleUser.email);
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on LogInWithGoogleCanceled {
      rethrow;
    } catch(e){
      log("logInWithGoogle hatasi: $e");

    }
  }


  /// Signs out the current user which will emit
  /// [AuthenticationUser.anonymous] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  @override
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      log(e.toString());
     // Error.throwWithStackTrace(LogOutFailure(error), stackTrace);
    }
  }

   /// Updates the user token in [TokenStorage] if the user is authenticated.
  Future<void> _onUserChanged(AuthenticationUser user) async {
    if (!user.isAnonymous) {
      await _tokenStorage.saveToken(user.id);
    } else {
      await _tokenStorage.clearToken();
    }
  }


    
}

extension on firebase_auth.User {
  AuthenticationUser get toUser {
    return AuthenticationUser(
      id: uid,
      email: email,
      name: displayName,
      photo: photoURL,
      isNewUser: metadata.creationTime == metadata.lastSignInTime,
    );
  }
}