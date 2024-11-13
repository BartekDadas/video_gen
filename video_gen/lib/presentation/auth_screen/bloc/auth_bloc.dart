import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:video_gen/domain/googleauth/google_auth_helper.dart';
import '../../../core/app_export.dart';
import '../models/auth_model.dart';
part 'auth_event.dart';
part 'auth_state.dart';

/// A bloc that manages the state of a Auth according to the event that is dispatched to it.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleAuthHelper auth = GoogleAuthHelper();
  AuthBloc(AuthState initialState) : super(initialState) {
    on<AuthInitialEvent>(_onInitialize);
    on<AuthLoginEvent>(_login);
  }

  _onInitialize(
    AuthInitialEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (await auth.alreadySignIn()) {
      NavigatorService.popAndPushNamed(
        AppRoutes.genScreen,
      );
    }
    emit(
      state.copyWith(
        userNameController: TextEditingController(),
        passwordController: TextEditingController(),
      ),
    );
  }

  _login(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    final user =
        await auth.signInWithEmailAndPassword(event.login, event.password);
    if (user != null) {
      NavigatorService.popAndPushNamed(AppRoutes.genScreen);
    }
  }
}
