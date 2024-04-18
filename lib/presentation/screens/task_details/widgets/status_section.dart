import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/enums/task_status/domain/task_status.dart';
import 'package:task_manager_app/presentation/common/context_extensions.dart';

import '../../../common/dimensions.dart';

class StatusSection extends StatefulWidget {
  final TaskStatus selectedStatus;
  final ValueSetter<TaskStatus> onValueChanged;

  const StatusSection(
    this.selectedStatus, {
    required this.onValueChanged,
    super.key,
  });

  @override
  State<StatusSection> createState() => _StatusSectionState();
}

class _StatusSectionState extends State<StatusSection> {
  late TaskStatus currentSelection;

  @override
  void initState() {
    super.initState();

    currentSelection = widget.selectedStatus;
  }

  _onSelectionUpdate(TaskStatus status) {
    setState(() => currentSelection = status);

    widget.onValueChanged(status);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.paddingM),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.only(start: 2),
                child: Text('Status:'),
              ),
              PopupMenuButton(
                padding: EdgeInsets.zero,
                onSelected: (value) {
                  final itemSelected = TaskStatus.values.firstWhere(
                    (element) => element.name == value,
                  );

                  _onSelectionUpdate(itemSelected);
                },
                icon: DecoratedBox(
                  decoration: BoxDecoration(
                    color: currentSelection.color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingS),
                    child: Row(
                      children: [
                        Text(
                          currentSelection.label,
                          style: context.themeTexts.labelLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                itemBuilder: (_) {
                  return [
                    PopupMenuItem<String>(
                      value: TaskStatus.planned.name,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: Dimensions.paddingXS),
                            child: Text(TaskStatus.planned.label),
                          )
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: TaskStatus.inProgress.name,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: Dimensions.paddingXS),
                            child: Text(TaskStatus.inProgress.label),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: TaskStatus.done.name,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: Dimensions.paddingXS),
                            child: Text(TaskStatus.done.label),
                          ),
                        ],
                      ),
                    )
                  ];
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
