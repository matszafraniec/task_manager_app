import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/logic/cubits/tasks/tasks_cubit.dart';
import 'package:task_manager_app/presentation/common/dimensions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('This is home screen'),
          const SizedBox(height: Dimensions.paddingL),
          ElevatedButton(
            onPressed: () async {
              await context.read<TasksCubit>().addTask();
            },
            child: Text('Add Task'),
          ),
          const SizedBox(height: Dimensions.paddingL),
          ElevatedButton(
            onPressed: () async {
              await context.read<TasksCubit>().fetchAll();
            },
            child: Text('Fetch all'),
          ),
        ],
      ),
    );
  }
}
