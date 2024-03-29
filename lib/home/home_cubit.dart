import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_modular_demo/text_field_module/text_field_module_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.userNameState, required this.passwordState})
      : super(const HomeState()) {
    _stateSubscription =
        CombineLatestStream([userNameState, passwordState], (values) => values)
            .listen((event) {
      final userNameState = event[0];
      _validateUserName(userNameState.text);

      final passwordState = event[1];
      _validatePassword(passwordState.text);

      _validateSubmit();
    });
  }

  final Stream<TextFieldModuleState> userNameState;
  final Stream<TextFieldModuleState> passwordState;
  StreamSubscription<List<TextFieldModuleState>>? _stateSubscription;

  void _validateUserName(String text) {
    if (text.isEmpty) {
      emit(state.copyWith(
          messageMap: Map.from(state.messageMap)
            ..addAll(
                {Message.userNameInvalid: Message.userNameInvalid.message})));
    } else {
      emit(state.copyWith(
          messageMap: Map.from(state.messageMap)
            ..remove(Message.userNameInvalid)));
    }
  }

  void _validatePassword(String text) {
    if (text.isEmpty) {
      emit(state.copyWith(
          messageMap: Map.from(state.messageMap)
            ..addAll(
                {Message.passwordInvalid: Message.passwordInvalid.message})));
    } else {
      emit(state.copyWith(
          messageMap: Map.from(state.messageMap)
            ..remove(Message.passwordInvalid)));
    }
  }

  void _validateSubmit() {
    if (!state.messageMap.containsKey(Message.userNameInvalid) &&
        !state.messageMap.containsKey(Message.passwordInvalid)) {
      emit(state.copyWith(
          messageMap: Map.from(state.messageMap)
            ..addAll({Message.allGood: Message.allGood.message})));
    } else {
      emit(state.copyWith(
          messageMap: Map.from(state.messageMap)..remove(Message.allGood)));
    }
  }

  @override
  Future<void> close() {
    _stateSubscription?.cancel();
    return super.close();
  }
}

@freezed
class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState({
    @Default('') String userName,
    @Default('') String password,
    @Default({}) Map<Message, String?> messageMap,
  }) = _Initial;
}

enum Message {
  userNameInvalid,
  passwordInvalid,
  allGood;

  String get message {
    return switch (this) {
      Message.userNameInvalid => 'User name is required',
      Message.passwordInvalid => 'Password is required',
      Message.allGood => 'All good to go!',
    };
  }
}
