import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_modular_demo/home/home_cubit.dart';
import 'package:flutter_bloc_modular_demo/text_field_module/text_field_module_widget.dart';

const kUserName = 'userName';
const kPassword = 'password';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        userNameState: kUserName.textFieldModuleStream,
        passwordState: kPassword.textFieldModuleStream,
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
            kUserName.textFieldModule,
            kPassword.textFieldModule,
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
