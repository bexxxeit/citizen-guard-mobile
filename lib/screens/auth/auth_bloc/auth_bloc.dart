import 'package:bloc/bloc.dart';
import 'package:diploma_citizen/data/api/api_provider.dart';
import 'package:diploma_citizen/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  ApiProvider _apiProvider = ApiProvider();
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      // TODO: implement event handler
      print('LOGIN BLOC');
      emit(AuthLoading());
      try {
        await _apiProvider.login(event.iin, event.password)
            ? emit(AuthSuccess())
            : emit(AuthFailure());
      } catch (e) {
        print('ERROR IN LOGIN CATCH');
        print(e);
        emit(AuthFailure());
      }
    });
    on<RegisterEvent>((event, emit) async {
      // TODO: implement event handler
      print('REGISTER BLOC');
      print(event.userModel);
      emit(AuthLoading());
      try {
        await _apiProvider.register(event.userModel)
            ? emit(AuthSuccess())
            : emit(AuthFailure());
      } catch (e) {
        print('ERROR IN REGISTER CATCH');
        print(e);
        emit(AuthFailure());
      }
    });
    on<Emit>((event, emit) => emit(AuthInitial()),);
  }
}
