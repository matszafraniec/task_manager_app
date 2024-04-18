import 'package:flutter/material.dart';

import '../../home_screen.dart';
import 'tasks_filters_builder/tasks_filters_builder.dart';
import 'tasks_grid_builder/tasks_grid_builder.dart';

class TasksSection extends StatelessWidget {
  const TasksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TasksFiltersBuilder(),
        TasksSectionHeader(),
        TasksGridBuilder(),
      ],
    );
  }
}
