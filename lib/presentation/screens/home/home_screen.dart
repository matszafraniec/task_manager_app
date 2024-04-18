import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/presentation/common/context_extensions.dart';
import 'package:task_manager_app/presentation/common/dimensions.dart';
import 'package:task_manager_app/presentation/common/ui/empty_app_bar.dart';

import '../../common/routing/routes.dart';
import 'widgets/tasks_grid_builder/tasks_grid_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: EmptyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TasksSectionHeader(),
            TasksGridBuilder(),
          ],
        ),
      ),
    );
  }
}

class TasksSectionHeader extends StatelessWidget {
  const TasksSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          start: Dimensions.paddingM, bottom: Dimensions.paddingS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tasks list',
            style: context.themeTexts.headlineSmall,
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => context.push(Routes.taskDetails),
          )
        ],
      ),
    );
  }
}
