import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_modular_demo/text_field_module/text_field_module_cubit.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

extension TextFieldModuleCubitExtension on String {
  Stream<TextFieldModuleState> get textFieldModuleStream => GetIt.I
      .get<TextFieldModuleCubit>(instanceName: this)
      .stream
      .startWith(TextFieldModuleState());

  TextFieldModule get textFieldModule => TextFieldModule(id: this);

  TextFieldModuleCubit get textFieldModuleCubit =>
      GetIt.I.get<TextFieldModuleCubit>(instanceName: this);

  TextFieldModuleCubit get textFieldModuleRegister {
    return GetIt.I.registerSingleton<TextFieldModuleCubit>(
      TextFieldModuleCubit(),
      instanceName: this,
    );
  }

  void get textFieldModuleUnRegister {
    GetIt.I.unregister<TextFieldModuleCubit>(
      instanceName: this,
    );
  }
}

class TextFieldModule extends HookWidget {
  const TextFieldModule({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    id.textFieldModuleRegister;

    useEffect(() {
      return () {
        /// This is similar dispose() method in StatefulWidget
        /// This will be called when the widget is removed from the widget tree
        /// This is where we can dispose of any resources
        id.textFieldModuleUnRegister;
      };
    }, const []);

    return FutureBuilder(
        future: GetIt.instance.allReady(),
        builder: (context, data) {
          if (data.hasData) {
            return _TextField(id.textFieldModuleCubit);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

class _TextField extends StatelessWidget {
  const _TextField(this.bloc);
  final TextFieldModuleCubit bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    /// return your widget here
    return TextField(
      onChanged: context.read<TextFieldModuleCubit>().updateText,
    );
  }
}
