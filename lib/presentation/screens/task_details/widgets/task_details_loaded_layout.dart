import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/logic/cubits/task_details/task_details_cubit.dart';
import 'package:task_manager_app/presentation/common/context_extensions.dart';

import '../../../../data/models/task/domain/task.dart';
import '../../../common/app_theme.dart';
import '../../../common/dimensions.dart';
import 'deadline_section.dart';
import 'priority_selector.dart';
import 'status_section.dart';

class TaskDetailsLoadedLayout extends StatelessWidget {
  final Task item;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TaskDetailsLoadedLayout(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          top: Dimensions.paddingS,
          start: Dimensions.paddingM,
          end: Dimensions.paddingM,
        ),
        child: SafeArea(
          bottom: true,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      PrioritySelector(
                        item.priority,
                        onValueChanged: (value) => item.priority = value,
                      ),
                      const SizedBox(height: Dimensions.paddingXL),
                      TextFormField(
                        initialValue: item.title,
                        decoration: AppTheme.defaultInputDecoration('Title'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) => item.title = value,
                        validator: (value) {
                          if (value!.length >= 4) return null;

                          return 'Input at least 4 characters';
                        },
                      ),
                      const SizedBox(height: Dimensions.paddingL),
                      TextFormField(
                        initialValue: item.description,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration:
                            AppTheme.defaultInputDecoration('Description'),
                        onChanged: (value) => item.description = value,
                        minLines: 4,
                        maxLines: 8,
                        validator: (value) {
                          if (value!.length >= 4) return null;

                          return 'Input at least 4 characters';
                        },
                      ),
                      StatusSection(
                        item.status,
                        onValueChanged: (value) => item.status = value,
                      ),
                      DeadlineSection(
                        item.deadlineAt,
                        onValueChanged: (value) => item.deadlineAt = value,
                      ),
                    ],
                  ),
                ),
              ),
              BottomButton(
                item: item,
                formKey: _formKey,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  final Task item;
  final GlobalKey<FormState> formKey;

  const BottomButton({
    required this.item,
    required this.formKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () => _onSaveButtonPressed(context),
      child: Text(
        'Save',
        style: context.themeTexts.headlineSmall!.copyWith(color: Colors.white),
      ),
    );
  }

  void _onSaveButtonPressed(BuildContext context) {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      context.read<TaskDetailsCubit>().onTaskSave(item);
    }
  }
}
