part of 'gen_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Gen widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class GenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the Gen widget is first created.
class GenInitialEvent extends GenEvent {
  @override
  List<Object?> get props => [];
}

class GenerateEvent extends GenEvent {
  String prompt;
  GenerateEvent({
    required this.prompt,
  });
  @override
  List<Object?> get props => [prompt];
}

class LoadingEvent extends GenEvent {
  @override
  List<Object?> get props => [];
}

class RefreshEvent extends GenEvent {
  String url;
  RefreshEvent({
    required this.url,
  });
  @override
  List<Object?> get props => [];
}

class LogOutEvent extends GenEvent {
  @override
  List<Object?> get props => [];
}
