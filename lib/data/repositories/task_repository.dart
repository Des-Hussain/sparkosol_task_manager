import 'package:sparkosol_task_manager/domain/entities/task.dart';
import 'package:sparkosol_task_manager/domain/repositories/task_repository.dart';

class TaskRepositoryIml implements TaskRepository {
  final List<Task> _tasks = [];

  @override
  Future<List<Task>> getTasks() async {
    return _tasks;
  }

  @override
  Future<void> addTask(Task task) async {
    _tasks.add(task);
  }

  @override
  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
  }
}
