import 'package:flutter_bloc/flutter_bloc.dart';

class ModuleCubit<T> extends Cubit<T?> {
  ModuleCubit({T? defaultValue}) : super(defaultValue);

  void update(T value) {
    emit(value);
  }

  @override
  Future<void> close() {
    print('object');
    return super.close();
  }
}
