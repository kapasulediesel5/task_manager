import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/widgets/weather/weather_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/widgets/tasks_list/new_task.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() {
    return _TasksState();
  }
}

class _TasksState extends State<Tasks> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString('tasks');

    if (tasksJson != null) {
      setState(() {
        tasks = (json.decode(tasksJson) as List)
            .map((taskJson) => Task.fromMap(taskJson))
            .toList();
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'tasks', json.encode(tasks.map((task) => task.toMap()).toList()));
  }

  void _openAddTaskWidget(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewTask(
          onAddTask: _addTask,
        ),
      ),
    );
  }

  void _addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
    _saveTasks();
  }

  void _deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
    _saveTasks();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Task deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              tasks.add(task);
            });
            _saveTasks();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                _openAddTaskWidget(context), // Navigate to add task page
          ),
          IconButton(
            icon: const Icon(Icons.cloud),
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const WeatherWidget(city: 'Kyiv'), // Default city: London
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: tasks.isEmpty
            ? const Text(
                'No Tasks found! Start adding some.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              )
            : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    onLongPress: () => _deleteTask(task),
                  );
                },
              ),
      ),
    );
  }
}
