import 'package:flutter/material.dart';
import 'package:task_manager_app/presentation/common/app.dart';

import 'injection/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupDependencies();

  runApp(const App());
}
