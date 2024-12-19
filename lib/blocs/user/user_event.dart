part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserGet extends UserEvent {}

sealed class UserSingleEvent extends Equatable {
  const UserSingleEvent();

  @override
  List<Object> get props => [];
}

class UserSingleGet extends UserSingleEvent {}
