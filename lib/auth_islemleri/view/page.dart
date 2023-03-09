import 'package:firebase_chat_app/auth_islemleri/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import '../package/firebase_authentication_client.dart';
import '../package/token_storage.dart';
import '../package/user_repository.dart';
class BlocPage extends StatelessWidget {
  const BlocPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      
      create: (_) {
        return LoginBloc(
          userRepository: UserRepository(
            authenticationClient: FirebaseAuthenticationClient(
              tokenStorage: InMemoryTokenStorage(),
            )
          )
        );
      },

      child: View(),
    );
  }
}