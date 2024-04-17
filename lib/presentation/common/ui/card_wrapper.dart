import 'package:flutter/material.dart';

import '../dimensions.dart';

class CardWrapper extends StatelessWidget {
  final Widget child;

  const CardWrapper({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingS),
        child: child,
      ),
    );
  }
}
