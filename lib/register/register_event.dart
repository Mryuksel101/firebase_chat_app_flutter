import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

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
  final BuildContext buildContext;
  const KayitOlEvent({required this.ad, required this.soyAd, required this.email, required this.sifre, required this.buildContext });

  @override
  List<Object?> get props => [email,sifre,ad,soyAd,buildContext];
}

class EventKayitOlGoogle extends RegisterEvent{
  final BuildContext buildContext;
  const EventKayitOlGoogle(this.buildContext);
  @override
  List<Object?> get props =>[buildContext];

}

class EventCikisyap extends RegisterEvent{
  final BuildContext buildContext;
  const EventCikisyap(this.buildContext);
  @override
  List<Object?> get props =>[buildContext];
}