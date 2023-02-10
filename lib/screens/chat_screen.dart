import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/constants.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {
  static String id = "chat_screen";

  const ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}







class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController _textController;
  final _auth =  FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User? loggedInUser;
  void getCurrentUser(){
   loggedInUser = _auth.currentUser;
   log(loggedInUser!.uid.toString());
   log(loggedInUser!.email.toString());
  }

  void messagesStream() async{
     
   await for (var element in  _firestore.collection("messages").snapshots()) {
     for (var elementx in element.docs) {
      log("tetiklendi");
      log(elementx.data().toString());
    }
   }
  }

  void getMessages()async{
    final mesajlar = await _firestore.collection("messages").get();
    for (var element in mesajlar.docs) {
      log(element.data().toString());
    }
  }

  

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
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
                    onPressed: () async {
                      //Implement send functionality.
                    
                    
                      
                     /*  _firestore.collection("messages").add(
                        {
                          "sender": "${loggedInUser!.email}",
                          "text" : _textController.text
                        }
                      
                      */
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
