import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/presentation/common/context_extensions.dart';
import 'package:task_manager_app/presentation/common/dimensions.dart';
import 'package:task_manager_app/presentation/common/ui/empty_app_bar.dart';
import 'package:task_manager_app/presentation/screens/home/widgets/notifications_section/notifications_section.dart';
import 'package:task_manager_app/presentation/screens/home/widgets/tasks_section/tasks_section.dart';
import 'package:task_manager_app/presentation/screens/home/widgets/weather_section/weather_section.dart';

import '../../common/routing/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: EmptyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WeatherSection(),
            NotificationsSection(),
            TasksSection(),
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
        top: Dimensions.paddingS,
        start: Dimensions.paddingM,
        bottom: Dimensions.paddingXM,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tasks list',
            style: context.themeTexts.headlineSmall,
          ),
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
              color: context.themeColors.primary,
              size: 30,
            ),
            onPressed: () => context.push(Routes.taskDetails),
          )
        ],
      ),
    );
  }
}
