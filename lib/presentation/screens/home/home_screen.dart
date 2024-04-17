import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/presentation/common/ui/empty_app_bar.dart';

import '../../../logic/cubits/tasks/tasks_cubit.dart';
import 'widgets/task_list_builder/task_list_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TaskListBuilder(),
          ],
        ),
      ),
    );
  }
}
