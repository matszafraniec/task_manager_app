import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/logic/cubits/task_details/task_details_cubit.dart';
import 'package:task_manager_app/presentation/common/context_extensions.dart';

import '../../../injection/injection.dart';
import '../../common/dimensions.dart';

class TaskDetailsScreen extends StatelessWidget {
  final String taskId;

  const TaskDetailsScreen({required this.taskId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskDetailsCubit>(
      create: (context) => locator.get<TaskDetailsCubit>(param1: taskId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Task details'),
          actions: const [
            ActionButtons(),
          ],
        ),
        body: BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
          builder: (context, state) => Column(
            children: [
              if (state is TaskDetailsLoaded)
                Text(
                  state.data.title,
                  style: context.themeTexts.titleMedium,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) async {
        if (value == 'remove') {
          await context.read<TaskDetailsCubit>().onTaskRemove();
        }
      },
      icon: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Padding(
          padding: EdgeInsets.all(Dimensions.paddingXS),
          child: Icon(
            Icons.more_vert,
            size: 16,
          ),
        ),
      ),
      itemBuilder: (_) {
        return [
          const PopupMenuItem<String>(
            value: 'remove',
            child: Row(
              children: [
                Icon(
                  Icons.delete,
                  size: 21,
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.only(start: Dimensions.paddingXS),
                  child: Text('Remove'),
                )
              ],
            ),
          )
        ];
      },
    );
  }
}
