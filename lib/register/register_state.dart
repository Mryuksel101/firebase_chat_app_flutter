

class RegisterState{
  String? emailHataMesaji;
  String? sifreHataMesaji;

  RegisterState({required this.emailHataMesaji, required this.sifreHataMesaji});

  RegisterState copyWith({String? email, String? sifre }){
    return RegisterState(
      emailHataMesaji: email,
      sifreHataMesaji: sifre
    );
  }
  
}