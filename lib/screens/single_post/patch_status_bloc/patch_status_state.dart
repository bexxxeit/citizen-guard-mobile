part of 'patch_status_bloc.dart';

abstract class PatchStatusState extends Equatable {
  const PatchStatusState();

  @override
  List<Object> get props => [];
}

class PatchStatusInitial extends PatchStatusState {}

class PatchStatusLoading extends PatchStatusState {}

class PatchStatusSuccess extends PatchStatusState {}

class PatchStatusFailure extends PatchStatusState {}
