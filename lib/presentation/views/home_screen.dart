// lib/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparkosol_task_manager/domain/entities/task.dart';
import 'package:sparkosol_task_manager/presentation/providers/task_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskListAsync = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Task Manager')),
      body: taskListAsync.when(
        data: (tasks) => ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return ListTile(
              title: Text(task.title),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await ref.read(taskListProvider.notifier).deleteTask(task.id);
                },
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context, (String text) {
          final taskTitle = text.trim();
          if (taskTitle.isNotEmpty) {
            final task = Task(id: DateTime.now().toString(), title: taskTitle);
            ref.read(taskUseCasesProvider).addTask(task);
          }
          Navigator.of(context).pop();
        }),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(
      BuildContext context, Function(String text) onPressed) {
    final TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(hintText: 'Task Title'),
          ),
          actions: [
            TextButton(
              onPressed: () => onPressed(taskController.text),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
