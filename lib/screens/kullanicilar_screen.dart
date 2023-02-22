import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chat_screen_user_to_user.dart';

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
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(10),
                child: Material(

                  borderRadius: BorderRadius.circular(30),
                  color: Colors.amber,
                  child: InkWell(
                    
                    focusColor: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      log(snapshot.data!.docs[index].data()["kullaniciAdi"]);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return UserToUserChat(snapshot.data!.docs[index].data()["kullaniciAdi"]);
                          },
                        )
                      );
                    },
                    child: Text(snapshot.data!.docs[index].data()["kullaniciAdi"])
                  ),
                )
              ),
            );
          }
          else{
            return const Text("deneme");
          }


        },
      ),
    );
  }
}