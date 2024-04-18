import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

@GenerateNiceMocks([
  MockSpec<TasksRepository>(),
])
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager_app/data/models/enums/tasks_filter/domain/tasks_filter.dart';
import 'package:task_manager_app/data/repositories/tasks_repository.dart';
import 'package:task_manager_app/logic/cubits/tasks/tasks_cubit.dart';

import 'tasks_cubit_test.mocks.dart';

void main() {
  final mockTasksRepo = MockTasksRepository();

  when(mockTasksRepo.queryListener(any)).thenAnswer(
    (_) => right(Stream.value([])),
  );

  blocTest(
    'The cubit should emit TasksPopulatedSuccess on startup',
    build: () => TasksCubit(tasksRepo: mockTasksRepo),
    expect: () => [
      isA<TasksPopulatedSuccess>(),
    ],
  );

  blocTest(
    'The cubit should emit TasksPopulatedSuccess after onFilterSet function call',
    build: () => TasksCubit(tasksRepo: mockTasksRepo),
    act: (cubit) {
      cubit.onFilterSet(TasksFilter.today);
    },
    expect: () => [
      isA<TasksPopulatedSuccess>(),
    ],
  );
}
