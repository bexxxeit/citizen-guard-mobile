import 'package:bloc/bloc.dart';
import 'package:diploma_citizen/data/api/api_provider.dart';
import 'package:diploma_citizen/data/models/user_type_model.dart';
import 'package:equatable/equatable.dart';

part 'user_me_event.dart';
part 'user_me_state.dart';

class UserMeBloc extends Bloc<UserMeEvent, UserMeState> {
  ApiProvider _apiProvider = ApiProvider();
  UserMeBloc() : super(UserMeInitial()) {
    on<UserMeEvent>((event, emit) async {
      // TODO: implement event handler
      print('USER ME BLOC');
      emit(UserMeLoading());
      try {
        UserModel? userType = await _apiProvider.getUserMe();
        userType != null
            ? emit(UserMeSuccess(userType: userType))
            : emit(UserMeFailure());
      } catch (e) {
        print('ERROR IN CATCH USER ME');
        print(e);
        emit(UserMeFailure());
      }
    });
    // on<UserProfileEvent>((event, emit) async {
    //   // TODO: implement event handler
    //   print('USER ME BLOC');
    //   emit(UserMeLoading());
    //   try {
    //     UserModel? userType = await _apiProvider.getUserMe();
    //     userType != null
    //         ? emit(UserMeSuccess(userType: userType))
    //         : emit(UserMeFailure());
    //   } catch (e) {
    //     print('ERROR IN CATCH USER ME');
    //     print(e);
    //     emit(UserMeFailure());
    //   }
    // });
  }
}
