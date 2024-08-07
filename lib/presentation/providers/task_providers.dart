import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparkosol_task_manager/data/repositories/task_repository.dart';
import 'package:sparkosol_task_manager/domain/entities/task.dart';
import 'package:sparkosol_task_manager/domain/usecases/task_use_cases.dart';

final taskListProvider =
    StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  return TaskListNotifier(ref);
});

class TaskListNotifier extends StateNotifier<List<Task>> {
  final Ref ref;

  TaskUseCases taskUseCases = TaskUseCases(TaskRepositoryIml());

  TaskListNotifier(this.ref) : super([]);

  Future<void> loadTasks() async {
    try {
      // Perform load operation
      state = [];
      final tasks = await taskUseCases.getTasks();
      state = tasks;
    } catch (e, stackTrace) {
      debugPrint('Error adding task: $e, Stack trace: $stackTrace');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      // Perform delete operation
      await taskUseCases.deleteTask(taskId);
      loadTasks();
    } catch (e, stackTrace) {
      debugPrint('Error adding task: $e, Stack trace: $stackTrace');
    }
  }

  Future<void> addTask(Task task) async {
    try {
      // Perform add operation
      await taskUseCases.addTask(task);
      loadTasks();
    } catch (e, stackTrace) {
      debugPrint('Error adding task: $e, Stack trace: $stackTrace');
    }
  }
}
