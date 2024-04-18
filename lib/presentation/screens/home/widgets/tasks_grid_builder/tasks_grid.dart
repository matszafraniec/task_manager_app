import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/data/models/enums/task_status/domain/task_status.dart';
import 'package:task_manager_app/logic/cubits/tasks/tasks_cubit.dart';
import 'package:task_manager_app/presentation/common/context_extensions.dart';
import 'package:task_manager_app/presentation/common/routing/routes.dart';
import 'package:task_manager_app/presentation/common/ui/card_wrapper.dart';

import '../../../../../data/models/enums/priority/domain/priority.dart';
import '../../../../../data/models/task/domain/task.dart';
import '../../../../common/dimensions.dart';

class TasksGrid extends StatelessWidget {
  const TasksGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingM,
      ),
      child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          if (state is TasksPopulatedSuccess) {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsetsDirectional.only(
                  bottom: Dimensions.paddingXL),
              itemCount: state.tasks.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: Dimensions.paddingM,
                mainAxisSpacing: Dimensions.paddingL,
              ),
              itemBuilder: (_, index) {
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
    return InkWell(
      onTap: () {
        context.push(
          Routes.taskDetails,
          extra: item.id,
        );
      },
      child: CardWrapper(
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
            const Divider(thickness: 0.5),
            PriorityInfo(item.priority),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.status.label,
                    style: context.themeTexts.labelMedium!.copyWith(
                      color: context.themeColors.secondary,
                      decoration: TextDecoration.underline,
                      decorationColor: item.status.color,
                      decorationThickness: 2,
                      letterSpacing: 1.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}

class Header extends StatelessWidget {
  final Task item;

  const Header(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: context.themeTexts.labelLarge,
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
      ),
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
          context.push(
            Routes.taskDetails,
            extra: item.id,
          );
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
            size: 12,
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
