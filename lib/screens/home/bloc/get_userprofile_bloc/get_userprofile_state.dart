// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_userprofile_bloc.dart';

abstract class GetUserprofileState extends Equatable {
  const GetUserprofileState();

  @override
  List<Object> get props => [];
}

class GetUserprofileInitial extends GetUserprofileState {}

class GetUserprofileLoading extends GetUserprofileState {}

class GetUserprofileSuccess extends GetUserprofileState {
  final RegistrationUserModel registrationUserModel;
  GetUserprofileSuccess({
    required this.registrationUserModel,
  });

  @override
  List<Object> get props => [registrationUserModel];
}

class SetUserprofileSuccess extends GetUserprofileState {}

class GetUserprofileFailure extends GetUserprofileState {}

class SetUserprofileFailure extends GetUserprofileState {}
