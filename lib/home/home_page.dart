import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_modular_demo/home/home_cubit.dart';
import 'package:flutter_bloc_modular_demo/text_field_module/text_field_module_cubit.dart';
import 'package:flutter_bloc_modular_demo/text_field_module/text_field_module_widget.dart';

final userNameTextFieldConfig = ModuleConfig<TextFieldController, String>(
  controller: TextFieldController(),
);
final passwordTextFieldConfig = ModuleConfig<TextFieldController, String>(
  controller: TextFieldController(),
);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        userNameState: userNameTextFieldConfig.moduleResultStream,
        passwordState: passwordTextFieldConfig.moduleResultStream,
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
              config: userNameTextFieldConfig,
              builder: (bloc) => TextFormField(
                initialValue: bloc.state,
                onChanged: bloc.update,
              ),
            ),
            ModuleBuilder<TextFieldController, String>(
              config: passwordTextFieldConfig,
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
