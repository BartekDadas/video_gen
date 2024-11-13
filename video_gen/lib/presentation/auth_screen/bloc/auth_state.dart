part of 'auth_bloc.dart';

/// Represents the state of Auth in the application.

// ignore_for_file: must_be_immutable
class AuthState extends Equatable {
  AuthState(
      {this.userNameController, this.passwordController, this.authModelObj});

  TextEditingController? userNameController;

  TextEditingController? passwordController;

  AuthModel? authModelObj;

  @override
  List<Object?> get props =>
      [userNameController, passwordController, authModelObj];
  AuthState copyWith({
    TextEditingController? userNameController,
    TextEditingController? passwordController,
    AuthModel? authModelObj,
  }) {
    return AuthState(
      userNameController: userNameController ?? this.userNameController,
      passwordController: passwordController ?? this.passwordController,
      authModelObj: authModelObj ?? this.authModelObj,
    );
  }
}
