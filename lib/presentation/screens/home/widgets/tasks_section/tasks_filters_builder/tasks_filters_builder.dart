import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../logic/cubits/tasks/tasks_cubit.dart';
import 'tasks_filters_selector.dart';

class TasksFiltersBuilder extends StatelessWidget {
  const TasksFiltersBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (state is TasksInitial || state is TasksLoading) {
          return const CircularProgressIndicator();
        } else if (state is TasksPopulatedSuccess) {
          return TasksFilterSelector(
            state.filter,
            tasksCount: state.tasks.length,
            onValueChanged: context.read<TasksCubit>().onFilterSet,
          );
        }

        return const SizedBox();
      },
    );
  }
}
