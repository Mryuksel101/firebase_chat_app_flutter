import 'package:bloc/bloc.dart';

import '../package/authentication_client.dart';
import '../package/user_repository.dart';
import 'login_event.dart';
import 'login_state.dart';
class LoginBloc extends Bloc<LoginEvent, LoginState>{
  
  final UserRepository _userRepository;
  LoginBloc({required UserRepository userRepository}):
    _userRepository = userRepository,
    super(LoginState()){
    on<LoginGoogleSubmitted>(_onGoogleSubmitted);
  }


  Future<void> _onGoogleSubmitted(LoginGoogleSubmitted loginGoogleSubmitted, Emitter emit) async{
    emit(
      state.copyWith(status: Status.inProgress),
    );

    try{
      await _userRepository.logInWithGoogle();
    }

    on LogInWithGoogleCanceled{
      
    }



    catch(e){

    }
  }
}