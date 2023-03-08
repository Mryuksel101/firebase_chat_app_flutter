import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GirisYap extends StatefulWidget {
  const GirisYap({Key? key}) : super(key: key);

  @override
  State<GirisYap> createState() => _GirisYapState();
}

class _GirisYapState extends State<GirisYap> {
   GoogleSignInAccount? googleSignInAccount;
   UserCredential? authResult;
    late GoogleSignIn _googleSignIn;
  void giris()async{
    try{
      
      _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );
      

      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn(); // Starts the interactive sign-in process.
      
      log("kanka: ${googleSignInAccount!.email}");
      // Authentication process is triggered only if there is no currently signed in user (that is when currentUser == null), otherwise this method returns a Future which resolves to the same user instance.
      
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

       authResult = await _auth.signInWithCredential(credential);                                                     

      
    }

    catch(e){
      log("hata $e");
    }
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("deneme"),
            TextButton(
              child: Text("giriş yap"),
              onPressed: () {
                
                giris();
              },
              
            ),


            TextButton(
              onPressed: () {
                log("isim ${googleSignInAccount!.email}");
              },
              child: Text("uid götüntüle"),
            ),


            TextButton(
              onPressed: () {
                log("isim ${authResult!.user!.email}");
              },
              child: Text("uid götüntüle"),
            ),


            TextButton(
              onPressed: () {
                //_googleSignIn.signOut();
                _auth.signOut();
              },
              child: Text("çıkış yap"),
            ),

            
          ],
        ),
      ),
    );
  }
}