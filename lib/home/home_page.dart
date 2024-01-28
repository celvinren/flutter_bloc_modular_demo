import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_modular_demo/home/home_cubit.dart';
import 'package:flutter_bloc_modular_demo/text_field_module/text_field_module_cubit.dart';
import 'package:flutter_bloc_modular_demo/text_field_module/text_field_module_widget.dart';

final userNameTextFieldConfig = ModuleConfig<TestController, String>(
  'userName',
  controller: TestController(),
  childBuilder: (bloc) => TextField(
    onChanged: bloc.update,
  ),
);
final passwordTextFieldConfig = ModuleConfig<TestController, String>(
  'password',
  controller: TestController(),
  childBuilder: (bloc) {
    return TextField(
      onChanged: bloc.update,
    );
  },
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
            userNameTextFieldConfig.widget,
            passwordTextFieldConfig.widget,
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

class TestController extends ModuleController<String> {
  TestController({defaultValue}) : super(defaultValue: defaultValue);

  @override
  void update(String value) {
    emit(value);
  }
}
