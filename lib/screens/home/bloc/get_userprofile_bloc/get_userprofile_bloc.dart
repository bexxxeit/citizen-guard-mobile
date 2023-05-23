import 'package:bloc/bloc.dart';
import 'package:diploma_citizen/data/api/api_provider.dart';
import 'package:diploma_citizen/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

part 'get_userprofile_event.dart';
part 'get_userprofile_state.dart';

class GetUserprofileBloc extends Bloc<GetUserEvent, GetUserprofileState> {
  ApiProvider _apiProvider = ApiProvider();
  GetUserprofileBloc() : super(GetUserprofileInitial()) {
    on<GetUserprofileEvent>((event, emit) async {
      // TODO: implement event handler
      emit(GetUserprofileLoading());
      try {
        RegistrationUserModel? rum = await _apiProvider.getUserProfile();
        rum != null
            ? emit(GetUserprofileSuccess(registrationUserModel: rum))
            : emit(SetUserprofileFailure());
      } catch (e) {
        print(e);
        print('ERROR GET PROFILE');
        emit(GetUserprofileFailure());
      }
    });
    on<SetUserprofileEvent>((event, emit) async {
      // TODO: implement event handler
      emit(GetUserprofileLoading());
      print('SET PROFILE');
      print(event.registrationUserModel);
      try {
        await _apiProvider.setUserProfile(event.registrationUserModel)
            ? emit(SetUserprofileSuccess())
            : emit(SetUserprofileFailure());
      } catch (e) {
        print(e);
        print('ERROR SET PROFILE');
        emit(GetUserprofileFailure());
      }
    });
  }
}
