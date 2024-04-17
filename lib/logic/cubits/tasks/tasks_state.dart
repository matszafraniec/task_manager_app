part of 'tasks_cubit.dart';

sealed class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

final class TasksInitial extends TasksState {
  const TasksInitial();
}

final class TasksLoading extends TasksState {
  const TasksLoading();
}

final class TasksPopulatedSuccess extends TasksState {
  final List<Task> tasks;

  const TasksPopulatedSuccess(this.tasks);

  @override
  List<Object> get props => [tasks];
}

final class TasksPopulatedFailure extends TasksState {
  final GeneralError error;

  const TasksPopulatedFailure(this.error);
}

final class TasksFiltered extends TasksState {
  const TasksFiltered();
}
