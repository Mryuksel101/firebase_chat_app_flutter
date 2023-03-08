enum LoginWithGoogleStateStatus{
  /// The form has not yet been submitted.
  initial,

  /// The form is in the process of being submitted.
  inProgress,

  /// The form has been submitted successfully.
  success,

  /// The form submission failed.
  failure,

  /// The form submission has been canceled.
  canceled
}


class LoginWithGoogleState{
  LoginWithGoogleStateStatus loginWithGoogleStateStatus;
  LoginWithGoogleState({ this.loginWithGoogleStateStatus = LoginWithGoogleStateStatus.initial });


  LoginWithGoogleState copyWith({required LoginWithGoogleStateStatus loginWithGoogleState}){
    return LoginWithGoogleState(
      loginWithGoogleStateStatus: loginWithGoogleState,
    );
  }
}