import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldModuleCubit extends Cubit<String> {
  TextFieldModuleCubit() : super('');

  void updateText(String text) {
    emit(text);
  }
}

// @freezed
// class TextFieldModuleState with _$TextFieldModuleState {
//   const TextFieldModuleState._();

//   factory TextFieldModuleState({
//     @Default('') String text,
//   }) = _TextFieldModuleState;
// }

// @immutable
// sealed class TextFieldModuleState {}

// @freezed
// final class TextFieldModuleInitial extends TextFieldModuleState {
//   TextFieldModuleInitial._();

//   const factory TextFieldModuleInitial() = _TextFieldModuleInitial;
// }
