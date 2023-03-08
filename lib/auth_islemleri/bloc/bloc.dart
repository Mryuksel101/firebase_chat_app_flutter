import 'package:bloc/bloc.dart';
import 'package:firebase_chat_app/auth_islemleri/bloc/event.dart';
import 'package:firebase_chat_app/auth_islemleri/bloc/state.dart';
class LoginBloc extends Bloc<LoginEvent, LoginState>{
  LoginBloc():super(LoginState()){
    on<LoginGoogleSubmitted>(_onGoogleSubmitted);
  }

  void _onGoogleSubmitted(LoginGoogleSubmitted loginGoogleSubmitted, Emitter<LoginState> emit){
    
  }
}