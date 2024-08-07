import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparkosol_task_manager/app/utils/ui_snackbars.dart';
import 'package:sparkosol_task_manager/common/widgets/loader.dart';
import 'package:sparkosol_task_manager/domain/entities/task.dart';
import 'package:sparkosol_task_manager/presentation/providers/task_providers.dart';
import 'package:sparkosol_task_manager/presentation/views/task_states.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(taskNotifierProvider.notifier).loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<TaskStates>(taskNotifierProvider, (previous, screenState) async {
      if (screenState is TaskErrorState) {
        ShowLoader.hideLoading(context);
        UIFeedback.message(
          context,
          message: screenState.error,
          type: SnackBarType.error,
        );
      } else if (screenState is TaskLoadingState) {
        debugPrint('Loading');
        await ShowLoader.showLoading(context);
      } else if (screenState is TaskSuccessState) {
        ShowLoader.hideLoading(context);
        if (screenState.message != null) {
          UIFeedback.message(
            context,
            message: screenState.message ?? '',
            type: SnackBarType.success,
          );
        }
      }
    });
    return Scaffold(
      appBar: AppBar(title: const Text('Task Manager')),
      body: SafeArea(
          child: ListView.builder(
        itemCount: ref.watch(taskListProvider).length,
        itemBuilder: (context, index) {
          final task = ref.watch(taskListProvider)[index];
          return ListTile(
            title: Text(task.title),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await ref
                    .read(taskNotifierProvider.notifier)
                    .deleteTask(task.id);
              },
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context, (String text) {
          final taskTitle = text.trim();
          if (taskTitle.isNotEmpty) {
            final task = Task(id: DateTime.now().toString(), title: taskTitle);
            ref.read(taskNotifierProvider.notifier).addTask(task);
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
