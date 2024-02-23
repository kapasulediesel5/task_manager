import 'package:task_manager/models/task.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(this.task, {super.key});

  final Task task;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Column(
          children: [
            Text(task.title),
            const SizedBox(height: 4),
            Row(
              children: [
                Row(
                  children: [
                    Text(task.description),
                    const SizedBox(
                      width: 8,
                    ),
                    Icon(categoryIcons[task.category]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(task.status.toString())
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
