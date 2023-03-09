import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class View extends StatelessWidget {
  const View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          SizedBox(
            height: 50,
          ),

          TextButton(
            onPressed: () {
              context.read<LoginBloc>().add(LogOut());
            },
            child: const Text("çıkış yap")
          ),
          TextButton(
            onPressed: () {
              context.read<LoginBloc>().add(LoginGoogleSubmitted());
            },
            child: const Text("giriş yap")
          ),

          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if(state.status==Status.inProgress){
                return Text("işlemde");
              }

              else{
                return Text("başlangic");
              }
            },
          )
        ],
      )
    );
  }
}