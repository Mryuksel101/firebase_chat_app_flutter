import 'package:flutter/material.dart';

class UserToUserChat extends StatefulWidget {
  static String id = "user_to_user_chat";
  
  String user;
  UserToUserChat(this.user);

  @override
  State<UserToUserChat> createState() => _UserToUserChatState();
}

class _UserToUserChatState extends State<UserToUserChat> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user),
      ),
    );
  }
}