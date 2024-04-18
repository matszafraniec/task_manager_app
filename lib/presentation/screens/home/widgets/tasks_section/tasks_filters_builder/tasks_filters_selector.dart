import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/enums/tasks_filter/domain/tasks_filter.dart';
import 'package:task_manager_app/presentation/common/context_extensions.dart';

import '../../../../../common/dimensions.dart';

class TasksFilterSelector extends StatefulWidget {
  final TasksFilter selectedFilter;
  final int tasksCount;
  final ValueSetter<TasksFilter> onValueChanged;

  const TasksFilterSelector(
    this.selectedFilter, {
    required this.tasksCount,
    required this.onValueChanged,
    super.key,
  });

  @override
  State<TasksFilterSelector> createState() => _TasksFilterSelectorState();
}

class _TasksFilterSelectorState extends State<TasksFilterSelector> {
  late TasksFilter currentSelection;

  @override
  void initState() {
    super.initState();

    currentSelection = widget.selectedFilter;
  }

  _onSelectionUpdate(TasksFilter filter) {
    setState(() => currentSelection = filter);

    widget.onValueChanged(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingM),
      child: Column(
        children: [
          Row(
            children: [
              FilterSelectorButton(
                TasksFilter.all,
                onPressed: () => _onSelectionUpdate(TasksFilter.all),
                isSelected: currentSelection == TasksFilter.all,
                count: widget.selectedFilter == TasksFilter.all
                    ? widget.tasksCount
                    : null,
              ),
              const SizedBox(width: Dimensions.paddingS),
              FilterSelectorButton(
                TasksFilter.today,
                onPressed: () => _onSelectionUpdate(TasksFilter.today),
                isSelected: currentSelection == TasksFilter.today,
                count: widget.selectedFilter == TasksFilter.today
                    ? widget.tasksCount
                    : null,
              ),
              const SizedBox(width: Dimensions.paddingS),
              FilterSelectorButton(
                TasksFilter.highPriority,
                onPressed: () => _onSelectionUpdate(TasksFilter.highPriority),
                isSelected: currentSelection == TasksFilter.highPriority,
                count: widget.selectedFilter == TasksFilter.highPriority
                    ? widget.tasksCount
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FilterSelectorButton extends StatelessWidget {
  final TasksFilter item;
  final VoidCallback onPressed;
  final bool isSelected;
  final int? count;

  const FilterSelectorButton(
    this.item, {
    this.count,
    required this.onPressed,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        type: MaterialType.card,
        elevation: isSelected ? 1.5 : 0,
        color: isSelected ? context.themeColors.primary : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: context.themeColors.primary, width: 1),
        ),
        child: InkWell(
          splashColor: context.themeColors.primary,
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsetsDirectional.all(Dimensions.paddingS),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.label,
                  style: isSelected
                      ? context.themeTexts.labelLarge!
                          .copyWith(color: Colors.white)
                      : context.themeTexts.labelLarge,
                  textAlign: TextAlign.center,
                ),
                if (count != null)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: Dimensions.paddingXS),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.white,
                      child: Text(
                        count.toString(),
                        style: context.themeTexts.labelMedium!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
