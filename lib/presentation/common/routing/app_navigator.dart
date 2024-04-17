import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/logic/cubits/statistics/statistics_cubit.dart';
import 'package:task_manager_app/presentation/screens/statistics/statistics_screen.dart';

import '../../../injection/injection.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/home/scaffold_with_navbar.dart';
import 'routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

class AppNavigator {
  final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => ScaffoldWithNavBar(
          navigationShell,
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: _sectionNavigatorKey,
            routes: [
              GoRoute(
                path: Routes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.statistics,
                builder: (context, state) => BlocProvider<StatisticsCubit>(
                  create: (context) => locator.get<StatisticsCubit>(),
                  child: const StatisticsScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
