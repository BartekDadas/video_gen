part of 'gen_bloc.dart';

/// Represents the state of Gen in the application.

// ignore_for_file: must_be_immutable
class GenState extends Equatable {
  GenState(
      {this.textInputController,
      this.genModelObj,
      this.url = "",
      this.loading = false});
  TextEditingController? textInputController;
  bool loading;
  GenModel? genModelObj;

  String url;
  @override
  List<Object?> get props => [textInputController, genModelObj, url, loading];

  GenState copyWith({
    TextEditingController? textInputController,
    GenModel? genModelObj,
    String? url,
    bool? loading,
  }) {
    return GenState(
      textInputController: textInputController ?? this.textInputController,
      genModelObj: genModelObj ?? this.genModelObj,
      url: url ?? this.url,
      loading: loading ?? this.loading,
    );
  }
}
