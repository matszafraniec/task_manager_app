import 'package:flutter/material.dart';
import 'package:task_manager_app/presentation/common/ui/no_items_text.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: const Column(
        children: [
          NoItemsText('Some day we will present statistics here 🥳'),
        ],
      ),
    );
  }
}
