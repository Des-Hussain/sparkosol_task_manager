import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:sparkosol_task_manager/domain/entities/task.dart';
import 'package:sparkosol_task_manager/domain/repositories/task_repository.dart';
import 'package:sparkosol_task_manager/domain/usecases/task_use_cases.dart';
import 'package:sparkosol_task_manager/presentation/views/task_states.dart';

final taskNotifierProvider =
    StateNotifierProvider<TaskListNotifier, TaskStates>((ref) {
  final taskUseCases = TaskUseCases(GetIt.I<TaskRepository>());
  return TaskListNotifier(ref, taskUseCases);
});

class TaskListNotifier extends StateNotifier<TaskStates> {
  final TaskUseCases taskUseCases;
  final Ref ref;

  TaskListNotifier(this.ref, this.taskUseCases) : super(TaskLoadingState()) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    try {
      state = TaskLoadingState();
      ref.read(taskListProvider).clear();
      final tasks = await taskUseCases.getTasks();
      ref.read(taskListProvider.notifier).update((state) => tasks);
      state = TaskSuccessState();
    } catch (e, stackTrace) {
      state = TaskErrorState(
          error: e.toString(), errorMessage: stackTrace.toString());
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await taskUseCases.deleteTask(taskId);
      loadTasks(); // Reload tasks after deletion
    } catch (e, stackTrace) {
      state = TaskErrorState(
          error: e.toString(), errorMessage: stackTrace.toString());
    }
  }

  Future<void> addTask(Task task) async {
    try {
      await taskUseCases.addTask(task);
      loadTasks(); // Reload tasks after addition
    } catch (e, stackTrace) {
      state = TaskErrorState(
          error: e.toString(), errorMessage: stackTrace.toString());
    }
  }
}

final taskListProvider = StateProvider<List<Task>>((ref) => []);
