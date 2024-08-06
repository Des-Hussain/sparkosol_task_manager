

import 'package:sparkosol_task_manager/domain/entities/task.dart';
import 'package:sparkosol_task_manager/domain/repositories/task_repository.dart';

class TaskUseCases {
  final TaskRepository repository;

  TaskUseCases(this.repository);

  Future<List<Task>> getTasks() {
    return repository.getTasks();
  }

  Future<void> addTask(Task task) {
    return repository.addTask(task);
  }

  Future<void> deleteTask(String id) {
    return repository.deleteTask(id);
  }
}
