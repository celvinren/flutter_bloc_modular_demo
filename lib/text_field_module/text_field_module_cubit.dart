import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_field_module_cubit.freezed.dart';

class TextFieldModuleCubit extends Cubit<TextFieldModuleState> {
  TextFieldModuleCubit() : super(TextFieldModuleState());

  void updateText(String text) {
    emit(state.copyWith(text: text));
  }
}

@freezed
class TextFieldModuleState with _$TextFieldModuleState {
  const TextFieldModuleState._();

  factory TextFieldModuleState({
    @Default('') String text,
  }) = _TextFieldModuleState;
}

// @immutable
// sealed class TextFieldModuleState {}

// @freezed
// final class TextFieldModuleInitial extends TextFieldModuleState {
//   TextFieldModuleInitial._();

//   const factory TextFieldModuleInitial() = _TextFieldModuleInitial;
// }
