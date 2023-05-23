import 'package:bloc/bloc.dart';
import 'package:diploma_citizen/data/api/api_provider.dart';
import 'package:equatable/equatable.dart';

part 'patch_status_event.dart';
part 'patch_status_state.dart';

class PatchStatusBloc extends Bloc<AllPatchStatusEvent, PatchStatusState> {
  ApiProvider _apiProvider = ApiProvider();
  PatchStatusBloc() : super(PatchStatusInitial()) {
    on<PatchStatusEvent>((event, emit) async {
      // TODO: implement event handler
      print('PATCH STATUS BLOC');
      emit(PatchStatusLoading());
      try {
        await _apiProvider.patchStatusPost(event.id, event.status)
            ? emit(PatchStatusSuccess())
            : emit(PatchStatusFailure());
      } catch (e) {
        print(e);
        print('ERROR IN CATCH PATCH STATUS');
        emit(PatchStatusFailure());
      }
    });
    on<EmitInitial>((event, emit) => emit(PatchStatusInitial()));
  }
}
