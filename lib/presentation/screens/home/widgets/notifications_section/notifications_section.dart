import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/presentation/common/context_extensions.dart';

import '../../../../../logic/cubits/notifications/notifications_cubit.dart';
import '../../../../common/dimensions.dart';

class NotificationsSection extends StatelessWidget {
  const NotificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        if (state is NotificationsChecked) {
          if (state.deadlineTasksCount > 0) {
            return NotificationBanner(count: state.deadlineTasksCount);
          } else {
            return const SizedBox();
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class NotificationBanner extends StatelessWidget {
  final int count;

  const NotificationBanner({
    required this.count,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingM, vertical: Dimensions.paddingL),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.black,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            onTap: () =>
                context.read<NotificationsCubit>().onNotificationsDismiss(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingS,
                horizontal: Dimensions.paddingXM,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.notifications_active,
                        color: Colors.white,
                        size: 18,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: Dimensions.paddingS),
                        child: Text(
                          text,
                          style: context.themeTexts.titleSmall!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String get text {
    if (count == 1) {
      return 'You have $count task today';
    } else {
      return 'You have $count tasks today';
    }
  }
}
