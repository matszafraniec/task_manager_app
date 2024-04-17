import 'package:flutter/material.dart';
import 'package:task_manager_app/presentation/common/app.dart';

import 'injection/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDependencies();

  runApp(const App());
}
