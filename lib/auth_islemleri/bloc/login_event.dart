class LoginEvent{
  const LoginEvent();
}

class LoginGoogleSubmitted extends LoginEvent{
  LoginGoogleSubmitted();
}

class LogOut extends LoginEvent{
  LogOut();
}

