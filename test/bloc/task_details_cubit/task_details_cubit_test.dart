import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager_app/data/models/enums/priority/domain/priority.dart';
import 'package:task_manager_app/data/models/enums/task_status/domain/task_status.dart';
import 'package:task_manager_app/data/repositories/tasks_repository.dart';
import 'package:task_manager_app/logic/cubits/task_details/task_details_cubit.dart';
import 'package:task_manager_app/data/models/task/domain/task.dart' as domain;

import 'task_details_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<TasksRepository>(),
])
void main() {
  final mockTasksRepo = MockTasksRepository();

  when(mockTasksRepo.queryListener(any)).thenAnswer(
    (_) => right(Stream.value([])),
  );
  when(mockTasksRepo.findById(any)).thenAnswer(
    (_) async => right(_dummyTask),
  );

  blocTest(
    'The cubit should emit TaskDetailsOnSelected on startup if taskId is not null',
    build: () => TaskDetailsCubit(
      taskId: '1',
      tasksRepo: mockTasksRepo,
    ),
    expect: () => [
      isA<TaskDetailsOnSelected>(),
    ],
  );
}

final _dummyTask = domain.Task(
  id: 'id',
  title: 'task title',
  description: 'task description',
  priority: Priority.medium,
  deadlineAt: DateTime.now().add(const Duration(days: 1)),
  createdAt: DateTime.now(),
  status: TaskStatus.inProgress,
);
