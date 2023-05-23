// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_userprofile_bloc.dart';

abstract class GetUserEvent extends Equatable {
  const GetUserEvent();

  @override
  List<Object> get props => [];
}

class GetUserprofileEvent extends GetUserEvent {
  const GetUserprofileEvent();

  @override
  List<Object> get props => [];
}

class SetUserprofileEvent extends GetUserEvent {
  const SetUserprofileEvent(
    this.registrationUserModel,
  );
  final RegistrationUserModel registrationUserModel;

  @override
  List<Object> get props => [registrationUserModel];
}
