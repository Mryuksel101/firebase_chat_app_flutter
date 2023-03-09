enum Status{
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


class LoginState{
  Status status;
  LoginState({ this.status = Status.initial });


  LoginState copyWith({required Status status}){
    return LoginState(
      status: status,
    );
  }
}