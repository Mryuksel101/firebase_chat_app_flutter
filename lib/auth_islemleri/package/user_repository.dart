import 'authentication_client.dart';

class UserRepository{
  AuthenticationClient _authenticationClient;
  UserRepository({required AuthenticationClient authenticationClient}) : _authenticationClient = authenticationClient;
  Future<void> logInWithGoogle() async {
    try {
      await _authenticationClient.logInWithGoogle();
    } on LogInWithGoogleFailure {
      rethrow;
    } on LogInWithGoogleCanceled {
      rethrow;
    } catch (error, stackTrace) {
      //Error.throwWithStackTrace(LogInWithGoogleFailure(error), stackTrace);
    }
  }
}