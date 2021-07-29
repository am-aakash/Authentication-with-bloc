part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthEvent {}

// Fired when a user has successfully logged in
class UserLoggedIn extends AuthEvent {
  final User user;

  UserLoggedIn({required this.user});

  @override
  List<Object> get props => [user];
}

// Fired when the user has logged out
class UserLoggedOut extends AuthEvent {}
