part of 'auth_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Auth widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the Auth widget is first created.
class AuthInitialEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final String login;
  final String password;

  AuthLoginEvent({required this.login, required this.password});

  @override
  List<Object?> get props => [login, password];
}
