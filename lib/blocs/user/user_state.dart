part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserFailed extends UserState {
  final String e;
  const UserFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class UserSuccess extends UserState {
  final List<UserModel> users;
  const UserSuccess(this.users);

  @override
  List<Object> get props => [users];
}

// Single
sealed class UserSingleState extends Equatable {
  const UserSingleState();

  @override
  List<Object> get props => [];
}

final class UserSingleInitial extends UserSingleState {}

final class UserSingleLoading extends UserSingleState {}

final class UserSingleFailed extends UserSingleState {
  final String e;
  const UserSingleFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class UserSingleSuccess extends UserSingleState {
  final UserModel user;
  const UserSingleSuccess(this.user);

  @override
  List<Object> get props => [user];
}
