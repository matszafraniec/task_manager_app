part of 'task_details_cubit.dart';

sealed class TaskDetailsState extends Equatable {
  const TaskDetailsState();

  @override
  List<Object> get props => [];
}

final class TaskDetailsInitial extends TaskDetailsState {
  const TaskDetailsInitial();
}

final class TaskDetailsLoading extends TaskDetailsState {
  const TaskDetailsLoading();
}

final class TaskDetailsError extends TaskDetailsState {
  final GeneralError error;

  const TaskDetailsError(this.error);
}

final class TaskDetailsDeleted extends TaskDetailsState {
  const TaskDetailsDeleted();
}

final class TaskDetailsLoaded extends TaskDetailsState {
  final Task data;

  const TaskDetailsLoaded(this.data);

  @override
  List<Object> get props => [data];
}
