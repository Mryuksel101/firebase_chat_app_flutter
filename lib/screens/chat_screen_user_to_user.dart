import 'dart:developer';

import 'package:flutter/material.dart';

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
  @override
  void initState() {
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
    );
  }
}