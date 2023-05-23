// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String iin;
  final String password;
  LoginEvent({
    required this.iin,
    required this.password,
  });

  @override
  List<Object> get props => [iin, password];
}

class RegisterEvent extends AuthEvent {
  final RegistrationUserModel userModel;
  RegisterEvent({
    required this.userModel,
  });

  @override
  List<Object> get props => [userModel];
}

class Emit extends AuthEvent{}
