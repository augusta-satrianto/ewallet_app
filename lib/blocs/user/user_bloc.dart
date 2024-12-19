import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ewallet_app/models/user_model.dart';
import 'package:ewallet_app/services/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is UserGet) {
        try {
          emit(UserLoading());

          final users = await UserService().getUsers();

          emit(UserSuccess(users));
        } catch (e) {
          emit(UserFailed(e.toString()));
        }
      }
    });
  }
}

class UserSingleBloc extends Bloc<UserSingleEvent, UserSingleState> {
  UserSingleBloc() : super(UserSingleInitial()) {
    on<UserSingleEvent>((event, emit) async {
      if (event is UserSingleGet) {
        try {
          emit(UserSingleLoading());

          final user = await UserService().getUser();

          emit(UserSingleSuccess(user));
        } catch (e) {
          emit(UserSingleFailed(e.toString()));
        }
      }
    });
  }
}
