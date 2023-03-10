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