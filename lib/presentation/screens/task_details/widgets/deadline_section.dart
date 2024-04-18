import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/data/common/extensions.dart';

import '../../../common/dimensions.dart';

class DeadlineSection extends StatefulWidget {
  final DateTime selectedDeadline;
  final ValueSetter<DateTime> onValueChanged;

  const DeadlineSection(
    this.selectedDeadline, {
    required this.onValueChanged,
    super.key,
  });

  @override
  State<DeadlineSection> createState() => _DeadlineSectionState();
}

class _DeadlineSectionState extends State<DeadlineSection> {
  late DateTime currentSelection;

  @override
  void initState() {
    super.initState();

    currentSelection = widget.selectedDeadline;
  }

  _onSelectionUpdate(DateTime deadline) {
    setState(() => currentSelection = deadline);

    widget.onValueChanged(deadline);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: Dimensions.paddingM,
        start: 2,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Deadline:'),
              Text(dateFormatted),
            ],
          ),
          IconButton(
            onPressed: () async => _showDatePicker(context),
            icon: const Icon(
              Icons.calendar_month,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    final now = DateTime.now();

    await showDatePicker(
      initialDate: now,
      context: context,
      initialEntryMode: DatePickerEntryMode.input,
      firstDate: DateTime(2024, 01, 01),
      lastDate: now.add(
        const Duration(days: 1460),
      ),
    ).then(
      (selectedDate) {
        if (selectedDate != null) {
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          ).then(
            (selectedTime) {
              if (selectedTime != null) {
                final selectedDateTime = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );
                _onSelectionUpdate(selectedDateTime);
              }
            },
          );
        }
      },
    );
  }

  String get dateFormatted {
    if (currentSelection.isToday) {
      return 'Today, ${DateFormat('HH:mm').format(currentSelection)}';
    } else if (currentSelection.isYesterday) {
      return 'Yesterday, ${DateFormat('HH:mm').format(currentSelection)}';
    }

    if (DateTime.now().year != currentSelection.year) {
      return DateFormat('dd.MM.yyyy, HH:mm').format(currentSelection);
    }

    return DateFormat('dd.MM, HH:mm').format(currentSelection);
  }
}
