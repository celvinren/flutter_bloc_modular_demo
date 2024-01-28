import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_modular_demo/home/home_cubit.dart';
import 'package:flutter_bloc_modular_demo/text_field_module/text_field_module_cubit.dart';
import 'package:flutter_bloc_modular_demo/text_field_module/text_field_module_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      GetIt.I.registerSingleton(
          ModuleConfig<TextFieldController, String>(
            controller: TextFieldController(),
          ),
          instanceName: 'userName');
      GetIt.I.registerSingleton(
          ModuleConfig<TextFieldController, String>(
            controller: TextFieldController(defaultValue: 'test'),
          ),
          instanceName: 'password');
      return () {
        GetIt.I.unregister<ModuleConfig<TextFieldController, String>>(
            instanceName: 'userName');
        GetIt.I.unregister<ModuleConfig<TextFieldController, String>>(
            instanceName: 'password');
      };
    }, const []);

    return BlocProvider(
      create: (context) => HomeCubit(
        userNameState: GetIt.I
            .get<ModuleConfig<TextFieldController, String>>(
                instanceName: 'userName')
            .moduleResultStream,
        passwordState: GetIt.I
            .get<ModuleConfig<TextFieldController, String>>(
                instanceName: 'password')
            .moduleResultStream,
      ),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ModuleBuilder<TextFieldController, String>(
              config: GetIt.I.get<ModuleConfig<TextFieldController, String>>(
                  instanceName: 'userName'),
              builder: (bloc) => TextFormField(
                initialValue: bloc.state,
                onChanged: bloc.update,
              ),
            ),
            ModuleBuilder<TextFieldController, String>(
              config: GetIt.I.get<ModuleConfig<TextFieldController, String>>(
                  instanceName: 'password'),
              builder: (bloc) => TextFormField(
                initialValue: bloc.state,
                onChanged: bloc.update,
              ),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (constex, state) {
                return Column(
                  children: state.messageMap.entries
                      .map((e) => Text(e.value ?? ''))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldController extends ModuleCubit<String> {
  TextFieldController({defaultValue}) : super(defaultValue: defaultValue);

  @override
  void update(String value) {
    emit(value);
  }
}
