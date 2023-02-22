import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/constants.dart';
import 'package:firebase_chat_app/screens/kullanicilar_screen.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {
  static String id = "chat_screen";

  const ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}






final _auth =  FirebaseAuth.instance;
late User? loggedInUser;
class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController _textController;
  
  final _firestore = FirebaseFirestore.instance;
  
  void getCurrentUser(){
   loggedInUser = _auth.currentUser;
   log(loggedInUser!.uid.toString());
   log(loggedInUser!.email.toString());
  }

 
  /*
  void getMessages()async{
    final mesajlar = await _firestore.collection("messages").get();
    for (var element in mesajlar.docs) {
      log(element.data().toString());
    }
  }

  */

  

  @override
  void initState() {
    _textController = TextEditingController();
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                Kullanicilar.id,
              );
            },
            icon: const Icon(
              Icons.supervised_user_circle_rounded,
            )
          ),
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
              }
            ),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder(
              stream: _firestore.collection("messages").orderBy("date",descending: false).snapshots(),
              
              builder: (context, snapshot) {
                
                if(snapshot.hasData){
                  return Expanded(
                    child: Mesajlar(snapshot.data!.docs.reversed.toList()),
                  );
                }

                else{
                  return Text("hata oldu");
                }

                
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      //Implement send functionality.
                      
                      
                       _firestore.collection("messages").add(
                        {
                          "sender": "${loggedInUser!.email}",
                          "text" : _textController.text,
                          "date" : DateTime.now(),
                        }
                      );

                      _textController.clear();
                      
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Mesajlar extends StatelessWidget {
  final List snapshot;
  const Mesajlar(this.snapshot, {super.key});

  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.all(10.0),
      itemCount:snapshot.length,
      itemBuilder: (context, index) {
        String gonderen = snapshot[index].data()["sender"];
        // şu anki mail ile firestoreden gelen stream responsnun "sender"deki mail eşleşirse benim mesajım demek oluyor
        bool kendiMesajimMi = loggedInUser!.email == gonderen;
        log(kendiMesajimMi.toString());
        log("list view $index");
        
        
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: kendiMesajimMi? CrossAxisAlignment.start :  CrossAxisAlignment.end,
            children: [
              Text(
                gonderen,
                style: const TextStyle(
                  color: Colors.white30
                ),
                ),
              Material(
                borderRadius: BorderRadius.only(
                  topRight: kendiMesajimMi? const Radius.circular(30) : const Radius.circular(0) ,
                  topLeft: kendiMesajimMi? const Radius.circular(0) :  const Radius.circular(30),
                  bottomRight:  const Radius.circular(30),
                  bottomLeft: const Radius.circular(30),
                ),
                elevation: 5,
                color: kendiMesajimMi? Colors.lightBlueAccent : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 9,
                  ),
                  child: Text(
                    snapshot[index].data()["text"],
                    style: TextStyle(
                      fontSize: 15,
                      color: kendiMesajimMi? Colors.white : Colors.black87
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
