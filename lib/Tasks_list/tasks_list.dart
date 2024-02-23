import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/widgets/tasks_list/task_item.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key, required this.tasks, required this.onRemoveTask});
  final void Function(Task task) onRemoveTask;

  final List<Task> tasks;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(tasks[index]),
            onDismissed: (direction) {
              onRemoveTask(tasks[index]);
            },
            child: TaskItem(tasks[index])));
  }
}
