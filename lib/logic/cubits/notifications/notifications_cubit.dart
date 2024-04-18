import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/tasks_repository.dart';

part 'notifications_state.dart';

@injectable
class NotificationsCubit extends Cubit<NotificationsState> {
  final TasksRepository _tasksRepo;
  late StreamSubscription _querySubscription;

  NotificationsCubit({
    required TasksRepository tasksRepo,
  })  : _tasksRepo = tasksRepo,
        super(NotificationsInitial()) {
    _checkDeadlineTasks();
  }

  void _checkDeadlineTasks() {
    _tasksRepo.queryListenerDeadlineTasks().fold(
      (_) => null,
      (stream) {
        _querySubscription = stream.listen(
          (tasks) => emit(NotificationsChecked(tasks.length)),
        );
      },
    );
  }

  void onNotificationsDismiss() {
    _querySubscription.cancel();

    emit(const NotificationsHidden());
  }
}
