import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:video_gen/domain/api/recraft.dart';
import 'package:video_gen/core/app_export.dart';
import 'package:video_gen/domain/googleauth/google_auth_helper.dart';
import 'package:video_gen/presentation/gen_screen/models/gen_model.dart';
part 'gen_event.dart';
part 'gen_state.dart';

/// A bloc that manages the state of a Gen according to the event that is dispatched to it.
class GenBloc extends Bloc<GenEvent, GenState> {
  GenBloc(GenState initialState) : super(initialState) {
    on<GenInitialEvent>(_onInitialize);
    on<GenerateEvent>(_generate);
    on<RefreshEvent>(_refresh);
    on<LoadingEvent>(_loading);
    on<LogOutEvent>(_logOut);
  }

  _onInitialize(
    GenInitialEvent event,
    Emitter<GenState> emit,
  ) async {
    emit(
      state.copyWith(
        url: "",
        textInputController: TextEditingController(),
      ),
    );
  }

  _generate(
    GenerateEvent event,
    Emitter<GenState> emit,
  ) async {
    add(LoadingEvent());
    Future.delayed(Duration(seconds: 10));
    final data = await RecraftApi().postData(event.prompt);
    print(data);
    if (data.isNotEmpty) {
      add(RefreshEvent(url: data));
    }
  }

  _loading(
    LoadingEvent event,
    Emitter<GenState> emit,
  ) {
    print("is loading up");
    emit(state.copyWith(
      loading: true,
    ));
  }

  _refresh(
    RefreshEvent event,
    Emitter<GenState> emit,
  ) async {
    emit(state.copyWith(
      url: event.url,
      loading: false,
    ));
  }

  _logOut(
    LogOutEvent event,
    Emitter<GenState> emit,
  ) async {
    await GoogleAuthHelper()
        .signOut()
        .then((_) => NavigatorService.popAndPushNamed(AppRoutes.authScreen));
  }
}
