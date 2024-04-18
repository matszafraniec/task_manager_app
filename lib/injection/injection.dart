import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../data/data_sources/local/local_database_source.dart';
import 'injection.config.dart';

final locator = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> setupDependencies() async {
  await locator
      .registerSingleton<LocalDatabaseSource>(LocalDatabaseSourceImpl())
      .setup();

  locator.init();
}
