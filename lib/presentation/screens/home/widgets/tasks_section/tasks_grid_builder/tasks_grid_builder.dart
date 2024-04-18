import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/presentation/common/context_extensions.dart';

import '../../../../../../logic/cubits/tasks/tasks_cubit.dart';
import 'tasks_grid.dart';

class TasksGridBuilder extends StatelessWidget {
  const TasksGridBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listener: _handleSideEffects,
      builder: (context, state) {
        if (state is TasksInitial || state is TasksLoading) {
          return const CircularProgressIndicator();
        } else if (state is TasksPopulatedSuccess) {
          if (state.tasks.isEmpty) {
            return const SizedBox();
          } else {
            return const TasksGrid();
          }
        }

        return const SizedBox();
      },
    );
  }
}

void _handleSideEffects(BuildContext context, TasksState state) {
  if (state is TasksPopulatedFailure) {
    _snackbarError(context, state.error.message);
  }
}

void _snackbarError(BuildContext context, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: context.themeColors.error,
        content: Text(message),
      ),
    );
