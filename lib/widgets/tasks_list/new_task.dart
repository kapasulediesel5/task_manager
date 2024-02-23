import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart';

class NewTask extends StatefulWidget {
  final Function(Task) onAddTask;

  const NewTask({super.key, required this.onAddTask});

  @override
  State<NewTask> createState() => _NewTask();
}

class _NewTask extends State<NewTask> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late Category _selectedCategory;
  late Status _selectedStatus;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _selectedCategory = Category.work; // Default category
    _selectedStatus = Status.inComplete;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitTask() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isNotEmpty) {
      final newTask = Task(
          title: title,
          description: description,
          category: _selectedCategory,
          status: _selectedStatus);

      widget.onAddTask(newTask);
      Navigator.of(context)
          .pop(); // Close the bottom sheet after adding the task
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Task'), // Title for the screen
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<Category>(
                value: _selectedCategory,
                onChanged: (category) {
                  setState(() {
                    _selectedCategory = category!;
                  });
                },
                items: Category.values.map((category) {
                  return DropdownMenuItem<Category>(
                    value: category,
                    child: Text(category.toString().split('.').last),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<Status>(
                // Dropdown for status
                value: _selectedStatus,
                onChanged: (status) {
                  setState(() {
                    _selectedStatus = status!;
                  });
                },
                items: Status.values.map((status) {
                  return DropdownMenuItem<Status>(
                    value: status,
                    child: Text(status.toString().split('.').last),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Completion Status',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submitTask,
                child: const Text('Add Task'),
              ),
            ],
          ),
        ));
  }
}
