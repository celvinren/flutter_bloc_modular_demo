import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_modular_demo/text_field_module/text_field_module_cubit.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class ModuleConfig<N extends ModuleController<T>, T> {
  ModuleConfig({required this.id, required this.controller});
  final String id;
  final N controller;
  // final Widget Function(N) childBuilder;

  Stream<T?> get moduleResultStream =>
      GetIt.I.get<N>(instanceName: id).stream.startWith(controller.state);

  // Widget get widget => _ModuleWidget(
  //       config: this,
  //     );

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

class ModuleBuilder<N extends ModuleController<T>, T> extends StatelessWidget {
  const ModuleBuilder({
    super.key,
    required this.config,
    required this.builder,
  });

  final ModuleConfig<N, T> config;
  final Widget Function(N) builder;
  @override
  Widget build(BuildContext context) {
    return _ModuleWidget(
      config: config,
      childBuilder: builder,
    );
  }
}

class _ModuleWidget<N extends ModuleController<T>, T> extends HookWidget {
  const _ModuleWidget({
    required this.config,
    required this.childBuilder,
  });

  final ModuleConfig<N, T> config;
  final Widget Function(N) childBuilder;

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
            return _ProviderWrapper(
              config: config,
              childBuilder: childBuilder,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

class _ProviderWrapper<N extends ModuleController<T>, T>
    extends StatelessWidget {
  const _ProviderWrapper({
    required this.config,
    required this.childBuilder,
  });
  final ModuleConfig<N, T> config;
  final Widget Function(N) childBuilder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => config.controller,
      child: _Body(
        config: config,
        childBuilder: childBuilder,
      ),
    );
  }
}

class _Body<N extends ModuleController<T>, T> extends StatelessWidget {
  const _Body({
    required this.config,
    required this.childBuilder,
  });
  final ModuleConfig<N, T> config;
  final Widget Function(N) childBuilder;

  @override
  Widget build(BuildContext context) {
    /// return your widget here
    return childBuilder(config.controller);
  }
}
