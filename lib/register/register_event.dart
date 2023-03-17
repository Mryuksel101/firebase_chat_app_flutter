import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable{
  const RegisterEvent();
}


class RegisterEmailChanged extends RegisterEvent{
  final String email;
  const RegisterEmailChanged({required this.email});
  
  @override
  List<Object?> get props => [email];

}

class KayitOlEvent extends RegisterEvent{
  final String email;
  final String sifre;
  final String ad;
  final String soyAd;

  const KayitOlEvent({required this.ad, required this.soyAd, required this.email, required this.sifre});

  @override
  List<Object?> get props => [email,sifre,ad,soyAd];
}