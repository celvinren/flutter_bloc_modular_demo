import 'package:flutter_bloc/flutter_bloc.dart';

class ModuleController<T> extends Cubit<T?> {
  ModuleController({T? defaultValue}) : super(defaultValue);

  void update(T value) {
    emit(value);
  }
}
