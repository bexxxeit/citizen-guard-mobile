// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'patch_status_bloc.dart';

class AllPatchStatusEvent extends Equatable {
  const AllPatchStatusEvent();

  @override
  List<Object> get props => [];
}

class PatchStatusEvent extends AllPatchStatusEvent {
  const PatchStatusEvent(
    this.id,
    this.status,
  );
  final int id;
  final String status;
  @override
  List<Object> get props => [id, status];
}

class EmitInitial extends AllPatchStatusEvent {}
