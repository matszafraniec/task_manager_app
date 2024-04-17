import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/logic/cubits/tasks/tasks_cubit.dart';
import 'package:task_manager_app/presentation/common/context_extensions.dart';
import 'package:task_manager_app/presentation/common/ui/card_wrapper.dart';

import '../../../../../data/models/enums/priority/domain/priority.dart';
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Header(item),
              ActionButtons(item),
            ],
          ),
          const Divider(),
          PriorityInfo(item.priority),
          const SizedBox(height: Dimensions.paddingL),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.statusFormatted,
                style: context.themeTexts.labelMedium!.copyWith(
                  color: context.themeColors.secondary,
                  decoration: TextDecoration.underline,
                  decorationColor: item.statusColor,
                  decorationThickness: 2,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                item.deadlineAtFormatted,
                style: context.themeTexts.labelMedium!.copyWith(
                  color: context.themeColors.secondary,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final Task item;

  const Header(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class PriorityInfo extends StatelessWidget {
  final Priority item;

  const PriorityInfo(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: item.color),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Dimensions.paddingXS),
            child: Text(
              item.label,
              style: context.themeTexts.labelSmall,
            ),
          ),
        ),
      ],
    );
  }
}

class ActionButtons extends StatelessWidget {
  final Task item;

  const ActionButtons(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) async {
        if (value == 'edit') {
          // TODO: navigate to details
        } else if (value == 'remove') {
          await context.read<TasksCubit>().onTaskRemove(item);
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
            value: 'edit',
            child: Row(
              children: [
                Icon(
                  Icons.edit_outlined,
                  size: 21,
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.only(start: Dimensions.paddingXS),
                  child: Text('Edit'),
                )
              ],
            ),
          ),
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
