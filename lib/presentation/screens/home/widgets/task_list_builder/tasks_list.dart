import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/logic/cubits/tasks/tasks_cubit.dart';
import 'package:task_manager_app/presentation/common/context_extensions.dart';
import 'package:task_manager_app/presentation/common/ui/card_wrapper.dart';

import '../../../../../data/models/task/domain/task.dart';
import '../../../../common/dimensions.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingM,
      ),
      child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          if (state is TasksPopulatedSuccess) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.tasks.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: Dimensions.paddingM),
              itemBuilder: (context, index) {
                final item = state.tasks[index];

                return TaskItem(item);
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task item;

  const TaskItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return CardWrapper(
      child: Column(
        children: [
          Text(
            item.title,
            style: context.themeTexts.headlineSmall,
          ),
          Text(
            item.description,
            style: context.themeTexts.labelMedium!.copyWith(
              color: context.themeColors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
