import 'dart:async';

import 'package:flutter/material.dart';

// extension TextFieldModuleCubitExtension on String {
//   Stream<TextFieldModuleState> get textFieldModuleStream => GetIt.I
//       .get<TextFieldModuleCubit>(instanceName: this)
//       .stream
//       .startWith(TextFieldModuleState());

//   TextFieldModule get textFieldModule => TextFieldModule(id: this);

//   TextFieldModuleCubit get textFieldModuleCubit =>
//       GetIt.I.get<TextFieldModuleCubit>(instanceName: this);

//   TextFieldModuleCubit get textFieldModuleRegister {
//     return GetIt.I.registerSingleton<TextFieldModuleCubit>(
//       TextFieldModuleCubit(),
//       instanceName: this,
//     );
//   }

//   void get textFieldModuleUnRegister {
//     GetIt.I.unregister<TextFieldModuleCubit>(
//       instanceName: this,
//     );
//   }
// }

// class TextFieldModule extends HookWidget {
//   const TextFieldModule({required this.id, super.key});

//   final String id;

//   @override
//   Widget build(BuildContext context) {
//     id.textFieldModuleRegister;

//     useEffect(() {
//       return () {
//         /// This is similar dispose() method in StatefulWidget
//         /// This will be called when the widget is removed from the widget tree
//         /// This is where we can dispose of any resources
//         id.textFieldModuleUnRegister;
//       };
//     }, const []);

//     return FutureBuilder(
//         future: GetIt.instance.allReady(),
//         builder: (context, data) {
//           if (data.hasData) {
//             return _TextField(id.textFieldModuleCubit);
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         });
//   }
// }

// class _TextField extends StatelessWidget {
//   const _TextField(this.bloc);
//   final TextFieldModuleCubit bloc;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => bloc,
//       child: const _Body(),
//     );
//   }
// }

class TextFieldModule extends StatelessWidget {
  const TextFieldModule({required this.interface, super.key});

  final StreamController<String> interface;

  @override
  Widget build(BuildContext context) {
    /// return your widget here
    return TextField(
      onChanged: (value) {
        interface.add(value);
      },
    );
  }
}
