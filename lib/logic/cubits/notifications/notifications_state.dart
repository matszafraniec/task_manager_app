part of 'notifications_cubit.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

final class NotificationsInitial extends NotificationsState {}

final class NotificationsChecked extends NotificationsState {
  final int deadlineTasksCount;

  const NotificationsChecked(this.deadlineTasksCount);

  @override
  List<Object> get props => [deadlineTasksCount];
}

final class NotificationsHidden extends NotificationsState {
  const NotificationsHidden();
}
