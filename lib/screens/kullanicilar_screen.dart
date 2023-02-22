import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Kullanicilar extends StatefulWidget {
  static String id = "kullanicilar_screen";
  const Kullanicilar({Key? key}) : super(key: key);

  @override
  State<Kullanicilar> createState() => _KullanicilarState();
}

class _KullanicilarState extends State<Kullanicilar> {
  final _firebase = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcılar"),
      ),

      body: StreamBuilder(
        stream: _firebase.collection("users").snapshots(),
        builder: (context, snapshot) {
          
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) => Text(snapshot.data!.docs[index].data()["kullaniciAdi"]),
            );
          }
          else{
            return Text("deneme");
          }


        },
      ),
    );
  }
}