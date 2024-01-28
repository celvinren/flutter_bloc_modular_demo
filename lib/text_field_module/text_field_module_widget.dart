import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_modular_demo/text_field_module/text_field_module_cubit.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class ModuleConfig<N extends ModuleController<T>, T> {
  const ModuleConfig(this.id,
      {required this.childBuilder, required this.controller});
  final String id;
  final N controller;
  final Widget Function(N) childBuilder;

  Stream<T?> get moduleResultStream =>
      GetIt.I.get<N>(instanceName: id).stream.startWith(controller.state);

  Widget get widget => _ModuleWidget(
        config: this,
      );

  // N get textFieldModuleCubit => GetIt.I.get<N>(instanceName: id);

  N get registerModule {
    return GetIt.I.registerSingleton<N>(
      controller,
      instanceName: id,
    );
  }

  void get unregisterModule {
    GetIt.I.unregister<ModuleController<T>>(
      instanceName: id,
    );
  }
}

class _ModuleWidget<N extends ModuleController<T>, T> extends HookWidget {
  const _ModuleWidget({
    required this.config,
  });

  final ModuleConfig<N, T> config;

  @override
  Widget build(BuildContext context) {
    config.registerModule;

    useEffect(() {
      return () {
        /// This is similar dispose() method in StatefulWidget
        /// This will be called when the widget is removed from the widget tree
        /// This is where we can dispose of any resources
        config.unregisterModule;
      };
    }, const []);

    return FutureBuilder(
        future: GetIt.instance.allReady(),
        builder: (context, data) {
          if (data.hasData) {
            return _ProviderWrapper(config: config);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

class _ProviderWrapper<N extends ModuleController<T>, T>
    extends StatelessWidget {
  const _ProviderWrapper({required this.config});
  final ModuleConfig<N, T> config;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => config.controller,
      child: _Body(config: config),
    );
  }
}

class _Body<N extends ModuleController<T>, T> extends StatelessWidget {
  const _Body({required this.config});
  final ModuleConfig<N, T> config;

  @override
  Widget build(BuildContext context) {
    /// return your widget here
    return config.childBuilder(config.controller);
  }
}
