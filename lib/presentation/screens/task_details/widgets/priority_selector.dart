import 'package:flutter/material.dart';
import 'package:task_manager_app/presentation/common/context_extensions.dart';

import '../../../../data/models/enums/priority/domain/priority.dart';
import '../../../common/dimensions.dart';

class PrioritySelector extends StatefulWidget {
  final Priority selectedPriority;
  final ValueSetter<Priority> onValueChanged;

  const PrioritySelector(
    this.selectedPriority, {
    required this.onValueChanged,
    super.key,
  });

  @override
  State<PrioritySelector> createState() => _PrioritySelectorState();
}

class _PrioritySelectorState extends State<PrioritySelector> {
  late Priority currentSelection;

  @override
  void initState() {
    super.initState();

    currentSelection = widget.selectedPriority;
  }

  _onSelectionUpdate(Priority priority) {
    setState(() => currentSelection = priority);

    widget.onValueChanged(priority);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            PrioritySelectorButton(
              Priority.low,
              onPressed: () => _onSelectionUpdate(Priority.low),
              isSelected: currentSelection == Priority.low,
            ),
            const SizedBox(width: Dimensions.paddingS),
            PrioritySelectorButton(
              Priority.medium,
              onPressed: () => _onSelectionUpdate(Priority.medium),
              isSelected: currentSelection == Priority.medium,
            ),
            const SizedBox(width: Dimensions.paddingS),
            PrioritySelectorButton(
              Priority.high,
              onPressed: () => _onSelectionUpdate(Priority.high),
              isSelected: currentSelection == Priority.high,
            )
          ],
        ),
      ],
    );
  }
}

class PrioritySelectorButton extends StatelessWidget {
  final Priority item;
  final VoidCallback onPressed;
  final bool isSelected;

  const PrioritySelectorButton(
    this.item, {
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
        color: isSelected ? item.color : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: item.color, width: 1),
        ),
        child: InkWell(
          splashColor: item.color,
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: Dimensions.paddingS,
              vertical: 6,
            ),
            child: Text(
              item.label,
              style: isSelected
                  ? context.themeTexts.labelMedium!
                      .copyWith(color: Colors.white)
                  : context.themeTexts.labelSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
