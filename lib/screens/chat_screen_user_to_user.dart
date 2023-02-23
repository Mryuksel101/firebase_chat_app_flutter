import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// giriş yapan kullanıcının username'ini al 1)
// mesaj göndermek istedğin kullanıcnın username'ini al 2)
// chat id yi belirle ve onu değişkene at 3)
// chat room daha önce oluşturulmuş mu diye bak 4)
class UserToUserChat extends StatefulWidget {
  static String id = "user_to_user_chat";
  String docId;
  String friendName;
  String friendUid;
  UserToUserChat({super.key, required this.friendName, required this.friendUid, required this.docId});

  @override
  State<UserToUserChat> createState() => _UserToUserChatState();
}

class _UserToUserChatState extends State<UserToUserChat> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String chatId = "";
  // 1)
  String girisYapanUid(){ 
    User? user = _auth.currentUser;
    log("girisYapanUserName: ${user!.displayName.toString()}");
    log("girisYapanUserName: ${user.email.toString()}");
    return user.uid;
  }

  String chatIdOlustur(String aPerson, bPerson){
    if(aPerson.substring(0,1).codeUnitAt(0)>bPerson.substring(0,1).codeUnitAt(0)){
      return "$aPerson _ $bPerson";
    }

    else{
      return "$bPerson _ $aPerson";
    }
  }

  void chatRoomControl() async{
   DocumentSnapshot sayi = await _firestore.collection("chatrooms").doc(chatId).get();
   log("kanak benim chat idim bu: $chatId");
   log(sayi.exists.toString());
   
   if(sayi.exists){ // chat odası ilk defa oluşturuluyor
    log("chat odası zaten var. $sayi");
   
   }

   else{
     log("chat odası ilk defa oluşturuluyor... chat id: $chatId");
    _firestore.collection("chatrooms").doc(chatId).set(
      {
        "kullanici1:" : "deneme1",
        "kullanici2" : widget.friendName,
      }
    );
   }
  }
  
  @override
  void initState() {
    chatId = chatIdOlustur(girisYapanUid(), widget.friendUid);
    chatRoomControl();
    log(widget.friendUid.toString());
    log("doc UID ${widget.docId}");
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.friendName),
      ),
      body: Stack(
        children: [

          
          StreamBuilder(
            stream: _firestore.collection("chatrooms").doc(chatId).collection("chats").snapshots(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount:snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Text(
                    "aaa",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  );
                },
              );
            },
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: TextField(
              decoration: InputDecoration.collapsed(hintText: "yaz"),
            ),
          ),
        ],
        
      ),
    );
  }
}