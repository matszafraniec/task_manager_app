import 'package:flutter/material.dart';
import 'package:task_manager_app/presentation/common/ui/empty_app_bar.dart';

import 'widgets/task_list_builder/tasks_list_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TasksListBuilder(),
          ],
        ),
      ),
    );
  }
}
