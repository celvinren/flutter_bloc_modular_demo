import 'package:flutter_bloc/flutter_bloc.dart';

class ModuleController<T> extends Cubit<T?> {
  ModuleController({T? defaultValue}) : super(defaultValue);

  void update(T value) {
    emit(value);
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