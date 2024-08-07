// lib/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparkosol_task_manager/domain/entities/task.dart';
import 'package:sparkosol_task_manager/presentation/providers/task_providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(taskListProvider.notifier).loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Manager',
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index].title),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        ref
                            .read(taskListProvider.notifier)
                            .deleteTask(data[index].id);
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => _showAddTaskDialog(context, ref),
              child: const Text("Add", style: TextStyle(fontSize: 20)),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => _showAddTaskDialog(context, ref),
      //   child: Icon(Icons.add),
      // ),
    );
  }

  void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
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
              onPressed: () {
                final taskTitle = taskController.text.trim();
                if (taskTitle.isNotEmpty) {
                  final task =
                      Task(id: DateTime.now().toString(), title: taskTitle);
                  ref.read(taskListProvider.notifier).addTask(task);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add Task'),
            ),
          ],
        );
      },
    );
  }
}
