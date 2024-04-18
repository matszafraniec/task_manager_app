import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection/injection.dart';
import '../../logic/cubits/tasks/tasks_cubit.dart';
import 'app_theme.dart';
import 'routing/app_navigator.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _hideKeyboard(context),
      child: BlocProvider<TasksCubit>(
        create: (context) => locator.get<TasksCubit>(),
        child: MaterialApp.router(
          title: 'Personal Task Manager',
          theme: lightTheme(),
          darkTheme: darkTheme(),
          routerConfig: locator.get<AppNavigator>().router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

void _hideKeyboard(BuildContext context) {
  final currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}
