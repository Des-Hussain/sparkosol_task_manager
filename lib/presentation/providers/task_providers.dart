import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparkosol_task_manager/data/repositories/mock_task_repository.dart';
import 'package:sparkosol_task_manager/domain/entities/task.dart';
import 'package:sparkosol_task_manager/domain/repositories/task_repository.dart';
import 'package:sparkosol_task_manager/domain/usecases/task_use_cases.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepositoryIml();
});

final taskUseCasesProvider = Provider<TaskUseCases>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskUseCases(repository);
});

// final taskListProvider = FutureProvider<List<Task>>((ref) async {
//   final useCases = ref.watch(taskUseCasesProvider);
//   return useCases.getTasks();
// });

final taskListProvider =
    StateNotifierProvider<TaskListNotifier, AsyncValue<List<Task>>>((ref) {
  final taskUseCases = ref.watch(taskUseCasesProvider);
  return TaskListNotifier(taskUseCases);
});

class TaskListNotifier extends StateNotifier<AsyncValue<List<Task>>> {
  final TaskUseCases taskUseCases;

  TaskListNotifier(this.taskUseCases) : super(const AsyncValue.loading()) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    try {
      final tasks = await taskUseCases.getTasks();
      state = AsyncValue.data(tasks);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await taskUseCases.deleteTask(taskId);
      _loadTasks(); // Reload tasks after deletion
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
