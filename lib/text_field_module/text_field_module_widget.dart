import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_modular_demo/text_field_module/text_field_module_cubit.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class TextFieldModuleConfig {
  const TextFieldModuleConfig(this.id, {required this.childBuilder});
  final String id;
  final Widget Function(TextFieldModuleCubit<String>) childBuilder;

  Stream<String?> get textFieldModuleStream => GetIt.I
      .get<TextFieldModuleCubit<String>>(instanceName: id)
      .stream
      .startWith('');

  Widget get textFieldModule => _TextFieldModule(
        config: this,
      );

  TextFieldModuleCubit<String> get textFieldModuleCubit =>
      GetIt.I.get<TextFieldModuleCubit<String>>(instanceName: id);

  TextFieldModuleCubit<String> get textFieldModuleRegister {
    return GetIt.I.registerSingleton<TextFieldModuleCubit<String>>(
      TextFieldModuleCubit<String>(defaultValue: ''),
      instanceName: id,
    );
  }

  void get textFieldModuleUnRegister {
    GetIt.I.unregister<TextFieldModuleCubit<String>>(
      instanceName: id,
    );
  }
}

class _TextFieldModule extends HookWidget {
  const _TextFieldModule({
    required this.config,
  });

  final TextFieldModuleConfig config;

  @override
  Widget build(BuildContext context) {
    config.textFieldModuleRegister;

    useEffect(() {
      return () {
        /// This is similar dispose() method in StatefulWidget
        /// This will be called when the widget is removed from the widget tree
        /// This is where we can dispose of any resources
        config.textFieldModuleUnRegister;
      };
    }, const []);

    return FutureBuilder(
        future: GetIt.instance.allReady(),
        builder: (context, data) {
          if (data.hasData) {
            return _TextField(config: config);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

class _TextField extends StatelessWidget {
  const _TextField({required this.config});
  final TextFieldModuleConfig config;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => config.textFieldModuleCubit,
      child: _Body(config: config),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.config});
  final TextFieldModuleConfig config;

  @override
  Widget build(BuildContext context) {
    /// return your widget here
    return config.childBuilder(config.textFieldModuleCubit);
    // return TextField(
    //   onChanged: context.read<TextFieldModuleCubit<String>>().update,
    // );
  }
}
