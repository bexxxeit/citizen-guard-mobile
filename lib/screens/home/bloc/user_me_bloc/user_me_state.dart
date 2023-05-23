// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_me_bloc.dart';

abstract class UserMeState extends Equatable {
  const UserMeState();

  @override
  List<Object> get props => [];
}

class UserMeInitial extends UserMeState {}

class UserMeLoading extends UserMeState {}

class UserMeSuccess extends UserMeState {
  final UserModel userType;
  UserMeSuccess({
    required this.userType,
  });
  @override
  List<Object> get props => [userType];
}

class UserMeFailure extends UserMeState {}
